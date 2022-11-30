// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/WaterBall"
{
	Properties
	{
		_Ice_Texture("Ice_Texture", 2D) = "white" {}
		_Ice_Tex_Normal("Ice_Tex_Normal", 2D) = "bump" {}
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 6.188235
		_Normal_Scale("Normal_Scale", Range( 0 , 3)) = 0.7882353
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,0)
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Parallax_Texture("Parallax_Texture", 2D) = "white" {}
		_Parallax_Scale("Parallax_Scale", Range( -10 , 10)) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissove("Dissove", Range( -0.2 , 1)) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		_Ice_Tex_VPanner("Ice_Tex_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[Toggle(_KEYWORD0_ON)] _Keyword0("Keyword 0", Float) = 0
		_Fade_Distance("Fade_Distance", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma shader_feature _KEYWORD0_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 screenPos;
		};

		uniform float4 _Fresnel_Color;
		uniform float _Normal_Scale;
		uniform sampler2D _Ice_Tex_Normal;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Ice_Texture;
		uniform float _Ice_Tex_VPanner;
		uniform sampler2D _Parallax_Texture;
		uniform float _Parallax_Scale;
		uniform float4 _Tint_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_Tex_VPanner;
		uniform float _Dissove;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float fresnelNdotV33 = dot( UnpackScaleNormal( tex2D( _Ice_Tex_Normal, i.uv_texcoord ), _Normal_Scale ), i.viewDir );
			float fresnelNode33 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV33, _Fresnel_Pow ) );
			float2 appendResult23 = (float2(0.0 , _Ice_Tex_VPanner));
			float2 Offset20 = ( ( tex2D( _Parallax_Texture, i.uv_texcoord ).r - 1 ) * i.viewDir.xy * _Parallax_Scale ) + i.uv_texcoord;
			float2 panner32 = ( 1.0 * _Time.y * appendResult23 + (Offset20*float2( 2,2 ) + 0.0));
			o.Emission = ( i.vertexColor * ( ( _Fresnel_Color * saturate( fresnelNode33 ) ) + ( tex2D( _Ice_Texture, panner32 ) * _Tint_Color ) ) ).rgb;
			float2 appendResult12 = (float2(0.0 , _Diss_Tex_VPanner));
			float2 panner22 = ( 1.0 * _Time.y * appendResult12 + i.uv_texcoord);
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch21 = i.uv_tex4coord.w;
			#else
				float staticSwitch21 = 0.0;
			#endif
			float cos34 = cos( staticSwitch21 );
			float sin34 = sin( staticSwitch21 );
			float2 rotator34 = mul( panner22 - temp_cast_1 , float2x2( cos34 , -sin34 , sin34 , cos34 )) + temp_cast_1;
			#ifdef _KEYWORD0_ON
				float staticSwitch35 = i.uv_tex4coord.z;
			#else
				float staticSwitch35 = _Dissove;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth36 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth36 = abs( ( screenDepth36 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			o.Alpha = ( i.vertexColor.a * ( step( tex2D( _Dissolve_Texture, rotator34 ).r , staticSwitch35 ) * saturate( distanceDepth36 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;12;1920;1007;1787.864;722.5226;1.034643;True;False
Node;AmplifyShaderEditor.CommentaryNode;1;-1501.831,-117.2298;Float;False;1115.365;626.9998;Parallax;8;28;20;16;8;7;6;5;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1451.831,70.12778;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;2;-1612.452,-1124.499;Float;False;1495.951;896.4332;Fresnel;10;50;49;40;33;29;27;26;24;19;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;5;-1160.467,321.7699;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;6;-1227.467,248.7699;Float;False;Property;_Parallax_Scale;Parallax_Scale;8;0;Create;True;0;0;False;0;0;0.69;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1192.467,-67.2298;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1251.618,57.6947;Float;True;Property;_Parallax_Texture;Parallax_Texture;7;0;Create;True;0;0;False;0;None;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-309.8844,318.5123;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-307.8844,412.5123;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;11;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;20;-907.4666,40.7702;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1562.452,-1074.499;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-316.7325,-104.258;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-314.7325,-10.25803;Float;False;Property;_Ice_Tex_VPanner;Ice_Tex_VPanner;12;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;16;-780.4666,302.7699;Float;False;Constant;_Vector1;Vector 1;9;0;Create;True;0;0;False;0;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;12;-98.88443,329.5123;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1305.484,-676.0662;Float;False;Property;_Normal_Scale;Normal_Scale;4;0;Create;True;0;0;False;0;0.7882353;0.171;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;14.41208,430.8304;Float;False;Constant;_Float3;Float 3;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-250.8844,143.5123;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;15;10.41208,617.8304;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-942.4845,-430.0662;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-947.4845,-344.0662;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;3;0;Create;True;0;0;False;0;6.188235;2.36;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;28;-603.4663,260.7699;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;20.41208,315.8304;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;27;-881.4845,-617.0662;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;23;-119.7325,-113.258;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;22;-10.88443,170.5123;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;21;133.4121,533.8305;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;3;293.0319,89.95728;Float;False;653;377.1619;Dissolve;3;43;37;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;24;-1013.315,-860.866;Float;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;1;0;Create;True;0;0;False;0;a193986083da480468d48b2feb42d6cd;a193986083da480468d48b2feb42d6cd;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;956.5327,657.0651;Float;False;Property;_Fade_Distance;Fade_Distance;15;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;307.0319,343.1192;Float;False;Property;_Dissove;Dissove;10;0;Create;True;0;0;False;0;0;1;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;32;-85.73251,-274.258;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;33;-602.4846,-640.0662;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;34;149.4121,277.8304;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;41;110.2681,-824.5841;Float;False;Property;_Fresnel_Color;Fresnel_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;40;-314.501,-651.6493;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;103.5108,-477.124;Float;True;Property;_Ice_Texture;Ice_Texture;0;0;Create;True;0;0;False;0;27b83114de59fc44dab96ecdeda996a0;27b83114de59fc44dab96ecdeda996a0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;344.2524,-279.3107;Float;False;Property;_Tint_Color;Tint_Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.7688679,0.8797404,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;36;1094.396,466.052;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;35;585.8826,542.7124;Float;False;Property;_Keyword0;Keyword 0;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;404.9723,139.9573;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;9;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;43;711.0319,170.1192;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;344.2681,-686.5841;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;44;1396.77,348.7012;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;408.3834,-313.8409;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;46;585.8477,-862.9706;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1043.407,179.1643;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;835.493,-474.45;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;1242.59,-170.5204;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;49;-1443.484,-804.0662;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;-0.05,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;50;-1251.484,-848.0662;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1257.367,-580.6919;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1640.616,-484.4871;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/WaterBall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;1;4;0
WireConnection;20;0;7;0
WireConnection;20;1;8;1
WireConnection;20;2;6;0
WireConnection;20;3;5;0
WireConnection;12;0;9;0
WireConnection;12;1;10;0
WireConnection;28;0;20;0
WireConnection;28;1;16;0
WireConnection;23;0;18;0
WireConnection;23;1;17;0
WireConnection;22;0;11;0
WireConnection;22;2;12;0
WireConnection;21;1;13;0
WireConnection;21;0;15;4
WireConnection;24;1;19;0
WireConnection;24;5;14;0
WireConnection;32;0;28;0
WireConnection;32;2;23;0
WireConnection;33;0;24;0
WireConnection;33;4;27;0
WireConnection;33;2;26;0
WireConnection;33;3;29;0
WireConnection;34;0;22;0
WireConnection;34;1;25;0
WireConnection;34;2;21;0
WireConnection;40;0;33;0
WireConnection;38;1;32;0
WireConnection;36;0;30;0
WireConnection;35;1;31;0
WireConnection;35;0;15;3
WireConnection;37;1;34;0
WireConnection;43;0;37;1
WireConnection;43;1;35;0
WireConnection;45;0;41;0
WireConnection;45;1;40;0
WireConnection;44;0;36;0
WireConnection;42;0;38;0
WireConnection;42;1;39;0
WireConnection;48;0;43;0
WireConnection;48;1;44;0
WireConnection;47;0;45;0
WireConnection;47;1;42;0
WireConnection;51;0;46;4
WireConnection;51;1;48;0
WireConnection;50;0;19;0
WireConnection;50;1;49;0
WireConnection;52;0;46;0
WireConnection;52;1;47;0
WireConnection;0;2;52;0
WireConnection;0;9;51;0
ASEEND*/
//CHKSM=1CF87DA5C3D49D3F91D4CAB361BC9C3D13204EC2