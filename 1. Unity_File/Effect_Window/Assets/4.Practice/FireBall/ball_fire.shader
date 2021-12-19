// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ball_fire"
{
	Properties
	{
		_3("3", 2D) = "white" {}
		_Float0("Float 0", Float) = 3.02
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _3;
		uniform float4 _3_ST;
		uniform float _Float0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_3 = i.uv_texcoord * _3_ST.xy + _3_ST.zw;
			float4 color7 = IsGammaSpace() ? float4(0.8588235,0.3488959,0.1098039,1) : float4(0.7083758,0.09982534,0.01161224,1);
			o.Emission = ( ( tex2D( _3, uv_3 ) * color7 * 1.41 ) * i.vertexColor * _Float0 ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-1020;388;1017;697;879.2292;289.2823;1.610398;True;False
Node;AmplifyShaderEditor.ColorNode;7;-777.4254,144.1559;Inherit;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0.8588235,0.3488959,0.1098039,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-668.926,347.0307;Inherit;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;1.41;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-678.245,-171.966;Inherit;True;Property;_3;3;0;0;Create;True;0;0;0;False;0;False;-1;4e04b53bdacdf63419e2ef81cf2daa9a;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-144.275,623.2912;Inherit;False;Property;_Float0;Float 0;2;0;Create;True;0;0;0;False;0;False;3.02;3.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;30;-156.9577,369.1617;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-225.6328,-102.19;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;63.04514,-92.70255;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;445.5834,-181.155;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;ball_fire;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;1;0
WireConnection;8;1;7;0
WireConnection;8;2;11;0
WireConnection;2;0;8;0
WireConnection;2;1;30;0
WireConnection;2;2;5;0
WireConnection;0;2;2;0
WireConnection;0;9;30;4
ASEEND*/
//CHKSM=6BCAD745FFCEB56965BE7E793366D11759795A8B