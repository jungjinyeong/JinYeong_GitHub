// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FX_Shader/Sword_STrail"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample5("Texture Sample 5", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _TextureSample5;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _TextureSample3;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult26 = (float4(0.0 , 0.0 , 0.0 , 0.0));
			float4 appendResult29 = (float4(0.0 , 0.0 , 0.0 , 0.0));
			float4 temp_output_30_0 = ( ( float4( i.uv_texcoord, 0.0 , 0.0 ) * appendResult26 ) + appendResult29 );
			float4 appendResult6 = (float4(0.0 , 0.0 , 0.0 , 0.0));
			float2 panner2 = ( 1.0 * _Time.y * appendResult6.xy + i.uv_texcoord);
			float4 tex2DNode1 = tex2D( _TextureSample1, panner2 );
			float4 appendResult8 = (float4(0.0 , 0.0 , 0.0 , 0.0));
			float2 panner9 = ( 1.0 * _Time.y * appendResult8.xy + i.uv_texcoord);
			float4 tex2DNode12 = tex2D( _TextureSample0, panner9 );
			float4 clampResult33 = clamp( ( temp_output_30_0 + float4( ( ( tex2DNode1.r * tex2DNode12.g ) + i.uv_texcoord ), 0.0 , 0.0 ) ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			o.Emission = ( tex2D( _TextureSample5, clampResult33.xy ) * i.vertexColor ).rgb;
			float temp_output_14_0 = ( tex2DNode1.g * tex2DNode12.r );
			float4 clampResult34 = clamp( ( temp_output_30_0 + float4( ( temp_output_14_0 + i.uv_texcoord ), 0.0 , 0.0 ) ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float ifLocalVar43 = 0;
			if( 0.0 >= temp_output_14_0 )
				ifLocalVar43 = 0.0;
			else
				ifLocalVar43 = 0.0;
			o.Alpha = ( tex2D( _TextureSample3, clampResult34.xy ).r * ifLocalVar43 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;584.0123;-254.594;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-2047.721,519.3035;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-2054.412,178.5852;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2048.688,596.1309;Float;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2055.379,254.4127;Float;False;Constant;_Float3;Float 3;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1847.76,393.0646;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1759.817,180.1668;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1753.127,521.885;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1854.451,51.34646;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;2;-1581.627,52.55862;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1168.772,-445.7893;Float;False;Constant;_Float4;Float 4;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-1574.936,394.2768;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1168.942,-351.6704;Float;False;Constant;_Float5;Float 5;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-974.2535,-582.736;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-1164.741,-259.8707;Float;False;Constant;_Float9;Float 9;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1164.742,-175.3707;Float;False;Constant;_Float6;Float 6;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-882.9716,-442.0241;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;12;-1373.773,368.0857;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1380.464,26.36753;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;fdb7f2284c843954baf647c1c33d72fe;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1002.144,623.8128;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;29;-883.4047,-256.0133;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-724.554,-435.8354;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-985.0295,397.1603;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-984.8257,5.315083;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1005.187,241.1281;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-743.5707,30.63192;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-714.9622,-256.8032;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-742.0669,361.4113;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-474.6751,0.2385747;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-470.7752,329.1385;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-135.6038,1086.563;Float;False;Constant;_Float11;Float 11;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-147.6676,956.6132;Float;False;Constant;_Float12;Float 12;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;33;-233.3105,3.505886;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;1,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;34;-235.0128,330.052;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;1,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-134.0243,1167.117;Float;False;Constant;_Float10;Float 10;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;43;50.69489,965.6554;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;10.65031,765.7119;Float;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;False;0;283cebc6a36ccaf4fb165b1c6678a35b;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;35;1.664431,4.19192;Float;True;Property;_TextureSample5;Texture Sample 5;5;0;Create;True;0;0;False;0;be992bbc6d79694478a1115b34900de4;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;38;118.8929,205.1241;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;0.7719443,565.1642;Float;True;Property;_TextureSample4;Texture Sample 4;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;675.0229,836.3466;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;692.4452,753.9857;Float;False;Constant;_Float14;Float 14;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;828.4839,1115.558;Float;False;Constant;_Float15;Float 15;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;47;1027.503,865.9936;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;353.5021,7.652476;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;39;87.86749,374.4711;Float;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;18.06036,-87.03168;Float;False;Constant;_Float13;Float 13;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;821.5531,1031.473;Float;False;Constant;_Float16;Float 16;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1356.202,582.1832;Float;False;Constant;_Float8;Float 8;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1358.737,257.4761;Float;False;Constant;_Float7;Float 7;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;359.7868,732.5334;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;654.2134,-35.39634;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;FX_Shader/Sword_STrail;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;52;625.0229,703.9857;Float;False;0;0;Comment;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;53;-1218.942,-632.736;Float;False;0;0;Comment;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;54;-2105.379,-44.68491;Float;False;0;0;Comment;0;;1,1,1,1;0;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;8;0;10;0
WireConnection;8;1;11;0
WireConnection;2;0;3;0
WireConnection;2;2;6;0
WireConnection;9;0;7;0
WireConnection;9;2;8;0
WireConnection;26;0;21;0
WireConnection;26;1;23;0
WireConnection;12;1;9;0
WireConnection;1;1;2;0
WireConnection;29;0;24;0
WireConnection;29;1;25;0
WireConnection;27;0;28;0
WireConnection;27;1;26;0
WireConnection;14;0;1;2
WireConnection;14;1;12;1
WireConnection;13;0;1;1
WireConnection;13;1;12;2
WireConnection;17;0;13;0
WireConnection;17;1;19;0
WireConnection;30;0;27;0
WireConnection;30;1;29;0
WireConnection;18;0;14;0
WireConnection;18;1;20;0
WireConnection;31;0;30;0
WireConnection;31;1;17;0
WireConnection;32;0;30;0
WireConnection;32;1;18;0
WireConnection;33;0;31;0
WireConnection;34;0;32;0
WireConnection;43;0;46;0
WireConnection;43;1;14;0
WireConnection;43;2;44;0
WireConnection;43;3;44;0
WireConnection;43;4;45;0
WireConnection;36;1;34;0
WireConnection;35;1;33;0
WireConnection;47;0;50;0
WireConnection;47;1;51;1
WireConnection;47;2;48;0
WireConnection;47;3;48;0
WireConnection;47;4;49;0
WireConnection;37;0;35;0
WireConnection;37;1;38;0
WireConnection;42;0;36;1
WireConnection;42;1;43;0
WireConnection;0;2;37;0
WireConnection;0;9;42;0
ASEEND*/
//CHKSM=073CB5F6D2BCDEB49150C6A276886126364E347B