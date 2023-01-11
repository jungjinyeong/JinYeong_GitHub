// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Ice_Floor_01"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		_Ice_Texure("Ice_Texure", 2D) = "white" {}
		_Ice_Tex_Normal("Ice_Tex_Normal", 2D) = "bump" {}
		_Ice_Tex_Smoke("Ice_Tex_Smoke", 2D) = "white" {}
		_Opacity_Val("Opacity_Val", Range( 0 , 5)) = 1
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 1
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv_texcoord;
		};

		uniform float _Cull_Mode;
		uniform float4 _Tint_Color;
		uniform sampler2D _Ice_Texure;
		uniform float4 _Ice_Texure_ST;
		uniform sampler2D _Ice_Tex_Smoke;
		uniform sampler2D _Ice_Tex_Normal;
		uniform float4 _Ice_Tex_Normal_ST;
		uniform float _Opacity_Val;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Ice_Texure = i.uv_texcoord * _Ice_Texure_ST.xy + _Ice_Texure_ST.zw;
			float2 uv_Ice_Tex_Normal = i.uv_texcoord * _Ice_Tex_Normal_ST.xy + _Ice_Tex_Normal_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch82 = i.uv_texcoord.w;
			#else
				float staticSwitch82 = _Opacity_Val;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch71 = i.uv_texcoord.z;
			#else
				float staticSwitch71 = _Dissolve_Val;
			#endif
			float4 temp_output_68_0 = ( saturate( ( tex2D( _Ice_Tex_Smoke, ( float3( i.uv_texcoord.xy ,  0.0 ) + ( (UnpackNormal( tex2D( _Ice_Tex_Normal, uv_Ice_Tex_Normal ) )).xyz * 0.1 ) ).xy ) * staticSwitch82 ) ) * saturate( ( tex2D( _Dissolve_Texture, i.uv_texcoord.xy ) + staticSwitch71 ) ) );
			o.Emission = ( i.vertexColor * ( ( _Tint_Color * tex2D( _Ice_Texure, uv_Ice_Texure ) ) * temp_output_68_0 ) ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_68_0 * ( 0.2 + temp_output_68_0 ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
-1920;224;1920;1011;-135.7434;315.0354;1;True;False
Node;AmplifyShaderEditor.SamplerNode;3;-471.1328,-63.40794;Inherit;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;2;0;Create;True;0;0;0;False;0;False;-1;1612e87ed21a8af4080fd48ab7954cae;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;59;-173.9155,-66.93533;Inherit;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-133.5626,238.6263;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;89.06404,-78.28923;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;95.52605,-307.2094;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;70;-42.76998,914.7101;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;420.6945,200.3832;Float;False;Property;_Opacity_Val;Opacity_Val;4;0;Create;True;0;0;0;False;0;False;1;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;396.5058,773.9413;Float;False;Property;_Dissolve_Val;Dissolve_Val;6;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;144.319,529.4869;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;411.9934,-180.9063;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;64;664.8284,554.6598;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;5;0;Create;True;0;0;0;False;0;False;-1;03344d3d32e85af4faf109e635145a9b;c3ec6f776be501a4db757961359756df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;654.5428,-3.047759;Inherit;True;Property;_Ice_Tex_Smoke;Ice_Tex_Smoke;3;0;Create;True;0;0;0;False;0;False;-1;a466d9e2abfe11c439ffdeb4cdcb4573;bbd5f397c453a4644b0d07074a3b3e8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;71;727.8445,774.512;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;82;775.9527,203.3295;Float;False;Property;_Use_Custom;Use_Custom;9;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;1082.946,134.2133;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;1011.507,581.2513;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;56;1293.901,137.9804;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;67;1214.467,582.142;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;810.2444,-399.5311;Inherit;True;Property;_Ice_Texure;Ice_Texure;1;0;Create;True;0;0;0;False;0;False;-1;1fd0a24bca365a343912d72c2c55ea4f;1fd0a24bca365a343912d72c2c55ea4f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;80;881.5948,-672.8555;Float;False;Property;_Tint_Color;Tint_Color;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1.341177,1.490196,1.717647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;1210.515,-395.5301;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;1483.728,135.4292;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1310.758,-7.965878;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;77;1660.93,-414.8112;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;1501.293,-374.2637;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;1687.743,-140.0354;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;57;1614.658,-188.981;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;1926.93,-404.8452;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;72;413.3496,533.2991;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;73;208.5781,682.5393;Float;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;78.35606,783.804;Float;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;2405.389,-237.1166;Float;True;Property;_Cull_Mode;Cull_Mode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;1911.372,99.08614;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;75;226.1848,784.5849;Float;False;Property;_Use_Custom;Use_Custom;8;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2160.498,-300.1184;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Ice_Floor_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;59;0;3;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;62;0;63;0
WireConnection;62;1;60;0
WireConnection;64;1;69;0
WireConnection;53;1;62;0
WireConnection;71;1;66;0
WireConnection;71;0;70;3
WireConnection;82;1;55;0
WireConnection;82;0;70;4
WireConnection;54;0;53;0
WireConnection;54;1;82;0
WireConnection;65;0;64;0
WireConnection;65;1;71;0
WireConnection;56;0;54;0
WireConnection;67;0;65;0
WireConnection;81;0;80;0
WireConnection;81;1;2;0
WireConnection;68;0;56;0
WireConnection;68;1;67;0
WireConnection;83;0;81;0
WireConnection;83;1;68;0
WireConnection;84;0;58;0
WireConnection;84;1;68;0
WireConnection;57;0;58;0
WireConnection;57;1;68;0
WireConnection;78;0;77;0
WireConnection;78;1;83;0
WireConnection;72;0;69;0
WireConnection;72;1;73;0
WireConnection;72;2;75;0
WireConnection;79;0;77;4
WireConnection;79;1;68;0
WireConnection;79;2;84;0
WireConnection;75;1;74;0
WireConnection;75;0;70;1
WireConnection;0;2;78;0
WireConnection;0;9;79;0
ASEEND*/
//CHKSM=4AB8A1793357657DE46C1A13BE038D3572144EEA