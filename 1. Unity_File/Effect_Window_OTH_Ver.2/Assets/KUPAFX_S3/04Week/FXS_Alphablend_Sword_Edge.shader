// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Sword_Edge"
{
	Properties
	{
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Edge_Ins("Edge_Ins", Range( 1 , 10)) = 1
		_Edge_Range("Edge_Range", Float) = 0.1
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Dissove("Dissove", Range( -1 , 1)) = 1
		_Edge_Pow("Edge_Pow", Range( 1 , 10)) = 1
		[Toggle(USE_CUSTOM_ON)] Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Edge_Color;
		uniform float _Edge_Range;
		uniform sampler2D _Sword_Texture;
		uniform float4 _Sword_Texture_ST;
		uniform float _Edge_Pow;
		uniform float _Edge_Ins;
		uniform sampler2D _Dissove_Texture;
		uniform float4 _Dissove_Texture_ST;
		uniform float _Dissove;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Sword_Texture = i.uv_texcoord * _Sword_Texture_ST.xy + _Sword_Texture_ST.zw;
			float temp_output_6_0 = ( step( ( 1.0 - i.uv_texcoord.y ) , _Edge_Range ) * tex2D( _Sword_Texture, uv_Sword_Texture ).r );
			#ifdef USE_CUSTOM_ON
				float staticSwitch24 = i.uv_tex4coord.z;
			#else
				float staticSwitch24 = _Edge_Ins;
			#endif
			o.Emission = ( ( _Edge_Color * ( pow( temp_output_6_0 , _Edge_Pow ) * staticSwitch24 ) ) * i.vertexColor ).rgb;
			float2 uv_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			#ifdef USE_CUSTOM_ON
				float staticSwitch23 = i.uv_tex4coord.w;
			#else
				float staticSwitch23 = _Dissove;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( ( temp_output_6_0 * saturate( ( tex2D( _Dissove_Texture, uv_Dissove_Texture ).r + staticSwitch23 ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;0;1920;1019;1681.964;550.3453;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1102,-372.5;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;5;-898,-367.5;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-677.245,473.5711;Inherit;False;Property;_Dissove;Dissove;5;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1057,-65.5;Inherit;False;Property;_Edge_Range;Edge_Range;2;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-942.9644,510.6547;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-918.245,202.5711;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;23;-409.3715,566.8365;Inherit;False;Property;Use_Custom;Use_Custom;7;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-661.1559,200.0856;Inherit;True;Property;_Dissove_Texture;Dissove_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-841,-45.5;Inherit;True;Property;_Sword_Texture;Sword_Texture;0;0;Create;True;0;0;0;False;0;False;-1;c655ce6b69242084aae743bf2992a8f5;c655ce6b69242084aae743bf2992a8f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;3;-760,-301.5;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-357.245,238.5711;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-469,-131.5;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-440,94.5;Inherit;False;Property;_Edge_Ins;Edge_Ins;1;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-273.245,-22.42889;Inherit;False;Property;_Edge_Pow;Edge_Pow;6;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;21;-71.245,-178.4289;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;-152.245,242.5711;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-136.9642,66.65472;Inherit;False;Property;Use_Custom;Use_Custom;7;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-282,-517.5;Inherit;False;Property;_Edge_Color;Edge_Color;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;19.46857,12.87774,8.052445,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;64.755,220.5711;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;111,-178.5;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;279.755,225.5711;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;11;323.3528,-50.53552;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;337,-264.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;647.3528,-130.5355;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;540.755,210.5711;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;925,-156;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Sword_Edge;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;2;2
WireConnection;23;1;16;0
WireConnection;23;0;25;4
WireConnection;13;1;14;0
WireConnection;3;0;5;0
WireConnection;3;1;4;0
WireConnection;15;0;13;1
WireConnection;15;1;23;0
WireConnection;6;0;3;0
WireConnection;6;1;1;1
WireConnection;21;0;6;0
WireConnection;21;1;22;0
WireConnection;17;0;15;0
WireConnection;24;1;8;0
WireConnection;24;0;25;3
WireConnection;18;0;6;0
WireConnection;18;1;17;0
WireConnection;7;0;21;0
WireConnection;7;1;24;0
WireConnection;19;0;18;0
WireConnection;9;0;10;0
WireConnection;9;1;7;0
WireConnection;12;0;9;0
WireConnection;12;1;11;0
WireConnection;20;0;11;4
WireConnection;20;1;19;0
WireConnection;0;2;12;0
WireConnection;0;9;20;0
ASEEND*/
//CHKSM=D78B659AE57488ABB8C360AC00CAC2B315F4A640