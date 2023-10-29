// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Ice_Floor"
{
	Properties
	{
		_FXT_Ice01("FXT_Ice01", 2D) = "white" {}
		_FXT_Ice01_Normal("FXT_Ice01_Normal", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_KEYWORD0_ON)] _Keyword0("Keyword 0", Float) = 0
		[Toggle(_KEYWORD1_ON)] _Keyword1("Keyword 1", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _KEYWORD1_ON
		#pragma shader_feature _KEYWORD0_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform sampler2D _FXT_Ice01;
		uniform float4 _FXT_Ice01_ST;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _FXT_Ice01_Normal;
		uniform float4 _FXT_Ice01_Normal_ST;
		uniform float _Opacity;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FXT_Ice01 = i.uv_texcoord * _FXT_Ice01_ST.xy + _FXT_Ice01_ST.zw;
			o.Emission = ( tex2D( _FXT_Ice01, uv_FXT_Ice01 ) * i.vertexColor ).rgb;
			float2 uv_FXT_Ice01_Normal = i.uv_texcoord * _FXT_Ice01_Normal_ST.xy + _FXT_Ice01_Normal_ST.zw;
			float2 uv0_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _KEYWORD1_ON
				float staticSwitch25 = i.uv_tex4coord.w;
			#else
				float staticSwitch25 = 0.0;
			#endif
			float cos22 = cos( staticSwitch25 );
			float sin22 = sin( staticSwitch25 );
			float2 rotator22 = mul( uv0_TextureSample1 - temp_cast_1 , float2x2( cos22 , -sin22 , sin22 , cos22 )) + temp_cast_1;
			#ifdef _KEYWORD0_ON
				float staticSwitch21 = i.uv_tex4coord.z;
			#else
				float staticSwitch21 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * step( 0.15 , ( saturate( ( tex2D( _TextureSample0, ( i.uv_texcoord + ( (UnpackNormal( tex2D( _FXT_Ice01_Normal, uv_FXT_Ice01_Normal ) )).xy * 0.1 ) ) ).r * _Opacity ) ) * saturate( ( tex2D( _TextureSample1, rotator22 ).r + staticSwitch21 ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;69;1920;950;598.2277;499.812;1;True;False
Node;AmplifyShaderEditor.SamplerNode;2;-1259.771,-37.91965;Float;True;Property;_FXT_Ice01_Normal;FXT_Ice01_Normal;1;0;Create;True;0;0;False;0;a193986083da480468d48b2feb42d6cd;a193986083da480468d48b2feb42d6cd;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;9;-970.8113,-38.69763;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1093.811,216.3024;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-932.434,801.3154;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;20;-494.4336,718.8154;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-962.434,697.3154;Float;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-968.5553,367.58;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;25;-717.434,970.3154;Float;False;Property;_Keyword1;Keyword 1;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-927.8113,146.3024;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-935.8113,-194.1976;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-665.8113,-67.69763;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;22;-768.434,665.3154;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-545.5553,596.58;Float;False;Property;_Dissolve;Dissolve;5;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-466,5.5;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;a466d9e2abfe11c439ffdeb4cdcb4573;a466d9e2abfe11c439ffdeb4cdcb4573;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;-188.4336,708.8154;Float;False;Property;_Keyword0;Keyword 0;6;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-482.5553,393.58;Float;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;False;0;None;710f0ecf3a70db046b1d6dc37fef65ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-515,214.5;Float;False;Property;_Opacity;Opacity;3;0;Create;True;0;0;False;0;1;2.56;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-163.5553,433.58;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-178,57.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;56.4447,421.58;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;26,55.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;207.4447,231.58;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;132.1483,-49.04077;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2.700002,-285.3;Float;True;Property;_FXT_Ice01;FXT_Ice01;0;0;Create;True;0;0;False;0;27b83114de59fc44dab96ecdeda996a0;27b83114de59fc44dab96ecdeda996a0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;7;477.1483,23.95923;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;26;411.7723,-167.812;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;613.7723,-189.812;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;807.7723,-79.81204;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1045,-324;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Ice_Floor;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;2;0
WireConnection;25;1;24;0
WireConnection;25;0;20;4
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;13;0;12;0
WireConnection;13;1;10;0
WireConnection;22;0;19;0
WireConnection;22;1;23;0
WireConnection;22;2;25;0
WireConnection;3;1;13;0
WireConnection;21;1;16;0
WireConnection;21;0;20;3
WireConnection;14;1;22;0
WireConnection;15;0;14;1
WireConnection;15;1;21;0
WireConnection;4;0;3;1
WireConnection;4;1;5;0
WireConnection;17;0;15;0
WireConnection;6;0;4;0
WireConnection;18;0;6;0
WireConnection;18;1;17;0
WireConnection;7;0;8;0
WireConnection;7;1;18;0
WireConnection;27;0;1;0
WireConnection;27;1;26;0
WireConnection;28;0;26;4
WireConnection;28;1;7;0
WireConnection;0;2;27;0
WireConnection;0;9;28;0
ASEEND*/
//CHKSM=2ED33EBE265DCCD3CB5E5E876B5E1771AA139F71