// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Shokewave_MaskTex"
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
		_Main_Str_Pow("Main_Str_Pow", Range( -10 , 10)) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 0.3)) = 0.06793601
		_Noise_Tex_UPanner("Noise_Tex_UPanner", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		_Diss_Texture("Diss_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Pow("Mask_Pow", Range( 1 , 20)) = 5.346326
		[Toggle(USE_CUSTOM_ON)] Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv3_tex4coord3;
			float4 uv2_tex4coord2;
		};

		uniform float _Src;
		uniform float _CullMode;
		uniform float _Dst;
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
		uniform float _Main_Str_Pow;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Diss_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Diss_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Pow;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult7 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult32 = (float2(_Noise_Tex_UPanner , _Noise_Tex_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner29 = ( 1.0 * _Time.y * appendResult32 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult80 = (float2(uv_Main_Texture.x , pow( uv_Main_Texture.y , _Main_Str_Pow )));
			float2 appendResult66 = (float2(i.uv3_tex4coord3.x , i.uv3_tex4coord3.y));
			#ifdef USE_CUSTOM_ON
				float2 staticSwitch67 = appendResult66;
			#else
				float2 staticSwitch67 = float2( 1,1 );
			#endif
			float2 panner3 = ( 1.0 * _Time.y * appendResult7 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner29 ) )).xy * _Noise_Str ) + appendResult80 )*staticSwitch67 + 0.0));
			float4 tex2DNode1 = tex2D( _Main_Texture, panner3 );
			#ifdef USE_CUSTOM_ON
				float staticSwitch61 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch61 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _TintColor * ( pow( tex2DNode1.r , _Main_Pow ) * staticSwitch61 ) ) ).rgb;
			float2 appendResult53 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv_Diss_Texture = i.uv_texcoord * _Diss_Texture_ST.xy + _Diss_Texture_ST.zw;
			float2 panner54 = ( 1.0 * _Time.y * appendResult53 + uv_Diss_Texture);
			#ifdef USE_CUSTOM_ON
				float staticSwitch62 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch62 = _Dissolve;
			#endif
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( saturate( ( tex2D( _Diss_Texture, panner54 ).r + staticSwitch62 ) ) * ( tex2DNode1.r * saturate( pow( tex2D( _Mask_Texture, uv_Mask_Texture ).r , _Mask_Pow ) ) ) ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;54;1920;965;4305.022;1318.565;2.206397;True;False
Node;AmplifyShaderEditor.CommentaryNode;35;-2467.313,-1060.732;Inherit;False;1309;487;Noise;9;24;25;27;26;29;32;30;34;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2417.313,-879.7318;Inherit;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2410.313,-806.7318;Inherit;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-2338.313,-1010.732;Inherit;False;0;24;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;32;-2186.313,-842.7318;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;29;-2124.313,-967.7318;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-1994.242,-267.9543;Inherit;False;Property;_Main_Str_Pow;Main_Str_Pow;10;0;Create;True;0;0;0;False;0;False;0;0;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2008.974,-562.455;Inherit;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;-1934.313,-891.7318;Inherit;True;Property;_Noise_Texture;Noise_Texture;13;0;Create;True;0;0;0;False;0;False;-1;1dbf1177420b46f47b20959a7c02ae71;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;25;-1641.313,-889.7318;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1706.313,-689.7318;Inherit;False;Property;_Noise_Str;Noise_Str;14;0;Create;True;0;0;0;False;0;False;0.06793601;0.06793601;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-1545.843,191.0442;Inherit;False;1471.905;422.1323;Dissolve;10;46;47;49;53;54;50;51;48;56;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;64;-2475.182,-364.8756;Inherit;True;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;81;-1696.242,-358.9543;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-2235.414,-335.8847;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1670.843,476.0443;Inherit;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;80;-1531.242,-521.9543;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1393.313,-885.7318;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;15;-2434.426,642.106;Inherit;False;2405.075;628.2074;Comment;6;13;12;44;14;77;78;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1670.843,399.0443;Inherit;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;68;-1848.532,-132.7446;Inherit;False;Constant;_Vector0;Vector 0;19;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1856.843,150.0441;Inherit;False;0;46;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1176.095,-214.5952;Inherit;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1181.91,-137.6073;Inherit;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-1315.197,-585.2432;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;67;-1655.061,-173.1566;Inherit;False;Property;Use_Custom;Use_Custom;23;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;78;-1628.67,882.0703;Inherit;False;0;77;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-1370.843,439.0443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-995.0954,-171.5952;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;65;-1389.33,-243.4441;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;54;-1190.843,281.0443;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;77;-1396.214,858.2023;Inherit;True;Property;_Mask_Texture;Mask_Texture;21;0;Create;True;0;0;0;False;0;False;-1;b26f529951a497d49ace8121bb60ef9f;b26f529951a497d49ace8121bb60ef9f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;63;-2079.402,31.61719;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-1117.7,509.4635;Inherit;False;Property;_Dissolve;Dissolve;18;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1376.565,1064.533;Inherit;False;Property;_Mask_Pow;Mask_Pow;22;0;Create;True;0;0;0;False;0;False;5.346326;5.346326;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;62;-847.2194,508.9821;Inherit;False;Property;Use_Custom;Use_Custom;16;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;3;-940.0954,-356.5952;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;46;-989.942,293.1764;Inherit;True;Property;_Diss_Texture;Diss_Texture;17;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;12;-1053.104,850.2455;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-636.0955,-494.5952;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;13;-779.8779,848.1661;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-675.9421,324.1764;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-726.6721,-82.149;Inherit;False;Property;_Main_Pow;Main_Pow;9;0;Create;True;0;0;0;False;0;False;1;2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-395.0293,669.4533;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-464.9421,323.1764;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-708.7979,39.77204;Inherit;False;Property;_Main_Ins;Main_Ins;8;0;Create;True;0;0;0;False;0;False;1;7.63;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;61;-188.2139,17.67075;Inherit;False;Property;Use_Custom;Use_Custom;16;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;579.5811,302.7638;Inherit;False;Property;_Opacity;Opacity;12;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-315.6721,-311.149;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-215.5806,316.3388;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-17.6721,-318.149;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;668.7863,56.80976;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-121.0955,-510.5952;Inherit;False;Property;_TintColor;Tint Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;76;1285.213,-527.4526;Inherit;False;222;346;Enum;3;73;74;75;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;168.7679,-446.2334;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;58;209.3779,-235.1814;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;22;1042.976,55.75035;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;79;1738.823,178.766;Inherit;False;718.4878;303.9999;Comment;3;69;72;70;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;75;1339.213,-297.4526;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;1788.823,249.5337;Inherit;False;Property;_Fade_Distance;Fade_Distance;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;69;2005.468,233.7779;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;2259.311,228.766;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1339.213,-390.4526;Inherit;False;Property;_Src;Src;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;1335.213,-477.4526;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;823.0321,-221.9714;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;602.778,-486.5812;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1058.258,-529.7874;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Shokewave_MaskTex;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;74;10;True;75;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;True;73;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;34;0
WireConnection;32;1;33;0
WireConnection;29;0;30;0
WireConnection;29;2;32;0
WireConnection;24;1;29;0
WireConnection;25;0;24;0
WireConnection;81;0;4;2
WireConnection;81;1;82;0
WireConnection;66;0;64;1
WireConnection;66;1;64;2
WireConnection;80;0;4;1
WireConnection;80;1;81;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;28;0;26;0
WireConnection;28;1;80;0
WireConnection;67;1;68;0
WireConnection;67;0;66;0
WireConnection;53;0;51;0
WireConnection;53;1;50;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;65;0;28;0
WireConnection;65;1;67;0
WireConnection;54;0;52;0
WireConnection;54;2;53;0
WireConnection;77;1;78;0
WireConnection;62;1;48;0
WireConnection;62;0;63;2
WireConnection;3;0;65;0
WireConnection;3;2;7;0
WireConnection;46;1;54;0
WireConnection;12;0;77;1
WireConnection;12;1;44;0
WireConnection;1;1;3;0
WireConnection;13;0;12;0
WireConnection;47;0;46;1
WireConnection;47;1;62;0
WireConnection;14;0;1;1
WireConnection;14;1;13;0
WireConnection;49;0;47;0
WireConnection;61;1;19;0
WireConnection;61;0;63;1
WireConnection;16;0;1;1
WireConnection;16;1;18;0
WireConnection;56;0;49;0
WireConnection;56;1;14;0
WireConnection;17;0;16;0
WireConnection;17;1;61;0
WireConnection;20;0;56;0
WireConnection;20;1;21;0
WireConnection;23;0;2;0
WireConnection;23;1;17;0
WireConnection;22;0;20;0
WireConnection;69;0;72;0
WireConnection;70;0;69;0
WireConnection;60;0;58;4
WireConnection;60;1;22;0
WireConnection;59;0;58;0
WireConnection;59;1;23;0
WireConnection;0;2;59;0
WireConnection;0;9;60;0
ASEEND*/
//CHKSM=F0545D76AA847471917A8A9EF48D54DDC9D793C9