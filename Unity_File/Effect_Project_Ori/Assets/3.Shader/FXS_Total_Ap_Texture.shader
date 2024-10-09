// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Total_Ap_Texture"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_U_Panner("Main_U_Panner", Float) = 0
		_Main_V_Panner("Main_V_Panner", Float) = 0
		_Main_Power("Main_Power", Float) = 1
		_Opacity_Val("Opacity_Val", Float) = 1
		[Toggle(_NOISE_ONDEFALT_0_ON)] _Noise_OnDefalt_0("--------------------Noise_On--------------------[Defalt_0]", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Float) = 0
		_Noise_U_Offset("Noise_U_Offset", Float) = 0
		_Noise_V_Offset("Noise_V_Offset", Float) = 0
		_Noise_U_Panner("Noise_U_Panner", Float) = 0
		_Noise_V_Panner("Noise_V_Panner", Float) = 0
		[Toggle(_DISSOLVE_TEXTURE_ONDEFALT_0_ON)] _Dissolve_Texture_OnDefalt_0("--------------Dissolve_Texture_On--------------[Defalt_0]", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_U_Scale("Dissolve_U_Scale", Float) = 1
		_Dissolve_V_Scale("Dissolve_V_Scale", Float) = 1
		_Dissolve_U_Panner("Dissolve_U_Panner", Float) = 0
		_Dissolve_V_Panner("Dissolve_V_Panner", Float) = 0
		[Toggle(_MASKDEFALT_ON_ON)] _MaskDefalt_On("===============Mask===============[Defalt_On]", Float) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Ins("Mask_Ins", Float) = 1
		_Mask_Pow("Mask_Pow", Float) = 1
		_Mask_U_Panner("Mask_U_Panner", Float) = 0
		_Mask_V_Panner("Mask_V_Panner", Float) = 0
		[Toggle(_TRANSITION_ONDEFALT_12_ON)] _Transition_OnDefalt_12("------------------Transition_On------------------[Defalt_-1.2]", Float) = 1
		_Transition_Texture("Transition_Texture", 2D) = "white" {}
		[HDR]_Transition_Line_Color("Transition_Line_Color", Color) = (1,1,1,0)
		_Transition_Val("Transition_Val", Range( -1.2 , 1.2)) = -1.2
		_Transition_Line_Val("Transition_Line_Val", Range( 0 , 0.1)) = 0
		_Transition_U_Offset("Transition_U_Offset", Float) = 1
		_Transition_V_Offset("Transition_V_Offset", Float) = 1
		_Transition_U_Panner("Transition_U_Panner", Float) = 0
		_Transition_V_Panner("Transition_V_Panner", Float) = 0
		[Toggle(_DEFALTDEFALT_ON_ON)] _DefaltDefalt_On("===============Defalt===============[Defalt_On]", Float) = 1
		[Toggle(_TOON_ONDEFALT_OFF_ON)] _Toon_OnDefalt_Off("--------------Toon_On--------------[Defalt_Off]", Float) = 0
		_DepthFade_Val("DepthFade_Val", Float) = 0
		_Chromatic_Val("Chromatic_Val", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 1
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _TOON_ONDEFALT_OFF_ON
		#pragma shader_feature_local _NOISE_ONDEFALT_0_ON
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma shader_feature_local _DISSOLVE_TEXTURE_ONDEFALT_0_ON
		#pragma shader_feature_local _TRANSITION_ONDEFALT_12_ON
		#pragma shader_feature_local _MASKDEFALT_ON_ON
		#pragma shader_feature_local _DEFALTDEFALT_ON_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 uv3_texcoord3;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_U_Panner;
		uniform float _Noise_V_Panner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_U_Offset;
		uniform float _Noise_V_Offset;
		uniform float _Noise_Val;
		uniform float _Main_U_Panner;
		uniform float _Main_V_Panner;
		uniform float4 _Main_Texture_ST;
		uniform float _Chromatic_Val;
		uniform float _Main_Power;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_U_Panner;
		uniform float _Dissolve_V_Panner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve_U_Scale;
		uniform float _Dissolve_V_Scale;
		uniform float4 _Transition_Line_Color;
		uniform sampler2D _Transition_Texture;
		uniform float _Transition_U_Panner;
		uniform float _Transition_V_Panner;
		uniform float4 _Transition_Texture_ST;
		uniform float _Transition_U_Offset;
		uniform float _Transition_V_Offset;
		uniform float _Transition_Line_Val;
		uniform float _Transition_Val;
		uniform sampler2D _Mask_Texture;
		uniform float _Mask_U_Panner;
		uniform float _Mask_V_Panner;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Pow;
		uniform float _Mask_Ins;
		uniform float _Opacity_Val;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthFade_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult80 = (float2(_Noise_U_Panner , _Noise_V_Panner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner85 = ( 1.0 * _Time.y * appendResult80 + uv_Noise_Texture);
			float2 appendResult84 = (float2(_Noise_U_Offset , _Noise_V_Offset));
			#ifdef _NOISE_ONDEFALT_0_ON
				float2 staticSwitch311 = ( (UnpackNormal( tex2D( _Noise_Texture, (panner85*1.0 + appendResult84) ) )).xy * _Noise_Val );
			#else
				float2 staticSwitch311 = float2( 0,0 );
			#endif
			float2 appendResult42 = (float2(_Main_U_Panner , _Main_V_Panner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner39 = ( 1.0 * _Time.y * appendResult42 + uv_Main_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch165 = i.uv2_texcoord2.x;
			#else
				float staticSwitch165 = 1.0;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch166 = i.uv2_texcoord2.y;
			#else
				float staticSwitch166 = 1.0;
			#endif
			float2 appendResult167 = (float2(staticSwitch165 , staticSwitch166));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch141 = i.uv2_texcoord2.z;
			#else
				float staticSwitch141 = 0.0;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch142 = i.uv2_texcoord2.w;
			#else
				float staticSwitch142 = 0.0;
			#endif
			float2 appendResult46 = (float2(staticSwitch141 , staticSwitch142));
			float2 temp_output_89_0 = ( staticSwitch311 + (panner39*appendResult167 + appendResult46) );
			float2 temp_cast_0 = (_Chromatic_Val).xx;
			float4 tex2DNode7 = tex2D( _Main_Texture, ( temp_output_89_0 - temp_cast_0 ) );
			float4 appendResult20 = (float4(tex2D( _Main_Texture, ( temp_output_89_0 + _Chromatic_Val ) ).r , tex2D( _Main_Texture, temp_output_89_0 ).g , tex2DNode7.b , 0.0));
			float4 temp_cast_1 = (_Main_Power).xxxx;
			float4 temp_cast_2 = (tex2DNode7.r).xxxx;
			float2 appendResult67 = (float2(_Dissolve_U_Panner , _Dissolve_V_Panner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner68 = ( 1.0 * _Time.y * appendResult67 + uv_Dissolve_Texture);
			float2 appendResult66 = (float2(_Dissolve_U_Scale , _Dissolve_V_Scale));
			#ifdef _DISSOLVE_TEXTURE_ONDEFALT_0_ON
				float4 staticSwitch256 = tex2D( _Dissolve_Texture, (panner68*appendResult66 + 0.0) );
			#else
				float4 staticSwitch256 = temp_cast_2;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch134 = i.uv3_texcoord3.w;
			#else
				float staticSwitch134 = 0.0;
			#endif
			float4 temp_output_72_0 = saturate( ( staticSwitch256 + ( 1.0 - ( staticSwitch134 * 2.0 ) ) ) );
			float4 temp_output_73_0 = ( pow( appendResult20 , temp_cast_1 ) * temp_output_72_0 );
			float2 appendResult114 = (float2(_Transition_U_Panner , _Transition_V_Panner));
			float2 uv_Transition_Texture = i.uv_texcoord * _Transition_Texture_ST.xy + _Transition_Texture_ST.zw;
			float2 panner119 = ( 1.0 * _Time.y * appendResult114 + uv_Transition_Texture);
			float2 appendResult118 = (float2(_Transition_U_Offset , _Transition_V_Offset));
			float4 temp_output_122_0 = saturate( tex2D( _Transition_Texture, (panner119*1.0 + appendResult118) ) );
			#ifdef _TRANSITION_ONDEFALT_12_ON
				float staticSwitch198 = 0.0;
			#else
				float staticSwitch198 = _Transition_Val;
			#endif
			float4 temp_cast_6 = (staticSwitch198).xxxx;
			float4 temp_output_105_0 = saturate( floor( ( ( temp_output_122_0 + _Transition_Line_Val ) - temp_cast_6 ) ) );
			float4 temp_cast_7 = (staticSwitch198).xxxx;
			float4 temp_output_314_0 = saturate( ( ( _Main_Color * temp_output_73_0 ) * ( temp_output_73_0 + ( _Transition_Line_Color * ( temp_output_105_0 - saturate( floor( ( temp_output_122_0 - temp_cast_7 ) ) ) ) ) ) ) );
			#ifdef _TOON_ONDEFALT_OFF_ON
				float4 staticSwitch319 = saturate( floor( ( temp_output_314_0 * 2.0 ) ) );
			#else
				float4 staticSwitch319 = temp_output_314_0;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch172 = i.uv3_texcoord3.x;
			#else
				float staticSwitch172 = 1.0;
			#endif
			o.Emission = ( ( staticSwitch319 * staticSwitch172 ) * i.vertexColor ).rgb;
			float2 appendResult53 = (float2(_Mask_U_Panner , _Mask_V_Panner));
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float2 panner54 = ( 1.0 * _Time.y * appendResult53 + uv_Mask_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch155 = i.uv3_texcoord3.y;
			#else
				float staticSwitch155 = 0.0;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch154 = i.uv3_texcoord3.z;
			#else
				float staticSwitch154 = 0.0;
			#endif
			float2 appendResult52 = (float2(staticSwitch155 , staticSwitch154));
			float4 temp_cast_13 = (_Mask_Pow).xxxx;
			float4 temp_output_36_0 = saturate( ( pow( tex2D( _Mask_Texture, (panner54*1.0 + appendResult52) ) , temp_cast_13 ) * _Mask_Ins ) );
			#ifdef _MASKDEFALT_ON_ON
				float4 staticSwitch310 = temp_output_36_0;
			#else
				float4 staticSwitch310 = temp_output_36_0;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth56 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth56 = abs( ( screenDepth56 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade_Val ) );
			float temp_output_58_0 = saturate( distanceDepth56 );
			#ifdef _DEFALTDEFALT_ON_ON
				float staticSwitch312 = temp_output_58_0;
			#else
				float staticSwitch312 = temp_output_58_0;
			#endif
			o.Alpha = ( i.vertexColor.a * ( ( ( ( ( appendResult20 * temp_output_72_0 ) * temp_output_105_0 ) * staticSwitch310 ) * _Opacity_Val ) * staticSwitch312 ) ).x;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
8;31;2544;972;1572.097;2062.404;3.553087;True;False
Node;AmplifyShaderEditor.RangedFloatNode;78;-4013.853,84.08385;Inherit;False;Property;_Noise_U_Panner;Noise_U_Panner;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-4013.853,180.084;Inherit;False;Property;_Noise_V_Panner;Noise_V_Panner;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;80;-3798.138,89.87095;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-4013.853,372.0841;Inherit;False;Property;_Noise_V_Offset;Noise_V_Offset;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-4013.853,276.084;Inherit;False;Property;_Noise_U_Offset;Noise_U_Offset;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-4040.424,-70.12916;Inherit;False;0;76;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;84;-3798.138,281.8711;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;201;-2797.991,1564.894;Inherit;False;3124.607;953.5806;Transition;24;113;112;114;117;115;116;119;118;120;121;122;95;71;97;103;104;98;99;105;100;198;102;109;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;85;-3638.138,-70.12916;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-2744.587,1973.532;Inherit;False;Property;_Transition_U_Panner;Transition_U_Panner;33;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;86;-3430.138,-70.12916;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2747.991,2072.654;Inherit;False;Property;_Transition_V_Panner;Transition_V_Panner;34;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-3021.474,915.0278;Inherit;False;Constant;_Main_V_Offset;Main_V_Offset;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-3029.983,608.7775;Inherit;False;Constant;_Main_U_Scale;Main_U_Scale;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;76;-3222.138,-86.12912;Inherit;True;Property;_Noise_Texture;Noise_Texture;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;115;-2742.994,2257.209;Inherit;False;Property;_Transition_V_Offset;Transition_V_Offset;32;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2809.355,405.7605;Inherit;False;Property;_Main_U_Panner;Main_U_Panner;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;139;-3433.496,716.7748;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-3014.465,806.3322;Inherit;False;Constant;_Main_U_Offset;Main_U_Offset;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-2744.863,2158.548;Inherit;False;Property;_Transition_U_Offset;Transition_U_Offset;31;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;114;-2479.334,1975.921;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-3036.992,717.473;Inherit;False;Constant;_Main_V_Scale;Main_V_Scale;26;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;116;-2720.379,1812.941;Inherit;False;0;121;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-2814.688,495.8312;Inherit;False;Property;_Main_V_Panner;Main_V_Panner;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2837.963,250.7367;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;119;-2317.858,1816.704;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;118;-2467.62,2163.661;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2821.466,112.1806;Inherit;False;Property;_Noise_Val;Noise_Val;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;142;-2811.892,916.4507;Inherit;False;Property;_Use_Custom;Use_Custom;4;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;165;-2825.892,608.0333;Inherit;False;Property;_Use_Custom;Use_Custom;38;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2596.917,413.7166;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;141;-2808.374,805.5881;Inherit;False;Property;_Use_Custom;Use_Custom;33;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;166;-2811.41,701.8959;Inherit;False;Property;_Use_Custom;Use_Custom;39;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;77;-2902.138,-86.12912;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;167;-2580.138,590.7225;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-2644.982,-91.43586;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2051.633,928.6484;Inherit;False;Property;_Dissolve_U_Panner;Dissolve_U_Panner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;39;-2435.44,254.4998;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-2053.434,1027.771;Inherit;False;Property;_Dissolve_V_Panner;Dissolve_V_Panner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-2564.62,788.2773;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;120;-2108.582,1816.443;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;121;-1881.557,1804.894;Inherit;True;Property;_Transition_Texture;Transition_Texture;27;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-2048.702,1115.268;Inherit;False;Property;_Dissolve_U_Scale;Dissolve_U_Scale;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2048.438,1212.326;Inherit;False;Property;_Dissolve_V_Scale;Dissolve_V_Scale;17;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;311;-2347.98,-116.0134;Inherit;False;Property;_Noise_OnDefalt_0;--------------------Noise_On--------------------[Defalt_0];7;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;43;-2226.165,254.2387;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-1786.89,563.6323;Inherit;False;0;60;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1844.101,927.8306;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1250.934,809.103;Inherit;False;Constant;_Dissolve_Val;Dissolve_Val;12;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1832.386,1115.571;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;68;-1466.758,558.0139;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;8;-1733.462,3157.628;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1825.762,336.2411;Inherit;False;Property;_Chromatic_Val;Chromatic_Val;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1359.097,1953.927;Inherit;False;Property;_Transition_Val;Transition_Val;29;0;Create;True;0;0;0;False;0;False;-1.2;-1.2;-1.2;1.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;122;-1557.193,1807.691;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1266.824,2228.427;Float;False;Property;_Transition_Line_Val;Transition_Line_Val;30;0;Create;True;0;0;0;False;0;False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-1915.77,66.29131;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;102;-977.0592,2136.969;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;198;-1096.043,1946.048;Inherit;False;Property;_Transition_OnDefalt_12;------------------Transition_On------------------[Defalt_-1.2];26;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-1494.315,35.77221;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;None;b59f107a25844c44d9c413e4c9cd9d86;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ScaleAndOffsetNode;61;-1257.484,557.7524;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-1493.962,235.8049;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-864.8889,948.9784;Inherit;False;Constant;_Defalt;Defalt;43;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;134;-951.0099,809.5034;Inherit;False;Property;_Use_Custom;Use_Custom;31;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;97;-748.3784,1798.354;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;200;-1410.206,2689.643;Inherit;False;2347.836;647.6489;Mask;18;310;36;32;35;33;34;31;47;54;52;53;55;154;155;48;50;49;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1495.034,-183.4805;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;60;-990.1608,526.7051;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;15;0;Create;True;0;0;0;False;0;False;-1;None;e3c4d74264986314bbb64f5d75f12488;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1199.79,244.6435;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;103;-745.8957,2128.907;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-661.8889,783.9784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;299;-486.0898,776.3301;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1160.801,2914.303;Inherit;False;Property;_Mask_U_Panner;Mask_U_Panner;24;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1196.285,32.59702;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1202.786,-157.6918;Inherit;True;Property;_DDD;DDD;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;104;-533.6391,2125.014;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;98;-533.2717,1799.215;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1162.603,3013.424;Inherit;False;Property;_Mask_V_Panner;Mask_V_Panner;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1359.471,3108.92;Inherit;False;Constant;_Mask_U_Offset;Mask_U_Offset;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1360.206,3214.396;Inherit;False;Constant;_Mask_V_Offset;Mask_V_Offset;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;256;-640.7105,522.22;Inherit;False;Property;_Dissolve_Texture_OnDefalt_0;--------------Dissolve_Texture_On--------------[Defalt_0];14;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-696.8906,45.45152;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;99;-349.6909,1801.426;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;-275.9126,524.716;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-1194.314,2750.506;Inherit;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-953.2682,2913.485;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;155;-1167.774,3102.194;Inherit;False;Property;_Use_Custom;Use_Custom;31;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;154;-1163.752,3213.994;Inherit;False;Property;_Use_Custom;Use_Custom;32;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;105;-351.6953,2124.296;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-461.1424,275.4984;Inherit;False;Property;_Main_Power;Main_Power;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;54;-791.7911,2754.269;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;100;-145.8642,1799.698;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-941.553,3101.222;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;72;-48.1546,529.9963;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;109;-156.228,1614.894;Inherit;False;Property;_Transition_Line_Color;Transition_Line_Color;28;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;25;-265.0859,43.00338;Inherit;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;47;-582.5162,2754.008;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;90.23436,1789.203;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;220.0012,38.04513;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;127;270.557,-438.2109;Inherit;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;162;437.3146,193.431;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;464.5326,-133.663;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;31;-359.0406,2744.897;Inherit;True;Property;_Mask_Texture;Mask_Texture;21;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-180.9832,2972.017;Inherit;False;Property;_Mask_Pow;Mask_Pow;23;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;193;-275.5604,268.7337;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;33;-25.34976,2747.215;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;321;130.9659,869.4431;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;696.2407,8.642155;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;62.76869,2970.255;Inherit;False;Property;_Mask_Ins;Mask_Ins;22;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;199;990.5644,2209.158;Inherit;False;985.397;158.6453;Depth Fade;4;312;58;56;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;228.7435,2743.59;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;192;337.2394,449.5336;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;173;-1908.738,638.8292;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;314;939.5806,7.351117;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;161;632.2106,2138.559;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;177;157.9148,872.6813;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;318;945.6405,259.5404;Inherit;False;Constant;_Float0;Float 0;47;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;175;-1180.497,445.8165;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;442.5193,2739.643;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;317;1119.963,242.6977;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1040.565,2276.752;Inherit;False;Property;_DepthFade_Val;DepthFade_Val;37;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;547.7858,810.1806;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;320;658.2434,2063.271;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;315;1269.366,244.7805;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;789.8563,811.0391;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;310;637.0334,2731.739;Inherit;False;Property;_MaskDefalt_On;===============Mask===============[Defalt_On];20;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;174;-921.5956,436.7321;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;56;1240.618,2259.158;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;58;1494.146,2260.873;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;1065.871,1057.753;Inherit;False;Property;_Opacity_Val;Opacity_Val;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1046.28,808.5834;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;197;908.8516,564.1664;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;316;1428.181,243.4615;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;1456.056,522.508;Inherit;False;Constant;_Main_Ins;Main_Ins;4;0;Create;True;0;0;0;False;0;False;1;1.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;172;1616.056,522.508;Inherit;False;Property;_Use_Custom;Use_Custom;29;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;312;1675.044,2248.846;Inherit;False;Property;_DefaltDefalt_On;===============Defalt===============[Defalt_On];35;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;1265.343,812.2728;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;319;1620.913,19.11587;Inherit;True;Property;_Toon_OnDefalt_Off;--------------Toon_On--------------[Defalt_Off];36;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;2054.06,816.8478;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;30;2011.52,363.5457;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;1935.023,24.19259;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;2771.243,-4.326726;Inherit;False;Property;_Cull_Mode;Cull_Mode;39;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.CullMode;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;2331.626,774.52;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;2183.919,20.01958;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2545.087,3.546903;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Total_Ap_Texture;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;38;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;78;0
WireConnection;80;1;79;0
WireConnection;84;0;83;0
WireConnection;84;1;82;0
WireConnection;85;0;81;0
WireConnection;85;2;80;0
WireConnection;86;0;85;0
WireConnection;86;2;84;0
WireConnection;76;1;86;0
WireConnection;114;0;112;0
WireConnection;114;1;113;0
WireConnection;119;0;116;0
WireConnection;119;2;114;0
WireConnection;118;0;117;0
WireConnection;118;1;115;0
WireConnection;142;1;45;0
WireConnection;142;0;139;4
WireConnection;165;1;163;0
WireConnection;165;0;139;1
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;141;1;44;0
WireConnection;141;0;139;3
WireConnection;166;1;164;0
WireConnection;166;0;139;2
WireConnection;77;0;76;0
WireConnection;167;0;165;0
WireConnection;167;1;166;0
WireConnection;87;0;77;0
WireConnection;87;1;88;0
WireConnection;39;0;2;0
WireConnection;39;2;42;0
WireConnection;46;0;141;0
WireConnection;46;1;142;0
WireConnection;120;0;119;0
WireConnection;120;2;118;0
WireConnection;121;1;120;0
WireConnection;311;0;87;0
WireConnection;43;0;39;0
WireConnection;43;1;167;0
WireConnection;43;2;46;0
WireConnection;67;0;62;0
WireConnection;67;1;63;0
WireConnection;66;0;64;0
WireConnection;66;1;65;0
WireConnection;68;0;69;0
WireConnection;68;2;67;0
WireConnection;122;0;121;0
WireConnection;89;0;311;0
WireConnection;89;1;43;0
WireConnection;102;0;122;0
WireConnection;102;1;95;0
WireConnection;198;1;71;0
WireConnection;61;0;68;0
WireConnection;61;1;66;0
WireConnection;17;0;89;0
WireConnection;17;1;14;0
WireConnection;134;1;111;0
WireConnection;134;0;8;4
WireConnection;97;0;122;0
WireConnection;97;1;198;0
WireConnection;16;0;89;0
WireConnection;16;1;14;0
WireConnection;60;1;61;0
WireConnection;7;0;5;0
WireConnection;7;1;17;0
WireConnection;103;0;102;0
WireConnection;103;1;198;0
WireConnection;308;0;134;0
WireConnection;308;1;309;0
WireConnection;299;0;308;0
WireConnection;6;0;5;0
WireConnection;6;1;89;0
WireConnection;1;0;5;0
WireConnection;1;1;16;0
WireConnection;104;0;103;0
WireConnection;98;0;97;0
WireConnection;256;1;7;1
WireConnection;256;0;60;0
WireConnection;20;0;1;1
WireConnection;20;1;6;2
WireConnection;20;2;7;3
WireConnection;99;0;98;0
WireConnection;110;0;256;0
WireConnection;110;1;299;0
WireConnection;53;0;48;0
WireConnection;53;1;49;0
WireConnection;155;1;50;0
WireConnection;155;0;8;2
WireConnection;154;1;51;0
WireConnection;154;0;8;3
WireConnection;105;0;104;0
WireConnection;54;0;55;0
WireConnection;54;2;53;0
WireConnection;100;0;105;0
WireConnection;100;1;99;0
WireConnection;52;0;155;0
WireConnection;52;1;154;0
WireConnection;72;0;110;0
WireConnection;25;0;20;0
WireConnection;25;1;27;0
WireConnection;47;0;54;0
WireConnection;47;2;52;0
WireConnection;108;0;109;0
WireConnection;108;1;100;0
WireConnection;73;0;25;0
WireConnection;73;1;72;0
WireConnection;162;0;73;0
WireConnection;162;1;108;0
WireConnection;128;0;127;0
WireConnection;128;1;73;0
WireConnection;31;1;47;0
WireConnection;193;0;20;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;321;0;72;0
WireConnection;158;0;128;0
WireConnection;158;1;162;0
WireConnection;32;0;33;0
WireConnection;32;1;35;0
WireConnection;192;0;193;0
WireConnection;173;0;8;1
WireConnection;314;0;158;0
WireConnection;161;0;105;0
WireConnection;177;0;321;0
WireConnection;175;0;173;0
WireConnection;36;0;32;0
WireConnection;317;0;314;0
WireConnection;317;1;318;0
WireConnection;176;0;192;0
WireConnection;176;1;177;0
WireConnection;320;0;161;0
WireConnection;315;0;317;0
WireConnection;160;0;176;0
WireConnection;160;1;320;0
WireConnection;310;1;36;0
WireConnection;310;0;36;0
WireConnection;174;0;175;0
WireConnection;56;0;57;0
WireConnection;58;0;56;0
WireConnection;37;0;160;0
WireConnection;37;1;310;0
WireConnection;197;0;174;0
WireConnection;316;0;315;0
WireConnection;172;1;28;0
WireConnection;172;0;197;0
WireConnection;312;1;58;0
WireConnection;312;0;58;0
WireConnection;180;0;37;0
WireConnection;180;1;181;0
WireConnection;319;1;314;0
WireConnection;319;0;316;0
WireConnection;59;0;180;0
WireConnection;59;1;312;0
WireConnection;24;0;319;0
WireConnection;24;1;172;0
WireConnection;178;0;30;4
WireConnection;178;1;59;0
WireConnection;29;0;24;0
WireConnection;29;1;30;0
WireConnection;0;2;29;0
WireConnection;0;9;178;0
ASEEND*/
//CHKSM=4EF3D4F921B4E4E794B8CF479F704A1415C523AB