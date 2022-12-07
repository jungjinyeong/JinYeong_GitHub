// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Portal01"
{
	Properties
	{
		_FXT_Space_Noise01("FXT_Space_Noise01", 2D) = "white" {}
		_Hole_Radius("Hole_Radius", Range( 0 , 1)) = 0.5
		_Height_Space("Height_Space", Float) = -0.08
		_FXT_Circle_RG("FXT_Circle_RG", 2D) = "white" {}
		[HDR]_CireleColor("CireleColor", Color) = (1,1,1,0)
		_Height_Circle("Height_Circle", Float) = -0.08
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		[Toggle(_USE_MASKTEX_ON)] _Use_MaskTex("Use_MaskTex", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _USE_MASKTEX_ON
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		UNITY_DECLARE_TEX2D_NOSAMPLER(_FXT_Circle_RG);
		uniform float _Height_Circle;
		SamplerState sampler_linear_clamp;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FXT_Space_Noise01);
		uniform float _Height_Space;
		SamplerState sampler_FXT_Space_Noise01;
		uniform float4 _CireleColor;
		uniform float _Hole_Radius;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Mask_Texture);
		uniform float4 _Mask_Texture_ST;
		SamplerState sampler_Mask_Texture;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 Offset26 = ( ( _Height_Circle - 1 ) * i.viewDir.xy * 1.0 ) + i.uv_texcoord;
			float4 tex2DNode17 = SAMPLE_TEXTURE2D( _FXT_Circle_RG, sampler_linear_clamp, Offset26 );
			float2 Offset33 = ( ( _Height_Space - 1 ) * i.viewDir.xy * 1.0 ) + i.uv_texcoord;
			o.Emission = ( ( ( ( 1.0 - tex2DNode17.r ) * SAMPLE_TEXTURE2D( _FXT_Space_Noise01, sampler_FXT_Space_Noise01, Offset33 ) ) + ( tex2DNode17.g * _CireleColor ) ) * i.vertexColor ).rgb;
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_5_0 = ( ( i.uv_texcoord - temp_cast_1 ) * 2.0 );
			float2 temp_cast_2 = (0.5).xx;
			float2 temp_output_7_0 = ( temp_output_5_0 * temp_output_5_0 );
			float2 temp_cast_3 = (0.5).xx;
			float2 temp_cast_4 = (0.5).xx;
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			#ifdef _USE_MASKTEX_ON
				float staticSwitch37 = SAMPLE_TEXTURE2D( _Mask_Texture, sampler_Mask_Texture, uv_Mask_Texture ).r;
			#else
				float staticSwitch37 = step( ( (temp_output_7_0).x + (temp_output_7_0).y ) , _Hole_Radius );
			#endif
			o.Alpha = ( i.vertexColor.a * staticSwitch37 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;12;1920;1007;938.5104;314.942;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;62;-1529.462,-102.8531;Inherit;False;1839.777;740.1171;Mask;13;4;3;6;5;7;9;10;15;12;37;36;2;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1479.462,-4.853112;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1435.462,251.1469;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-1272.462,12.1469;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1216.462,238.1469;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1335.991,-824.2964;Inherit;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1342.991,-917.2964;Inherit;False;Property;_Height_Circle;Height_Circle;5;0;Create;True;0;0;0;False;0;False;-0.08;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1367.991,-1041.296;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;30;-1332.991,-702.2964;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1072.462,19.14689;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-873.4622,14.1469;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerStateNode;32;-961.8778,-726.9673;Inherit;False;1;1;1;1;-1;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.ParallaxMappingNode;26;-1050.991,-951.2964;Inherit;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1332.627,-438.13;Inherit;False;Property;_Height_Space;Height_Space;2;0;Create;True;0;0;0;False;0;False;-0.08;-0.73;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;-678.4622,-52.8531;Inherit;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;33;-952.627,-401.13;Inherit;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;9;-675.4622,172.1469;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-608.9913,-744.2964;Inherit;True;Property;_FXT_Circle_RG;FXT_Circle_RG;3;0;Create;True;0;0;0;False;0;False;-1;d38cd1127fc69224abe2d3e55c9da608;d38cd1127fc69224abe2d3e55c9da608;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-590,-406.5;Inherit;True;Property;_FXT_Space_Noise01;FXT_Space_Noise01;0;0;Create;True;0;0;0;False;0;False;-1;ff43c8a762114ad42a9677b19874a99c;ff43c8a762114ad42a9677b19874a99c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;21;-173.9913,-739.2964;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-151.9913,-395.2964;Inherit;False;Property;_CireleColor;CireleColor;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;5.216475,1.802552,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-410.4621,78.14697;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-455.2986,308.1777;Inherit;False;Property;_Hole_Radius;Hole_Radius;1;0;Create;True;0;0;0;False;0;False;0.5;0.339;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;91.00867,-443.2964;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;88.00867,-703.2964;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;36;-291.6848,407.2639;Inherit;True;Property;_Mask_Texture;Mask_Texture;6;0;Create;True;0;0;0;False;0;False;-1;None;8813ac6b4a65824479c76a296ad80607;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;12;-176.4762,85.85696;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;346.0087,-545.2964;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;61;-1731.693,661.2503;Inherit;False;2038.7;701.546;Tri Mask;16;41;53;55;46;54;47;48;42;44;51;40;58;57;59;56;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;37;58.31514,299.2639;Inherit;False;Property;_Use_MaskTex;Use_MaskTex;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;63;344.4896,-279.942;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;437.4896,12.05798;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;619.4896,-474.942;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-698.693,1014.796;Inherit;False;Property;_Radius;Radius;8;0;Create;True;0;0;0;False;0;False;0.12;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;58;-383.6931,1108.796;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;40;-547.9703,722.2718;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;51;-729.5726,718.6366;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;44;-857.4312,711.2503;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;42;-852.6192,825.7668;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;47;-1101.97,792.2718;Inherit;False;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1442.478,815.0203;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1408.693,1028.796;Inherit;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1681.693,939.7965;Inherit;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-1644.97,804.2719;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;59;-112.6931,1040.796;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;48;-1101.97,712.2718;Inherit;False;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;72.00697,779.6964;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;56;-279.693,787.7966;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-1241.693,926.7965;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;662,-263;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Portal01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;7;1;5;0
WireConnection;26;0;27;0
WireConnection;26;1;28;0
WireConnection;26;2;29;0
WireConnection;26;3;30;0
WireConnection;8;0;7;0
WireConnection;33;0;27;0
WireConnection;33;1;34;0
WireConnection;33;2;29;0
WireConnection;33;3;30;0
WireConnection;9;0;7;0
WireConnection;17;1;26;0
WireConnection;17;7;32;0
WireConnection;1;1;33;0
WireConnection;21;0;17;1
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;23;0;17;2
WireConnection;23;1;24;0
WireConnection;22;0;21;0
WireConnection;22;1;1;0
WireConnection;12;0;10;0
WireConnection;12;1;15;0
WireConnection;25;0;22;0
WireConnection;25;1;23;0
WireConnection;37;1;12;0
WireConnection;37;0;36;1
WireConnection;65;0;63;4
WireConnection;65;1;37;0
WireConnection;64;0;25;0
WireConnection;64;1;63;0
WireConnection;58;0;40;0
WireConnection;40;0;51;0
WireConnection;51;0;44;0
WireConnection;51;1;42;0
WireConnection;44;0;48;0
WireConnection;44;1;47;0
WireConnection;47;0;54;0
WireConnection;46;0;41;0
WireConnection;46;1;53;0
WireConnection;59;0;58;0
WireConnection;59;1;57;0
WireConnection;48;0;54;0
WireConnection;60;0;56;0
WireConnection;60;1;59;0
WireConnection;56;0;40;0
WireConnection;56;1;57;0
WireConnection;54;0;46;0
WireConnection;54;1;55;0
WireConnection;0;2;64;0
WireConnection;0;9;65;0
ASEEND*/
//CHKSM=5E550E9E67F47930CF8AC762EBE49155520B4F7F