// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/World_Reflaction"
{
	Properties
	{
		_Cube_Map("Cube_Map", CUBE) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldRefl;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform samplerCUBE _Cube_Map;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldReflection = i.worldRefl;
			o.Emission = texCUBE( _Cube_Map, ase_worldReflection ).rgb;
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_6_0 = ( ( i.uv_texcoord - temp_cast_1 ) * 2.0 );
			float2 temp_cast_2 = (0.5).xx;
			float2 break9 = ( temp_output_6_0 * temp_output_6_0 );
			o.Alpha = step( 0.19 , ( 1.0 - ( break9.x + break9.y ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1916;3;1920;1013;2985.073;897.8522;1.933619;True;False
Node;AmplifyShaderEditor.CommentaryNode;17;-2125.205,254.8588;Float;False;2058.771;465.7107;Sperer;11;3;5;4;7;6;8;9;11;13;16;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2075.205,335.7903;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1989.748,491.9673;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1797.805,337.3385;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1751.748,583.9672;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1548.748,329.9673;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1316.748,324.9673;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-1098.749,315.9673;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-835.1132,310.6596;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;2;-712.0344,-51.59057;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;13;-570.2076,304.8588;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-479.3273,604.5695;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0.19;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-368,-57.5;Float;True;Property;_Cube_Map;Cube_Map;0;0;Create;True;0;0;False;0;56a68e301a0ff55469ae441c0112d256;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;15;-301.4344,359.0001;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;354.7644,-56.3319;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/World_Reflaction;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;6;0;4;0
WireConnection;6;1;7;0
WireConnection;8;0;6;0
WireConnection;8;1;6;0
WireConnection;9;0;8;0
WireConnection;11;0;9;0
WireConnection;11;1;9;1
WireConnection;13;0;11;0
WireConnection;1;1;2;0
WireConnection;15;0;16;0
WireConnection;15;1;13;0
WireConnection;0;2;1;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=E68B1009C95C21A552613E5218F2DDBDC38265FB