// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Water_Toon"
{
	Properties
	{
		_FXT_Water01("FXT_Water01", 2D) = "white" {}
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 5)) = 0.1
		_Dissolve_Texure("Dissolve_Texure", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 1
		_FXT_Water01_Normal("FXT_Water01_Normal", 2D) = "bump" {}
		_Highlingt("Highlingt", Float) = 12
		[HDR]_ColorA("ColorA", Color) = (1,1,1,0)
		[HDR]_ColorB("ColorB", Color) = (0,0.1739125,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform sampler2D _FXT_Water01_Normal;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _Highlingt;
		uniform float4 _ColorB;
		uniform float4 _ColorA;
		uniform sampler2D _FXT_Water01;
		uniform sampler2D _Dissolve_Texure;
		uniform float4 _Dissolve_Texure_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + uv0_Noise_Texture);
			float3 temp_output_4_0 = ( (UnpackNormal( tex2D( _Noise_Texture, panner8 ) )).xyz * _Noise_Str );
			float2 temp_cast_2 = (1.1).xx;
			float4 tex2DNode1 = tex2D( _FXT_Water01, ( float3( i.uv_texcoord ,  0.0 ) + temp_output_4_0 ).xy );
			float4 lerpResult55 = lerp( _ColorB , _ColorA , tex2DNode1.r);
			o.Emission = ( ( saturate( ( pow( ( 1.0 - length( abs( ( (UnpackNormal( tex2D( _FXT_Water01_Normal, ( float3( i.uv_texcoord ,  0.0 ) + temp_output_4_0 ).xy ) )).xy - temp_cast_2 ) ) ) ) , 1.0 ) * _Highlingt ) ) + lerpResult55 ) * i.vertexColor ).rgb;
			float2 uv0_Dissolve_Texure = i.uv_texcoord * _Dissolve_Texure_ST.xy + _Dissolve_Texure_ST.zw;
			float2 temp_cast_6 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch30 = i.uv_tex4coord.w;
			#else
				float staticSwitch30 = 0.0;
			#endif
			float cos28 = cos( staticSwitch30 );
			float sin28 = sin( staticSwitch30 );
			float2 rotator28 = mul( uv0_Dissolve_Texure - temp_cast_6 , float2x2( cos28 , -sin28 , sin28 , cos28 )) + temp_cast_6;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch26 = i.uv_tex4coord.z;
			#else
				float staticSwitch26 = _Dissolve;
			#endif
			o.Alpha = ( step( 0.1 , ( tex2DNode1.r * saturate( ( saturate( ( pow( tex2D( _Dissolve_Texure, rotator28 ).r , 3.0 ) * 4.0 ) ) + staticSwitch26 ) ) ) ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;923.2372;894.3287;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1207.962,207.7803;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;10;-1124.962,354.7802;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;8;-962.9626,246.7803;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-764.9626,240.7803;Float;True;Property;_Noise_Texture;Noise_Texture;1;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;3;-475.2515,238.9435;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-538.9625,451.7801;Float;False;Property;_Noise_Str;Noise_Str;2;0;Create;True;0;0;False;0;0.1;0.08;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1717.98,693.5742;Float;False;1970.958;861.6489;Dissolve;16;28;29;25;31;30;27;16;22;15;21;18;23;26;17;19;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-227.9624,340.7802;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-2004.236,-483.3825;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-1603.143,1322.81;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1473.443,1129.311;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-1704.833,-422.7674;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;34;-1555.865,-462.5212;Float;True;Property;_FXT_Water01_Normal;FXT_Water01_Normal;6;0;Create;True;0;0;False;0;635035644f4199548a8fe4a830af641c;d8a10ebbd112c2946a8223b63754375c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1628.043,785.111;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1425.243,957.811;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;30;-1336.743,1130.411;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;28;-1282.243,786.811;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1221.359,-260.2682;Float;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;35;-1256.359,-462.2682;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1019.315,926.8742;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-1122.315,743.5742;Float;True;Property;_Dissolve_Texure;Dissolve_Texure;3;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-1001.359,-452.2682;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-706.0219,969.5269;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-835.3151,743.8742;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;38;-797.3593,-453.2682;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;39;-629.3593,-449.2682;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-596.022,751.5268;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-481.2222,979.4269;Float;False;Property;_Dissolve;Dissolve;4;0;Create;True;0;0;False;0;0;-0.05;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-562.3593,-196.2682;Float;False;Constant;_Float5;Float 5;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-389.022,750.5268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;26;-131.2431,1172.811;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-279.9624,66.78039;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;60;-451.2372,-437.3287;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;-264.3593,-448.2682;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;120.6407,-489.2682;Float;False;Property;_Highlingt;Highlingt;7;0;Create;True;0;0;False;0;12;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-35.12555,101.7173;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-159.0223,763.5268;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;128.0374,-30.30543;Float;True;Property;_FXT_Water01;FXT_Water01;0;0;Create;True;0;0;False;0;ace0dd7ee505acc488ee8881271bca01;ace0dd7ee505acc488ee8881271bca01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;19;46.08086,773.3547;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;323.7937,-771.8216;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;57;130.9834,-385.6615;Float;False;Property;_ColorB;ColorB;9;1;[HDR];Create;True;0;0;False;0;0,0.1739125,1,0;0,0.3296814,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;56;140.9834,-222.6616;Float;False;Property;_ColorA;ColorA;8;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;565.9755,346.7041;Float;False;Constant;_Float7;Float 7;10;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;480.5645,423.1407;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;55;421.3297,-311.6629;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;59;557.8732,-719.8802;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;32;936.0804,-123.2156;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;52;764.9755,407.7041;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;669.6732,-467.0099;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;1263.292,60.27205;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;1250.962,-246.3853;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1475.63,-368.8917;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Water_Toon;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;9;0
WireConnection;8;2;10;0
WireConnection;2;1;8;0
WireConnection;3;0;2;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;45;0;44;0
WireConnection;45;1;4;0
WireConnection;34;1;45;0
WireConnection;30;1;31;0
WireConnection;30;0;25;4
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;28;2;30;0
WireConnection;35;0;34;0
WireConnection;14;1;28;0
WireConnection;36;0;35;0
WireConnection;36;1;37;0
WireConnection;15;0;14;1
WireConnection;15;1;16;0
WireConnection;38;0;36;0
WireConnection;39;0;38;0
WireConnection;21;0;15;0
WireConnection;21;1;22;0
WireConnection;23;0;21;0
WireConnection;26;1;18;0
WireConnection;26;0;25;3
WireConnection;60;0;39;0
WireConnection;40;0;60;0
WireConnection;40;1;41;0
WireConnection;7;0;6;0
WireConnection;7;1;4;0
WireConnection;17;0;23;0
WireConnection;17;1;26;0
WireConnection;1;1;7;0
WireConnection;19;0;17;0
WireConnection;42;0;40;0
WireConnection;42;1;43;0
WireConnection;51;0;1;1
WireConnection;51;1;19;0
WireConnection;55;0;57;0
WireConnection;55;1;56;0
WireConnection;55;2;1;1
WireConnection;59;0;42;0
WireConnection;52;0;54;0
WireConnection;52;1;51;0
WireConnection;58;0;59;0
WireConnection;58;1;55;0
WireConnection;33;0;52;0
WireConnection;33;1;32;4
WireConnection;50;0;58;0
WireConnection;50;1;32;0
WireConnection;0;2;50;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=DB31EF05BD6987CD345F7FD812BC8DD5C4B515F9