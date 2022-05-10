// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Dissolve_Int("Dissolve_Int", Range( -1 , 1)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 2)) = 0
		_Step_Size_Int("Step_Size_Int", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HDR]_Dissolve_Color("Dissolve_Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Dissolve_Val;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Step_Size_Int;
		uniform float4 _Dissolve_Color;
		uniform float _Dissolve_Int;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch20 = i.uv_tex4coord.z;
			#else
				float staticSwitch20 = _Dissolve_Val;
			#endif
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float4 tex2DNode14 = tex2D( _Noise_Texture, uv0_Noise_Texture );
			float temp_output_3_0_g11 = ( staticSwitch20 - tex2DNode14.r );
			float temp_output_42_0 = saturate( ( temp_output_3_0_g11 / fwidth( temp_output_3_0_g11 ) ) );
			float temp_output_3_0_g10 = ( ( staticSwitch20 + _Step_Size_Int ) - tex2DNode14.r );
			float temp_output_43_0 = saturate( ( temp_output_3_0_g10 / fwidth( temp_output_3_0_g10 ) ) );
			o.Emission = ( ( tex2D( _Main_Texture, uv0_Main_Texture ) * temp_output_42_0 * i.vertexColor ) + ( i.vertexColor.a * ( temp_output_43_0 - temp_output_42_0 ) * _Dissolve_Color * saturate( _Dissolve_Int ) ) ).rgb;
			o.Alpha = temp_output_43_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;12;2560;999;3588.409;632.7632;1.264348;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-3128.648,888.2718;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-3152.681,725.7061;Float;False;Property;_Dissolve_Val;Dissolve_Val;3;0;Create;True;0;0;False;0;0;2;-1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-3279.457,506.0216;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;20;-2845.885,782.4536;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3073.506,1140.425;Float;False;Property;_Step_Size_Int;Step_Size_Int;4;0;Create;True;0;0;False;0;0;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2619.022,911.1901;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-2932.033,476.1649;Float;True;Property;_Noise_Texture;Noise_Texture;2;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;42;-2310.054,498.569;Float;True;Step Antialiasing;-1;;11;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;43;-2318.028,885.2769;Float;True;Step Antialiasing;-1;;10;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-2760.453,-16.68317;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-1481.886,1011.892;Float;False;Property;_Dissolve_Int;Dissolve_Int;1;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2345.292,-13.77772;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;40526e53665b54f4ab08530fa57888a3;40526e53665b54f4ab08530fa57888a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;2;-1739.175,259.9499;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;51;-1192.969,728.1989;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1844.383,476.2902;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;48;-1577.884,771.1917;Float;False;Property;_Dissolve_Color;Dissolve_Color;6;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.844303,0.7821388,0.3765854,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1556.461,6.526432;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1086.314,313.1293;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-636.5974,32.93074;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-226.0053,70.79372;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;1;16;0
WireConnection;20;0;19;3
WireConnection;41;0;20;0
WireConnection;41;1;44;0
WireConnection;14;1;13;0
WireConnection;42;1;14;1
WireConnection;42;2;20;0
WireConnection;43;1;14;1
WireConnection;43;2;41;0
WireConnection;1;1;52;0
WireConnection;51;0;49;0
WireConnection;46;0;43;0
WireConnection;46;1;42;0
WireConnection;45;0;1;0
WireConnection;45;1;42;0
WireConnection;45;2;2;0
WireConnection;47;0;2;4
WireConnection;47;1;46;0
WireConnection;47;2;48;0
WireConnection;47;3;51;0
WireConnection;50;0;45;0
WireConnection;50;1;47;0
WireConnection;0;2;50;0
WireConnection;0;9;43;0
ASEEND*/
//CHKSM=9D7349CD7654C7302E1F6F925765377770DF7CBE