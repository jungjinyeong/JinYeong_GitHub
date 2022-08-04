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
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
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
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float _Cull_Mode;
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
			o.Emission = tex2D( _Ice_Texure, uv_Ice_Texure ).rgb;
			float4 temp_cast_1 = (0.2).xxxx;
			float2 uv_Ice_Tex_Normal = i.uv_texcoord * _Ice_Tex_Normal_ST.xy + _Ice_Tex_Normal_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch71 = i.uv_tex4coord.z;
			#else
				float staticSwitch71 = _Dissolve_Val;
			#endif
			o.Alpha = step( temp_cast_1 , ( saturate( ( tex2D( _Ice_Tex_Smoke, ( float3( i.uv_texcoord ,  0.0 ) + ( (UnpackNormal( tex2D( _Ice_Tex_Normal, uv_Ice_Tex_Normal ) )).xyz * 0.1 ) ).xy ) * _Opacity_Val ) ) * saturate( ( tex2D( _Dissolve_Texture, i.uv_texcoord ) + staticSwitch71 ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;73;951;599;600.979;-196.4823;1.597554;True;False
Node;AmplifyShaderEditor.SamplerNode;3;-471.1328,-63.40794;Float;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;2;0;Create;True;0;0;False;0;1612e87ed21a8af4080fd48ab7954cae;1612e87ed21a8af4080fd48ab7954cae;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;59;-173.9155,-66.93533;Float;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-133.5626,238.6263;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;89.06404,-78.28923;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;95.52605,-307.2094;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;66;480.0947,803.147;Float;False;Property;_Dissolve_Val;Dissolve_Val;6;0;Create;True;0;0;False;0;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;211.9977,564.1939;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;411.9934,-180.9063;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;70;482.1201,951.8981;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;71;811.4332,803.7177;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;64;664.8284,554.6598;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;5;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;654.5428,-3.047759;Float;True;Property;_Ice_Tex_Smoke;Ice_Tex_Smoke;3;0;Create;True;0;0;False;0;a466d9e2abfe11c439ffdeb4cdcb4573;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;679.7413,240.6404;Float;False;Property;_Opacity_Val;Opacity_Val;4;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;1082.946,134.2133;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;1011.507,581.2513;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;67;1242.665,578.1137;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;56;1293.901,137.9804;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;1483.728,135.4292;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1310.758,-7.965878;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;2143.948,-260.6324;Float;True;Property;_Cull_Mode;Cull_Mode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;919.5047,-309.8012;Float;True;Property;_Ice_Texure;Ice_Texure;1;0;Create;True;0;0;False;0;1fd0a24bca365a343912d72c2c55ea4f;1fd0a24bca365a343912d72c2c55ea4f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;57;1695.157,113.4191;Float;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1918.423,-297.3518;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Ice_Floor_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;59;0;3;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;62;0;63;0
WireConnection;62;1;60;0
WireConnection;71;1;66;0
WireConnection;71;0;70;3
WireConnection;64;1;69;0
WireConnection;53;1;62;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;65;0;64;0
WireConnection;65;1;71;0
WireConnection;67;0;65;0
WireConnection;56;0;54;0
WireConnection;68;0;56;0
WireConnection;68;1;67;0
WireConnection;57;0;58;0
WireConnection;57;1;68;0
WireConnection;0;2;2;0
WireConnection;0;9;57;0
ASEEND*/
//CHKSM=2F43D673B5E12F20B1A044E86704831B2FD63767