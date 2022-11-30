// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/After_Shadow"
{
	Properties
	{
		_TopTexture0("Top Texture 0", 2D) = "white" {}
		_U_Tiling("U_Tiling", Float) = 0
		_V_Tiling("V_Tiling", Float) = 0
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 1.71
		[HDR]_F_Color_B("F_Color_B", Color) = (0,0,0,0)
		[HDR]_F_Color_A("F_Color_A", Color) = (0,0,0,0)
		_Tex_Pow("Tex_Pow", Range( 1 , 15)) = 0
		_Tex_Ins("Tex_Ins", Range( 1 , 10)) = 0
		_UPanner("UPanner", Float) = 0
		_VPanner("VPanner", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _TopTexture0;
		uniform float _U_Tiling;
		uniform float _V_Tiling;
		uniform float _UPanner;
		uniform float _VPanner;
		uniform float _Tex_Pow;
		uniform float _Tex_Ins;
		uniform float4 _F_Color_A;
		uniform float4 _F_Color_B;
		uniform float _Fresnel_Pow;


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 appendResult63 = (float2(_U_Tiling , _V_Tiling));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult56 = (float2(_UPanner , _VPanner));
			float4 triplanar66 = TriplanarSamplingSF( _TopTexture0, ( ase_worldViewDir + float3( ( _Time.y * appendResult56 ) ,  0.0 ) ), ase_worldNormal, 1.0, appendResult63, 1.0, 0 );
			float4 temp_cast_1 = (_Tex_Pow).xxxx;
			float fresnelNdotV65 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode65 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV65, 5.0 ) );
			float4 lerpResult74 = lerp( _F_Color_A , _F_Color_B , saturate( pow( fresnelNode65 , _Fresnel_Pow ) ));
			o.Emission = ( ( ( pow( triplanar66 , temp_cast_1 ) * _Tex_Ins ) + lerpResult74 ) * i.vertexColor ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;1685.887;1062.91;1.806914;True;False
Node;AmplifyShaderEditor.RangedFloatNode;54;-1953.155,-653.2714;Float;False;Property;_UPanner;UPanner;11;0;Create;True;0;0;False;0;0;0.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1954.155,-561.2713;Float;False;Property;_VPanner;VPanner;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-1727.155,-636.2714;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;57;-1806.155,-779.2714;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1440.287,-645.2374;Float;False;Property;_U_Tiling;U_Tiling;4;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-1598.155,-783.2714;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1440.287,-501.2375;Float;True;Property;_V_Tiling;V_Tiling;5;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;60;-1864.287,-1003.237;Float;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;63;-1264.287,-613.2374;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1225.373,39.71906;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;6;0;Create;True;0;0;False;0;1.71;2.182228;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;65;-1335.911,-173.183;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-1449.155,-890.2714;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TriplanarNode;66;-1201.08,-891.1976;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;67;-1099.155,-608.2711;Float;False;Property;_Tex_Pow;Tex_Pow;9;0;Create;True;0;0;False;0;0;4.26;1;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;-773.5787,-158.9217;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;73;-553.6658,-156.7762;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-686.1556,-541.2712;Float;False;Property;_F_Color_A;F_Color_A;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.3070848,0.07208972,0.3396226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;72;-766.1553,-871.2711;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;69;-683.1556,-376.2712;Float;False;Property;_F_Color_B;F_Color_B;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.031711,6.954127,16.82482,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-811.1553,-650.2711;Float;False;Property;_Tex_Ins;Tex_Ins;10;0;Create;True;0;0;False;0;0;5.08;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;74;-382.3921,-421.9713;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-483.1554,-866.2711;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;89;-19.01007,-425.6459;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-142.448,-703.5684;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DitheringNode;78;400.2317,-201.5378;Float;False;0;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-420.5489,497.9111;Float;False;Property;_Opacity_Pow;Opacity_Pow;2;0;Create;True;0;0;False;0;2.270588;2.14;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;82;-1179.421,168.6434;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;84;-192.8462,173.6387;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;88;-950.3674,236.9655;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;830.1977,230.3008;Float;False;Property;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.23;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;87;-700.5305,244.6929;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-807.5488,487.9111;Float;False;Property;_Opcity_Scale;Opcity_Scale;3;0;Create;True;0;0;False;0;2.164706;2.41;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;157.0301,-204.1519;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;502.2403,117.2306;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;90;182.3016,109.923;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT;1;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;81;-1173.859,330.2496;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-469.5489,244.9111;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;83;-945.3814,-114.6215;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;277.6831,-429.2466;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1076.133,-382;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/After_Shadow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;-10;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;58;0;57;0
WireConnection;58;1;56;0
WireConnection;63;0;61;0
WireConnection;63;1;59;0
WireConnection;64;0;60;0
WireConnection;64;1;58;0
WireConnection;66;9;64;0
WireConnection;66;3;63;0
WireConnection;68;0;65;0
WireConnection;68;1;62;0
WireConnection;73;0;68;0
WireConnection;72;0;66;0
WireConnection;72;1;67;0
WireConnection;74;0;71;0
WireConnection;74;1;69;0
WireConnection;74;2;73;0
WireConnection;75;0;72;0
WireConnection;75;1;70;0
WireConnection;85;0;75;0
WireConnection;85;1;74;0
WireConnection;78;0;90;0
WireConnection;84;0;86;0
WireConnection;84;1;80;0
WireConnection;88;0;82;0
WireConnection;88;1;81;0
WireConnection;87;0;88;0
WireConnection;87;1;88;0
WireConnection;79;0;89;4
WireConnection;79;1;84;0
WireConnection;91;0;90;0
WireConnection;91;1;92;0
WireConnection;86;0;87;0
WireConnection;86;1;76;0
WireConnection;83;0;88;0
WireConnection;77;0;85;0
WireConnection;77;1;89;0
WireConnection;0;2;77;0
WireConnection;0;9;78;0
ASEEND*/
//CHKSM=3B9FDDACE2B32E55A3B5348EF3E9D5FAD9EB8A5F