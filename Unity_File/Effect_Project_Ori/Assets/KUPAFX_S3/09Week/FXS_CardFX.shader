// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/CardFX"
{
	Properties
	{
		_RenderTexture("Render Texture", 2D) = "white" {}
		_FXT_CardFront("FXT_CardFront", 2D) = "white" {}
		_FXT_CardBack("FXT_CardBack", 2D) = "white" {}
		_FXT_CardMask("FXT_CardMask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
		};

		uniform sampler2D _FXT_CardBack;
		uniform float4 _FXT_CardBack_ST;
		uniform sampler2D _FXT_CardFront;
		uniform float4 _FXT_CardFront_ST;
		uniform sampler2D _FXT_CardMask;
		uniform float4 _FXT_CardMask_ST;
		uniform sampler2D _RenderTexture;
		uniform float4 _RenderTexture_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FXT_CardBack = i.uv_texcoord * _FXT_CardBack_ST.xy + _FXT_CardBack_ST.zw;
			float2 uv_FXT_CardFront = i.uv_texcoord * _FXT_CardFront_ST.xy + _FXT_CardFront_ST.zw;
			float2 uv_FXT_CardMask = i.uv_texcoord * _FXT_CardMask_ST.xy + _FXT_CardMask_ST.zw;
			float4 tex2DNode4 = tex2D( _FXT_CardMask, uv_FXT_CardMask );
			float2 uv_RenderTexture = i.uv_texcoord * _RenderTexture_ST.xy + _RenderTexture_ST.zw;
			float4 switchResult7 = (((i.ASEVFace>0)?(tex2D( _FXT_CardBack, uv_FXT_CardBack )):(( tex2D( _FXT_CardFront, uv_FXT_CardFront ) + ( tex2DNode4.r * tex2D( _RenderTexture, uv_RenderTexture ) ) ))));
			o.Emission = switchResult7.rgb;
			o.Alpha = tex2DNode4.g;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
248;91;1920;959;1854.089;1030.992;1.702692;True;False
Node;AmplifyShaderEditor.SamplerNode;4;-985,-222.5;Inherit;True;Property;_FXT_CardMask;FXT_CardMask;3;0;Create;True;0;0;0;False;0;False;-1;748c6b242b944714f8aa29e298b6ad51;748c6b242b944714f8aa29e298b6ad51;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-967.8112,5.364601;Inherit;True;Property;_RenderTexture;Render Texture;0;0;Create;True;0;0;0;False;0;False;-1;5555fc446a10ecc48b7fd7717cebdd84;5555fc446a10ecc48b7fd7717cebdd84;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-618,-218.5;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-861,-438.5;Inherit;True;Property;_FXT_CardFront;FXT_CardFront;1;0;Create;True;0;0;0;False;0;False;-1;63984d7acb7728d49875716577332df9;63984d7acb7728d49875716577332df9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-434,-432.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-737.4,-741.1;Inherit;True;Property;_FXT_CardBack;FXT_CardBack;2;0;Create;True;0;0;0;False;0;False;-1;dbc4d5cdf12457f4b91be8dab72ecf3f;dbc4d5cdf12457f4b91be8dab72ecf3f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;7;-213,-659.5;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;266,-461;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/CardFX;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;4;1
WireConnection;5;1;1;0
WireConnection;6;0;2;0
WireConnection;6;1;5;0
WireConnection;7;0;3;0
WireConnection;7;1;6;0
WireConnection;0;2;7;0
WireConnection;0;9;4;2
ASEEND*/
//CHKSM=731424E1636532B833298343FBB294D96795B054