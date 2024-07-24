// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Sword"
{
	Properties
	{
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Sword_Uoffset("Sword_Uoffset", Range( -1 , 1)) = 0.2235294
		_Emi_Ins("Emi_Ins", Range( 1 , 10)) = 0
		[HDR]_Emi_Color("Emi_Color", Color) = (0,0,0,0)
		_Emi_Offset("Emi_Offset", Range( -1 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_Ins("Main_Ins", Range( 1 , 10)) = 0
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 0.5)) = 0.53
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 0
		_DissTex_UPanner("DissTex_UPanner", Float) = 0
		_DissTex_VPanner("DissTex_VPanner", Float) = 0
		[Toggle(USE_CUSTOM_ON)] Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local USE_CUSTOM_ON
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#endif//ASE Sampling Macros

		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _Emi_Offset;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Main_Texture);
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Noise_Texture);
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		SamplerState sampler_Noise_Texture;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;
		SamplerState sampler_Main_Texture;
		uniform float _Emi_Ins;
		uniform float4 _Emi_Color;
		uniform float4 _Main_Color;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Sword_Texture);
		uniform float _Sword_Uoffset;
		SamplerState sampler_Sword_Texture;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Dissolve_Texture);
		uniform float _DissTex_UPanner;
		uniform float _DissTex_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		SamplerState sampler_Dissolve_Texture;
		uniform float _Dissolve_Val;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef USE_CUSTOM_ON
				float staticSwitch78 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch78 = _Emi_Offset;
			#endif
			float temp_output_62_0 = saturate( ( ( 1.0 - i.uv_texcoord.x ) + staticSwitch78 ) );
			float2 appendResult15 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult39 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner41 = ( 1.0 * _Time.y * appendResult39 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner12 = ( 1.0 * _Time.y * appendResult15 + ( ( (UnpackNormal( SAMPLE_TEXTURE2D( _Noise_Texture, sampler_Noise_Texture, panner41 ) )).xy * _Noise_Str ) + uv_Main_Texture ));
			float4 tex2DNode9 = SAMPLE_TEXTURE2D( _Main_Texture, sampler_Main_Texture, panner12 );
			#ifdef USE_CUSTOM_ON
				float staticSwitch79 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch79 = _Emi_Ins;
			#endif
			o.Emission = ( ( ( saturate( ( pow( ( temp_output_62_0 * ( temp_output_62_0 + tex2DNode9.r ) ) , 4.0 ) * staticSwitch79 ) ) * _Emi_Color ) + ( _Main_Color * ( pow( tex2DNode9.r , _Main_Pow ) * _Main_Ins ) ) ) * i.vertexColor ).rgb;
			#ifdef USE_CUSTOM_ON
				float staticSwitch76 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch76 = _Sword_Uoffset;
			#endif
			float2 appendResult7 = (float2(staticSwitch76 , 0.0));
			float2 appendResult86 = (float2(_DissTex_UPanner , _DissTex_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner83 = ( 1.0 * _Time.y * appendResult86 + uv_Dissolve_Texture);
			#ifdef USE_CUSTOM_ON
				float staticSwitch77 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch77 = _Dissolve_Val;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( SAMPLE_TEXTURE2D( _Sword_Texture, sampler_Sword_Texture, (i.uv_texcoord*1.0 + appendResult7) ).r * saturate( pow( ( ( i.uv_texcoord.x * ( 1.0 - i.uv_texcoord.x ) ) * 4.0 ) , 2.0 ) ) ) * saturate( ( SAMPLE_TEXTURE2D( _Dissolve_Texture, sampler_Dissolve_Texture, panner83 ).r + staticSwitch77 ) ) ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
-62;226;1920;995;3151.755;107.0579;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;42;-2876.288,-508.67;Inherit;False;1206.358;494.6667;Noise_Tex;9;48;49;44;41;40;38;37;39;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2661.288,-122.0036;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2675.288,-210.0035;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;14;0;Create;True;0;0;0;False;0;False;0;-0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-2463.288,-171.0036;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-2826.288,-458.67;Inherit;True;0;36;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;41;-2572.288,-423.67;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;36;-2390.928,-449.2171;Inherit;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;0;False;0;False;-1;None;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;71;-1899.212,-1336.516;Inherit;False;2183.14;690.3801;Emi_Color;16;70;93;92;65;67;68;66;64;63;62;59;61;60;58;78;79;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-2207.088,-114.0703;Inherit;False;Property;_Noise_Str;Noise_Str;13;0;Create;True;0;0;0;False;0;False;0.53;0.149;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;44;-2111.087,-446.07;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;54;-1583.508,-578.6783;Inherit;False;1707.251;569.9335;Comment;13;11;14;13;15;43;12;51;9;50;53;52;2;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1431.256,-305.0116;Inherit;False;Property;_Main_UPanner;Main_UPanner;10;0;Create;True;0;0;0;False;0;False;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1838.212,-948.5156;Inherit;False;Property;_Emi_Offset;Emi_Offset;4;0;Create;True;0;0;0;False;0;False;0;0.22;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-1849.212,-1286.516;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;80;-2491.711,190.1958;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1880.087,-260.0702;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1435.256,-226.0115;Inherit;False;Property;_Main_VPanner;Main_VPanner;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1430.971,538.5166;Inherit;False;1331;446;Mask;7;16;18;17;19;21;20;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1526.508,-448.9756;Inherit;False;0;9;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1315.916,-500.8417;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;90;-1431.509,1000.305;Inherit;False;1312;413.5474;Comment;10;82;83;84;85;86;81;88;87;89;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1380.971,588.5164;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;60;-1624.212,-1230.516;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;78;-1596.316,-870.1775;Inherit;False;Property;Use_Custom;Use_Custom;20;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1237.256,-275.0115;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;18;-1133.971,730.5165;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1381.509,1214.852;Inherit;False;Property;_DissTex_UPanner;DissTex_UPanner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-1376.509,1297.852;Inherit;False;Property;_DissTex_VPanner;DissTex_VPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;55;-1434.366,25.38462;Inherit;False;1548.203;494.4955;Sword;8;6;4;7;3;1;24;91;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;-1430.212,-1222.516;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1595.087,184.3194;Inherit;False;Property;_Sword_Uoffset;Sword_Uoffset;1;0;Create;True;0;0;0;False;0;False;0.2235294;-0.07;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-1072.256,-356.6783;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;76;-1311.765,235.8288;Inherit;False;Property;Use_Custom;Use_Custom;15;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1225.389,343.2452;Inherit;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-885.2564,-371.6783;Inherit;True;Property;_Main_Texture;Main_Texture;6;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;62;-1253.212,-1235.516;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;86;-1163.509,1236.852;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;82;-1339.509,1059.852;Inherit;False;0;81;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-938.9709,612.5164;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-1070.449,-1071.514;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1296.366,75.38466;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-958.5087,1255.852;Inherit;False;Property;_Dissolve_Val;Dissolve_Val;17;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-732.9716,609.5164;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;83;-1069.509,1077.852;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-669.9716,855.5165;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1090.366,284.3848;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;3;-1022.366,86.38466;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;81;-865.6049,1050.305;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;16;0;Create;True;0;0;0;False;0;False;-1;None;e3c24bd69ca2d4a42933ef11dbb112c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-823.3599,-1233.222;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;20;-532.9718,610.5164;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-756.3945,-816.7556;Inherit;False;Property;_Emi_Ins;Emi_Ins;2;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;77;-649.0721,1313.709;Inherit;False;Property;Use_Custom;Use_Custom;15;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-748.0725,-992.1355;Inherit;False;Constant;_Float2;Float 2;14;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;79;-447.0548,-761.4308;Inherit;False;Property;Use_Custom;Use_Custom;15;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-297.972,609.5164;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-713.0759,146.425;Inherit;True;Property;_Sword_Texture;Sword_Texture;0;0;Create;True;0;0;0;False;0;False;-1;c655ce6b69242084aae743bf2992a8f5;c655ce6b69242084aae743bf2992a8f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;-863.5874,-164.535;Inherit;False;Property;_Main_Pow;Main_Pow;9;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;-518.5087,1077.852;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;65;-616.0725,-1230.135;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-268.2135,185.8454;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-355.6487,-1176.898;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;89;-317.5089,1073.852;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-554.2502,-88.93958;Inherit;False;Property;_Main_Ins;Main_Ins;8;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;50;-506.9919,-332.0032;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-33.42178,388.5777;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-251.7824,-313.7448;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-465.2567,-528.6783;Inherit;False;Property;_Main_Color;Main_Color;7;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.563821,1.378595,3.211117,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;68;-207.0725,-938.1355;Inherit;False;Property;_Emi_Color;Emi_Color;3;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1.660377,0.664826,0.242791,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-38.29976,624.7725;Inherit;False;Property;_Opacity;Opacity;5;0;Create;True;0;0;0;False;0;False;0;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;-155.0725,-1169.135;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-152.2567,-356.6783;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;65.92751,-940.1355;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;193.2456,412.6317;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;86.8275,-370.4354;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;75;413.8847,212.1237;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;72;124.2781,-146.533;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;652.1712,86.56789;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;435.9479,-197.3086;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;773.2337,-155.4009;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Sword;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;41;0;40;0
WireConnection;41;2;39;0
WireConnection;36;1;41;0
WireConnection;44;0;36;0
WireConnection;48;0;44;0
WireConnection;48;1;49;0
WireConnection;43;0;48;0
WireConnection;43;1;11;0
WireConnection;60;0;58;1
WireConnection;78;1;61;0
WireConnection;78;0;80;3
WireConnection;15;0;14;0
WireConnection;15;1;13;0
WireConnection;18;0;16;1
WireConnection;59;0;60;0
WireConnection;59;1;78;0
WireConnection;12;0;43;0
WireConnection;12;2;15;0
WireConnection;76;1;5;0
WireConnection;76;0;80;1
WireConnection;9;1;12;0
WireConnection;62;0;59;0
WireConnection;86;0;84;0
WireConnection;86;1;85;0
WireConnection;17;0;16;1
WireConnection;17;1;18;0
WireConnection;63;0;62;0
WireConnection;63;1;9;1
WireConnection;19;0;17;0
WireConnection;83;0;82;0
WireConnection;83;2;86;0
WireConnection;7;0;76;0
WireConnection;7;1;6;0
WireConnection;3;0;4;0
WireConnection;3;2;7;0
WireConnection;81;1;83;0
WireConnection;64;0;62;0
WireConnection;64;1;63;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;77;1;88;0
WireConnection;77;0;80;2
WireConnection;79;1;93;0
WireConnection;79;0;80;4
WireConnection;22;0;20;0
WireConnection;1;1;3;0
WireConnection;87;0;81;1
WireConnection;87;1;77;0
WireConnection;65;0;64;0
WireConnection;65;1;66;0
WireConnection;24;0;1;1
WireConnection;24;1;22;0
WireConnection;92;0;65;0
WireConnection;92;1;79;0
WireConnection;89;0;87;0
WireConnection;50;0;9;1
WireConnection;50;1;51;0
WireConnection;91;0;24;0
WireConnection;91;1;89;0
WireConnection;52;0;50;0
WireConnection;52;1;53;0
WireConnection;70;0;92;0
WireConnection;10;0;2;0
WireConnection;10;1;52;0
WireConnection;67;0;70;0
WireConnection;67;1;68;0
WireConnection;25;0;91;0
WireConnection;25;1;26;0
WireConnection;69;0;67;0
WireConnection;69;1;10;0
WireConnection;75;0;25;0
WireConnection;74;0;72;4
WireConnection;74;1;75;0
WireConnection;73;0;69;0
WireConnection;73;1;72;0
WireConnection;0;2;73;0
WireConnection;0;9;74;0
ASEEND*/
//CHKSM=811CF4DA1992985F3024DFB97FDA8639DB2D6486