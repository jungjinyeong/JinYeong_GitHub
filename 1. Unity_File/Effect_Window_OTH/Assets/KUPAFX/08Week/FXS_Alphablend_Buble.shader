// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Buble"
{
	Properties
	{
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 6.6
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Chromatic_Val("Chromatic_Val", Range( 0 , 0.05)) = 0
		_Vertex_Str("Vertex_Str", Range( 0 , 10)) = 0
		_Vertex_Noise_Tex("Vertex_Noise_Tex", 2D) = "white" {}
		_Vertex_Noise_Panner("Vertex_Noise_Panner", Float) = 0.18
		_Normal_Textrue("Normal_Textrue", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 5)) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Vertex_Noise_Tex;
		uniform float _Vertex_Noise_Panner;
		uniform float _Vertex_Str;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _Normal_Textrue;
		uniform float4 _Normal_Textrue_ST;
		uniform float _Normal_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Main_Tex;
		uniform float _Chromatic_Val;
		uniform float4 _Tint_Color;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult39 = (float2(0.0 , _Vertex_Noise_Panner));
			float2 panner34 = ( 1.0 * _Time.y * appendResult39 + v.texcoord.xy);
			v.vertex.xyz += ( ( ase_vertexNormal * ( saturate( pow( tex2Dlod( _Vertex_Noise_Tex, float4( panner34, 0, 0.0) ).r , 4.0 ) ) * saturate( pow( ( ( saturate( ( 1.0 - v.texcoord.xy.y ) ) * v.texcoord.xy.y ) * 4.0 ) , 6.0 ) ) ) ) * _Vertex_Str );
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 uv_Normal_Textrue = i.uv_texcoord * _Normal_Textrue_ST.xy + _Normal_Textrue_ST.zw;
			float2 panner56 = ( 1.0 * _Time.y * float2( 0,-0.15 ) + uv_Normal_Textrue);
			float4 screenColor50 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _Normal_Textrue, panner56 ), _Normal_Scale ) , 0.0 ) ).xy);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1, _Fresnel_Pow ) );
			float temp_output_7_0 = saturate( fresnelNode1 );
			float2 panner17 = ( 1.0 * _Time.y * float2( 0,-0.145 ) + i.uv_texcoord);
			float2 temp_output_15_0 = (panner17*float2( 0.5,2 ) + 0.0);
			float2 temp_cast_2 = (_Chromatic_Val).xx;
			float3 appendResult23 = (float3(tex2D( _Main_Tex, ( temp_output_15_0 + _Chromatic_Val ) ).r , tex2D( _Main_Tex, temp_output_15_0 ).g , tex2D( _Main_Tex, ( temp_output_15_0 - temp_cast_2 ) ).b));
			o.Emission = ( screenColor50 + ( float4( ( temp_output_7_0 * ( temp_output_7_0 + appendResult23 ) ) , 0.0 ) * _Tint_Color ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1576;741;5470.947;2152.58;5.922109;True;False
Node;AmplifyShaderEditor.CommentaryNode;63;-2094.294,677.4029;Inherit;False;1636.826;803.0002;채널분리;13;14;18;16;17;26;15;25;24;19;6;20;21;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;62;676.0267,280.2396;Inherit;False;1691.104;1273.675;Vertexno _Normal;22;33;41;38;43;37;45;42;39;44;47;34;46;32;30;49;31;27;40;48;61;28;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2044.294,783.9478;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;726.0267,839.4064;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;18;-1957.58,947.6136;Float;False;Constant;_Vector1;Vector 1;1;0;Create;True;0;0;0;False;0;False;0,-0.145;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;16;-1797.58,963.6136;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;0;False;0;False;0.5,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;17;-1804.58,777.6136;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;41;1063.512,1274.914;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;781.9651,1088.414;Float;False;Property;_Vertex_Noise_Panner;Vertex_Noise_Panner;5;0;Create;True;0;0;0;False;0;False;0.18;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;844.66,1003.63;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;1006.735,1040.332;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1635.467,1051.403;Float;False;Property;_Chromatic_Val;Chromatic_Val;2;0;Create;True;0;0;0;False;0;False;0;0.0061;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;64;-1332.467,-111.1961;Inherit;False;830.4305;304.2573;프레넬;3;9;1;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;15;-1535.581,933.6136;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;43;1217.512,1274.914;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1461.512,1430.914;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;34;1062.027,877.4064;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;19;-1261.581,1003.614;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;0;False;0;False;None;8d21b35fab1359d4aa689ddf302e1b01;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1255.468,727.4029;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-1232.468,1226.403;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1282.467,-17.05569;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;0;0;Create;True;0;0;0;False;0;False;6.6;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1386.511,1191.914;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-1029.197,-959.2518;Inherit;False;1448.485;465;grab공간 일그러진 역할;8;58;57;54;56;51;53;52;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;30;1244.027,840.4064;Inherit;True;Property;_Vertex_Noise_Tex;Vertex_Noise_Tex;4;0;Create;True;0;0;0;False;0;False;-1;None;6904366d56281b64b949da6521ac47d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;58;-880.1974,-758.5985;Float;False;Constant;_Vector2;Vector 2;8;0;Create;True;0;0;0;False;0;False;0,-0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-979.1974,-907.5985;Inherit;False;0;53;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;1590.512,1192.914;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;1644.512,1437.914;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;1383.027,1038.407;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1000.581,784.6136;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;1;-1016.325,-61.19611;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-1002.581,1207.614;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-1008.581,1007.614;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;23;-692.468,1032.403;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;46;1811.512,1187.914;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;1555.927,833.6065;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;-687.1974,-864.5985;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;7;-700.0361,-60.93881;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-639.5104,-625.2518;Float;False;Property;_Normal_Scale;Normal_Scale;7;0;Create;True;0;0;0;False;0;False;0;0.18;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;2036.512,1189.914;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-226.6623,35.28807;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;61;1761.36,813.1632;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;51;-257.5105,-907.5476;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;-360.5105,-724.2518;Inherit;True;Property;_Normal_Textrue;Normal_Textrue;6;0;Create;True;0;0;0;False;0;False;-1;None;ca13f4c0cd8f4eb4fb22f7b62e6e0d7e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1892.328,828.939;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;27;1540.861,619.4346;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;60;283.0524,79.49349;Float;False;Property;_Tint_Color;Tint_Color;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.7647189,1.058316,1.741101,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-9.510486,-789.2518;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;49.51837,-57.4878;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;2132.131,634.4088;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;29;1429.028,462.6439;Float;False;Property;_Vertex_Str;Vertex_Str;3;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;579.5096,-55.31421;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;50;223.2872,-762.3119;Float;False;Global;_GrabScreen0;Grab Screen 0;6;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1706.658,330.2396;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;720.4252,-467.8611;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1092.6,-247.0949;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Buble;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;14;0
WireConnection;17;2;18;0
WireConnection;41;0;33;2
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;15;0;17;0
WireConnection;15;1;16;0
WireConnection;43;0;41;0
WireConnection;34;0;33;0
WireConnection;34;2;39;0
WireConnection;24;0;15;0
WireConnection;24;1;26;0
WireConnection;25;0;15;0
WireConnection;25;1;26;0
WireConnection;42;0;43;0
WireConnection;42;1;33;2
WireConnection;30;1;34;0
WireConnection;44;0;42;0
WireConnection;44;1;45;0
WireConnection;6;0;19;0
WireConnection;6;1;24;0
WireConnection;1;3;9;0
WireConnection;21;0;19;0
WireConnection;21;1;25;0
WireConnection;20;0;19;0
WireConnection;20;1;15;0
WireConnection;23;0;6;1
WireConnection;23;1;20;2
WireConnection;23;2;21;3
WireConnection;46;0;44;0
WireConnection;46;1;47;0
WireConnection;31;0;30;1
WireConnection;31;1;32;0
WireConnection;56;0;57;0
WireConnection;56;2;58;0
WireConnection;7;0;1;0
WireConnection;49;0;46;0
WireConnection;12;0;7;0
WireConnection;12;1;23;0
WireConnection;61;0;31;0
WireConnection;53;1;56;0
WireConnection;53;5;54;0
WireConnection;48;0;61;0
WireConnection;48;1;49;0
WireConnection;52;0;51;0
WireConnection;52;1;53;0
WireConnection;13;0;7;0
WireConnection;13;1;12;0
WireConnection;40;0;27;0
WireConnection;40;1;48;0
WireConnection;59;0;13;0
WireConnection;59;1;60;0
WireConnection;50;0;52;0
WireConnection;28;0;40;0
WireConnection;28;1;29;0
WireConnection;55;0;50;0
WireConnection;55;1;59;0
WireConnection;0;2;55;0
WireConnection;0;11;28;0
ASEEND*/
//CHKSM=C727831EBEAC3738F09A230D2A8C3B54EDDAF63A