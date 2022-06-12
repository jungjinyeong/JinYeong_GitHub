// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/14Week_Crack_Test"
{
	Properties
	{
		_VertexPositionX("VertexPosition X", Float) = 0
		_VertexPositionY("VertexPosition Y", Float) = 0
		_VertexPositionZ("VertexPosition Z", Float) = 0
		_Vertex_Str("Vertex_Str", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv2_texcoord2;
		};

		uniform float _VertexPositionX;
		uniform float _VertexPositionY;
		uniform float _VertexPositionZ;
		uniform float _Vertex_Str;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (0.5).xx;
			float temp_output_10_0 = pow( saturate( ( 1.0 - length( ( ( v.texcoord1.xy - temp_cast_0 ) * 2.0 ) ) ) ) , 2.0 );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 appendResult18 = (float3(_VertexPositionX , _VertexPositionY , _VertexPositionZ));
			v.vertex.xyz += ( ( temp_output_10_0 * ( ( ase_vertex3Pos - appendResult18 ) * appendResult18 ) ) * _Vertex_Str );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (0.5).xx;
			float temp_output_10_0 = pow( saturate( ( 1.0 - length( ( ( i.uv2_texcoord2 - temp_cast_0 ) * 2.0 ) ) ) ) , 2.0 );
			float3 temp_cast_1 = (temp_output_10_0).xxx;
			o.Emission = temp_cast_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
91;609;1920;1724;344.6328;149.4471;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;4;-573.7173,133.6735;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-689.7173,-207.3265;Float;True;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-443.7173,-120.3265;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-375.7173,73.67349;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-261.7173,-97.32651;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;7;4.282715,-20.32651;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;187.8184,747.1835;Float;False;Property;_VertexPositionZ;VertexPosition Z;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;191.8184,659.1835;Float;False;Property;_VertexPositionY;VertexPosition Y;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;181.8184,566.1835;Float;False;Property;_VertexPositionX;VertexPosition X;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;8;181.2827,-19.32651;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;419.8184,612.1835;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;12;267.8184,361.1835;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;570.8184,367.1835;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;9;352.2827,-21.32651;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;360.2827,178.6735;Float;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;537.2827,-11.32651;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;802.8184,371.1835;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;923.4184,185.6835;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;22;1098.367,422.5529;Float;False;Property;_Vertex_Str;Vertex_Str;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;410.1726,-402.2607;Float;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.2938324,0.4453805,0.8773585,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;1229.667,275.6529;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1146.757,-329.8907;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX_Study/14Week_Crack_Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;8;0;7;0
WireConnection;18;0;15;0
WireConnection;18;1;16;0
WireConnection;18;2;17;0
WireConnection;13;0;12;0
WireConnection;13;1;18;0
WireConnection;9;0;8;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;19;0;13;0
WireConnection;19;1;18;0
WireConnection;20;0;10;0
WireConnection;20;1;19;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;0;2;10;0
WireConnection;0;11;21;0
ASEEND*/
//CHKSM=0750ED7435A2BF041866302648F654B25AD59D63