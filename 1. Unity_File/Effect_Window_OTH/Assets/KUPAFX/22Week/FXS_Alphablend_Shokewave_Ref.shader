// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Shokewave_Ref"
{
	Properties
	{
		_Main_Texure("Main_Texure", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 0
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0.5
		_Mian_UVPow("Mian_UVPow", Range( -10 , 10)) = 1.84
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Range("Mask_Range", Range( 1 , 20)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Chromatic("Chromatic", Range( 0 , 0.05)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 screenPos;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
		};

		uniform float _CullMode;
		uniform sampler2D _GrabTexture;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texure;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texure_ST;
		uniform float _Mian_UVPow;
		uniform float _Chromatic;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Range;
		uniform float _Opacity;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult49 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner45 = ( 1.0 * _Time.y * appendResult49 + uv0_Noise_Texture);
			float2 temp_output_43_0 = ( (UnpackNormal( tex2D( _Noise_Texture, panner45 ) )).xy * _Noise_Val );
			float4 screenColor85 = tex2D( _GrabTexture, ( ase_grabScreenPosNorm + float4( temp_output_43_0, 0.0 , 0.0 ) ).xy );
			float2 appendResult6 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_Main_Texure = i.uv_texcoord * _Main_Texure_ST.xy + _Main_Texure_ST.zw;
			float2 appendResult63 = (float2(uv0_Main_Texure.x , pow( uv0_Main_Texure.y , _Mian_UVPow )));
			float2 panner3 = ( 1.0 * _Time.y * appendResult6 + ( temp_output_43_0 + appendResult63 ));
			float4 tex2DNode1 = tex2D( _Main_Texure, panner3 );
			float2 temp_cast_2 = (_Chromatic).xx;
			float4 appendResult81 = (float4(tex2D( _Main_Texure, ( panner3 + _Chromatic ) ).r , tex2DNode1.g , tex2D( _Main_Texure, ( panner3 - temp_cast_2 ) ).b , 0.0));
			float4 temp_cast_3 = (_Main_Pow).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch71 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch71 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( screenColor85 + ( _Main_Color * ( pow( appendResult81 , temp_cast_3 ) * staticSwitch71 ) ) ) ).rgb;
			float2 appendResult59 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner56 = ( 1.0 * _Time.y * appendResult59 + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch72 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch72 = _Dissolve;
			#endif
			float2 uv0_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			o.Alpha = saturate( ( ( i.vertexColor.a * ( ( tex2DNode1.r * saturate( ( tex2D( _Dissolve_Texture, panner56 ).r + staticSwitch72 ) ) ) * saturate( pow( tex2D( _Mask_Texture, uv0_Mask_Texture ).r , _Mask_Range ) ) ) ) * _Opacity ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;1565.505;410.0736;1.685502;True;False
Node;AmplifyShaderEditor.CommentaryNode;69;-3431.414,-834.3706;Float;False;1369;444.9999;Noise;9;48;47;49;46;45;41;42;44;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-3381.414,-621.3707;Float;False;Property;_Noise_UPanner;Noise_UPanner;12;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-3373.414,-539.3707;Float;False;Property;_Noise_VPanner;Noise_VPanner;13;0;Create;True;0;0;False;0;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-3351.414,-784.3707;Float;False;0;41;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;49;-3169.414,-582.3707;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;45;-3087.413,-714.3707;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;41;-2872.412,-720.3707;Float;True;Property;_Noise_Texture;Noise_Texture;10;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2818.973,-370.7967;Float;True;0;78;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-2862.655,-82.19928;Float;False;Property;_Mian_UVPow;Mian_UVPow;6;0;Create;True;0;0;False;0;1.84;4;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2622.411,-505.3707;Float;False;Property;_Noise_Val;Noise_Val;11;0;Create;True;0;0;False;0;0;0.307;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;42;-2566.411,-723.3707;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;61;-2509.411,-183.7031;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;67;-1143.47,414.3179;Float;False;1330.868;445.7848;Dissolve;10;58;57;59;56;50;52;51;53;55;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-2052.022,-109.8703;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1089.47,721.7181;Float;False;Property;_Diss_VPanner;Diss_VPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2054.022,-31.8703;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;False;0;0.5;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2293.411,-698.3707;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;63;-2242.645,-348.5993;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1093.47,641.7181;Float;False;Property;_Diss_UPanner;Diss_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-2019.811,-421.073;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1867.022,-77.8703;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-1048.47,464.3179;Float;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;59;-927.4701,662.7181;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;70;-2116.717,48.35259;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;-674.2447,737.1027;Float;False;Property;_Dissolve;Dissolve;15;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;-751.47,534.718;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1820.154,-543.0796;Float;False;Property;_Chromatic;Chromatic;20;0;Create;True;0;0;False;0;0;0.0113;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;28;-913.3305,901.5666;Float;False;1097.737;419.5788;Comment;5;29;12;17;14;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;3;-1734.831,-359.6855;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;72;-394.546,742.3965;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-1447.175,-550.0638;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;83;-1490.48,-77.9045;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;78;-1331.61,-257.3657;Float;True;Property;_Main_Texure;Main_Texure;0;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;50;-535.2007,519.3494;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;14;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-833.6074,957.648;Float;False;0;12;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-231.6262,554.8202;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;79;-1054.136,-136.2179;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;80;-1081.091,-573.4241;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-546.5563,1143.145;Float;False;Property;_Mask_Range;Mask_Range;9;0;Create;True;0;0;False;0;0;4;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1076.13,-361.462;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-581.3305,951.5665;Float;True;Property;_Mask_Texture;Mask_Texture;8;0;Create;True;0;0;False;0;a2b434f2424cfc145872c7207c36c447;073f1c809f6bd0845ae30549adc129c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;68;-425.0151,-14.31448;Float;False;994.3589;312.2493;Opacity;2;10;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;81;-724.4321,-433.661;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;89;-1100.081,-1299.409;Float;False;710.9999;311.9999;Grab;3;86;87;85;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-433.9906,-216.869;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;0;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;14;-258.1942,988.4492;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;-24.08574,568.9897;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-747.0918,-229.0076;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;1;2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;11.10623,975.2653;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;86;-1050.081,-1249.409;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;7;-414.0917,-444.0076;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;71;-82.60099,-142.3329;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;118.0263,171.5694;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;64;251.4402,-287.6675;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;550.2621,564.8138;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;87;-807.0811,-1241.409;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-110.9907,-395.869;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;27;-161.9907,-570.869;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2,2,2,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;638.9806,134.978;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;284.6813,61.32398;Float;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;85;-585.0811,-1240.409;Float;False;Global;_GrabScreen0;Grab Screen 0;24;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;97.00933,-493.869;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;39;1164.684,-509.8358;Float;False;1209.298;751.2979;Maks 공부;8;36;37;32;33;38;34;31;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;952.8596,88.64903;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;285.9186,-561.0052;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;31;2118.945,-406.7101;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1564.607,-12.53799;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;73;-2497.139,249.7828;Float;False;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;75;769.9285,-125.6824;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1785.607,-13.53799;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;2413.351,-490.2773;Float;False;Property;_CullMode;CullMode;19;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;2120.358,-205.862;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;683.0203,-513.1212;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;33;2113.686,6.694061;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;1214.684,-450.8402;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;34;1410.113,-146.853;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1802.408,-216.2809;Float;False;Constant;_Mask_Range_;Mask_Range_;9;0;Create;True;0;0;False;0;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;942.0999,-510.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Shokewave_Ref;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;74;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;45;0;46;0
WireConnection;45;2;49;0
WireConnection;41;1;45;0
WireConnection;42;0;41;0
WireConnection;61;0;2;2
WireConnection;61;1;62;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;63;0;2;1
WireConnection;63;1;61;0
WireConnection;40;0;43;0
WireConnection;40;1;63;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;59;0;57;0
WireConnection;59;1;58;0
WireConnection;56;0;55;0
WireConnection;56;2;59;0
WireConnection;3;0;40;0
WireConnection;3;2;6;0
WireConnection;72;1;52;0
WireConnection;72;0;70;2
WireConnection;82;0;3;0
WireConnection;82;1;84;0
WireConnection;83;0;3;0
WireConnection;83;1;84;0
WireConnection;50;1;56;0
WireConnection;51;0;50;1
WireConnection;51;1;72;0
WireConnection;79;0;78;0
WireConnection;79;1;83;0
WireConnection;80;0;78;0
WireConnection;80;1;82;0
WireConnection;1;0;78;0
WireConnection;1;1;3;0
WireConnection;12;1;29;0
WireConnection;81;0;80;1
WireConnection;81;1;1;2
WireConnection;81;2;79;3
WireConnection;14;0;12;1
WireConnection;14;1;20;0
WireConnection;53;0;51;0
WireConnection;17;0;14;0
WireConnection;7;0;81;0
WireConnection;7;1;8;0
WireConnection;71;1;24;0
WireConnection;71;0;70;1
WireConnection;54;0;1;1
WireConnection;54;1;53;0
WireConnection;22;0;54;0
WireConnection;22;1;17;0
WireConnection;87;0;86;0
WireConnection;87;1;43;0
WireConnection;23;0;7;0
WireConnection;23;1;71;0
WireConnection;66;0;64;4
WireConnection;66;1;22;0
WireConnection;85;0;87;0
WireConnection;25;0;27;0
WireConnection;25;1;23;0
WireConnection;9;0;66;0
WireConnection;9;1;10;0
WireConnection;88;0;85;0
WireConnection;88;1;25;0
WireConnection;31;0;30;2
WireConnection;31;1;38;0
WireConnection;36;0;34;0
WireConnection;36;1;30;2
WireConnection;73;1;62;0
WireConnection;73;0;70;3
WireConnection;75;0;9;0
WireConnection;37;0;36;0
WireConnection;32;0;34;0
WireConnection;32;1;38;0
WireConnection;65;0;64;0
WireConnection;65;1;88;0
WireConnection;33;0;37;0
WireConnection;33;1;38;0
WireConnection;34;0;30;2
WireConnection;0;2;65;0
WireConnection;0;9;75;0
ASEEND*/
//CHKSM=D7036D0A50860AF7B45DC32458F8E27E86373032