// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ball"
{
	Properties
	{
		_ball_texture("ball_texture", 2D) = "white" {}
		_ball_bs("ball_bs", 2D) = "white" {}
		_Power("Power", Float) = 1
		_Float4("Float 4", Float) = 0
		_S_Power("S_Power", Float) = 0
		_Color1("Color 1", Color) = (0,0,0,0)
		_Color0("Color 0", Color) = (0,0,0,0)
		_Float5("Float 5", Float) = 0
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
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _ball_texture;
		uniform float4 _Color1;
		uniform float _Float4;
		uniform sampler2D _ball_bs;
		uniform float _S_Power;
		uniform float4 _Color0;
		uniform float _Float5;
		uniform float _Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (0.0).xx;
			float2 panner10 = ( _Time.y * temp_cast_0 + (i.uv_texcoord).xy);
			float2 temp_cast_1 = (_S_Power).xx;
			float2 panner15 = ( _Time.y * temp_cast_1 + i.uv_texcoord);
			o.Emission = ( ( ( tex2D( _ball_texture, panner10 ) * _Color1 * _Float4 ) + ( tex2D( _ball_bs, panner15 ) * _Color0 * _Float5 ) ) * i.vertexColor * _Power ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-1020;388;1017;696;2879.848;566.1009;2.176063;True;False
Node;AmplifyShaderEditor.RangedFloatNode;18;-1758.321,663.4924;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2188.788,-206.157;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1963.34,154.2503;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-1706.682,139.5546;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;29;-1891.697,-197.5508;Inherit;True;True;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1913.004,33.47852;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;-1559.821,641.2924;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1728.622,537.0923;Inherit;False;Property;_S_Power;S_Power;5;0;Create;True;0;0;0;False;0;False;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1709.657,374.4383;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1372.855,343.5594;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;10;-1483.016,-84.90177;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-1093.474,312.5178;Inherit;True;Property;_ball_bs;ball_bs;2;0;Create;True;0;0;0;False;0;False;-1;0789ca3568f0a2547be4babad25b9f54;c5c9e5aff791c7644a2c9159d7c0ec76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-794.0032,720.8922;Inherit;False;Property;_Float5;Float 5;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-1008.275,622.8715;Inherit;False;Property;_Color0;Color 0;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.7229172,0.2311321,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1146.5,-103.1;Inherit;True;Property;_ball_texture;ball_texture;1;0;Create;True;0;0;0;False;0;False;-1;c5c9e5aff791c7644a2c9159d7c0ec76;0789ca3568f0a2547be4babad25b9f54;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-1091.485,106.4852;Inherit;False;Property;_Color1;Color 1;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-847.2031,177.4922;Inherit;False;Property;_Float4;Float 4;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-702.8833,347.8291;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-784.4478,4.500287;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-491.9149,87.15759;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;3;-508.1358,258.2178;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-426.2337,462.3136;Inherit;False;Property;_Power;Power;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-268.936,35.91772;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;ball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;29;0;7;0
WireConnection;16;0;18;0
WireConnection;15;0;9;0
WireConnection;15;2;17;0
WireConnection;15;1;16;0
WireConnection;10;0;29;0
WireConnection;10;2;11;0
WireConnection;10;1;13;0
WireConnection;5;1;15;0
WireConnection;1;1;10;0
WireConnection;20;0;5;0
WireConnection;20;1;19;0
WireConnection;20;2;24;0
WireConnection;22;0;1;0
WireConnection;22;1;21;0
WireConnection;22;2;23;0
WireConnection;6;0;22;0
WireConnection;6;1;20;0
WireConnection;2;0;6;0
WireConnection;2;1;3;0
WireConnection;2;2;4;0
WireConnection;0;2;2;0
ASEEND*/
//CHKSM=34FD9AE4695696B3BCCCB412B59CA99DAC1BB271