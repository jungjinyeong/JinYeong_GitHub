// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "t"
{
	Properties
	{
		_Mask_Range("Mask_Range", Range( 0 , 1)) = 0.8823529
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Height("Height", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Height;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 paralaxOffset21 = ParallaxOffset( 0 , _Height , i.viewDir );
			o.Emission = tex2D( _TextureSample0, paralaxOffset21 ).rgb;
			float2 uv_TexCoord4 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_9_0 = ( uv_TexCoord4 - float2( 1,1 ) );
			float temp_output_14_0 = frac( ( atan2( (temp_output_9_0).x , (temp_output_9_0).y ) / 6.28318548202515 ) );
			o.Alpha = ( step( _Mask_Range , temp_output_14_0 ) + step( _Mask_Range , ( 1.0 - temp_output_14_0 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;13;1920;1006;1643.081;745.0243;1;True;False
Node;AmplifyShaderEditor.Vector2Node;6;-1945.024,-159.656;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1777.624,-176.156;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;8;-1733.217,-25.48804;Float;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-1548.432,-42.70763;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;10;-1338.924,-42.45605;Float;False;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;11;-1338.924,-122.456;Float;False;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;5;-1089.573,-8.961038;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;7;-1094.385,-123.4775;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;3;-930.7535,-120.2998;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;14;-767.8293,-65.01921;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-489.8052,210.2085;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-601.8052,35.2085;Float;False;Property;_Mask_Range;Mask_Range;0;0;Create;True;0;0;False;0;0.8823529;0.612;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;22;-803.0812,-277.0243;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;23;-816.0812,-416.0243;Float;False;Property;_Height;Height;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;17;-255.8052,185.2085;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;16;-286.8052,-124.7915;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;21;-603.0812,-414.0243;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-39.80518,19.2085;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-326.0812,-437.0243;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;c35a6c6f47622495a8223791e4a66f44;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;494,-159;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;t;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;6;0
WireConnection;9;0;4;0
WireConnection;9;1;8;0
WireConnection;10;0;9;0
WireConnection;11;0;9;0
WireConnection;7;0;11;0
WireConnection;7;1;10;0
WireConnection;3;0;7;0
WireConnection;3;1;5;0
WireConnection;14;0;3;0
WireConnection;15;0;14;0
WireConnection;17;0;18;0
WireConnection;17;1;15;0
WireConnection;16;0;18;0
WireConnection;16;1;14;0
WireConnection;21;1;23;0
WireConnection;21;2;22;0
WireConnection;19;0;16;0
WireConnection;19;1;17;0
WireConnection;20;1;21;0
WireConnection;0;2;20;0
WireConnection;0;9;19;0
ASEEND*/
//CHKSM=58254A4387D4FC679AD1DF9965619F6761D6D279