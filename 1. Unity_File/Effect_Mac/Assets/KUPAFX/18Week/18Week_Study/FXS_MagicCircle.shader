// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/MagicCircle"
{
	Properties
	{
		_Dissolve("Dissolve", Range( -1 , 0)) = 0.6588235
		_FXT_Magiccircle("FXT_Magiccircle", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 1)) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _FXT_Magiccircle;
		uniform float4 _FXT_Magiccircle_ST;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _Sampler6021;
		uniform float _Noise_Str;
		uniform float _Dissolve;
		uniform float4 _Edge_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FXT_Magiccircle = i.uv_texcoord * _FXT_Magiccircle_ST.xy + _FXT_Magiccircle_ST.zw;
			float4 tex2DNode14 = tex2D( _FXT_Magiccircle, uv_FXT_Magiccircle );
			float2 temp_output_1_0_g1 = float2( 1,1 );
			float2 appendResult10_g1 = (float2(( (temp_output_1_0_g1).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g1).y )));
			float2 temp_output_11_0_g1 = float2( 0,0 );
			float2 panner18_g1 = ( ( (temp_output_11_0_g1).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g1 = ( ( _Time.y * (temp_output_11_0_g1).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g1 = (float2((panner18_g1).x , (panner19_g1).y));
			float2 temp_output_47_0_g1 = float2( 0,-0.1 );
			float2 uv_TexCoord78_g1 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g1 = ( uv_TexCoord78_g1 - float2( 1,1 ) );
			float2 appendResult39_g1 = (float2(frac( ( atan2( (temp_output_31_0_g1).x , (temp_output_31_0_g1).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g1 )));
			float2 panner54_g1 = ( ( (temp_output_47_0_g1).x * _Time.y ) * float2( 1,0 ) + appendResult39_g1);
			float2 panner55_g1 = ( ( _Time.y * (temp_output_47_0_g1).y ) * float2( 0,1 ) + appendResult39_g1);
			float2 appendResult58_g1 = (float2((panner54_g1).x , (panner55_g1).y));
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_6_0 = ( ( ( ( (UnpackNormal( tex2D( _TextureSample0, ( ( (tex2D( _Sampler6021, ( appendResult10_g1 + appendResult24_g1 ) )).rg * 1.0 ) + ( float2( 1,0.25 ) * appendResult58_g1 ) ) ) )).xy * _Noise_Str ) + i.uv_texcoord ) - temp_cast_0 ) * 2.0 );
			float2 temp_cast_1 = (0.5).xx;
			float2 break10 = ( temp_output_6_0 * temp_output_6_0 );
			float temp_output_36_0 = ( ( break10.x + break10.y ) + _Dissolve );
			float temp_output_34_0 = step( temp_output_36_0 , -0.6 );
			o.Emission = ( tex2DNode14.r + ( ( temp_output_34_0 - step( temp_output_36_0 , -0.61 ) ) * _Edge_Color ) ).rgb;
			o.Alpha = ( tex2DNode14.r * temp_output_34_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-219;398;1920;939;1348.958;194.0309;1;True;False
Node;AmplifyShaderEditor.Vector2Node;22;-3122.827,-187.5713;Float;False;Constant;_Vector2;Vector 2;4;0;Create;True;0;0;False;0;1,0.25;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;23;-3116.827,-30.57129;Float;False;Constant;_Vector3;Vector 3;4;0;Create;True;0;0;False;0;0,-0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;21;-2916.827,-230.5713;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6021;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;16;-2451.827,-229.5713;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2121.827,3.428711;Float;False;Property;_Noise_Str;Noise_Str;3;0;Create;True;0;0;False;0;0;0.103;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;17;-2152.827,-213.5713;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2173.728,108.7501;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1852.827,-182.5713;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1750.728,375.7501;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1799.827,114.4287;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1566.728,354.7501;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1584.728,114.7501;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1379.728,119.7501;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1135.728,119.7501;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-908.7276,123.7501;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-693.7276,111.7501;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-713.9495,347.9588;Float;False;Property;_Dissolve;Dissolve;0;0;Create;True;0;0;False;0;0.6588235;-0.746;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-403.9576,448.9691;Float;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;-0.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-412.9576,550.9691;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;-0.61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-464.9576,169.9691;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;29;-134.9576,430.9691;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;34;-140.9576,180.9691;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;-110.9576,-0.03091431;Float;False;Property;_Edge_Color;Edge_Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;8.672654,3.933452,1.186354,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;176.0424,411.9691;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-477.8273,-206.5713;Float;True;Property;_FXT_Magiccircle;FXT_Magiccircle;1;0;Create;True;0;0;False;0;567f6e3987a573340a2c5fd917116c0d;567f6e3987a573340a2c5fd917116c0d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;124.0424,-11.03091;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LengthOpNode;8;-897.7275,381.7501;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;320.0424,-258.0309;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;373.0751,133.7529;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;587.7131,-186.754;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/MagicCircle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;68;22;0
WireConnection;21;47;23;0
WireConnection;16;1;21;0
WireConnection;17;0;16;0
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;18;0;19;0
WireConnection;18;1;3;0
WireConnection;4;0;18;0
WireConnection;4;1;5;0
WireConnection;6;0;4;0
WireConnection;6;1;7;0
WireConnection;9;0;6;0
WireConnection;9;1;6;0
WireConnection;10;0;9;0
WireConnection;11;0;10;0
WireConnection;11;1;10;1
WireConnection;36;0;11;0
WireConnection;36;1;13;0
WireConnection;29;0;36;0
WireConnection;29;1;28;0
WireConnection;34;0;36;0
WireConnection;34;1;35;0
WireConnection;24;0;34;0
WireConnection;24;1;29;0
WireConnection;30;0;24;0
WireConnection;30;1;31;0
WireConnection;8;0;6;0
WireConnection;32;0;14;1
WireConnection;32;1;30;0
WireConnection;15;0;14;1
WireConnection;15;1;34;0
WireConnection;2;2;32;0
WireConnection;2;9;15;0
ASEEND*/
//CHKSM=9117A309738D28A2AE830F968925F21AD4345744