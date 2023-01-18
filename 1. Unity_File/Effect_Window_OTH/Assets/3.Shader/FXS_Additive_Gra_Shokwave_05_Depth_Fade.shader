// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Gra_Shokwave_05_Depth_Fade"
{
	Properties
	{
		_Gra_Offset("Gra_Offset", Range( -1 , 1)) = 0
		_Gra_Ins("Gra_Ins", Range( 1 , 10)) = 0
		_Gra_Pow("Gra_Pow", Range( 1 , 20)) = 1
		[HDR]_Gra_Color("Gra_Color", Color) = (1,1,1,0)
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 20)) = 8
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_Sub_Color("Sub_Color", Color) = (1,1,1,0)
		_Sub_Ins("Sub_Ins", Range( 0 , 20)) = 0
		_Sub_Pow("Sub_Pow", Range( 1 , 10)) = 1
		_Sub_VPanner("Sub_VPanner", Float) = 0
		_Sub_UPanner("Sub_UPanner", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Depth_Fade("Depth_Fade", Range( 0 , 1)) = 0
		_Gra_Texture("Gra_Texture", 2D) = "white" {}
		_Chromatic_Val("Chromatic_Val", Float) = 0.06
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
		uniform float _Sub_UPanner;
		uniform float _Sub_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _Gra_Texture;
		uniform float4 _Gra_Texture_ST;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float _Gra_Offset;
		uniform float _Chromatic_Val;
		uniform float _Gra_Pow;
		uniform float _Gra_Ins;
		uniform float4 _Gra_Color;
		uniform float _Mask_Pow;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Fade;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult57 = (float2(_Sub_UPanner , _Sub_VPanner));
			float4 uvs_Sub_Texture = i.uv_texcoord;
			uvs_Sub_Texture.xy = i.uv_texcoord.xy * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner54 = ( 1.0 * _Time.y * appendResult57 + uvs_Sub_Texture.xy);
			float4 uvs_Gra_Texture = i.uv_texcoord;
			uvs_Gra_Texture.xy = i.uv_texcoord.xy * _Gra_Texture_ST.xy + _Gra_Texture_ST.zw;
			float2 appendResult26 = (float2(_Noise_UPanner , _Noise_VPanner));
			float4 uvs_Noise_Texture = i.uv_texcoord;
			uvs_Noise_Texture.xy = i.uv_texcoord.xy * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult26 + uvs_Noise_Texture.xy);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch61 = i.uv_texcoord.w;
			#else
				float staticSwitch61 = _Noise_Val;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch60 = i.uv_texcoord.z;
			#else
				float staticSwitch60 = _Gra_Offset;
			#endif
			float2 appendResult7 = (float2(0.0 , staticSwitch60));
			float3 temp_output_76_0 = ( float3( uvs_Gra_Texture.xy ,  0.0 ) * (( ( (tex2D( _Noise_Texture, panner23 )).rga * staticSwitch61 ) + float3( i.uv_texcoord.xy ,  0.0 ) )*1.0 + float3( appendResult7 ,  0.0 )) );
			float3 temp_cast_7 = (_Chromatic_Val).xxx;
			float3 appendResult74 = (float3(tex2D( _Gra_Texture, ( temp_output_76_0 + _Chromatic_Val ).xy ).r , tex2D( _Gra_Texture, temp_output_76_0.xy ).g , tex2D( _Gra_Texture, ( temp_output_76_0 - temp_cast_7 ).xy ).b));
			float4 temp_cast_11 = (_Gra_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner54 ).r , _Sub_Pow ) * _Sub_Ins ) * _Sub_Color ) + float4( appendResult74 , 0.0 ) ) * float4( appendResult74 , 0.0 ) ) , temp_cast_11 ) * _Gra_Ins ) * _Gra_Color ) ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth64 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth64 = abs( ( screenDepth64 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth_Fade ) );
			o.Alpha = ( ( i.vertexColor.a * saturate( pow( ( saturate( ( i.uv_texcoord.xy.y * ( 1.0 - i.uv_texcoord.xy.y ) ) ) * 4.0 ) , _Mask_Pow ) ) ) * saturate( distanceDepth64 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1010;521;3018.605;667.0392;2.219027;True;False
Node;AmplifyShaderEditor.RangedFloatNode;24;-4703.981,-191.7982;Float;False;Property;_Noise_UPanner;Noise_UPanner;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-4703.983,-95.59825;Float;False;Property;_Noise_VPanner;Noise_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-4479.08,-437.4982;Inherit;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-4479.083,-199.5981;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-4137.182,-403.6981;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-3888.999,-177.8548;Float;False;Property;_Noise_Val;Noise_Val;6;0;Create;True;0;0;0;False;0;False;0;0.235;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;59;-4007.975,120.2737;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-3887.583,-416.6986;Inherit;True;Property;_Noise_Texture;Noise_Texture;5;0;Create;True;0;0;0;False;0;False;-1;None;cc86ef0fc250b1d4a9457c3ba98421bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-3629.296,218.2779;Float;False;Property;_Gra_Offset;Gra_Offset;1;0;Create;True;0;0;0;False;0;False;0;-0.33;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;61;-3518.132,-177.365;Float;False;Property;_Use_Custom;Use_Custom;17;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;-3522.283,-414.0985;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-3089.513,-762.7437;Float;False;Property;_Sub_UPanner;Sub_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-3192.083,-402.398;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;60;-3330.318,358.2614;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-3184.964,181.2779;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-3105.183,-681.7786;Float;False;Property;_Sub_VPanner;Sub_VPanner;14;0;Create;True;0;0;0;False;0;False;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-3285.964,-58.72218;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-3022.912,-958.6276;Inherit;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-2915.964,196.2779;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-2957.167,-76.81625;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-2909.3,-760.132;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;54;-2669.016,-915.5329;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;71;-2441.463,-294.2653;Inherit;False;0;68;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-2706.964,23.27781;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1943.757,94.67162;Inherit;False;Property;_Chromatic_Val;Chromatic_Val;20;0;Create;True;0;0;0;False;0;False;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-2098.073,-205.1866;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;43;-2303.835,-894.2932;Inherit;True;Property;_Sub_Texture;Sub_Texture;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-2281.152,-670.6713;Float;False;Property;_Sub_Pow;Sub_Pow;13;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1590.167,859.2838;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;-1968.423,-667.3661;Float;False;Property;_Sub_Ins;Sub_Ins;12;0;Create;True;0;0;0;False;0;False;0;1.5;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;44;-1925.445,-890.5652;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;73;-1539.88,232.9799;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-1617.395,-316.9031;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;68;-1647.981,-107.5552;Inherit;True;Property;_Gra_Texture;Gra_Texture;19;0;Create;True;0;0;0;False;0;False;None;1f7bfb2ae7e94e345b708a040e18d5ea;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1612.164,-881.8837;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1366.693,-62.61696;Inherit;True;Property;_Gra_Texture2;Gra_Texture2;1;0;Create;True;0;0;0;False;0;False;-1;1f7bfb2ae7e94e345b708a040e18d5ea;3f5b46fe17ed58946937189037ccfc8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;69;-1366.915,-285.2865;Inherit;True;Property;_TextureSample0;Texture Sample 0;22;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;63;-1316.254,1138.769;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;49;-1605.07,-648.4896;Float;False;Property;_Sub_Color;Sub_Color;11;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-1361.005,198.0799;Inherit;True;Property;_TextureSample1;Texture Sample 1;23;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1131.474,1009.886;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;74;-942.7925,-119.4273;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1328.164,-882.8837;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-852.6021,-435.791;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;62;-860.4623,1007.428;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-723.0547,219.9654;Float;False;Property;_Gra_Pow;Gra_Pow;3;0;Create;True;0;0;0;False;0;False;1;2.5;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-688.9665,-24.73421;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-645.5518,855.7322;Float;False;Property;_Mask_Pow;Mask_Pow;9;0;Create;True;0;0;0;False;0;False;8;8;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-641.5481,1014.101;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;38;-342.9672,1000.328;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-407.491,281.4837;Float;False;Property;_Gra_Ins;Gra_Ins;2;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-354.1643,11.88372;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;65;230.5153,797.9947;Float;False;Property;_Depth_Fade;Depth_Fade;18;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;-39.32531,1003.702;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-100.7945,268.3624;Float;False;Property;_Gra_Color;Gra_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-84.49103,17.48373;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;64;534.3656,715.1264;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;15;205.3867,-215.8946;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;457.1092,253.2832;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;148.5089,6.483727;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;66;819.8003,663.827;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;470.1803,-7.228267;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;-41.01229,625.8364;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;31;-854.0974,614.0281;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-619.6186,614.0281;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-1127.376,612.3415;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;-353.0885,622.4626;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1294.927,20.49962;Float;False;Property;_CullMode;CullMode;16;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;805.3317,257.3781;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1298.21,807.448;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1061.092,17.62859;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Gra_Shokwave_05_Depth_Fade;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;58;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;42;-1634.526,562.3415;Inherit;False;1793.199;875.8582;Mask;0;;1,1,1,1;0;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;23;0;20;0
WireConnection;23;2;26;0
WireConnection;18;1;23;0
WireConnection;61;1;22;0
WireConnection;61;0;59;4
WireConnection;19;0;18;0
WireConnection;21;0;19;0
WireConnection;21;1;61;0
WireConnection;60;1;6;0
WireConnection;60;0;59;3
WireConnection;7;0;8;0
WireConnection;7;1;60;0
WireConnection;17;0;21;0
WireConnection;17;1;3;0
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;54;0;53;0
WireConnection;54;2;57;0
WireConnection;4;0;17;0
WireConnection;4;2;7;0
WireConnection;76;0;71;0
WireConnection;76;1;4;0
WireConnection;43;1;54;0
WireConnection;44;0;43;1
WireConnection;44;1;45;0
WireConnection;73;0;76;0
WireConnection;73;1;75;0
WireConnection;72;0;76;0
WireConnection;72;1;75;0
WireConnection;46;0;44;0
WireConnection;46;1;47;0
WireConnection;1;0;68;0
WireConnection;1;1;76;0
WireConnection;69;0;68;0
WireConnection;69;1;72;0
WireConnection;63;0;27;2
WireConnection;70;0;68;0
WireConnection;70;1;73;0
WireConnection;36;0;27;2
WireConnection;36;1;63;0
WireConnection;74;0;69;1
WireConnection;74;1;1;2
WireConnection;74;2;70;3
WireConnection;48;0;46;0
WireConnection;48;1;49;0
WireConnection;50;0;48;0
WireConnection;50;1;74;0
WireConnection;62;0;36;0
WireConnection;51;0;50;0
WireConnection;51;1;74;0
WireConnection;37;0;62;0
WireConnection;38;0;37;0
WireConnection;38;1;33;0
WireConnection;9;0;51;0
WireConnection;9;1;12;0
WireConnection;40;0;38;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;64;0;65;0
WireConnection;41;0;15;4
WireConnection;41;1;40;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;66;0;64;0
WireConnection;16;0;15;0
WireConnection;16;1;11;0
WireConnection;34;0;32;0
WireConnection;31;0;29;0
WireConnection;28;0;31;0
WireConnection;29;0;27;2
WireConnection;29;1;30;0
WireConnection;32;0;28;0
WireConnection;32;1;33;0
WireConnection;67;0;41;0
WireConnection;67;1;66;0
WireConnection;0;2;16;0
WireConnection;0;9;67;0
ASEEND*/
//CHKSM=EB821CAE52C251D85B8D5B85A8B99FCA4456ABB6