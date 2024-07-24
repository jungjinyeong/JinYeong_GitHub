// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/AfterShadow"
{
	Properties
	{
		_TopTexture0("Top Texture 0", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
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

		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float4 screenPosition;
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
		uniform float _Cutoff = 0.5;


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


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 appendResult19 = (float2(_U_Tiling , _V_Tiling));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult37 = (float2(_UPanner , _VPanner));
			float4 triplanar14 = TriplanarSamplingSF( _TopTexture0, ( ase_worldViewDir + float3( ( _Time.y * appendResult37 ) ,  0.0 ) ), ase_worldNormal, 1.0, appendResult19, 1.0, 0 );
			float4 temp_cast_1 = (_Tex_Pow).xxxx;
			float fresnelNdotV44 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode44 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV44, 5.0 ) );
			float4 lerpResult26 = lerp( _F_Color_A , _F_Color_B , saturate( pow( fresnelNode44 , _Fresnel_Pow ) ));
			float4 temp_output_29_0 = ( ( pow( triplanar14 , temp_cast_1 ) * _Tex_Ins ) + lerpResult26 );
			o.Emission = temp_output_29_0.xyz;
			o.Alpha = 1;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen10 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither10 = Dither4x4Bayer( fmod(clipScreen10.x, 4), fmod(clipScreen10.y, 4) );
			float fresnelNdotV48 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode48 = ( 1.0 + 1.0 * pow( 1.0 - fresnelNdotV48, 2.0 ) );
			dither10 = step( dither10, fresnelNode48 );
			clip( dither10 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;1707.097;1076.204;1.54072;True;False
Node;AmplifyShaderEditor.RangedFloatNode;36;-1777.937,-598.843;Float;False;Property;_UPanner;UPanner;11;0;Create;True;0;0;False;0;0;0.001;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1778.937,-506.843;Float;False;Property;_VPanner;VPanner;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1551.937,-581.843;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;35;-1630.937,-724.843;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1265.069,-590.8091;Float;False;Property;_U_Tiling;U_Tiling;4;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1422.937,-728.843;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1265.069,-446.8091;Float;True;Property;_V_Tiling;V_Tiling;5;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;15;-1689.069,-948.8091;Float;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;24;-1050.155,94.14741;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;6;0;Create;True;0;0;False;0;1.71;2.182228;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;-1089.069,-558.8091;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1273.937,-835.843;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;44;-1160.693,-118.7547;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;14;-1025.862,-836.7692;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-923.937,-553.8428;Float;False;Property;_Tex_Pow;Tex_Pow;9;0;Create;True;0;0;False;0;0;4.26;1;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;23;-598.3603,-104.4934;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;-378.4474,-102.3479;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-510.9373,-486.8428;Float;False;Property;_F_Color_A;F_Color_A;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.3070848,0.07208972,0.3396226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;30;-590.937,-816.8428;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;27;-507.9373,-321.8428;Float;False;Property;_F_Color_B;F_Color_B;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.031711,6.954127,16.82482,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-635.937,-595.8428;Float;False;Property;_Tex_Ins;Tex_Ins;10;0;Create;True;0;0;False;0;0;5.08;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;48;357.52,164.3513;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT;1;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;-207.1737,-367.5429;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-307.937,-811.8428;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;8;-17.62781,228.0671;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;40;156.2083,-371.2175;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;4;-775.149,291.3939;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;7;-525.3121,299.1213;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-294.3305,299.3395;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;32.77042,-649.1401;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;22;-770.1631,-60.19316;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;1005.416,284.7291;Float;False;Property;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.23;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;6;-998.6409,384.678;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-245.3305,552.3395;Float;False;Property;_Opacity_Pow;Opacity_Pow;2;0;Create;True;0;0;False;0;2.270588;2.14;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;332.2485,-149.7236;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;10;575.45,-147.1095;Float;False;0;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;452.9015,-374.8182;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-632.3304,542.3395;Float;False;Property;_Opcity_Scale;Opcity_Scale;3;0;Create;True;0;0;False;0;2.164706;2.41;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;677.4586,171.6589;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;5;-1004.203,223.0717;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1057.343,-470.8308;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/AfterShadow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;36;0
WireConnection;37;1;38;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;19;0;16;0
WireConnection;19;1;18;0
WireConnection;34;0;15;0
WireConnection;34;1;39;0
WireConnection;14;9;34;0
WireConnection;14;3;19;0
WireConnection;23;0;44;0
WireConnection;23;1;24;0
WireConnection;25;0;23;0
WireConnection;30;0;14;0
WireConnection;30;1;31;0
WireConnection;26;0;28;0
WireConnection;26;1;27;0
WireConnection;26;2;25;0
WireConnection;32;0;30;0
WireConnection;32;1;33;0
WireConnection;8;0;11;0
WireConnection;8;1;9;0
WireConnection;4;0;5;0
WireConnection;4;1;6;0
WireConnection;7;0;4;0
WireConnection;7;1;4;0
WireConnection;11;0;7;0
WireConnection;11;1;12;0
WireConnection;29;0;32;0
WireConnection;29;1;26;0
WireConnection;22;0;4;0
WireConnection;42;0;40;4
WireConnection;42;1;8;0
WireConnection;10;0;48;0
WireConnection;41;0;29;0
WireConnection;41;1;40;0
WireConnection;49;0;48;0
WireConnection;49;1;50;0
WireConnection;0;2;29;0
WireConnection;0;10;10;0
ASEEND*/
//CHKSM=FF65B315A249C264312B0848378CFC36BDE8C8C4