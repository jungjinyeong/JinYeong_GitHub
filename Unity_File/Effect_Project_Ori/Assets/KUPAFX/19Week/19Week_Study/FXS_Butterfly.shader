// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/Butterfly"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_FXT_Butterfly("FXT_Butterfly", 2D) = "white" {}
		_FXT_Butterfly_Mask("FXT_Butterfly_Mask", 2D) = "white" {}
		_Wing_Speed("Wing_Speed", Float) = 7.74
		_Speed_Range("Speed_Range", Float) = 3
		_VertexNormal_Str("VertexNormal_Str", Float) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Wing_Speed;
		uniform float _Speed_Range;
		uniform float _VertexNormal_Str;
		uniform sampler2D _FXT_Butterfly;
		uniform float4 _FXT_Butterfly_ST;
		uniform float4 _Tint_Color;
		uniform sampler2D _FXT_Butterfly_Mask;
		uniform float4 _FXT_Butterfly_Mask_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime4 = _Time.y * _Wing_Speed;
			v.vertex.xyz += ( ( ( ase_vertexNormal * saturate( sin( ( ( v.texcoord.xy.x + mulTime4 ) * _Speed_Range ) ) ) ) * _VertexNormal_Str ) * saturate( ( abs( ( v.texcoord.xy.x - 0.5 ) ) * 2.0 ) ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FXT_Butterfly = i.uv_texcoord * _FXT_Butterfly_ST.xy + _FXT_Butterfly_ST.zw;
			o.Emission = ( tex2D( _FXT_Butterfly, uv_FXT_Butterfly ) * _Tint_Color ).rgb;
			o.Alpha = 1;
			float2 uv_FXT_Butterfly_Mask = i.uv_texcoord * _FXT_Butterfly_Mask_ST.xy + _FXT_Butterfly_Mask_ST.zw;
			clip( tex2D( _FXT_Butterfly_Mask, uv_FXT_Butterfly_Mask ).r - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;22;1920;997;-165.6666;660.5348;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-413.1107,705.3939;Float;False;Property;_Wing_Speed;Wing_Speed;3;0;Create;True;0;0;False;0;7.74;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-329,404.5;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;4;-234,655.5;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-39,424.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;43,694.5;Float;False;Property;_Speed_Range;Speed_Range;4;0;Create;True;0;0;False;0;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;205,477.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;488.2257,979.409;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;232.2257,831.4091;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;8;413,464.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;647.2258,850.4091;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;11;572.8893,468.3939;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;10;375.8893,293.3939;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;19;838.2258,846.4091;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;990.9528,851.7708;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;768.4812,666.8224;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;758.8893,392.3939;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;21;1201.657,854.0586;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;999.4812,465.8224;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;877,-306.5;Float;True;Property;_FXT_Butterfly;FXT_Butterfly;1;0;Create;True;0;0;False;0;b828e626dc9aa274ab16f78be228fea0;b828e626dc9aa274ab16f78be228fea0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;1005.667,-21.53479;Float;False;Property;_Tint_Color;Tint_Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1447.425,451.0806;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;142,104.5;Float;True;Property;_FXT_Butterfly_Mask;FXT_Butterfly_Mask;2;0;Create;True;0;0;False;0;45aaa9d1225215a4091080282665a5fb;45aaa9d1225215a4091080282665a5fb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1280.667,-136.5348;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1652.681,-178.4158;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/Butterfly;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;9;0
WireConnection;5;0;3;1
WireConnection;5;1;4;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;8;0;6;0
WireConnection;17;0;15;1
WireConnection;17;1;18;0
WireConnection;11;0;8;0
WireConnection;19;0;17;0
WireConnection;20;0;19;0
WireConnection;12;0;10;0
WireConnection;12;1;11;0
WireConnection;21;0;20;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;22;0;13;0
WireConnection;22;1;21;0
WireConnection;23;0;1;0
WireConnection;23;1;25;0
WireConnection;0;2;23;0
WireConnection;0;10;2;1
WireConnection;0;11;22;0
ASEEND*/
//CHKSM=4C1F39E1E1591702363B0261CB93E03397A095C1