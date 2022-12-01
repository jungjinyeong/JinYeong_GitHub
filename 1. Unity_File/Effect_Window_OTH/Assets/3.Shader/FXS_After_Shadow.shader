// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/After_Shadow"
{
	Properties
	{
		_TriplanarTexture("Triplanar Texture", 2D) = "white" {}
		_Tex_Pow("Tex_Pow", Range( 1 , 15)) = 0
		_Tex_Ins("Tex_Ins", Range( 1 , 10)) = 0
		_U_Tiling("U_Tiling", Float) = 0
		_V_Tiling("V_Tiling", Float) = 0
		_UPanner("UPanner", Float) = 0
		_VPanner("VPanner", Float) = 0
		[HDR]_F_Color_A("F_Color_A", Color) = (0,0,0,0)
		[HDR]_F_Color_B("F_Color_B", Color) = (0,0,0,0)
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 1.71
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		_Opacity_Pow("Opacity_Pow", Range( 1 , 10)) = 2.270588
		_Opcity_Scale("Opcity_Scale", Range( 1 , 10)) = 2.164706
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Toggle(_DITHER_ONOFF_ON)] _Dither_OnOff("Dither_On/Off", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _DITHER_ONOFF_ON
		#pragma shader_feature _USE_CUSTOM_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 screenPosition;
		};

		uniform sampler2D _TriplanarTexture;
		uniform float _U_Tiling;
		uniform float _V_Tiling;
		uniform float _UPanner;
		uniform float _VPanner;
		uniform float _Tex_Pow;
		uniform float _Tex_Ins;
		uniform float4 _F_Color_A;
		uniform float4 _F_Color_B;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float _Opcity_Scale;
		uniform float _Opacity_Pow;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve_Val;
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
			float2 appendResult63 = (float2(_U_Tiling , _V_Tiling));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult56 = (float2(_UPanner , _VPanner));
			float4 triplanar66 = TriplanarSamplingSF( _TriplanarTexture, ( ase_worldViewDir + float3( ( _Time.y * appendResult56 ) ,  0.0 ) ), ase_worldNormal, 1.0, appendResult63, 1.0, 0 );
			float4 temp_cast_1 = (_Tex_Pow).xxxx;
			float fresnelNdotV65 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode65 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV65, _Fresnel_Pow ) );
			float4 lerpResult74 = lerp( _F_Color_A , _F_Color_B , saturate( fresnelNode65 ));
			o.Emission = ( ( pow( triplanar66 , temp_cast_1 ) * _Tex_Ins ) + lerpResult74 ).xyz;
			o.Alpha = 1;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float dotResult88 = dot( ase_worldViewDir , ase_vertexNormal );
			float dotResult87 = dot( dotResult88 , dotResult88 );
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch101 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch101 = _Dissolve_Val;
			#endif
			float4 temp_output_100_0 = ( pow( ( dotResult87 * _Opcity_Scale ) , _Opacity_Pow ) * ( tex2D( _Dissolve_Tex, uv0_Dissolve_Tex ) + staticSwitch101 ) );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen78 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither78 = Dither4x4Bayer( fmod(clipScreen78.x, 4), fmod(clipScreen78.y, 4) );
			dither78 = step( dither78, temp_output_100_0.r );
			float4 temp_cast_5 = (dither78).xxxx;
			#ifdef _DITHER_ONOFF_ON
				float4 staticSwitch95 = temp_cast_5;
			#else
				float4 staticSwitch95 = temp_output_100_0;
			#endif
			clip( staticSwitch95.r - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;73;1284;705;1845.127;-506.3472;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;54;-1953.155,-653.2714;Float;False;Property;_UPanner;UPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1954.155,-561.2713;Float;False;Property;_VPanner;VPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;82;-1291.213,229.6214;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalVertexDataNode;81;-1285.651,391.2277;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;56;-1727.155,-636.2714;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;57;-1806.155,-779.2714;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;88;-1062.16,297.9435;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1440.287,-501.2375;Float;True;Property;_V_Tiling;V_Tiling;4;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;87;-812.3229,305.671;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-732.0871,972.6404;Float;False;Property;_Dissolve_Val;Dissolve_Val;17;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-893.0646,563.0377;Float;False;Property;_Opcity_Scale;Opcity_Scale;12;0;Create;True;0;0;False;0;2.164706;3.850362;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-1598.155,-783.2714;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;97;-1062.206,705.4564;Float;False;0;96;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;60;-1864.287,-1003.237;Float;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexCoordVertexDataNode;102;-1059.269,1045.237;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-1440.287,-645.2374;Float;False;Property;_U_Tiling;U_Tiling;3;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;96;-742.297,695.6697;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;16;0;Create;True;0;0;False;0;None;c220f5ca8dd80ab428a59cf7da722c81;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;63;-1264.287,-613.2374;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-581.3412,305.8892;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1233.9,38.06651;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;9;0;Create;True;0;0;False;0;1.71;3.818435;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;101;-439.1377,985.2126;Float;False;Property;_Use_Custom;Use_Custom;15;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-1449.155,-890.2714;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1178.348,-49.25999;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-613.1925,562.9315;Float;False;Property;_Opacity_Pow;Opacity_Pow;11;0;Create;True;0;0;False;0;2.270588;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;65;-958.199,-191.1902;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1099.155,-608.2711;Float;False;Property;_Tex_Pow;Tex_Pow;1;0;Create;True;0;0;False;0;0;1.5;1;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;98;-278.7924,701.2834;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;84;-328.894,305.3613;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;66;-1201.08,-891.1976;Float;True;Spherical;World;False;Triplanar Texture;_TriplanarTexture;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-48.95674,305.4374;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;72;-766.1553,-871.2711;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-811.1553,-650.2711;Float;False;Property;_Tex_Ins;Tex_Ins;2;0;Create;True;0;0;False;0;0;3.62;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-686.1556,-541.2712;Float;False;Property;_F_Color_A;F_Color_A;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.3070848,0.07208972,0.3396226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;69;-683.1556,-376.2712;Float;False;Property;_F_Color_B;F_Color_B;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.931179,6.385607,19.49572,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;73;-640.8942,-186.4964;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;74;-406.0069,-540.0452;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-483.1554,-866.2711;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DitheringNode;78;261.4843,343.1982;Float;False;0;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-142.448,-703.5684;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;95;457.4562,199.4738;Float;False;Property;_Dither_OnOff;Dither_On/Off;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;763.2566,-762.1735;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/After_Shadow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;13;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;88;0;82;0
WireConnection;88;1;81;0
WireConnection;87;0;88;0
WireConnection;87;1;88;0
WireConnection;58;0;57;0
WireConnection;58;1;56;0
WireConnection;96;1;97;0
WireConnection;63;0;61;0
WireConnection;63;1;59;0
WireConnection;86;0;87;0
WireConnection;86;1;76;0
WireConnection;101;1;99;0
WireConnection;101;0;102;3
WireConnection;64;0;60;0
WireConnection;64;1;58;0
WireConnection;65;2;94;0
WireConnection;65;3;62;0
WireConnection;98;0;96;0
WireConnection;98;1;101;0
WireConnection;84;0;86;0
WireConnection;84;1;80;0
WireConnection;66;9;64;0
WireConnection;66;3;63;0
WireConnection;100;0;84;0
WireConnection;100;1;98;0
WireConnection;72;0;66;0
WireConnection;72;1;67;0
WireConnection;73;0;65;0
WireConnection;74;0;71;0
WireConnection;74;1;69;0
WireConnection;74;2;73;0
WireConnection;75;0;72;0
WireConnection;75;1;70;0
WireConnection;78;0;100;0
WireConnection;85;0;75;0
WireConnection;85;1;74;0
WireConnection;95;1;100;0
WireConnection;95;0;78;0
WireConnection;0;2;85;0
WireConnection;0;10;95;0
ASEEND*/
//CHKSM=73CA073F4336906E3F2CC23AC2F6B3392DEFC661