// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Beam_Black"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_UPanner("UPanner", Float) = 0
		_VPanner("VPanner", Float) = 0
		_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		_Opacity("Opacity", Range( 0 , 10)) = 0
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
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _TextureSample0;
		uniform float _UPanner;
		uniform float _VPanner;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = ( _Tint_Color * i.vertexColor ).rgb;
			float2 appendResult20 = (float2(_UPanner , _VPanner));
			float2 panner16 = ( 1.0 * _Time.y * appendResult20 + i.uv_texcoord);
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_5_0 = ( ( i.uv_texcoord - temp_cast_1 ) * 2.0 );
			float2 temp_cast_2 = (0.5).xx;
			float2 break8 = ( temp_output_5_0 * temp_output_5_0 );
			float temp_output_13_0 = saturate( pow( saturate( ( 1.0 - ( break8.x + break8.y ) ) ) , 4.0 ) );
			o.Alpha = ( i.vertexColor * ( ( ( tex2D( _TextureSample0, panner16 ).r + temp_output_13_0 ) * temp_output_13_0 ) * _Opacity ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;12;1920;1007;1665;697.6223;1.749078;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1868.924,265.4929;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1819.924,513.4929;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-1652.924,295.4929;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1560.924,532.4928;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1457.924,289.4929;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1257.924,282.4929;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;8;-1072.924,279.4929;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-860.9245,284.4929;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-868.6466,177.8501;Float;False;Property;_VPanner;VPanner;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-870.6466,81.8501;Float;False;Property;_UPanner;UPanner;1;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;10;-640.0196,284.3018;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-883.6466,-117.1499;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;20;-682.6466,156.8501;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-494.2799,574.275;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;-408.8566,258.2296;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;11;-259.6953,278.2526;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;16;-569.6466,24.8501;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;13;-10.74121,274.2524;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-339,30.5;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;26;8.513428,20.50223;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;29.4996,538.5994;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;0;2.36;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;198.3534,250.8501;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;27;470.6244,78.96846;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;110.3534,-216.1499;Float;False;Property;_Tint_Color;Tint_Color;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;453.4996,282.5994;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;692.7571,73.72119;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;619.2959,-279.5926;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;846.5831,-251;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Beam_Black;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;5;0
WireConnection;8;0;7;0
WireConnection;9;0;8;0
WireConnection;9;1;8;1
WireConnection;10;0;9;0
WireConnection;20;0;18;0
WireConnection;20;1;19;0
WireConnection;25;0;10;0
WireConnection;11;0;25;0
WireConnection;11;1;12;0
WireConnection;16;0;15;0
WireConnection;16;2;20;0
WireConnection;13;0;11;0
WireConnection;1;1;16;0
WireConnection;26;0;1;1
WireConnection;26;1;13;0
WireConnection;14;0;26;0
WireConnection;14;1;13;0
WireConnection;24;0;14;0
WireConnection;24;1;23;0
WireConnection;28;0;27;0
WireConnection;28;1;24;0
WireConnection;29;0;21;0
WireConnection;29;1;27;0
WireConnection;0;2;29;0
WireConnection;0;9;28;0
ASEEND*/
//CHKSM=0E12D35C394C9426559F3E3C179689EB91497AAE