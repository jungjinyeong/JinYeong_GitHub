// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/08Week_Rander Trarget"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_FXT_08Week_Card_Alpha("FXT_08Week_Card_Alpha", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
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

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _FXT_08Week_Card_Alpha;
		uniform float4 _FXT_08Week_Card_Alpha_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode3 = tex2D( _Texture0, uv_Texture0 );
			float temp_output_2_0 = ( tex2DNode3.a + 0.0 );
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 switchResult8 = (((i.ASEVFace>0)?(tex2D( _Texture0, uv_Texture0 )):(( ( tex2DNode3 * saturate( pow( ( 1.0 - temp_output_2_0 ) , 10.0 ) ) ) + ( temp_output_2_0 * tex2D( _TextureSample0, uv_TextureSample0 ) ) ))));
			o.Emission = switchResult8.rgb;
			float2 uv_FXT_08Week_Card_Alpha = i.uv_texcoord * _FXT_08Week_Card_Alpha_ST.xy + _FXT_08Week_Card_Alpha_ST.zw;
			o.Alpha = tex2D( _FXT_08Week_Card_Alpha, uv_FXT_08Week_Card_Alpha ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;12;1920;1007;1115.93;464.0044;1.616139;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;10;-583.7334,-255.2026;Float;True;Property;_Texture0;Texture 0;2;0;Create;True;0;0;False;0;None;e411f63cfffbad94a87b1e6a3f5a887a;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;3;-270,-174.5;Float;True;Property;_FXT_08Week_Card;FXT_08Week_Card;0;0;Create;True;0;0;False;0;e411f63cfffbad94a87b1e6a3f5a887a;e411f63cfffbad94a87b1e6a3f5a887a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-177,68.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;49.63123,-54.64056;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;156.9125,308.3474;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;13;244.9126,181.3474;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;163.1889,407.2163;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;4eab24cc24df19e42af5718c41b33ade;4eab24cc24df19e42af5718c41b33ade;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;200.2888,40.40848;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;645.2813,196.488;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;362.3281,-128.308;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;296.1682,-498.959;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;e411f63cfffbad94a87b1e6a3f5a887a;e411f63cfffbad94a87b1e6a3f5a887a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;6;584.313,-169.3386;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;8;840.2666,-248.2026;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;9;779.2666,-84.20258;Float;True;Property;_FXT_08Week_Card_Alpha;FXT_08Week_Card_Alpha;1;0;Create;True;0;0;False;0;2b28bacbeb2dfac41a9151d33a1334ba;2b28bacbeb2dfac41a9151d33a1334ba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1118,-222;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/08Week_Rander Trarget;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;10;0
WireConnection;2;0;3;4
WireConnection;12;0;2;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;15;0;13;0
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;11;0;3;0
WireConnection;11;1;15;0
WireConnection;7;0;10;0
WireConnection;6;0;11;0
WireConnection;6;1;5;0
WireConnection;8;0;7;0
WireConnection;8;1;6;0
WireConnection;0;2;8;0
WireConnection;0;9;9;1
ASEEND*/
//CHKSM=90CE765544B8F2AC87954228262782474D51781B