// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/02Week_Stduy021"
{
	Properties
	{
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[HDR]_Glow_Color("Glow_Color", Color) = (1,1,1,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Depth_Face_Val("Depth_Face_Val", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 2.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 uv3_texcoord3;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform float4 _Glow_Color;
		uniform sampler2D _TextureSample2;
		uniform float _Dissolve;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Face_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float4 tex2DNode77 = tex2D( _TextureSample3, uv_TextureSample3 );
			o.Emission = ( i.vertexColor * ( tex2DNode77 * _Glow_Color ) ).rgb;
			float2 appendResult92 = (float2(i.uv2_texcoord2.z , i.uv2_texcoord2.w));
			float2 appendResult91 = (float2(i.uv2_texcoord2.x , i.uv2_texcoord2.y));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch83 = i.uv3_texcoord3.x;
			#else
				float staticSwitch83 = _Dissolve;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth96 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth96 = abs( ( screenDepth96 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth_Face_Val ) );
			o.Alpha = ( i.vertexColor.a * ( ( tex2DNode77.r * saturate( ( tex2D( _TextureSample2, (i.uv_texcoord*appendResult92 + appendResult91) ).r + staticSwitch83 ) ) ) * saturate( distanceDepth96 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1084;672;687.8304;564.2106;1.905692;True;False
Node;AmplifyShaderEditor.CommentaryNode;95;-1480.273,-487.248;Inherit;False;765.3448;403.2615;타일링 오프셋 설정방법;4;88;91;92;89;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;70;-756.8712,-767.8707;Inherit;False;2012.297;1427.303;Dissolve;18;93;75;78;76;79;69;74;77;67;83;66;68;82;90;96;97;98;99;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;88;-1430.273,-405.2481;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;91;-1109.273,-437.248;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;90;-303.328,-387.3793;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;92;-1116.273,-325.2481;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-601.6031,157.1294;Float;False;Property;_Dissolve;Dissolve;9;0;Create;True;0;0;0;False;0;False;0;-0.37;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;82;-572.5017,244.8983;Inherit;True;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;89;-931.928,-242.9865;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;66;-297.3758,-268.4713;Inherit;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;83;-282.5016,151.8982;Float;True;Property;_Use_Custom;Use_Custom;11;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;30.09773,-171.4496;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;310.7523,251.4255;Inherit;False;Property;_Depth_Face_Val;Depth_Face_Val;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;77;17.15678,-568.676;Inherit;True;Property;_TextureSample3;Texture Sample 3;2;0;Create;True;0;0;0;False;0;False;-1;ada7d7b9960604d429f82277e242d1ef;c367de5ac39165e49aeab33213590c9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;69;233.7609,-169.6148;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;96;545.1525,203.7833;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;74;330.947,-478.4377;Float;False;Property;_Glow_Color;Glow_Color;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.766829,1.722582,3.350343,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;98;783.3636,182.8207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;411.4882,-181.8125;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;629.0027,-186.8836;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;1301.131,-952.459;Inherit;False;1772;686;UV_Noise;9;64;63;62;61;56;58;60;59;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;55;1327.911,-253.301;Inherit;False;1321.227;927.4623;Glow;10;46;73;72;71;48;49;53;47;54;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;76;572.1401,-378.4651;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;603.9789,-554.2965;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;53;1713.912,60.69902;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;2168.132,-902.459;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;1514.912,307.6992;Float;False;Property;_Power;Power;3;0;Create;True;0;0;0;False;0;False;3;2.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;64;1392.132,-491.4593;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;0,0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;776.9034,-209.8331;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;722.2552,-509.7597;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;52;1377.911,81.69901;Inherit;True;Property;_FXT_Glow;FXT_Glow;1;0;Create;True;0;0;0;False;0;False;-1;ada7d7b9960604d429f82277e242d1ef;ada7d7b9960604d429f82277e242d1ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;57;2753.131,-731.4592;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;2382.074,160.2943;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;2377.074,-111.7058;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;1750.912,381.6992;Float;True;Property;_Opacity;Opacity;0;0;Create;True;0;0;0;False;0;False;0;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;71;1981.075,-132.7058;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;47;1394.911,-171.301;Float;False;Property;_Tint_Color;Tint_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;0.2859558,0.6449831,0.9622642,0;0.2859558,0.6449831,0.9622642,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;62;1625.131,-636.4592;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;2452.131,-696.4592;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;2026.91,66.69893;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;1351.131,-637.4592;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;56;1877.131,-628.4592;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;2206.132,-526.459;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;2064.911,338.6991;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;1845.131,-382.4592;Float;False;Property;_UV_Noise;UV_Noise;7;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1080.849,-466.8606;Float;False;True;-1;0;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/02Week_Stduy021;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;94;-332.5016,101.8982;Inherit;False;313;309;스위치;0;;1,1,1,1;0;0
WireConnection;91;0;88;1
WireConnection;91;1;88;2
WireConnection;92;0;88;3
WireConnection;92;1;88;4
WireConnection;89;0;90;0
WireConnection;89;1;92;0
WireConnection;89;2;91;0
WireConnection;66;1;89;0
WireConnection;83;1;68;0
WireConnection;83;0;82;1
WireConnection;67;0;66;1
WireConnection;67;1;83;0
WireConnection;69;0;67;0
WireConnection;96;0;97;0
WireConnection;98;0;96;0
WireConnection;79;0;77;1
WireConnection;79;1;69;0
WireConnection;99;0;79;0
WireConnection;99;1;98;0
WireConnection;78;0;77;0
WireConnection;78;1;74;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;93;0;76;4
WireConnection;93;1;99;0
WireConnection;75;0;76;0
WireConnection;75;1;78;0
WireConnection;57;1;59;0
WireConnection;73;0;71;4
WireConnection;73;1;49;0
WireConnection;72;0;71;0
WireConnection;72;1;48;0
WireConnection;62;0;63;0
WireConnection;62;2;64;0
WireConnection;59;0;58;0
WireConnection;59;1;60;0
WireConnection;48;0;47;0
WireConnection;48;1;53;0
WireConnection;56;1;62;0
WireConnection;60;0;56;1
WireConnection;60;1;61;0
WireConnection;49;0;52;1
WireConnection;49;1;46;0
WireConnection;0;2;75;0
WireConnection;0;9;93;0
ASEEND*/
//CHKSM=FF78E5627218729F9386A7D5CF3C9AA88F71D3C2