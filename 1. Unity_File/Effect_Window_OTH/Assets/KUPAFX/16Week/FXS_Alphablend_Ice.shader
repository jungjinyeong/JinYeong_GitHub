// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alaphablend_Ice"
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
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
		uniform float4 _Ice_Tex_Normal_ST;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Ice_Texture;
		uniform float _Ice_Tex_VPanner;
		uniform float4 _Ice_Texture_ST;
		uniform sampler2D _Parallax_Texture;
		uniform float4 _Parallax_Texture_ST;
		uniform float _Parallax_Scale;
		uniform float4 _Tint_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Dissolve_Texture_ST;
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
			float2 uv0_Ice_Tex_Normal = i.uv_texcoord * _Ice_Tex_Normal_ST.xy + _Ice_Tex_Normal_ST.zw;
			float fresnelNdotV3 = dot( UnpackScaleNormal( tex2D( _Ice_Tex_Normal, (uv0_Ice_Tex_Normal*float2( -0.05,0.5 ) + 0.0) ), _Normal_Scale ), i.viewDir );
			float fresnelNode3 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV3, _Fresnel_Pow ) );
			float2 appendResult42 = (float2(0.0 , _Ice_Tex_VPanner));
			float2 uv0_Ice_Texture = i.uv_texcoord * _Ice_Texture_ST.xy + _Ice_Texture_ST.zw;
			float2 uv0_Parallax_Texture = i.uv_texcoord * _Parallax_Texture_ST.xy + _Parallax_Texture_ST.zw;
			float2 Offset19 = ( ( tex2D( _Parallax_Texture, uv0_Parallax_Texture ).r - 1 ) * i.viewDir.xy * _Parallax_Scale ) + uv0_Ice_Texture;
			float2 panner41 = ( 1.0 * _Time.y * appendResult42 + (Offset19*float2( 2,2 ) + 0.0));
			o.Emission = ( i.vertexColor * ( ( _Fresnel_Color * saturate( fresnelNode3 ) ) + ( tex2D( _Ice_Texture, panner41 ) * _Tint_Color ) ) ).rgb;
			float2 appendResult38 = (float2(0.0 , _Diss_Tex_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner36 = ( 1.0 * _Time.y * appendResult38 + uv0_Dissolve_Texture);
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch47 = i.uv_tex4coord.w;
			#else
				float staticSwitch47 = 0.0;
			#endif
			float cos48 = cos( staticSwitch47 );
			float sin48 = sin( staticSwitch47 );
			float2 rotator48 = mul( panner36 - temp_cast_1 , float2x2( cos48 , -sin48 , sin48 , cos48 )) + temp_cast_1;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch45 = i.uv_tex4coord.z;
			#else
				float staticSwitch45 = _Dissove;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth52 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth52 = abs( ( screenDepth52 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			o.Alpha = ( i.vertexColor.a * ( step( tex2D( _Dissolve_Texture, rotator48 ).r , staticSwitch45 ) * saturate( distanceDepth52 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;69;1920;950;2776.342;820.4125;2.373148;True;False
Node;AmplifyShaderEditor.CommentaryNode;27;-1841.269,263.6541;Float;False;1115.365;626.9998;Parallax;8;20;23;22;25;19;24;21;26;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;28;-1951.89,-743.6155;Float;False;1495.951;896.4332;Fresnel;10;11;10;8;6;2;5;7;3;9;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1791.269,451.0117;Float;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1901.89,-693.6155;Float;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;11;-1782.923,-423.1823;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;-0.05,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;20;-1499.905,702.6538;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;23;-1566.905,629.6538;Float;False;Property;_Parallax_Scale;Parallax_Scale;8;0;Create;True;0;0;False;0;0;0.69;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1531.905,313.6541;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;-1591.056,438.5786;Float;True;Property;_Parallax_Texture;Parallax_Texture;7;0;Create;True;0;0;False;0;None;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-649.3229,699.3962;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-647.3229,793.3962;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;11;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;25;-1119.905,683.6538;Float;False;Constant;_Vector1;Vector 1;9;0;Create;True;0;0;False;0;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;44;-656.171,276.6259;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-654.171,370.6259;Float;False;Property;_Ice_Tex_VPanner;Ice_Tex_VPanner;12;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;19;-1246.905,421.6541;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;10;-1590.923,-467.1823;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;46;-329.0264,998.7143;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1644.923,-295.1823;Float;False;Property;_Normal_Scale;Normal_Scale;4;0;Create;True;0;0;False;0;0.7882353;0.171;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-325.0264,811.7143;Float;False;Constant;_Float3;Float 3;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-438.3229,710.3962;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-590.3229,524.3962;Float;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;24;-942.9048,641.6538;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-1220.923,-236.1823;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;5;-1281.923,-49.18231;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;2;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1286.923,36.81768;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;3;0;Create;True;0;0;False;0;6.188235;2.36;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1352.753,-479.9821;Float;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;1;0;Create;True;0;0;False;0;a193986083da480468d48b2feb42d6cd;a193986083da480468d48b2feb42d6cd;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-319.0264,696.7143;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;36;-350.3229,551.3962;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;35;-46.40662,470.8412;Float;False;653;377.1619;Dissolve;3;31;33;32;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;47;-206.0264,914.7144;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-459.171,267.6259;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;54;617.0942,1037.949;Float;False;Property;_Fade_Distance;Fade_Distance;14;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-32.40662,724.0031;Float;False;Property;_Dissove;Dissove;10;0;Create;True;0;0;False;0;0;1;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;41;-425.171,106.6259;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;3;-941.9231,-259.1823;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;48;-190.0264,658.7143;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;4;-653.9395,-270.7654;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-229.1704,-443.7002;Float;False;Property;_Fresnel_Color;Fresnel_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;4.813919,101.5732;Float;False;Property;_Tint_Color;Tint_Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.7688679,0.8797404,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-235.9277,-96.24013;Float;True;Property;_Ice_Texture;Ice_Texture;0;0;Create;True;0;0;False;0;27b83114de59fc44dab96ecdeda996a0;27b83114de59fc44dab96ecdeda996a0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;65.53381,520.8412;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;9;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;52;754.9576,846.9359;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;45;246.4441,923.5963;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;246.2634,-55.16295;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;32;371.5934,551.0031;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;968.0942,803.949;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;4.82959,-305.7002;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;29;246.4092,-482.0867;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;196.5299,-314.0162;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;703.9682,560.0482;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;484.2179,-413.0693;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;900.7552,167.232;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1022.8,-153.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alaphablend_Ice;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;1;26;0
WireConnection;19;0;22;0
WireConnection;19;1;21;1
WireConnection;19;2;23;0
WireConnection;19;3;20;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;38;0;39;0
WireConnection;38;1;40;0
WireConnection;24;0;19;0
WireConnection;24;1;25;0
WireConnection;2;1;10;0
WireConnection;2;5;8;0
WireConnection;36;0;37;0
WireConnection;36;2;38;0
WireConnection;47;1;51;0
WireConnection;47;0;46;4
WireConnection;42;0;44;0
WireConnection;42;1;43;0
WireConnection;41;0;24;0
WireConnection;41;2;42;0
WireConnection;3;0;2;0
WireConnection;3;4;7;0
WireConnection;3;2;5;0
WireConnection;3;3;6;0
WireConnection;48;0;36;0
WireConnection;48;1;50;0
WireConnection;48;2;47;0
WireConnection;4;0;3;0
WireConnection;1;1;41;0
WireConnection;31;1;48;0
WireConnection;52;0;54;0
WireConnection;45;1;33;0
WireConnection;45;0;46;3
WireConnection;15;0;1;0
WireConnection;15;1;17;0
WireConnection;32;0;31;1
WireConnection;32;1;45;0
WireConnection;53;0;52;0
WireConnection;13;0;14;0
WireConnection;13;1;4;0
WireConnection;12;0;13;0
WireConnection;12;1;15;0
WireConnection;55;0;32;0
WireConnection;55;1;53;0
WireConnection;30;0;29;0
WireConnection;30;1;12;0
WireConnection;34;0;29;4
WireConnection;34;1;55;0
WireConnection;0;2;30;0
WireConnection;0;9;34;0
ASEEND*/
//CHKSM=97EE71CED8E259F4ABABB51F9B6043CE4AECCFB2