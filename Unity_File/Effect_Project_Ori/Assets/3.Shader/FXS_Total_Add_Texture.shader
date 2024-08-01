// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Total_Add_Texture"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_U_Panner("Main_U_Panner", Float) = 0
		_Main_V_Panner("Main_V_Panner", Float) = 0
		_Main_Power("Main_Power", Float) = 1
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Val("Noise_Val", Float) = 0
		_Noise_U_Offset("Noise_U_Offset", Float) = 0
		_Noise_V_Offset("Noise_V_Offset", Float) = 0
		_Noise_U_Panner("Noise_U_Panner", Float) = 0
		_Noise_V_Panner("Noise_V_Panner", Float) = 0
		[Toggle(_DISSOLVE_TEXTURE_ONDEFALT_0_ON)] _Dissolve_Texture_OnDefalt_0("--------------Dissolve_Texture_On--------------[Defalt_0]", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_U_Offset("Dissolve_U_Offset", Float) = 0
		_Dissolve_V_Offset("Dissolve_V_Offset", Float) = 0
		_Dissolve_U_Panner("Dissolve_U_Panner", Float) = 0
		_Dissolve_V_Panner("Dissolve_V_Panner", Float) = 0
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Ins("Mask_Ins", Float) = 1
		_Mask_Pow("Mask_Pow", Float) = 1
		_Mask_U_Panner("Mask_U_Panner", Float) = 0
		_Mask_V_Panner("Mask_V_Panner", Float) = 0
		[Toggle(_TRANSITION_ONDEFALT_12_ON)] _Transition_OnDefalt_12("------------------Transition_On------------------[Defalt_-1.2]", Float) = 1
		_Transition_Texture("Transition_Texture", 2D) = "white" {}
		[HDR]_Transition_Line_Color("Transition_Line_Color", Color) = (1,1,1,0)
		_Transition_Val("Transition_Val", Range( -1.2 , 1.2)) = -1.2
		_Transition_Line_Val("Transition_Line_Val", Range( 0 , 0.1)) = 0.1
		_Transition_U_Offset("Transition_U_Offset", Float) = 1
		_Transition_V_Offset("Transition_V_Offset", Float) = 1
		_Transition_U_Panner("Transition_U_Panner", Float) = 0
		_Transition_V_Panner("Transition_V_Panner", Float) = 0
		_Chromatic_Val("Chromatic_Val", Float) = 0
		_DepthFade_Val("DepthFade_Val", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma shader_feature_local _DISSOLVE_TEXTURE_ONDEFALT_0_ON
		#pragma shader_feature_local _TRANSITION_ONDEFALT_12_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
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
		uniform float _Dissolve_U_Offset;
		uniform float _Dissolve_V_Offset;
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
				float staticSwitch141 = 1.0;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch142 = i.uv2_texcoord2.w;
			#else
				float staticSwitch142 = 1.0;
			#endif
			float2 appendResult46 = (float2(staticSwitch141 , staticSwitch142));
			float3 temp_output_89_0 = ( ( (tex2D( _Noise_Texture, (panner85*1.0 + appendResult84) )).rga * _Noise_Val ) + float3( (panner39*appendResult167 + appendResult46) ,  0.0 ) );
			float3 temp_cast_5 = (_Chromatic_Val).xxx;
			float4 tex2DNode7 = tex2D( _Main_Texture, ( temp_output_89_0 - temp_cast_5 ).xy );
			float4 appendResult20 = (float4(tex2D( _Main_Texture, ( temp_output_89_0 + _Chromatic_Val ).xy ).r , tex2D( _Main_Texture, temp_output_89_0.xy ).g , tex2DNode7.b , 0.0));
			float4 temp_cast_7 = (_Main_Power).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch172 = i.uv3_texcoord3.x;
			#else
				float staticSwitch172 = 1.0;
			#endif
			float4 temp_cast_8 = (tex2DNode7.r).xxxx;
			float2 appendResult67 = (float2(_Dissolve_U_Panner , _Dissolve_V_Panner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner68 = ( 1.0 * _Time.y * appendResult67 + uv_Dissolve_Texture);
			float2 appendResult66 = (float2(_Dissolve_U_Offset , _Dissolve_V_Offset));
			#ifdef _DISSOLVE_TEXTURE_ONDEFALT_0_ON
				float4 staticSwitch183 = tex2D( _Dissolve_Texture, (panner68*1.0 + appendResult66) );
			#else
				float4 staticSwitch183 = temp_cast_8;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch134 = i.uv3_texcoord3.w;
			#else
				float staticSwitch134 = 0.0;
			#endif
			float4 temp_output_73_0 = ( ( pow( appendResult20 , temp_cast_7 ) * staticSwitch172 ) * saturate( ( staticSwitch183 + ( 1.0 - ( staticSwitch134 * 2.0 ) ) ) ) );
			float2 appendResult114 = (float2(_Transition_U_Panner , _Transition_V_Panner));
			float2 uv_Transition_Texture = i.uv_texcoord * _Transition_Texture_ST.xy + _Transition_Texture_ST.zw;
			float2 panner119 = ( 1.0 * _Time.y * appendResult114 + uv_Transition_Texture);
			float2 appendResult118 = (float2(_Transition_U_Offset , _Transition_V_Offset));
			float4 temp_output_122_0 = saturate( tex2D( _Transition_Texture, (panner119*1.0 + appendResult118) ) );
			#ifdef _TRANSITION_ONDEFALT_12_ON
				float staticSwitch178 = _Transition_Val;
			#else
				float staticSwitch178 = 0.0;
			#endif
			float4 temp_cast_12 = (staticSwitch178).xxxx;
			float4 temp_output_105_0 = saturate( floor( ( ( temp_output_122_0 + _Transition_Line_Val ) - temp_cast_12 ) ) );
			float4 temp_cast_13 = (staticSwitch178).xxxx;
			o.Emission = ( ( ( _Main_Color * temp_output_73_0 ) * ( temp_output_73_0 + ( _Transition_Line_Color * ( temp_output_105_0 - saturate( floor( ( temp_output_122_0 - temp_cast_13 ) ) ) ) ) ) ) * i.vertexColor ).rgb;
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
			float4 temp_cast_17 = (_Mask_Pow).xxxx;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth56 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth56 = abs( ( screenDepth56 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade_Val ) );
			o.Alpha = ( ( ( i.vertexColor.a * temp_output_105_0 ) * saturate( ( pow( tex2D( _Mask_Texture, (panner54*1.0 + appendResult52) ) , temp_cast_17 ) * _Mask_Ins ) ) ) * saturate( distanceDepth56 ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
318;57;1376;798;4639.12;1557.939;5.778281;True;False
Node;AmplifyShaderEditor.RangedFloatNode;79;-3614.194,204.8994;Inherit;False;Property;_Noise_V_Panner;Noise_V_Panner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-3614.194,108.8993;Inherit;False;Property;_Noise_U_Panner;Noise_U_Panner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;179;-2707.014,1317.888;Inherit;False;3126.607;825.2346;Transition;27;112;113;116;114;115;117;119;118;120;121;95;122;102;169;178;168;103;97;104;98;99;105;109;100;108;71;161;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-3640.765,-45.3137;Inherit;False;0;76;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;83;-3614.194,300.8995;Inherit;False;Property;_Noise_U_Offset;Noise_U_Offset;7;0;Create;True;0;0;0;False;0;False;0;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-3614.194,396.8997;Inherit;False;Property;_Noise_V_Offset;Noise_V_Offset;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;80;-3398.479,114.6864;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2657.014,1825.647;Inherit;False;Property;_Transition_V_Panner;Transition_V_Panner;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-2653.61,1726.525;Inherit;False;Property;_Transition_U_Panner;Transition_U_Panner;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;84;-3398.479,306.6866;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;85;-3238.479,-45.3137;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-3021.474,915.0278;Inherit;False;Constant;_Main_V_Offset;Main_V_Offset;26;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;86;-3030.479,-45.3137;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;139;-3433.496,716.7748;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;-2809.355,405.7605;Inherit;False;Property;_Main_U_Panner;Main_U_Panner;2;0;Create;True;0;0;0;False;0;False;0;-1.97;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-3029.983,608.7775;Inherit;False;Constant;_Main_U_Scale;Main_U_Scale;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-3036.992,717.473;Inherit;False;Constant;_Main_V_Scale;Main_V_Scale;26;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3014.465,806.3322;Inherit;False;Constant;_Main_U_Offset;Main_U_Offset;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-2653.885,1911.541;Inherit;False;Property;_Transition_U_Offset;Transition_U_Offset;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-2652.017,2010.203;Inherit;False;Property;_Transition_V_Offset;Transition_V_Offset;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;114;-2388.357,1728.914;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2814.688,495.8312;Inherit;False;Property;_Main_V_Panner;Main_V_Panner;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;116;-2629.402,1565.934;Inherit;False;0;121;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;166;-2811.41,701.8959;Inherit;False;Property;_Use_Custom;Use_Custom;34;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;76;-2822.479,-61.31367;Inherit;True;Property;_Noise_Texture;Noise_Texture;5;0;Create;True;0;0;0;False;0;False;-1;None;31496c9491be4144c9dcfccb8903ffa0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2837.963,250.7367;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;141;-2808.374,805.5881;Inherit;False;Property;_Use_Custom;Use_Custom;34;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;165;-2825.892,608.0333;Inherit;False;Property;_Use_Custom;Use_Custom;34;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;142;-2811.892,916.4507;Inherit;False;Property;_Use_Custom;Use_Custom;2;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;119;-2226.881,1569.697;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;118;-2376.643,1916.654;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2596.917,413.7166;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;167;-2580.138,590.7225;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-2564.62,788.2773;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;120;-2017.605,1569.436;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;77;-2502.479,-61.31367;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1410.771,666.0565;Inherit;False;Property;_Dissolve_U_Panner;Dissolve_U_Panner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-1412.572,765.179;Inherit;False;Property;_Dissolve_V_Panner;Dissolve_V_Panner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;39;-2435.44,254.4998;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2421.807,136.996;Inherit;False;Property;_Noise_Val;Noise_Val;6;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;8;-1726.462,2214.625;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;169;-1179.941,1630.4;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1322.74,854.8577;Inherit;False;Property;_Dissolve_U_Offset;Dissolve_U_Offset;13;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;177;-988.3983,2181.075;Inherit;False;2050.725;662.6731;Mask;17;48;50;49;55;155;53;52;54;47;34;31;33;35;32;36;51;154;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1322.475,951.9154;Inherit;False;Property;_Dissolve_V_Offset;Dissolve_V_Offset;14;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-2245.323,-66.62041;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1203.239,665.2386;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;121;-1790.58,1557.887;Inherit;True;Property;_Transition_Texture;Transition_Texture;23;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-1444.284,502.2591;Inherit;False;0;60;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;43;-2226.165,254.2387;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-738.9943,2405.736;Inherit;False;Property;_Mask_U_Panner;Mask_U_Panner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;168;-383.4703,1470.126;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-937.6634,2600.354;Inherit;False;Constant;_Mask_U_Offset;Mask_U_Offset;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-740.7954,2504.858;Inherit;False;Property;_Mask_V_Panner;Mask_V_Panner;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-938.3983,2705.83;Inherit;False;Constant;_Mask_V_Offset;Mask_V_Offset;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;-1915.77,66.29131;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1493.628,239.8456;Inherit;False;Property;_Chromatic_Val;Chromatic_Val;31;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1106.424,855.1604;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1105.295,971.518;Inherit;False;Constant;_Dissolve_Val;Dissolve_Val;12;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1280.681,1731.967;Inherit;False;Property;_Transition_Val;Transition_Val;25;0;Create;True;0;0;0;False;0;False;-1.2;-1.2;-1.2;1.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;122;-1466.216,1560.684;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1258.926,1922.548;Float;False;Property;_Transition_Line_Val;Transition_Line_Val;26;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;68;-1041.763,506.0218;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;155;-745.9671,2593.628;Inherit;False;Property;_Use_Custom;Use_Custom;31;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-1200.451,25.41576;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;025001106dce0864f96ddd0fe480bf9d;2822ecb5059399a4e8fc6c602cd71c99;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1201.17,-193.8369;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-1200.098,225.4485;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-772.5073,2241.938;Inherit;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-531.4611,2404.918;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;178;-1015.201,1712.011;Inherit;False;Property;_Transition_OnDefalt_12;------------------Transition_On------------------[Defalt_-1.2];22;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-499.3416,1038.072;Inherit;False;Constant;_Defalt;Defalt;43;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;102;-886.0822,1889.962;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;173;-1506.332,489.0558;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;154;-741.9451,2705.428;Inherit;False;Property;_Use_Custom;Use_Custom;32;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;134;-804.7184,971.8077;Inherit;False;Property;_Use_Custom;Use_Custom;31;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;61;-832.4877,505.7606;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-339.049,927.8082;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-902.4204,22.24057;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;54;-369.9846,2245.701;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-908.9216,-168.0482;Inherit;True;Property;_DDD;DDD;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;175;-1180.497,445.8165;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;103;-654.9185,1881.9;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-519.7462,2592.656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-905.9255,234.287;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;60;-611.4638,494.213;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;12;0;Create;True;0;0;0;False;0;False;-1;None;2822ecb5059399a4e8fc6c602cd71c99;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;97;-657.4012,1551.347;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-461.1424,275.4984;Inherit;False;Property;_Main_Power;Main_Power;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-293.7899,273.6021;Inherit;False;Constant;_Main_Ins;Main_Ins;4;0;Create;True;0;0;0;False;0;False;1;1.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;98;-442.2945,1552.208;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;181;-98.03027,901.5756;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;183;-287.7603,484.2849;Inherit;False;Property;_Dissolve_Texture_OnDefalt_0;--------------Dissolve_Texture_On--------------[Defalt_0];11;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;47;-160.7097,2245.44;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-517.2267,46.69505;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;174;-921.5956,436.7321;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;104;-442.6619,1878.007;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;99;-258.7142,1554.419;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;34;240.8235,2463.45;Inherit;False;Property;_Mask_Pow;Mask_Pow;19;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;31;62.7661,2236.329;Inherit;True;Property;_Mask_Texture;Mask_Texture;17;0;Create;True;0;0;0;False;0;False;-1;073f1c809f6bd0845ae30549adc129c3;2c5200db151edf7488b19ac5fc3616ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;25;-265.0859,43.00338;Inherit;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;99.32814,488.4938;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;105;-260.7186,1877.289;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;172;-134.6357,275.2326;Inherit;False;Property;_Use_Custom;Use_Custom;29;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;72;324.172,486.1003;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;109;-63.25116,1367.888;Inherit;False;Property;_Transition_Line_Color;Transition_Line_Color;24;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;100;-54.88735,1552.691;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;484.5753,2461.688;Inherit;False;Property;_Mask_Ins;Mask_Ins;18;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;33;396.457,2238.647;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;176;559.439,2868.166;Inherit;False;675.201;183.3201;Depth Fade;3;57;56;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1.117934,41.52037;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;183.2112,1542.196;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;650.5506,2235.022;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;220.0012,38.04513;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;161;370.8058,1355.188;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;30;483.7238,699.072;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;57;609.439,2935.759;Inherit;False;Property;_DepthFade_Val;DepthFade_Val;32;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;127;270.557,-438.2109;Inherit;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;56;809.4915,2918.165;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;864.3263,2231.075;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;162;510.6022,199.8598;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;688.7161,800.105;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;464.5326,-133.663;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;58;1063.02,2919.88;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;814.5294,17.64238;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;945.14,797.6493;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1716.659,-5.653219;Inherit;False;Property;_Cull_Mode;Cull_Mode;33;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.CullMode;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;1107.363,66.41974;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;1228.369,804.6614;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1490.504,2.220407;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Total_Add_Texture;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;35;-1;-1;-1;0;False;0;0;True;38;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;78;0
WireConnection;80;1;79;0
WireConnection;84;0;83;0
WireConnection;84;1;82;0
WireConnection;85;0;81;0
WireConnection;85;2;80;0
WireConnection;86;0;85;0
WireConnection;86;2;84;0
WireConnection;114;0;112;0
WireConnection;114;1;113;0
WireConnection;166;1;164;0
WireConnection;166;0;139;2
WireConnection;76;1;86;0
WireConnection;141;1;44;0
WireConnection;141;0;139;3
WireConnection;165;1;163;0
WireConnection;165;0;139;1
WireConnection;142;1;45;0
WireConnection;142;0;139;4
WireConnection;119;0;116;0
WireConnection;119;2;114;0
WireConnection;118;0;117;0
WireConnection;118;1;115;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;167;0;165;0
WireConnection;167;1;166;0
WireConnection;46;0;141;0
WireConnection;46;1;142;0
WireConnection;120;0;119;0
WireConnection;120;2;118;0
WireConnection;77;0;76;0
WireConnection;39;0;2;0
WireConnection;39;2;42;0
WireConnection;169;0;8;4
WireConnection;87;0;77;0
WireConnection;87;1;88;0
WireConnection;67;0;62;0
WireConnection;67;1;63;0
WireConnection;121;1;120;0
WireConnection;43;0;39;0
WireConnection;43;1;167;0
WireConnection;43;2;46;0
WireConnection;168;0;169;0
WireConnection;89;0;87;0
WireConnection;89;1;43;0
WireConnection;66;0;64;0
WireConnection;66;1;65;0
WireConnection;122;0;121;0
WireConnection;68;0;69;0
WireConnection;68;2;67;0
WireConnection;155;1;50;0
WireConnection;155;0;8;2
WireConnection;16;0;89;0
WireConnection;16;1;14;0
WireConnection;17;0;89;0
WireConnection;17;1;14;0
WireConnection;53;0;48;0
WireConnection;53;1;49;0
WireConnection;178;0;71;0
WireConnection;102;0;122;0
WireConnection;102;1;95;0
WireConnection;173;0;8;1
WireConnection;154;1;51;0
WireConnection;154;0;8;3
WireConnection;134;1;111;0
WireConnection;134;0;168;0
WireConnection;61;0;68;0
WireConnection;61;2;66;0
WireConnection;180;0;134;0
WireConnection;180;1;182;0
WireConnection;6;0;5;0
WireConnection;6;1;89;0
WireConnection;54;0;55;0
WireConnection;54;2;53;0
WireConnection;1;0;5;0
WireConnection;1;1;16;0
WireConnection;175;0;173;0
WireConnection;103;0;102;0
WireConnection;103;1;178;0
WireConnection;52;0;155;0
WireConnection;52;1;154;0
WireConnection;7;0;5;0
WireConnection;7;1;17;0
WireConnection;60;1;61;0
WireConnection;97;0;122;0
WireConnection;97;1;178;0
WireConnection;98;0;97;0
WireConnection;181;0;180;0
WireConnection;183;1;7;1
WireConnection;183;0;60;0
WireConnection;47;0;54;0
WireConnection;47;2;52;0
WireConnection;20;0;1;1
WireConnection;20;1;6;2
WireConnection;20;2;7;3
WireConnection;174;0;175;0
WireConnection;104;0;103;0
WireConnection;99;0;98;0
WireConnection;31;1;47;0
WireConnection;25;0;20;0
WireConnection;25;1;27;0
WireConnection;110;0;183;0
WireConnection;110;1;181;0
WireConnection;105;0;104;0
WireConnection;172;1;28;0
WireConnection;172;0;174;0
WireConnection;72;0;110;0
WireConnection;100;0;105;0
WireConnection;100;1;99;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;24;0;25;0
WireConnection;24;1;172;0
WireConnection;108;0;109;0
WireConnection;108;1;100;0
WireConnection;32;0;33;0
WireConnection;32;1;35;0
WireConnection;73;0;24;0
WireConnection;73;1;72;0
WireConnection;161;0;105;0
WireConnection;56;0;57;0
WireConnection;36;0;32;0
WireConnection;162;0;73;0
WireConnection;162;1;108;0
WireConnection;160;0;30;4
WireConnection;160;1;161;0
WireConnection;128;0;127;0
WireConnection;128;1;73;0
WireConnection;58;0;56;0
WireConnection;158;0;128;0
WireConnection;158;1;162;0
WireConnection;37;0;160;0
WireConnection;37;1;36;0
WireConnection;29;0;158;0
WireConnection;29;1;30;0
WireConnection;59;0;37;0
WireConnection;59;1;58;0
WireConnection;0;2;29;0
WireConnection;0;9;59;0
ASEEND*/
//CHKSM=8B95E552325D0E14F52E09714F35941C1DC0B186