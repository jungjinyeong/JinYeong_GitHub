// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Smoke_Exp01"
{
	Properties
	{
		_LUT_Texture("LUT_Texture", 2D) = "white" {}
		[HDR]_ColorA("ColorA", Color) = (0,0,0,0)
		[HDR]_ColorB("ColorB", Color) = (0,0,0,0)
		_VectorY("VectorY", Float) = 1
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Str("Noise_Str", Range( 0 , 1)) = 0.85
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Smootstep_Max("Smootstep_Max", Float) = 0.37
		_Smootstep_Min("Smootstep_Min", Float) = 0.03
		_Vertex_Normal_Texture("Vertex_Normal_Texture", 2D) = "white" {}
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_VertexNormal_Str("VertexNormal_Str", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Vertex_Normal_Texture;
		uniform float4 _Vertex_Normal_Texture_ST;
		uniform float _VertexNormal_Str;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform sampler2D _LUT_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _VectorY;
		uniform float _Smootstep_Min;
		uniform float _Smootstep_Max;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv0_Vertex_Normal_Texture = v.texcoord.xy * _Vertex_Normal_Texture_ST.xy + _Vertex_Normal_Texture_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch46 = v.texcoord1.z;
			#else
				float staticSwitch46 = _VertexNormal_Str;
			#endif
			v.vertex.xyz += ( ( tex2Dlod( _Vertex_Normal_Texture, float4( uv0_Vertex_Normal_Texture, 0, 0.0) ).r * ase_vertexNormal ) * staticSwitch46 );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner11 = ( 1.0 * _Time.y * float2( 0.15,-0.15 ) + uv0_Noise_Texture);
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch44 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch44 = _VectorY;
			#endif
			float3 appendResult6 = (float3(0.0 , staticSwitch44 , 0.0));
			float dotResult7 = dot( ( ( tex2D( _Noise_Texture, panner11 ).r + _Noise_Str ) * ase_vertexNormal ) , appendResult6 );
			float2 temp_cast_0 = (saturate( dotResult7 )).xx;
			float4 lerpResult17 = lerp( _ColorA , _ColorB , tex2D( _LUT_Texture, temp_cast_0 ).r);
			o.Emission = ( lerpResult17 * i.vertexColor ).rgb;
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner39 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch45 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch45 = _Dissolve;
			#endif
			float temp_output_23_0 = ( tex2D( _Dissolve_Texture, panner39 ).r + staticSwitch45 );
			float smoothstepResult49 = smoothstep( _Smootstep_Min , _Smootstep_Max , temp_output_23_0);
			o.Alpha = ( i.vertexColor.a * saturate( smoothstepResult49 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;2976.357;1149.952;2.67258;True;False
Node;AmplifyShaderEditor.CommentaryNode;41;-1907.919,-519.4431;Float;False;1934.777;624.4117;Noise_Vector;16;1;9;7;6;3;5;8;15;12;13;11;10;2;16;44;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;13;-1767.773,-331.4291;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0.15,-0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1857.919,-469.4432;Float;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;11;-1586.499,-433.0234;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;47;-1546.612,114.4827;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-1384.542,-454.7313;Float;True;Property;_Noise_Texture;Noise_Texture;5;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-1323.233,-267.2613;Float;False;Property;_Noise_Str;Noise_Str;6;0;Create;True;0;0;False;0;0.85;0.374;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-1118.169,116.2256;Float;False;1653.573;415;Dissolve;10;22;24;23;27;26;39;40;38;25;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1036.118,-11.11673;Float;False;Property;_VectorY;VectorY;4;0;Create;True;0;0;False;0;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-1283.542,-185.7313;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;44;-881.6121,9.4827;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-1068.169,202.0209;Float;False;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1032.282,-123.429;Float;False;Constant;_VectorX;VectorX;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1004.282,-203.429;Float;False;Constant;_VectorZ;VectorZ;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1055.596,-430.03;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;40;-1009.887,327.0628;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;24;-744.4803,398.2255;Float;False;Property;_Dissolve;Dissolve;8;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;39;-870.5866,209.9628;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-777.9048,-182.5183;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-911.8762,-435.1128;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;22;-684.4803,182.2255;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;7;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;45;-468.6118,490.4827;Float;False;Property;_Use_Custom;Use_Custom;11;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-434.1967,663.5579;Float;False;1071.618;450.9999;VertexNormal;6;34;32;36;33;35;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;7;-657.122,-359.9749;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-297.8118,270.9769;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-25.16681,405.6817;Float;False;Property;_Smootstep_Min;Smootstep_Min;10;0;Create;True;0;0;False;0;0.03;0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-384.1967,752.9526;Float;False;0;32;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;-75.24963,502.3436;Float;False;Property;_Smootstep_Max;Smootstep_Max;9;0;Create;True;0;0;False;0;0.37;0.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-456.8908,-362.2388;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;49;148.4055,390.255;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-259.2394,-360.3195;Float;True;Property;_LUT_Texture;LUT_Texture;1;0;Create;True;0;0;False;0;f2096819c1bb1314ab53917155b185c7;ae551726e7cab524688cc6b6ab4f87c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;33.6251,-716.1091;Float;False;Property;_ColorA;ColorA;2;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.1132075,0.00160199,0.00160199,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;42.6251,-521.1091;Float;False;Property;_ColorB;ColorB;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.118547,1.475219,0.9317172,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-120.1998,713.5579;Float;True;Property;_Vertex_Normal_Texture;Vertex_Normal_Texture;11;0;Create;True;0;0;False;0;None;6e5343f0266cf36489aa21b41e5bc1f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;140.8002,992.5584;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;12;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;34;-84.19976,931.5579;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;184.8002,747.5579;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;17;280.6251,-550.1091;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;25;493.8179,200.3672;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;29;361.3224,-105.2533;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;46;198.3882,1136.483;Float;False;Property;_Use_Custom;Use_Custom;12;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-160.1298,163.7417;Float;False;Constant;_Float0;Float 0;9;0;Create;True;0;0;False;0;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;911.3307,54.67566;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;402.4213,752.0753;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;719.3307,-157.3243;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;26;152.9274,164.4168;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1243.509,-145.6555;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Smoke_Exp01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;12;0
WireConnection;11;2;13;0
WireConnection;10;1;11;0
WireConnection;44;1;4;0
WireConnection;44;0;47;1
WireConnection;15;0;10;1
WireConnection;15;1;16;0
WireConnection;39;0;38;0
WireConnection;39;2;40;0
WireConnection;6;0;3;0
WireConnection;6;1;44;0
WireConnection;6;2;5;0
WireConnection;8;0;15;0
WireConnection;8;1;2;0
WireConnection;22;1;39;0
WireConnection;45;1;24;0
WireConnection;45;0;47;2
WireConnection;7;0;8;0
WireConnection;7;1;6;0
WireConnection;23;0;22;1
WireConnection;23;1;45;0
WireConnection;9;0;7;0
WireConnection;49;0;23;0
WireConnection;49;1;50;0
WireConnection;49;2;51;0
WireConnection;1;1;9;0
WireConnection;32;1;37;0
WireConnection;33;0;32;1
WireConnection;33;1;34;0
WireConnection;17;0;20;0
WireConnection;17;1;21;0
WireConnection;17;2;1;1
WireConnection;25;0;49;0
WireConnection;46;1;36;0
WireConnection;46;0;47;3
WireConnection;31;0;29;4
WireConnection;31;1;25;0
WireConnection;35;0;33;0
WireConnection;35;1;46;0
WireConnection;30;0;17;0
WireConnection;30;1;29;0
WireConnection;26;0;27;0
WireConnection;26;1;23;0
WireConnection;0;2;30;0
WireConnection;0;9;31;0
WireConnection;0;11;35;0
ASEEND*/
//CHKSM=426EA2B65F125A6D055EF4ADC2340B38A47D532D