// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additve_Shiled"
{
	Properties
	{
		_MainTexture("MainTexture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (0.9811321,0.03239589,0.03239589,0)
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 0
		_Main_Ins("Main_Ins", Range( 1 , 10)) = 0
		_Chromatic_Val("Chromatic_Val", Range( 0 , 0.1)) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Offset("Offset", Range( -1 , 1)) = -0.2705882
		_Main_Noise_Str("Main_Noise_Str", Range( 0 , 1)) = 0
		_Main_Noise_UTiling("Main_Noise_UTiling", Float) = 0
		_Main_Noise_VTiling("Main_Noise_VTiling", Float) = 0
		_Main_Noise_VPanner("Main_Noise_VPanner", Float) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thinkness("Edge_Thinkness", Range( 0 , 1)) = 0.1182353
		_Noise_Str("Noise_Str", Range( 0 , 1)) = 0
		_Noise_Tex_UPanner("Noise_Tex_UPanner", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_SubTex_Color("SubTex_Color", Color) = (0,0,0,0)
		_SubTex_Ins("SubTex_Ins", Range( 0 , 10)) = 0
		_SubTex_Pow("SubTex_Pow", Range( 1 , 10)) = 0
		_SubTex_UPanner("SubTex_UPanner", Float) = 0
		_SubTex_VPanner("SubTex_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
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
		uniform float _Main_Noise_UTiling;
		uniform float _Main_Noise_VTiling;
		uniform float _Main_Noise_Str;
		uniform float _Chromatic_Val;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float _Edge_Thinkness;
		uniform float _Noise_Tex_UPanner;
		uniform float _Noise_Tex_VPanner;
		uniform float4 _Normal_Tex_ST;
		uniform float _Noise_Str;
		uniform float _Offset;
		uniform float4 _Edge_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult63 = (float2(_SubTex_UPanner , _SubTex_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner60 = ( 1.0 * _Time.y * appendResult63 + uv0_Sub_Texture);
			float2 appendResult36 = (float2(_Main_VPanner , _Main_UPanner));
			float2 uv0_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float2 appendResult82 = (float2(0.0 , _Main_Noise_VPanner));
			float2 panner80 = ( 1.0 * _Time.y * appendResult82 + i.uv_texcoord);
			float2 appendResult79 = (float2(_Main_Noise_UTiling , _Main_Noise_VTiling));
			float2 panner31 = ( 1.0 * _Time.y * appendResult36 + ( float3( uv0_MainTexture ,  0.0 ) + ( (UnpackNormal( tex2D( _Normal_Tex, (panner80*appendResult79 + 0.0) ) )).xyz * _Main_Noise_Str ) ).xy);
			float2 temp_cast_2 = (_Chromatic_Val).xx;
			float3 appendResult53 = (float3(tex2D( _MainTexture, ( panner31 + _Chromatic_Val ) ).r , tex2D( _MainTexture, panner31 ).g , tex2D( _MainTexture, ( panner31 - temp_cast_2 ) ).b));
			float3 temp_cast_3 = (_Main_Pow).xxx;
			float2 appendResult28 = (float2(_Noise_Tex_UPanner , _Noise_Tex_VPanner));
			float2 uv0_Normal_Tex = i.uv_texcoord * _Normal_Tex_ST.xy + _Normal_Tex_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult28 + uv0_Normal_Tex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch69 = i.uv_tex4coord.z;
			#else
				float staticSwitch69 = _Offset;
			#endif
			float temp_output_6_0 = saturate( ( ( ( (UnpackNormal( tex2D( _Normal_Tex, panner23 ) )).xy * _Noise_Str ) + i.uv_texcoord ).y + staticSwitch69 ) );
			float temp_output_7_0 = step( _Edge_Thinkness , temp_output_6_0 );
			o.Emission = ( i.vertexColor * ( ( ( ( pow( tex2D( _Sub_Texture, panner60 ).r , _SubTex_Pow ) * _SubTex_Ins ) * _SubTex_Color ) + ( _Tint_Color * float4( ( pow( appendResult53 , temp_cast_3 ) * _Main_Ins ) , 0.0 ) ) ) + ( saturate( ( temp_output_7_0 - step( 0.15 , temp_output_6_0 ) ) ) * _Edge_Color ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_7_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;1802.032;1767.482;2.913461;True;False
Node;AmplifyShaderEditor.RangedFloatNode;81;-3093.009,-567.4337;Float;False;Property;_Main_Noise_VPanner;Main_Noise_VPanner;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-3075.009,-652.4337;Float;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;82;-2819.009,-615.4337;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2619.676,-682.7668;Float;False;Property;_Main_Noise_UTiling;Main_Noise_UTiling;10;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-2616.676,-606.7668;Float;False;Property;_Main_Noise_VTiling;Main_Noise_VTiling;11;0;Create;True;0;0;False;0;0;0.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;75;-2767.738,-992.7777;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;79;-2363.676,-645.7668;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;80;-2588.676,-879.767;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-3135.129,-147.5046;Float;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3132.53,-61.00458;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;17;0;Create;True;0;0;False;0;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-3185.129,-381.5046;Float;False;0;72;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;72;-3091.15,-909.5616;Float;True;Property;_Normal_Tex;Normal_Tex;25;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;76;-2404.337,-812.1779;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2860.429,-225.6046;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-2790.428,-382.5045;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;73;-2209.851,-894.8618;Float;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;74;-1972.451,-718.9618;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2105.402,-584.4147;Float;False;Property;_Main_Noise_Str;Main_Noise_Str;9;0;Create;True;0;0;False;0;0;0.18;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-2511.186,-507.4026;Float;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-1854.402,-875.4147;Float;False;0;47;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1736.402,-681.4147;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1615.402,-239.4147;Float;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;17;-2156.379,-418.3706;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1621.402,-324.4147;Float;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2194.986,-231.1026;Float;False;Property;_Noise_Str;Noise_Str;15;0;Create;True;0;0;False;0;0;0.183;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-1524.402,-849.4147;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;71;-1682.699,438.4554;Float;False;320;275;W : Offset T : Empty;1;70;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1771.728,-32.13339;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1921.578,-324.2705;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-1398.402,-289.4147;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;70;-1632.699,488.4554;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1498.277,-43.47048;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1092.796,-940.5498;Float;False;Property;_SubTex_VPanner;SubTex_VPanner;23;0;Create;True;0;0;False;0;0;0.21;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1617.837,296.3345;Float;False;Property;_Offset;Offset;8;0;Create;True;0;0;False;0;-0.2705882;-0.029;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1277.317,-220.4967;Float;False;Property;_Chromatic_Val;Chromatic_Val;5;0;Create;True;0;0;False;0;0;0.0027;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;31;-1297.402,-468.4147;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1094.796,-1014.55;Float;False;Property;_SubTex_UPanner;SubTex_UPanner;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;47;-1108.87,-745.4855;Float;True;Property;_MainTexture;MainTexture;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-1024.317,-504.4967;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;69;-1277.199,403.1554;Float;True;Property;_Use_Custom;Use_Custom;24;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;22;-1295.377,-40.9705;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;51;-930.317,-215.4967;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-1112.796,-1223.55;Float;False;0;54;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;63;-881.7961,-990.5498;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;48;-706.317,-748.4967;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;60;-790.7961,-1208.55;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;49;-714.317,-328.4967;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-1049.737,-47.06549;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-711.4022,-546.4147;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-310.317,-521.4967;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-379.7468,-189.7221;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;0;1.26;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-707.2717,396.5678;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;54;-506.9926,-1109.062;Float;True;Property;_Sub_Texture;Sub_Texture;18;0;Create;True;0;0;False;0;None;68e5980af78d21e4f8e879df5d2164b5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-846.7369,209.9345;Float;False;Property;_Edge_Thinkness;Edge_Thinkness;14;0;Create;True;0;0;False;0;0.1182353;0.141;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-475.7961,-850.5498;Float;False;Property;_SubTex_Pow;SubTex_Pow;21;0;Create;True;0;0;False;0;0;1.83;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;-837.7369,-47.06549;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-357.7906,315.3719;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-122.7961,-834.5498;Float;False;Property;_SubTex_Ins;SubTex_Ins;20;0;Create;True;0;0;False;0;0;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;55;-187.7961,-1120.55;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;-38.95581,-334.9542;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;7;-366.1342,95.44139;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-73.95581,-93.95416;Float;False;Property;_Main_Ins;Main_Ins;4;0;Create;True;0;0;False;0;0;2.46;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;66;232.1164,-848.2307;Float;False;Property;_SubTex_Color;SubTex_Color;19;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.773585,0.9226214,0.8114988,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-84.92767,137.4094;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;150.2039,-1119.55;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;212.0442,-353.9542;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1;158.9,-642.5001;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;0.9811321,0.03239589,0.03239589,0;0.745283,0.4965527,0.2495995,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;361.8888,-588.9468;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-51.38611,340.1974;Float;False;Property;_Edge_Color;Edge_Color;13;1;[HDR];Create;True;0;0;False;0;1,1,1,0;3.195432,2.143944,0.9285873,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;437.5163,-1130.33;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;13;202.6139,180.1974;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;643.0164,-819.6306;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;486.6139,237.1974;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;938.3138,-578.4026;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;44;1397.044,-669.7542;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1442.944,-518.1542;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;1008.025,-206.9237;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1616.1,-383.9;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additve_Shiled;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;82;0;83;0
WireConnection;82;1;81;0
WireConnection;79;0;77;0
WireConnection;79;1;78;0
WireConnection;80;0;75;0
WireConnection;80;2;82;0
WireConnection;76;0;80;0
WireConnection;76;1;79;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;23;0;24;0
WireConnection;23;2;28;0
WireConnection;73;0;72;0
WireConnection;73;1;76;0
WireConnection;74;0;73;0
WireConnection;16;0;72;0
WireConnection;16;1;23;0
WireConnection;38;0;74;0
WireConnection;38;1;39;0
WireConnection;17;0;16;0
WireConnection;37;0;32;0
WireConnection;37;1;38;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;21;0;18;0
WireConnection;21;1;3;0
WireConnection;31;0;37;0
WireConnection;31;2;36;0
WireConnection;50;0;31;0
WireConnection;50;1;52;0
WireConnection;69;1;5;0
WireConnection;69;0;70;3
WireConnection;22;0;21;0
WireConnection;51;0;31;0
WireConnection;51;1;52;0
WireConnection;63;0;61;0
WireConnection;63;1;62;0
WireConnection;48;0;47;0
WireConnection;48;1;50;0
WireConnection;60;0;59;0
WireConnection;60;2;63;0
WireConnection;49;0;47;0
WireConnection;49;1;51;0
WireConnection;4;0;22;1
WireConnection;4;1;69;0
WireConnection;29;0;47;0
WireConnection;29;1;31;0
WireConnection;53;0;48;1
WireConnection;53;1;29;2
WireConnection;53;2;49;3
WireConnection;54;1;60;0
WireConnection;6;0;4;0
WireConnection;9;0;10;0
WireConnection;9;1;6;0
WireConnection;55;0;54;1
WireConnection;55;1;57;0
WireConnection;40;0;53;0
WireConnection;40;1;42;0
WireConnection;7;0;8;0
WireConnection;7;1;6;0
WireConnection;11;0;7;0
WireConnection;11;1;9;0
WireConnection;56;0;55;0
WireConnection;56;1;58;0
WireConnection;41;0;40;0
WireConnection;41;1;43;0
WireConnection;30;0;1;0
WireConnection;30;1;41;0
WireConnection;64;0;56;0
WireConnection;64;1;66;0
WireConnection;13;0;11;0
WireConnection;68;0;64;0
WireConnection;68;1;30;0
WireConnection;12;0;13;0
WireConnection;12;1;14;0
WireConnection;15;0;68;0
WireConnection;15;1;12;0
WireConnection;45;0;44;0
WireConnection;45;1;15;0
WireConnection;46;0;44;4
WireConnection;46;1;7;0
WireConnection;0;2;45;0
WireConnection;0;9;46;0
ASEEND*/
//CHKSM=39490AD2F37C6D577B0CF46A004E64BD99F3C1FF