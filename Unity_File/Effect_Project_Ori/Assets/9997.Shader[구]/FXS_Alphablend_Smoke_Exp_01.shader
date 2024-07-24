// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Smoke_EXP"
{
	Properties
	{
		_LUT_Texture("LUT_Texture", 2D) = "white" {}
		_VectorY("VectorY", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		[HDR]_Color_A("Color_A", Color) = (0,0,0,0)
		_Noise_Str("Noise_Str", Float) = 0.85
		[HDR]_Color_B("Color_B", Color) = (0,0,0,0)
		_Noise_Texture_Panner("Noise_Texture_Panner", Vector) = (0.15,-0.15,0,0)
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 0
		_Float0("Float 0", Float) = 0
		_Vertex_Nomal_Texture("Vertex_Nomal_Texture", 2D) = "white" {}
		_VertexNomal_Str("VertexNomal_Str", Range( 0 , 10)) = 0
		_Dissolve_Panner("Dissolve_Panner", Vector) = (0,0,0,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
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

		uniform sampler2D _Vertex_Nomal_Texture;
		uniform float4 _Vertex_Nomal_Texture_ST;
		uniform float _VertexNomal_Str;
		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _LUT_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float2 _Noise_Texture_Panner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _VectorY;
		uniform float _Float0;
		uniform sampler2D _Dissolve_Texture;
		uniform float2 _Dissolve_Panner;
		uniform float _Dissolve_Val;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv0_Vertex_Nomal_Texture = v.texcoord.xy * _Vertex_Nomal_Texture_ST.xy + _Vertex_Nomal_Texture_ST.zw;
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch46 = v.texcoord1.z;
			#else
				float staticSwitch46 = _VertexNomal_Str;
			#endif
			v.vertex.xyz += ( ( tex2Dlod( _Vertex_Nomal_Texture, float4( uv0_Vertex_Nomal_Texture, 0, 0.0) ) * float4( ase_vertexNormal , 0.0 ) ) * staticSwitch46 ).rgb;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner12 = ( 1.0 * _Time.y * _Noise_Texture_Panner + uv0_Noise_Texture);
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch45 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch45 = _VectorY;
			#endif
			float3 appendResult7 = (float3(0.0 , staticSwitch45 , 0.0));
			float dotResult8 = dot( ( ( tex2D( _Noise_Texture, panner12 ).r + _Noise_Str ) * ase_vertexNormal ) , appendResult7 );
			float2 temp_cast_0 = (saturate( dotResult8 )).xx;
			float4 lerpResult19 = lerp( _Color_A , _Color_B , tex2D( _LUT_Texture, temp_cast_0 ).r);
			o.Emission = ( lerpResult19 * i.vertexColor ).rgb;
			float4 temp_cast_2 = (_Float0).xxxx;
			float2 panner40 = ( 1.0 * _Time.y * _Dissolve_Panner + i.uv_texcoord);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch47 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch47 = _Dissolve_Val;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( step( temp_cast_2 , ( tex2D( _Dissolve_Texture, panner40 ) + staticSwitch47 ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;2560;1005;3160.068;-21.36974;2.047146;True;False
Node;AmplifyShaderEditor.CommentaryNode;43;-1981.79,-420.3471;Float;False;2173.62;749.7771;Noise_Vecter;16;15;13;12;10;17;2;16;18;7;4;5;3;8;9;1;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;15;-1935.121,-215.7751;Float;False;Property;_Noise_Texture_Panner;Noise_Texture_Panner;7;0;Create;True;0;0;False;0;0.15,-0.15;0.15,-0.15;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1931.79,-361.3471;Float;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;12;-1659.275,-363.3471;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1408.563,89.38876;Float;False;Property;_VectorY;VectorY;2;0;Create;True;0;0;False;0;0;1.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1454.275,-364.3471;Float;True;Property;_Noise_Texture;Noise_Texture;3;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;48;-2007.011,416.0081;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;42;-1470.549,363.1018;Float;False;1650.054;538.4812;Dissolve;10;47;25;26;28;29;24;23;40;41;39;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1297.275,-163.3472;Float;False;Property;_Noise_Str;Noise_Str;5;0;Create;True;0;0;False;0;0.85;0.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-994.6179,69.2218;Float;False;Constant;_VectorX;VectorX;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-1420.549,509.6967;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1071.275,-369.3471;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-1087.925,-128.8203;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;45;-1214.078,123.072;Float;False;Property;_Use_Custom;Use_Custom;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-996.8146,213.43;Float;False;Constant;_VectorZ;VectorZ;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-1282.2,654.5829;Float;False;Property;_Dissolve_Panner;Dissolve_Panner;13;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-818.2749,-370.3471;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;40;-1022.596,517.0323;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-703.7518,136.6599;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;49;-1762.016,762.7529;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1041.353,690.8277;Float;False;Property;_Dissolve_Val;Dissolve_Val;9;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;47;-713.9915,777.6178;Float;False;Property;_Use_Custom;Use_Custom;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;8;-551.5817,-369.5583;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-802.0972,489.1028;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;8;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;44;200.5447,845.4645;Float;False;1186.964;555.6646;Vertex_Nomal;7;38;34;33;36;35;37;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;9;-341.8591,-364.4909;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-429.5031,413.1018;Float;False;Property;_Float0;Float 0;10;0;Create;True;0;0;False;0;0;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-475.0678,503.2242;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;250.5447,935.4799;Float;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;626.14,1239.129;Float;False;Property;_VertexNomal_Str;VertexNomal_Str;12;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;34;420.8344,1173.77;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;253.337,-657.2377;Float;False;Property;_Color_A;Color_A;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.2830189,0.04138483,0.04138483,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-128.1693,-359.6054;Float;True;Property;_LUT_Texture;LUT_Texture;1;0;Create;True;0;0;False;0;f2096819c1bb1314ab53917155b185c7;f2096819c1bb1314ab53917155b185c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;28;-242.5631,495.9235;Float;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;22;265.3369,-488.2378;Float;False;Property;_Color_B;Color_B;6;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.36994,1.210842,0.6002467,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;33;577.6244,895.4645;Float;True;Property;_Vertex_Nomal_Texture;Vertex_Nomal_Texture;11;0;Create;True;0;0;False;0;None;6e5343f0266cf36489aa21b41e5bc1f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;50;-1755.349,1178.384;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;26;-22.49494,497.1063;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;906.13,1003.802;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;30;603.144,39.61457;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;19;575.052,-379.3539;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;46;925.0524,1270.769;Float;False;Property;_Use_Custom;Use_Custom;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;927.2916,349.2767;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;924.2253,-379.5327;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1152.509,1017.78;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1568.424,-56.19688;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Smoke_EXP;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;13;0
WireConnection;12;2;15;0
WireConnection;10;1;12;0
WireConnection;16;0;10;1
WireConnection;16;1;17;0
WireConnection;45;1;4;0
WireConnection;45;0;48;1
WireConnection;18;0;16;0
WireConnection;18;1;2;0
WireConnection;40;0;39;0
WireConnection;40;2;41;0
WireConnection;7;0;3;0
WireConnection;7;1;45;0
WireConnection;7;2;5;0
WireConnection;49;0;48;2
WireConnection;47;1;25;0
WireConnection;47;0;49;0
WireConnection;8;0;18;0
WireConnection;8;1;7;0
WireConnection;23;1;40;0
WireConnection;9;0;8;0
WireConnection;24;0;23;0
WireConnection;24;1;47;0
WireConnection;1;1;9;0
WireConnection;28;0;29;0
WireConnection;28;1;24;0
WireConnection;33;1;38;0
WireConnection;50;0;48;3
WireConnection;26;0;28;0
WireConnection;36;0;33;0
WireConnection;36;1;34;0
WireConnection;19;0;20;0
WireConnection;19;1;22;0
WireConnection;19;2;1;1
WireConnection;46;1;37;0
WireConnection;46;0;50;0
WireConnection;32;0;30;4
WireConnection;32;1;26;0
WireConnection;31;0;19;0
WireConnection;31;1;30;0
WireConnection;35;0;36;0
WireConnection;35;1;46;0
WireConnection;0;2;31;0
WireConnection;0;9;32;0
WireConnection;0;11;35;0
ASEEND*/
//CHKSM=A3800F59D685E88E645A30E17829BB1286BBD049