// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additive_Gra_Shokewave"
{
	Properties
	{
		_Gra_Texture("Gra_Texture", 2D) = "white" {}
		[HDR]_Gra_Color("Gra_Color ", Color) = (0,0,0,0)
		_Gra_Offset("Gra_Offset", Range( -1 , 1)) = 0
		_Gra_Pow("Gra_Pow", Range( 1 , 20)) = 1
		_Gra_Ins("Gra_Ins", Range( 1 , 10)) = 0
		_Chromatic_Val("Chromatic_Val", Range( 0 , 0.05)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_Sub_Color("Sub_Color", Color) = (0,0,0,0)
		_Sub_Tex_Pow("Sub_Tex_Pow", Range( 1 , 10)) = 2
		_Sub_Tex_Ins("Sub_Tex_Ins", Range( 0 , 20)) = 2
		_Sub_Tex_VPanner("Sub_Tex_VPanner", Float) = 0
		_Sub_Tex_UPanner("Sub_Tex_UPanner", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Depth_Fade_Val("Depth_Fade_Val", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv_texcoord;
			float4 screenPos;
		};

		uniform float _CullMode;
		uniform sampler2D _Sub_Texture;
		uniform float _Sub_Tex_UPanner;
		uniform float _Sub_Tex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Sub_Tex_Pow;
		uniform float _Sub_Tex_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _Gra_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Gra_Texture_ST;
		uniform float _Gra_Offset;
		uniform float _Chromatic_Val;
		uniform float _Gra_Pow;
		uniform float _Gra_Ins;
		uniform float4 _Gra_Color;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Fade_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult56 = (float2(_Sub_Tex_UPanner , _Sub_Tex_VPanner));
			float4 uvs_Sub_Texture = i.uv_texcoord;
			uvs_Sub_Texture.xy = i.uv_texcoord.xy * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner52 = ( 1.0 * _Time.y * appendResult56 + uvs_Sub_Texture.xy);
			float2 appendResult25 = (float2(_Noise_UPanner , _Noise_VPanner));
			float4 uvs_Noise_Texture = i.uv_texcoord;
			uvs_Noise_Texture.xy = i.uv_texcoord.xy * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner21 = ( 1.0 * _Time.y * appendResult25 + uvs_Noise_Texture.xy);
			float4 uvs_Gra_Texture = i.uv_texcoord;
			uvs_Gra_Texture.xy = i.uv_texcoord.xy * _Gra_Texture_ST.xy + _Gra_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch61 = i.uv_texcoord.z;
			#else
				float staticSwitch61 = _Gra_Offset;
			#endif
			float2 appendResult6 = (float2(0.0 , staticSwitch61));
			float3 temp_output_3_0 = (( ( (tex2D( _Noise_Texture, panner21 )).rga * _Noise_Val ) + float3( uvs_Gra_Texture.xy ,  0.0 ) )*1.0 + float3( appendResult6 ,  0.0 ));
			float3 temp_cast_4 = (_Chromatic_Val).xxx;
			float4 appendResult65 = (float4(tex2D( _Gra_Texture, ( temp_output_3_0 + _Chromatic_Val ).xy ).r , tex2D( _Gra_Texture, temp_output_3_0.xy ).g , tex2D( _Gra_Texture, ( temp_output_3_0 - temp_cast_4 ).xy ).b , 0.0));
			float4 temp_cast_8 = (_Gra_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner52 ).r , _Sub_Tex_Pow ) * _Sub_Tex_Ins ) * _Sub_Color ) + appendResult65 ) * appendResult65 ) , temp_cast_8 ) * _Gra_Ins ) * _Gra_Color ) ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth69 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth69 = abs( ( screenDepth69 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth_Fade_Val ) );
			o.Alpha = ( i.vertexColor.a * saturate( distanceDepth69 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1084;672;1215.276;602.6215;2.263114;True;False
Node;AmplifyShaderEditor.RangedFloatNode;24;-2871.482,-280.938;Float;False;Property;_Noise_VPanner;Noise_VPanner;10;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2866.482,-358.938;Float;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2664.482,-330.938;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2827.482,-563.9381;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;21;-2574.482,-497.938;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-2371.482,-528.9381;Inherit;True;Property;_Noise_Texture;Noise_Texture;7;0;Create;True;0;0;0;False;0;False;-1;None;d66bfe10b05fc6e46b051b9afca6d29b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;57;-2151.66,-1238.228;Inherit;False;1699;596.0478;Sub;13;43;45;47;50;48;44;46;42;52;56;54;55;53;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2101.66,-1010.18;Float;False;Property;_Sub_Tex_UPanner;Sub_Tex_UPanner;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2142.481,-331.938;Float;False;Property;_Noise_Val;Noise_Val;8;0;Create;True;0;0;0;False;0;False;0;0.252;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;18;-2076.481,-531.9381;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2098.66,-945.1799;Float;False;Property;_Sub_Tex_VPanner;Sub_Tex_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1989.481,130.062;Float;False;Property;_Gra_Offset;Gra_Offset;3;0;Create;True;0;0;0;False;0;False;0;0.15;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;60;-1967.229,218.5361;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-2099.969,-1188.228;Inherit;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1897.481,-130.9381;Inherit;False;0;62;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;56;-1933.66,-1002.18;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1602.481,30.06193;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;61;-1679.229,140.5361;Float;False;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1838.481,-465.938;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1632.481,-343.938;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;52;-1825.66,-1135.18;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1461.481,31.06193;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;3;-1406.481,-137.9381;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1712.66,-889.1799;Float;False;Property;_Sub_Tex_Pow;Sub_Tex_Pow;14;0;Create;True;0;0;0;False;0;False;2;1.69;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1350.89,49.32318;Float;False;Property;_Chromatic_Val;Chromatic_Val;6;0;Create;True;0;0;0;False;0;False;0;0.0035;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-1675.66,-1113.18;Inherit;True;Property;_Sub_Texture;Sub_Texture;12;0;Create;True;0;0;0;False;0;False;-1;68e5980af78d21e4f8e879df5d2164b5;68e5980af78d21e4f8e879df5d2164b5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;67;-1049.89,74.32318;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;43;-1359.66,-1068.18;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;62;-1090.378,-173.6943;Float;True;Property;_Gra_Texture;Gra_Texture;1;0;Create;True;0;0;0;False;0;False;None;3f5b46fe17ed58946937189037ccfc8c;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;66;-1048.89,-339.6768;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1429.66,-846.1799;Float;False;Property;_Sub_Tex_Ins;Sub_Tex_Ins;15;0;Create;True;0;0;0;False;0;False;2;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-826.2041,-178.2018;Inherit;True;Property;_FXT_GraTex01;FXT_GraTex01;1;0;Create;True;0;0;0;False;0;False;-1;3f5b46fe17ed58946937189037ccfc8c;a661d79a3837b3547a5550ceab1cd351;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;63;-823.2791,56.07678;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;3f5b46fe17ed58946937189037ccfc8c;a661d79a3837b3547a5550ceab1cd351;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1128.66,-1065.18;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;48;-1090.66,-854.1799;Float;False;Property;_Sub_Color;Sub_Color;13;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;-828.2791,-390.9232;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;3f5b46fe17ed58946937189037ccfc8c;a661d79a3837b3547a5550ceab1cd351;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;65;-441.6085,-158.6288;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-916.6598,-1054.18;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-687.6598,-1000.18;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-203.6598,-340.1799;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-478,59.5;Float;False;Property;_Gra_Pow;Gra_Pow;4;0;Create;True;0;0;0;False;0;False;1;4.2;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;391.5352,375.0437;Inherit;False;Property;_Depth_Fade_Val;Depth_Fade_Val;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-254,227.5;Float;False;Property;_Gra_Ins;Gra_Ins;5;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-207,-0.5;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;89,256.5;Float;False;Property;_Gra_Color;Gra_Color ;2;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.439855,0.6300626,1.135301,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;37,-0.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;69;568.0581,318.4659;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;862.2628,291.3085;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;14;261,-172.5;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;230,-5.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;41;-789.2689,666.0665;Inherit;False;1532.36;1072.357;Mask;15;28;32;34;35;36;37;38;26;27;29;30;31;33;40;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-187.3939,1254.777;Float;False;Property;_Mask_Range;Mask_Range;11;0;Create;True;0;0;0;False;0;False;8;8;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;316.6194,1019.245;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;29;-286.2108,1004.829;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;53.96764,1017.597;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;-520.4828,1027.776;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-925.269,1025.423;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-685.0005,1179.463;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;513.4091,-122.8243;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;38;514.7313,1392.424;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-536.5145,1429.429;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;537.7432,697.9456;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-168.6932,1430.946;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;147.7312,1393.424;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1385.123,-117.8984;Float;False;Property;_CullMode;CullMode;18;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;-335.5486,1430.083;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-129.8582,1004.95;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-704.269,1457.424;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;780.7906,19.73482;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1153.025,-160.4302;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additive_Gra_Shokewave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;58;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;21;0;22;0
WireConnection;21;2;25;0
WireConnection;17;1;21;0
WireConnection;18;0;17;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;61;1;5;0
WireConnection;61;0;60;3
WireConnection;19;0;18;0
WireConnection;19;1;20;0
WireConnection;16;0;19;0
WireConnection;16;1;2;0
WireConnection;52;0;53;0
WireConnection;52;2;56;0
WireConnection;6;0;7;0
WireConnection;6;1;61;0
WireConnection;3;0;16;0
WireConnection;3;2;6;0
WireConnection;42;1;52;0
WireConnection;67;0;3;0
WireConnection;67;1;68;0
WireConnection;43;0;42;1
WireConnection;43;1;44;0
WireConnection;66;0;3;0
WireConnection;66;1;68;0
WireConnection;1;0;62;0
WireConnection;1;1;3;0
WireConnection;63;0;62;0
WireConnection;63;1;67;0
WireConnection;45;0;43;0
WireConnection;45;1;46;0
WireConnection;64;0;62;0
WireConnection;64;1;66;0
WireConnection;65;0;64;1
WireConnection;65;1;1;2
WireConnection;65;2;63;3
WireConnection;47;0;45;0
WireConnection;47;1;48;0
WireConnection;50;0;47;0
WireConnection;50;1;65;0
WireConnection;51;0;50;0
WireConnection;51;1;65;0
WireConnection;8;0;51;0
WireConnection;8;1;12;0
WireConnection;9;0;8;0
WireConnection;9;1;13;0
WireConnection;69;0;70;0
WireConnection;71;0;69;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;33;0;31;0
WireConnection;29;0;27;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;27;0;26;2
WireConnection;27;1;28;0
WireConnection;15;0;14;0
WireConnection;15;1;10;0
WireConnection;38;0;37;0
WireConnection;35;0;26;2
WireConnection;35;1;34;0
WireConnection;40;0;14;4
WireConnection;40;1;33;0
WireConnection;36;0;59;0
WireConnection;37;0;36;0
WireConnection;37;1;32;0
WireConnection;59;0;35;0
WireConnection;30;0;29;0
WireConnection;34;0;26;2
WireConnection;72;0;14;4
WireConnection;72;1;71;0
WireConnection;0;2;15;0
WireConnection;0;9;72;0
ASEEND*/
//CHKSM=3D0438DCBE238FF12CEB1E211B071193D1B7A159