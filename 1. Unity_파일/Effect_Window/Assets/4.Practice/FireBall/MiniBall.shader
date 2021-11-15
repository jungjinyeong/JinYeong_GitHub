// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MiniBall"
{
	Properties
	{
		_ball_bs("ball_bs", 2D) = "white" {}
		_ball_texture("ball_texture", 2D) = "white" {}
		_Power("Power", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _ball_bs;
		uniform float4 _ball_bs_ST;
		uniform sampler2D _ball_texture;
		uniform float4 _ball_texture_ST;
		uniform float _Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_ball_bs = i.uv_texcoord * _ball_bs_ST.xy + _ball_bs_ST.zw;
			float4 color7 = IsGammaSpace() ? float4(1,0.0235849,0.0235849,0) : float4(1,0.001825457,0.001825457,0);
			float2 uv_ball_texture = i.uv_texcoord * _ball_texture_ST.xy + _ball_texture_ST.zw;
			o.Emission = ( ( ( tex2D( _ball_bs, uv_ball_bs ) * color7 * 11.79 ) + tex2D( _ball_texture, uv_ball_texture ) ) * i.vertexColor * _Power ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-1020;388;1017;696;1827.083;337.5402;1.549378;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1195.484,-325.8363;Inherit;True;Property;_ball_bs;ball_bs;1;0;Create;True;0;0;0;False;0;False;-1;c5c9e5aff791c7644a2c9159d7c0ec76;c5c9e5aff791c7644a2c9159d7c0ec76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-1210.431,-80.34342;Inherit;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;1,0.0235849,0.0235849,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-1032.253,46.70555;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;11.79;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-834.4778,104.8907;Inherit;True;Property;_ball_texture;ball_texture;2;0;Create;True;0;0;0;False;0;False;-1;0789ca3568f0a2547be4babad25b9f54;0789ca3568f0a2547be4babad25b9f54;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-736.3215,-266.2687;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-457.9791,72.35379;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;6;-518.4049,386.8774;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-299.9427,427.1612;Inherit;False;Property;_Power;Power;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-157.3999,4.181098;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;108.4564,-41.83319;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;MiniBall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;1;0
WireConnection;8;1;7;0
WireConnection;8;2;9;0
WireConnection;4;0;8;0
WireConnection;4;1;2;0
WireConnection;3;0;4;0
WireConnection;3;1;6;0
WireConnection;3;2;5;0
WireConnection;0;2;3;0
ASEEND*/
//CHKSM=5E41E65CE317157A8E30AD6A638D3492765D06CB