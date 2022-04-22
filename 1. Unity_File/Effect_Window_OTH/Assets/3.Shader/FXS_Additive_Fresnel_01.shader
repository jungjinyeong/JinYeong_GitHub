// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Fresnel_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,0)
		_F_Pow("F_Pow", Float) = 5
		_F_Scale("F_Scale", Float) = 5
		_Dissolve_Int("Dissolve_Int", Range( -1 , 1)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 0
		_Step_Size_Int("Step_Size_Int", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HDR]_Dissolve_Color("Dissolve_Color", Color) = (0,0,0,0)
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float _F_Scale;
		uniform float _F_Pow;
		uniform float4 _Fresnel_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Dissolve_Val;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Step_Size_Int;
		uniform float4 _Dissolve_Color;
		uniform float _Dissolve_Int;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV3 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode3 = ( 0.0 + _F_Scale * pow( 1.0 - fresnelNdotV3, _F_Pow ) );
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch20 = i.uv_tex4coord.z;
			#else
				float staticSwitch20 = _Dissolve_Val;
			#endif
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float4 tex2DNode14 = tex2D( _Noise_Texture, uv0_Noise_Texture );
			float temp_output_3_0_g7 = ( staticSwitch20 - tex2DNode14.r );
			float temp_output_42_0 = saturate( ( temp_output_3_0_g7 / fwidth( temp_output_3_0_g7 ) ) );
			float temp_output_3_0_g6 = ( ( staticSwitch20 + _Step_Size_Int ) - tex2DNode14.r );
			float temp_output_43_0 = saturate( ( temp_output_3_0_g6 / fwidth( temp_output_3_0_g6 ) ) );
			o.Emission = ( ( saturate( ( fresnelNode3 * _Fresnel_Color ) ) + ( tex2D( _Main_Texture, uv_Main_Texture ) * temp_output_42_0 * i.vertexColor ) ) + ( i.vertexColor.a * ( temp_output_43_0 - temp_output_42_0 ) * _Dissolve_Color * saturate( _Dissolve_Int ) ) ).rgb;
			o.Alpha = temp_output_43_0;
			clip( temp_output_43_0 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;12;1920;1007;3183.075;576.6236;1.349234;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-3128.648,888.2718;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-3221.774,738.9929;Float;False;Property;_Dissolve_Val;Dissolve_Val;6;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-3279.457,506.0216;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;20;-2845.885,782.4536;Float;False;Property;_Use_Custom;Use_Custom;8;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3073.506,1140.425;Float;False;Property;_Step_Size_Int;Step_Size_Int;7;0;Create;True;0;0;False;0;0;0.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2238.364,-242.7257;Float;False;Property;_F_Pow;F_Pow;2;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2239.826,-349.4484;Float;False;Property;_F_Scale;F_Scale;3;0;Create;True;0;0;False;0;5;-0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;3;-2025.034,-399.9855;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2002.882,-227.5103;Float;False;Property;_Fresnel_Color;Fresnel_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.120697,0.3722585,0.2484565,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2619.022,911.1901;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-2932.033,476.1649;Float;True;Property;_Noise_Texture;Noise_Texture;5;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;42;-2310.054,498.569;Float;True;Step Antialiasing;-1;;7;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1481.886,1011.892;Float;False;Property;_Dissolve_Int;Dissolve_Int;4;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2345.292,-13.77772;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;40526e53665b54f4ab08530fa57888a3;40526e53665b54f4ab08530fa57888a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-1742.844,-399.9855;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;43;-2318.028,885.2769;Float;True;Step Antialiasing;-1;;6;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2;-1739.175,259.9499;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;10;-1482.897,-398.2953;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1556.461,6.526432;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1844.383,476.2902;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;48;-1577.884,771.1917;Float;False;Property;_Dissolve_Color;Dissolve_Color;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.844303,0.7821388,0.3765854,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;51;-1192.969,728.1989;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1086.314,313.1293;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1040.325,-33.51049;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-636.5974,32.93074;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-226.0053,70.79372;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Fresnel_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;10;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;1;16;0
WireConnection;20;0;19;3
WireConnection;3;2;9;0
WireConnection;3;3;8;0
WireConnection;41;0;20;0
WireConnection;41;1;44;0
WireConnection;14;1;13;0
WireConnection;42;1;14;1
WireConnection;42;2;20;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;43;1;14;1
WireConnection;43;2;41;0
WireConnection;10;0;4;0
WireConnection;45;0;1;0
WireConnection;45;1;42;0
WireConnection;45;2;2;0
WireConnection;46;0;43;0
WireConnection;46;1;42;0
WireConnection;51;0;49;0
WireConnection;47;0;2;4
WireConnection;47;1;46;0
WireConnection;47;2;48;0
WireConnection;47;3;51;0
WireConnection;6;0;10;0
WireConnection;6;1;45;0
WireConnection;50;0;6;0
WireConnection;50;1;47;0
WireConnection;0;2;50;0
WireConnection;0;9;43;0
WireConnection;0;10;43;0
ASEEND*/
//CHKSM=D1A6270C0E6A0BE8BBBBF788D932B37B0A55C589