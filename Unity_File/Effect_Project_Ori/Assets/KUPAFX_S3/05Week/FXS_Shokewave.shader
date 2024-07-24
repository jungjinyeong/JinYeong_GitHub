// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Shokewave_Master"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Src("Src", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_TintColor("Tint Color", Color) = (1,1,1,0)
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_Ins("Main_Ins", Range( 1 , 10)) = 1
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Fade_Distance("Fade_Distance", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 0.3)) = 0.06793601
		_Noise_Tex_UPanner("Noise_Tex_UPanner", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		_Diss_Texture("Diss_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		[Toggle(USE_CUSTOM_ON)] Use_Custom("Use_Custom", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_SubTex_Color("SubTex_Color", Color) = (0,0,0,0)
		_SubTex_Ins("SubTex_Ins", Range( 0 , 10)) = 0
		_SubTex_Pow("SubTex_Pow", Range( 1 , 10)) = 0
		_SubTex_UPanner("SubTex_UPanner", Float) = 0
		_SubTex_VPanner("SubTex_VPanner", Float) = 0
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		[Toggle(_USE_MASKTEX_ON)] _Use_MaskTex("Use_MaskTex", Float) = 0
		[Toggle(_MASK_1X_ON)] _Mask_1x("Mask_-1x", Float) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 50)) = 5.346326
		[Toggle(_MASK_MIRROR_ON)] _Mask_Mirror("Mask_Mirror", Float) = 1
		[Toggle(_USE_ADDMULITYMASK_ON)] _Use_AddMulityMask("Use_AddMulityMask", Float) = 0
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local USE_CUSTOM_ON
		#pragma shader_feature_local _USE_ADDMULITYMASK_ON
		#pragma shader_feature_local _USE_MASKTEX_ON
		#pragma shader_feature_local _MASK_MIRROR_ON
		#pragma shader_feature_local _MASK_1X_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv3_tex4coord3;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform float _CullMode;
		uniform float _Dst;
		uniform float _Src;
		uniform sampler2D _Sub_Texture;
		uniform float _SubTex_UPanner;
		uniform float _SubTex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _SubTex_Pow;
		uniform float _SubTex_Ins;
		uniform float4 _SubTex_Color;
		uniform float4 _TintColor;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_Tex_UPanner;
		uniform float _Noise_Tex_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Diss_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Diss_Texture_ST;
		uniform float _Dissolve;
		uniform float _Mask_Pow;
		uniform sampler2D _Mask_Texture;
		uniform float _Opacity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult97 = (float2(_SubTex_UPanner , _SubTex_VPanner));
			float2 uv_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner92 = ( 1.0 * _Time.y * appendResult97 + uv_Sub_Texture);
			float2 appendResult7 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult32 = (float2(_Noise_Tex_UPanner , _Noise_Tex_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner29 = ( 1.0 * _Time.y * appendResult32 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult66 = (float2(i.uv3_tex4coord3.x , i.uv3_tex4coord3.y));
			#ifdef USE_CUSTOM_ON
				float2 staticSwitch67 = appendResult66;
			#else
				float2 staticSwitch67 = float2( 1,1 );
			#endif
			float2 panner3 = ( 1.0 * _Time.y * appendResult7 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner29 ) )).xy * _Noise_Str ) + uv_Main_Texture )*staticSwitch67 + 0.0));
			float4 tex2DNode1 = tex2D( _Main_Texture, panner3 );
			#ifdef USE_CUSTOM_ON
				float staticSwitch61 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch61 = _Main_Ins;
			#endif
			o.Emission = ( ( ( ( pow( tex2D( _Sub_Texture, panner92 ).r , _SubTex_Pow ) * _SubTex_Ins ) * _SubTex_Color ) + ( _TintColor * ( pow( tex2DNode1.r , _Main_Pow ) * staticSwitch61 ) ) ) * i.vertexColor ).rgb;
			float2 appendResult53 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv_Diss_Texture = i.uv_texcoord * _Diss_Texture_ST.xy + _Diss_Texture_ST.zw;
			float2 panner54 = ( 1.0 * _Time.y * appendResult53 + uv_Diss_Texture);
			#ifdef USE_CUSTOM_ON
				float staticSwitch62 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch62 = _Dissolve;
			#endif
			#ifdef _MASK_1X_ON
				float staticSwitch81 = ( 1.0 - i.uv_texcoord.y );
			#else
				float staticSwitch81 = i.uv_texcoord.y;
			#endif
			#ifdef _MASK_MIRROR_ON
				float staticSwitch82 = ( saturate( ( ( 1.0 - i.uv_texcoord.y ) * i.uv_texcoord.y ) ) * 4.0 );
			#else
				float staticSwitch82 = staticSwitch81;
			#endif
			#ifdef _USE_MASKTEX_ON
				float staticSwitch89 = saturate( pow( tex2D( _Mask_Texture, i.uv_texcoord ).r , _Mask_Pow ) );
			#else
				float staticSwitch89 = saturate( pow( staticSwitch82 , _Mask_Pow ) );
			#endif
			#ifdef _USE_ADDMULITYMASK_ON
				float staticSwitch109 = ( ( tex2DNode1.r + staticSwitch89 ) * staticSwitch89 );
			#else
				float staticSwitch109 = ( tex2DNode1.r * staticSwitch89 );
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth69 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth69 = abs( ( screenDepth69 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			o.Alpha = ( i.vertexColor.a * ( saturate( ( ( saturate( ( tex2D( _Diss_Texture, panner54 ).r + staticSwitch62 ) ) * staticSwitch109 ) * _Opacity ) ) * saturate( distanceDepth69 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;24;1920;995;2529.245;-569.8925;1.647005;True;False
Node;AmplifyShaderEditor.CommentaryNode;35;-2467.313,-1060.732;Inherit;False;1309;487;Noise;9;24;25;27;26;29;32;30;34;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2417.313,-879.7318;Inherit;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;14;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2410.313,-806.7318;Inherit;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;15;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;15;-2434.426,642.106;Inherit;False;2509.075;993.5074;Comment;14;82;81;13;12;79;11;10;8;45;9;14;89;108;110;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-2338.313,-1010.732;Inherit;False;0;24;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;32;-2186.313,-842.7318;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2321.926,937.9167;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;29;-2124.313,-967.7318;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;9;-2038.226,731.3165;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1850.226,965.3171;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-1934.313,-891.7318;Inherit;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;0;False;0;False;-1;1dbf1177420b46f47b20959a7c02ae71;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;88;-1764.582,1681.505;Inherit;False;1096.792;382.3668;Mask_Tex;5;83;84;85;86;87;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1706.313,-689.7318;Inherit;False;Property;_Noise_Str;Noise_Str;13;0;Create;True;0;0;0;False;0;False;0.06793601;0.25;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;25;-1641.313,-889.7318;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;45;-1612.772,909.4771;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;79;-1882.356,1218.316;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;64;-2263.018,-326.7524;Inherit;True;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;81;-1619.755,1180.615;Inherit;True;Property;_Mask_1x;Mask_-1x;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;83;-1714.582,1765.409;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;68;-1848.532,-132.7446;Inherit;False;Constant;_Vector0;Vector 0;19;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;66;-2008.332,-307.7067;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1703.687,-516.7565;Inherit;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1508.026,921.0164;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1393.313,-885.7318;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;84;-1482.126,1741.541;Inherit;True;Property;_Mask_Texture;Mask_Texture;27;0;Create;True;0;0;0;False;0;False;-1;b26f529951a497d49ace8121bb60ef9f;fe7348c5b1084654894bc778e5cc4284;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;67;-1655.061,-173.1566;Inherit;False;Property;Use_Custom;Use_Custom;20;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-1452.772,-535.5172;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-1454.242,1951.166;Inherit;False;Property;_Mask_Pow;Mask_Pow;30;0;Create;True;0;0;0;False;0;False;5.346326;5;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1176.095,-214.5952;Inherit;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-1545.843,191.0442;Inherit;False;1471.905;422.1323;Dissolve;9;46;47;49;53;54;50;51;48;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1181.91,-137.6073;Inherit;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;82;-1327.255,1161.115;Inherit;True;Property;_Mask_Mirror;Mask_Mirror;31;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;65;-1389.33,-243.4441;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1670.843,399.0443;Inherit;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-995.0954,-171.5952;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1670.843,476.0443;Inherit;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;86;-1139.016,1733.584;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;12;-996.9095,1149.533;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1856.843,150.0441;Inherit;False;0;46;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;106;-1067.597,-1325.548;Inherit;False;1591.756;513.8267;SubTex;12;93;92;97;95;96;90;99;101;98;100;102;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;3;-940.0954,-356.5952;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;87;-865.7899,1731.505;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;13;-742.3455,1151.586;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;53;-1370.843,439.0443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;54;-1190.843,281.0443;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;63;-2079.402,31.61719;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;96;-1011.841,-1032.721;Inherit;False;Property;_SubTex_VPanner;SubTex_VPanner;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1007.841,-1104.721;Inherit;False;Property;_SubTex_UPanner;SubTex_UPanner;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1117.7,509.4635;Inherit;False;Property;_Dissolve;Dissolve;17;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;89;-499.093,1112.046;Inherit;True;Property;_Use_MaskTex;Use_MaskTex;28;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-707.0955,-296.5952;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;97;-752.8413,-1077.721;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;93;-1017.597,-1262.069;Inherit;False;0;90;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;-989.942,293.1764;Inherit;True;Property;_Diss_Texture;Diss_Texture;16;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;62;-847.2194,508.9821;Inherit;False;Property;Use_Custom;Use_Custom;16;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;108;-429.7578,713.0895;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-725.152,322.0368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;92;-748.5969,-1253.069;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-110.5424,726.0053;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-123.9623,961.5646;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-726.6721,-82.149;Inherit;False;Property;_Main_Pow;Main_Pow;9;0;Create;True;0;0;0;False;0;False;1;2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-537.8413,-1062.721;Inherit;False;Property;_SubTex_Pow;SubTex_Pow;24;0;Create;True;0;0;0;False;0;False;0;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-708.7979,39.77204;Inherit;False;Property;_Main_Ins;Main_Ins;8;0;Create;True;0;0;0;False;0;False;1;1.73;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;109;144.3305,925.5602;Inherit;True;Property;_Use_AddMulityMask;Use_AddMulityMask;32;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;107;249.8362,519.581;Inherit;False;675.7916;190.0119;DepthFade;3;69;70;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;49;-511.8756,335.1169;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;-530.6014,-1275.548;Inherit;True;Property;_Sub_Texture;Sub_Texture;21;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;299.8362,577.8666;Inherit;False;Property;_Fade_Distance;Fade_Distance;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-228.8413,-1033.721;Inherit;False;Property;_SubTex_Ins;SubTex_Ins;23;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;61;-188.2139,17.67075;Inherit;False;Property;Use_Custom;Use_Custom;16;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-315.6721,-311.149;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;45.9243,346.0859;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;331.6097,362.7262;Inherit;False;Property;_Opacity;Opacity;10;0;Create;True;0;0;0;False;0;False;1;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;98;-204.8413,-1253.721;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;61.90454,-679.5952;Inherit;False;Property;_TintColor;Tint Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.819067,1.353208,4.237095,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;24.3279,-462.149;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;32.15869,-1249.721;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;263.5573,19.46363;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;69;505.7843,574.593;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;103;68.15869,-1023.721;Inherit;False;Property;_SubTex_Color;SubTex_Color;22;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;327.7679,-532.2334;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;289.1587,-1255.721;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;70;760.6276,569.5811;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;497.1848,5.991344;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;698.7404,8.863548;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;76;1285.213,-527.4526;Inherit;False;222;346;Enum;3;73;74;75;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;105;503.0149,-613.2177;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;58;527.3779,-340.1814;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;73;1335.213,-477.4526;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;1339.213,-297.4526;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;781.778,-545.5812;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;823.0321,-221.9714;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1339.213,-390.4526;Inherit;False;Property;_Src;Src;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1058.258,-529.7874;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Shokewave_Master;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;74;10;True;75;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;True;73;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;34;0
WireConnection;32;1;33;0
WireConnection;29;0;30;0
WireConnection;29;2;32;0
WireConnection;9;0;8;2
WireConnection;10;0;9;0
WireConnection;10;1;8;2
WireConnection;24;1;29;0
WireConnection;25;0;24;0
WireConnection;45;0;10;0
WireConnection;79;0;8;2
WireConnection;81;1;8;2
WireConnection;81;0;79;0
WireConnection;66;0;64;1
WireConnection;66;1;64;2
WireConnection;11;0;45;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;84;1;83;0
WireConnection;67;1;68;0
WireConnection;67;0;66;0
WireConnection;28;0;26;0
WireConnection;28;1;4;0
WireConnection;82;1;81;0
WireConnection;82;0;11;0
WireConnection;65;0;28;0
WireConnection;65;1;67;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;86;0;84;1
WireConnection;86;1;85;0
WireConnection;12;0;82;0
WireConnection;12;1;85;0
WireConnection;3;0;65;0
WireConnection;3;2;7;0
WireConnection;87;0;86;0
WireConnection;13;0;12;0
WireConnection;53;0;51;0
WireConnection;53;1;50;0
WireConnection;54;0;52;0
WireConnection;54;2;53;0
WireConnection;89;1;13;0
WireConnection;89;0;87;0
WireConnection;1;1;3;0
WireConnection;97;0;95;0
WireConnection;97;1;96;0
WireConnection;46;1;54;0
WireConnection;62;1;48;0
WireConnection;62;0;63;2
WireConnection;108;0;1;1
WireConnection;108;1;89;0
WireConnection;47;0;46;1
WireConnection;47;1;62;0
WireConnection;92;0;93;0
WireConnection;92;2;97;0
WireConnection;14;0;1;1
WireConnection;14;1;89;0
WireConnection;110;0;108;0
WireConnection;110;1;89;0
WireConnection;109;1;14;0
WireConnection;109;0;110;0
WireConnection;49;0;47;0
WireConnection;90;1;92;0
WireConnection;61;1;19;0
WireConnection;61;0;63;1
WireConnection;16;0;1;1
WireConnection;16;1;18;0
WireConnection;56;0;49;0
WireConnection;56;1;109;0
WireConnection;98;0;90;1
WireConnection;98;1;99;0
WireConnection;17;0;16;0
WireConnection;17;1;61;0
WireConnection;100;0;98;0
WireConnection;100;1;101;0
WireConnection;20;0;56;0
WireConnection;20;1;21;0
WireConnection;69;0;72;0
WireConnection;23;0;2;0
WireConnection;23;1;17;0
WireConnection;102;0;100;0
WireConnection;102;1;103;0
WireConnection;70;0;69;0
WireConnection;22;0;20;0
WireConnection;71;0;22;0
WireConnection;71;1;70;0
WireConnection;105;0;102;0
WireConnection;105;1;23;0
WireConnection;59;0;105;0
WireConnection;59;1;58;0
WireConnection;60;0;58;4
WireConnection;60;1;71;0
WireConnection;0;2;59;0
WireConnection;0;9;60;0
ASEEND*/
//CHKSM=C3420DBE92F122B9AE0ACF7B5FD4D5B6B812BCD2