// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Vertexoffset_Gasi"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Offset("Offset", Range( -1 , 1)) = 0
		_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		_Offset_Range("Offset_Range", Float) = 0
		_Vertex_Normal_Str("Vertex_Normal_Str", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Offset;
		uniform float _Offset_Range;
		uniform float _Vertex_Normal_Str;
		uniform float4 _Tint_Color;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_7_0 = pow( saturate( ( ( 1.0 - v.texcoord.xy.y ) + _Offset ) ) , _Offset_Range );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( temp_output_7_0 * ase_vertexNormal ) * _Vertex_Normal_Str );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Emission = _Tint_Color.rgb;
			o.Alpha = 1;
			float temp_output_7_0 = pow( saturate( ( ( 1.0 - i.uv_texcoord.y ) + _Offset ) ) , _Offset_Range );
			clip( temp_output_7_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;1299;70.5;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1306,-47.5;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1120,258.5;Float;False;Property;_Offset;Offset;1;0;Create;True;0;0;False;0;0;0.02;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-1067,-56.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-849,50;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-598,56.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-706,334.5;Float;False;Property;_Offset_Range;Offset_Range;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-415,225.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;9;-405,477.5;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-205,389.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-148,613.5;Float;False;Property;_Vertex_Normal_Str;Vertex_Normal_Str;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-122,-242.5;Float;False;Property;_Tint_Color;Tint_Color;2;0;Create;True;0;0;False;0;0,0,0,0;0.5377358,0.5377358,0.5377358,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;44,394.5;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;146,-81;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/Vertexoffset_Gasi;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;1;2
WireConnection;2;0;5;0
WireConnection;2;1;3;0
WireConnection;4;0;2;0
WireConnection;7;0;4;0
WireConnection;7;1;8;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;0;2;6;0
WireConnection;0;10;7;0
WireConnection;0;11;11;0
ASEEND*/
//CHKSM=A932DB8E9160242456E72B52AE8344F378137257