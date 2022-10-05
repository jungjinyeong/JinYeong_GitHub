// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Shiled"
{
	Properties
	{
		_MainTexture("MainTexture", 2D) = "white" {}
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 0
		_Main_Ins("Main_Ins", Range( 1 , 10)) = 1
		[HDR]_Tint_Color("Tint_Color", Color) = (0.9811321,0.03239589,0.03239589,0)
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_SubTex_Pow("SubTex_Pow", Range( 1 , 10)) = 0
		_SubTex_Ins("SubTex_Ins", Range( 0 , 10)) = 0
		_SubTex_UPanner("SubTex_UPanner", Float) = 0
		_SubTex_VPanner("SubTex_VPanner", Float) = 0
		[HDR]_SubTex_Color("SubTex_Color", Color) = (0,0,0,0)
		_Main_Noise_Str("Main_Noise_Str", Range( 0 , 1)) = 0
		_Main_Noise_UTiling("Main_Noise_UTiling", Float) = 0
		_Main_Noise_VTiling("Main_Noise_VTiling", Float) = 0
		_Main_Noise_VPanner("Main_Noise_VPanner", Float) = 0
		_Offset("Offset", Range( -1 , 1)) = -0.2705882
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thinkness("Edge_Thinkness", Range( 0 , 1)) = 0.1182353
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 1)) = 0
		_Noise_Tex_UPanner("Noise_Tex_UPanner", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Chromatic_Val("Chromatic_Val", Range( 0 , 0.1)) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float _Cull_Mode;
		uniform sampler2D _Sub_Texture;
		uniform float _SubTex_UPanner;
		uniform float _SubTex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _SubTex_Pow;
		uniform float _SubTex_Ins;
		uniform float4 _SubTex_Color;
		uniform float4 _Tint_Color;
		uniform sampler2D _MainTexture;
		uniform float _Main_VPanner;
		uniform float _Main_UPanner;
		uniform float4 _MainTexture_ST;
		uniform sampler2D _Normal_Tex;
		uniform float _Main_Noise_VPanner;
		uniform float4 _Normal_Tex_ST;
		uniform float _Main_Noise_UTiling;
		uniform float _Main_Noise_VTiling;
		uniform float _Main_Noise_Str;
		uniform float _Chromatic_Val;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float _Edge_Thinkness;
		uniform float _Noise_Tex_UPanner;
		uniform float _Noise_Tex_VPanner;
		uniform float _Noise_Str;
		uniform float _Offset;
		uniform float4 _Edge_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult44 = (float2(_SubTex_UPanner , _SubTex_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner46 = ( 1.0 * _Time.y * appendResult44 + uv0_Sub_Texture);
			float2 appendResult30 = (float2(_Main_VPanner , _Main_UPanner));
			float2 uv0_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float2 appendResult4 = (float2(0.0 , _Main_Noise_VPanner));
			float2 uv0_Normal_Tex = i.uv_texcoord * _Normal_Tex_ST.xy + _Normal_Tex_ST.zw;
			float2 panner9 = ( 1.0 * _Time.y * appendResult4 + uv0_Normal_Tex);
			float2 appendResult8 = (float2(_Main_Noise_UTiling , _Main_Noise_VTiling));
			float2 panner36 = ( 1.0 * _Time.y * appendResult30 + ( float3( uv0_MainTexture ,  0.0 ) + ( (UnpackNormal( tex2D( _Normal_Tex, (panner9*appendResult8 + 0.0) ) )).xyz * _Main_Noise_Str ) ).xy);
			float2 temp_cast_2 = (_Chromatic_Val).xx;
			float3 appendResult50 = (float3(tex2D( _MainTexture, ( panner36 + _Chromatic_Val ) ).r , tex2D( _MainTexture, panner36 ).g , tex2D( _MainTexture, ( panner36 - temp_cast_2 ) ).b));
			float3 temp_cast_3 = (_Main_Pow).xxx;
			float2 appendResult15 = (float2(_Noise_Tex_UPanner , _Noise_Tex_VPanner));
			float2 panner16 = ( 1.0 * _Time.y * appendResult15 + uv0_Normal_Tex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch40 = i.uv_tex4coord.z;
			#else
				float staticSwitch40 = _Offset;
			#endif
			float temp_output_56_0 = saturate( ( ( ( (UnpackNormal( tex2D( _Normal_Tex, panner16 ) )).xy * _Noise_Str ) + i.uv_texcoord ).y + staticSwitch40 ) );
			float temp_output_61_0 = step( _Edge_Thinkness , temp_output_56_0 );
			o.Emission = ( i.vertexColor * ( ( ( ( pow( tex2D( _Sub_Texture, panner46 ).r , _SubTex_Pow ) * _SubTex_Ins ) * _SubTex_Color ) + ( _Tint_Color * float4( ( pow( appendResult50 , temp_cast_3 ) * _Main_Ins ) , 0.0 ) ) ) + ( saturate( ( temp_output_61_0 - step( 0.15 , temp_output_56_0 ) ) ) * _Edge_Color ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_61_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
8;81;1241;673;4028.616;1934.658;3.594192;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2;-4797.672,-22.49306;Float;False;Property;_Main_Noise_VPanner;Main_Noise_VPanner;15;0;Create;True;0;0;False;0;0;1.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-4779.672,-107.4931;Float;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-4523.672,-70.49306;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-4324.339,-137.8261;Float;False;Property;_Main_Noise_UTiling;Main_Noise_UTiling;13;0;Create;True;0;0;False;0;0;2.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-4321.339,-61.82613;Float;False;Property;_Main_Noise_VTiling;Main_Noise_VTiling;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-4472.401,-447.837;Float;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-4837.193,483.9361;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-4293.339,-334.8264;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-4839.792,397.4361;Float;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;21;0;Create;True;0;0;False;0;0;0.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-4068.34,-100.8261;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-4889.792,163.4361;Float;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-4109,-267.2373;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-4565.092,319.336;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-4795.813,-364.621;Float;True;Property;_Normal_Tex;Normal_Tex;19;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;16;-4495.091,162.4362;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-3914.515,-349.9212;Float;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-4215.85,37.53806;Float;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;77;-3677.115,-174.0211;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-3810.066,-39.47402;Float;False;Property;_Main_Noise_Str;Main_Noise_Str;12;0;Create;True;0;0;False;0;0;0.14;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-3441.066,-136.474;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;23;-3861.043,126.5701;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3320.066,305.5259;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-3326.066,220.526;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-3899.65,313.838;Float;False;Property;_Noise_Str;Noise_Str;20;0;Create;True;0;0;False;0;0;0.102;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3559.066,-330.474;Float;False;0;38;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;30;-3103.066,255.526;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-3626.242,220.6702;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-3229.066,-304.4739;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;-3387.363,983.3961;Float;False;320;275;W : Offset T : Empty;1;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-3476.392,512.8072;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;31;-3337.363,1033.396;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-3202.941,501.4701;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2981.981,324.4439;Float;False;Property;_Chromatic_Val;Chromatic_Val;24;0;Create;True;0;0;False;0;0;0.0062;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-3322.501,841.2751;Float;False;Property;_Offset;Offset;16;0;Create;True;0;0;False;0;-0.2705882;-0.46;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;36;-3002.066,76.52595;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2797.46,-395.6091;Float;False;Property;_SubTex_VPanner;SubTex_VPanner;10;0;Create;True;0;0;False;0;0;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2799.46,-469.6093;Float;False;Property;_SubTex_UPanner;SubTex_UPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-2728.981,40.44394;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-2817.46,-678.6094;Float;False;0;53;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;44;-2586.46,-445.6091;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;40;-2981.863,948.0959;Float;True;Property;_Use_Custom;Use_Custom;23;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;42;-2634.981,329.4439;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;38;-2813.534,-200.5448;Float;True;Property;_MainTexture;MainTexture;0;0;Create;True;0;0;False;0;None;a6838ad1f58538f4589587594b750c3d;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.BreakToComponentsNode;41;-3000.041,503.9701;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.PannerNode;46;-2495.46,-663.6094;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-2754.401,497.8751;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-2410.981,-203.556;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-2418.981,216.444;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;49;-2416.066,-1.474014;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;-2084.411,355.2185;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;0;3.25;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;50;-2014.981,23.44394;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2551.401,754.8751;Float;False;Property;_Edge_Thinkness;Edge_Thinkness;18;0;Create;True;0;0;False;0;0.1182353;0.142;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;56;-2542.401,497.8751;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;-2211.656,-564.1214;Float;True;Property;_Sub_Texture;Sub_Texture;6;0;Create;True;0;0;False;0;None;02898dfb4fcd1e249b2c981ed0c5c828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-2180.46,-305.6091;Float;False;Property;_SubTex_Pow;SubTex_Pow;7;0;Create;True;0;0;False;0;0;2.49;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2411.936,941.5083;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1827.46,-289.6092;Float;False;Property;_SubTex_Ins;SubTex_Ins;8;0;Create;True;0;0;False;0;0;0.93;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;61;-2070.798,640.382;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;57;-2062.454,860.3124;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;60;-1743.62,209.9865;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1792.643,450.9865;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;5.14;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;-1892.46,-575.6094;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;66;-1545.764,-97.55946;Float;False;Property;_Tint_Color;Tint_Color;3;1;[HDR];Create;True;0;0;False;0;0.9811321,0.03239589,0.03239589,0;1.39772,1.236726,0.6293399,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;62;-1472.547,-303.29;Float;False;Property;_SubTex_Color;SubTex_Color;11;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.369606,1.921573,1.397174,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-1554.46,-574.6094;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1492.62,190.9865;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;-1789.591,682.35;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1267.147,-585.3893;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-1342.775,-44.00612;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;70;-1502.05,725.138;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-1756.05,885.138;Float;False;Property;_Edge_Color;Edge_Color;17;1;[HDR];Create;True;0;0;False;0;1,1,1,0;3.396226,1.396656,0.5286579,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-1218.05,782.138;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-1061.647,-274.69;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-766.3499,-33.46193;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;76;-183.9485,-187.1389;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;83;-1429.136,-1059.552;Float;False;0;82;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-387.5374,330.4778;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;79;-189.2655,-1088.233;Float;False;Global;_GrabScreen0;Grab Screen 0;27;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;26.31346,-4.161426;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-484.4759,-1090.214;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GrabScreenPosition;80;-749.9488,-1145.686;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;90;-1012.29,-770.3046;Float;False;Constant;_Float0;Float 0;29;0;Create;True;0;0;False;0;3.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;84;-1095.711,-1038.888;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1;863.741,-5.976642;Float;False;Property;_Cull_Mode;Cull_Mode;25;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;85;-1372.167,-842.7538;Float;False;Property;_Vector0;Vector 0;28;0;Create;True;0;0;False;0;0,0;1,-0.15;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;82;-830.9406,-952.2874;Float;True;Property;_TextureSample3;Texture Sample 3;26;0;Create;True;0;0;False;0;None;291b26790b4e30e43b6347b381849af8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;644.2672,-9.967793;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Shiled;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;27;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;9;0;7;0
WireConnection;9;2;4;0
WireConnection;8;0;5;0
WireConnection;8;1;6;0
WireConnection;14;0;9;0
WireConnection;14;1;8;0
WireConnection;15;0;10;0
WireConnection;15;1;11;0
WireConnection;16;0;12;0
WireConnection;16;2;15;0
WireConnection;17;0;13;0
WireConnection;17;1;14;0
WireConnection;19;0;13;0
WireConnection;19;1;16;0
WireConnection;77;0;17;0
WireConnection;21;0;77;0
WireConnection;21;1;18;0
WireConnection;23;0;19;0
WireConnection;30;0;24;0
WireConnection;30;1;22;0
WireConnection;29;0;23;0
WireConnection;29;1;25;0
WireConnection;26;0;20;0
WireConnection;26;1;21;0
WireConnection;32;0;29;0
WireConnection;32;1;28;0
WireConnection;36;0;26;0
WireConnection;36;2;30;0
WireConnection;39;0;36;0
WireConnection;39;1;35;0
WireConnection;44;0;37;0
WireConnection;44;1;33;0
WireConnection;40;1;34;0
WireConnection;40;0;31;3
WireConnection;42;0;36;0
WireConnection;42;1;35;0
WireConnection;41;0;32;0
WireConnection;46;0;43;0
WireConnection;46;2;44;0
WireConnection;48;0;41;1
WireConnection;48;1;40;0
WireConnection;45;0;38;0
WireConnection;45;1;39;0
WireConnection;47;0;38;0
WireConnection;47;1;42;0
WireConnection;49;0;38;0
WireConnection;49;1;36;0
WireConnection;50;0;45;1
WireConnection;50;1;49;2
WireConnection;50;2;47;3
WireConnection;56;0;48;0
WireConnection;53;1;46;0
WireConnection;61;0;54;0
WireConnection;61;1;56;0
WireConnection;57;0;52;0
WireConnection;57;1;56;0
WireConnection;60;0;50;0
WireConnection;60;1;51;0
WireConnection;59;0;53;1
WireConnection;59;1;55;0
WireConnection;64;0;59;0
WireConnection;64;1;58;0
WireConnection;65;0;60;0
WireConnection;65;1;78;0
WireConnection;63;0;61;0
WireConnection;63;1;57;0
WireConnection;69;0;64;0
WireConnection;69;1;62;0
WireConnection;67;0;66;0
WireConnection;67;1;65;0
WireConnection;70;0;63;0
WireConnection;72;0;70;0
WireConnection;72;1;68;0
WireConnection;71;0;69;0
WireConnection;71;1;67;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;75;0;76;4
WireConnection;75;1;61;0
WireConnection;79;0;81;0
WireConnection;74;0;76;0
WireConnection;74;1;73;0
WireConnection;81;0;80;0
WireConnection;81;1;82;0
WireConnection;84;0;83;0
WireConnection;84;2;85;0
WireConnection;82;1;84;0
WireConnection;82;5;90;0
WireConnection;0;2;74;0
WireConnection;0;9;75;0
ASEEND*/
//CHKSM=3A01B52B248742FC91F40C35B6566C8782E87BEE