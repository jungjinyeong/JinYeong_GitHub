// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablen_Sword_Toon_Lerp"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 0
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 0
		_Main_UPanner("Main_UPanner", Float) = -0.15
		_Main_VPanner("Main_VPanner", Float) = 0
		_Emi_Offset("Emi_Offset", Range( -1 , 1)) = 0
		[HDR]_Color0("Color 0", Color) = (0.2450042,0.9058824,0.2196078,0)
		[HDR]_Emi_Lerp_Color_A("Emi_Lerp_Color_A", Color) = (0.2450042,0.9058824,0.2196078,0)
		[HDR]_Emi_Lerp_Color_B("Emi_Lerp_Color_B", Color) = (0.1623798,0.7381574,0.8396226,0)
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Sword_UOffset("Sword_UOffset", Range( -1 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_UPanner("Diss_UPanner", Float) = -0.15
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Mask_Val("Mask_Val", Float) = 3
		_Noise_Val("Noise_Val", Range( 0 , 10)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = -0.15
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Emi_Ins("Emi_Ins", Range( 1 , 100)) = 12
		_FXT_Mask01("FXT_Mask01", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float _Emi_Offset;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texture_ST;
		uniform float _Emi_Ins;
		uniform float4 _Color0;
		uniform float4 _Tint_Color;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Emi_Lerp_Color_A;
		uniform float4 _Emi_Lerp_Color_B;
		uniform sampler2D _Sword_Texture;
		uniform float4 _Sword_Texture_ST;
		uniform float _Sword_UOffset;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _FXT_Mask01;
		uniform float4 _FXT_Mask01_ST;
		uniform float _Mask_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch91 = i.uv2_texcoord2.z;
			#else
				float staticSwitch91 = _Emi_Offset;
			#endif
			float2 appendResult28 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner35 = ( 1.0 * _Time.y * appendResult38 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult28 + ( ( (tex2D( _Noise_Texture, panner35 )).rga * _Noise_Val ) + float3( uv_Main_Texture ,  0.0 ) ).xy);
			float temp_output_108_0 = ( ceil( ( ( tex2D( _Main_Texture, panner25 ).r + 0.0 ) * 4.0 ) ) / 4.0 );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch98 = i.uv2_texcoord2.w;
			#else
				float staticSwitch98 = _Emi_Ins;
			#endif
			o.Emission = ( ( ( ( pow( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) + staticSwitch91 ) ) * temp_output_108_0 ) , 3.0 ) * staticSwitch98 ) * _Color0 ) + ( _Tint_Color * ( pow( temp_output_108_0 , _Main_Pow ) * _Main_Ins ) ) ) * i.vertexColor ).rgb;
			float2 uv_Sword_Texture = i.uv_texcoord * _Sword_Texture_ST.xy + _Sword_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch90 = i.uv2_texcoord2.x;
			#else
				float staticSwitch90 = _Sword_UOffset;
			#endif
			float2 appendResult18 = (float2(staticSwitch90 , 0.0));
			float2 appendResult42 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner44 = ( 1.0 * _Time.y * appendResult42 + uv_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch92 = i.uv2_texcoord2.y;
			#else
				float staticSwitch92 = _Dissolve;
			#endif
			float2 uv_FXT_Mask01 = i.uv_texcoord * _FXT_Mask01_ST.xy + _FXT_Mask01_ST.zw;
			float temp_output_71_0 = saturate( ( ( ( tex2D( _Sword_Texture, (uv_Sword_Texture*1.0 + appendResult18) ).r * _Opacity ) * step( 0.0 , ( tex2D( _Dissolve_Texture, panner44 ).r + staticSwitch92 ) ) ) * saturate( pow( tex2D( _FXT_Mask01, uv_FXT_Mask01 ).r , _Mask_Val ) ) ) );
			float4 lerpResult113 = lerp( _Emi_Lerp_Color_A , _Emi_Lerp_Color_B , temp_output_71_0);
			o.Alpha = ( i.vertexColor.a * lerpResult113 * temp_output_71_0 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1209;711;800.0992;662.5349;2.106819;True;False
Node;AmplifyShaderEditor.CommentaryNode;69;-2462.767,-788.4642;Inherit;False;1372.606;516.9355;UV_Noise;9;37;36;38;34;35;30;33;32;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2412.767,-387.5287;Float;False;Property;_Noise_VPanner;Noise_VPanner;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2412.767,-468.5285;Float;False;Property;_Noise_UPanner;Noise_UPanner;20;0;Create;True;0;0;0;False;0;False;-0.15;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-2239.767,-475.5284;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-2319.298,-738.4642;Inherit;True;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;35;-2082.299,-650.4642;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;30;-1922.999,-641.0643;Inherit;True;Property;_Noise_Texture;Noise_Texture;17;0;Create;True;0;0;0;False;0;False;-1;None;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;70;-1080.544,-741.2458;Inherit;False;1959.292;591.2757;Main;13;66;67;65;68;21;22;23;25;29;28;26;27;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1681.673,-444.5044;Float;False;Property;_Noise_Val;Noise_Val;19;0;Create;True;0;0;0;False;0;False;0;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;33;-1616.999,-638.0643;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-915.5939,-278.9701;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-915.5939,-359.9702;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;0;False;0;False;-0.15;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1030.544,-525.9474;Inherit;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1325.161,-582.0628;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-742.594,-366.9702;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-809.9745,-593.7151;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;25;-572.5363,-515.0197;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1233.571,-97.3922;Inherit;False;1471.854;438.4681;Sword;8;16;19;20;1;4;18;3;90;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;49;-1072.659,394.5561;Inherit;False;1285.005;501.9355;Dissolve;10;44;43;42;41;40;39;46;45;92;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;21;-327.9235,-546.5479;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;94;-1079.788,-1455.485;Inherit;False;1943.922;682.3606;EMI;14;73;77;91;75;74;76;78;80;79;81;83;82;98;115;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1022.659,700.4918;Float;False;Property;_Diss_UPanner;Diss_UPanner;15;0;Create;True;0;0;0;False;0;False;-0.15;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1022.659,780.4916;Float;False;Property;_Diss_VPanner;Diss_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1179.571,75.80066;Float;False;Property;_Sword_UOffset;Sword_UOffset;11;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;89;-2340.736,689.477;Inherit;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;111;368.7301,-60.94525;Float;False;Constant;_Float3;Float 3;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;514.7299,-153.9452;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;1261.622,268.2838;Float;False;Constant;_Float2;Float 2;25;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;90;-908.4787,129.2254;Float;False;Property;_Use_Custom;Use_Custom;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-753.6591,705.4918;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-942.522,-1124.433;Float;True;Property;_Emi_Offset;Emi_Offset;6;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-1029.788,-1404.461;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-909.1906,444.5561;Inherit;True;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;77;-822.667,-1401.793;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-566.1426,-1046.396;Float;True;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-680.5713,107.8007;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-843.1429,-47.3922;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;44;-680.1899,499.5561;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-615.4809,694.8218;Float;False;Property;_Dissolve;Dissolve;14;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;59;-1373.209,916.9092;Inherit;False;1575.824;855.3057;Mask;8;58;56;57;55;54;53;50;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;1315.622,-5.716114;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;106;1706.622,-15.71611;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-502.218,-15.08401;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;64;-937.5176,1433.792;Inherit;False;858.7072;309.5375;텍스쳐로 마스크 주는법;3;62;63;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;39;-481.5175,471.3387;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;13;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-639.1062,-1404.559;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-314.574,722.8356;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-877.9522,1497.102;Inherit;True;Property;_FXT_Mask01;FXT_Mask01;24;0;Create;True;0;0;0;False;0;False;-1;371833fbab316d14f80a74792f0fdeca;371833fbab316d14f80a74792f0fdeca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;108;1920.622,28.28389;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;76;-445.7938,-1405.485;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-649.4084,1317.509;Float;False;Property;_Mask_Val;Mask_Val;18;0;Create;True;0;0;0;False;0;False;3;1.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-274.6016,-14.0903;Inherit;True;Property;_Sword_Texture;Sword_Texture;10;0;Create;True;0;0;0;False;0;False;-1;fbd881075d1df3b41ae412d200105292;9a86b758588118b4ebe7c6e6f64a0aa8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-249.3285,202.4925;Float;False;Property;_Opacity;Opacity;12;0;Create;True;0;0;0;False;0;False;1;3.25;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-189.6112,503.2491;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;62;-516.2556,1502.639;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-136.5228,-1123.397;Float;False;Property;_Emi_Ins;Emi_Ins;22;0;Create;True;0;0;0;False;0;False;12;1;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;3.282366,73.07593;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;103;-4.082703,473.8614;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-265.4782,-1402.245;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-264.8203,-1146.909;Float;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;19.78792,-297.978;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;0;False;0;False;0;2.94;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;98;41.08551,-1005.44;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;79;-52.67994,-1400.048;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;210.6032,73.40817;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;63;-267.2447,1501.749;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;65;129.627,-523.4651;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;291.6955,-289.6746;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;0;False;0;False;0;1.38;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;406.1169,-510.6048;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;115;353.3177,-1119.789;Float;False;Property;_Color0;Color 0;7;1;[HDR];Create;True;0;0;0;False;0;False;0.2450042,0.9058824,0.2196078,0;0.4991342,2.118547,0.432583,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;199.4155,-1402.683;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;23;334.2344,-691.2458;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.3446487,0.7229218,1.605559,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;410.5873,74.54524;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;639.7473,-563.4088;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;575.2454,-1402.993;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;84;562.1282,563.5415;Float;False;Property;_Emi_Lerp_Color_B;Emi_Lerp_Color_B;9;1;[HDR];Create;True;0;0;0;False;0;False;0.1623798,0.7381574,0.8396226,0;0.4991342,2.118547,0.432583,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;71;617.9805,73.60535;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;112;563.3982,369.76;Float;False;Property;_Emi_Lerp_Color_A;Emi_Lerp_Color_A;8;1;[HDR];Create;True;0;0;0;False;0;False;0.2450042,0.9058824,0.2196078,0;0.4991342,2.118547,0.432583,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;113;859.553,135.5524;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;903.84,-1069.796;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;95;889.3226,-588.1505;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;1078.323,-769.1505;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-638.2086,1100.909;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-847.2084,1085.909;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;1105.323,-357.1505;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;50;-1258.209,1035.909;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;53;-1029.208,1154.909;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;257.0023,702.3399;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;56;-441.2085,1100.909;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;58;-206.2083,1102.909;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1370.653,-644.4121;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablen_Sword_Toon_Lerp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;37;0
WireConnection;38;1;36;0
WireConnection;35;0;34;0
WireConnection;35;2;38;0
WireConnection;30;1;35;0
WireConnection;33;0;30;0
WireConnection;31;0;33;0
WireConnection;31;1;32;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;29;0;31;0
WireConnection;29;1;24;0
WireConnection;25;0;29;0
WireConnection;25;2;28;0
WireConnection;21;1;25;0
WireConnection;110;0;21;1
WireConnection;110;1;111;0
WireConnection;90;1;16;0
WireConnection;90;0;89;1
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;77;0;73;1
WireConnection;91;1;75;0
WireConnection;91;0;89;3
WireConnection;18;0;90;0
WireConnection;44;0;43;0
WireConnection;44;2;42;0
WireConnection;107;0;110;0
WireConnection;107;1;109;0
WireConnection;106;0;107;0
WireConnection;4;0;3;0
WireConnection;4;2;18;0
WireConnection;39;1;44;0
WireConnection;74;0;77;0
WireConnection;74;1;91;0
WireConnection;92;1;46;0
WireConnection;92;0;89;2
WireConnection;108;0;106;0
WireConnection;108;1;109;0
WireConnection;76;0;74;0
WireConnection;1;1;4;0
WireConnection;45;0;39;1
WireConnection;45;1;92;0
WireConnection;62;0;61;1
WireConnection;62;1;57;0
WireConnection;19;0;1;1
WireConnection;19;1;20;0
WireConnection;103;1;45;0
WireConnection;78;0;76;0
WireConnection;78;1;108;0
WireConnection;98;1;82;0
WireConnection;98;0;89;4
WireConnection;79;0;78;0
WireConnection;79;1;80;0
WireConnection;48;0;19;0
WireConnection;48;1;103;0
WireConnection;63;0;62;0
WireConnection;65;0;108;0
WireConnection;65;1;68;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;81;0;79;0
WireConnection;81;1;98;0
WireConnection;60;0;48;0
WireConnection;60;1;63;0
WireConnection;22;0;23;0
WireConnection;22;1;66;0
WireConnection;83;0;81;0
WireConnection;83;1;115;0
WireConnection;71;0;60;0
WireConnection;113;0;112;0
WireConnection;113;1;84;0
WireConnection;113;2;71;0
WireConnection;85;0;83;0
WireConnection;85;1;22;0
WireConnection;96;0;85;0
WireConnection;96;1;95;0
WireConnection;55;0;54;0
WireConnection;54;0;50;1
WireConnection;54;1;53;0
WireConnection;97;0;95;4
WireConnection;97;1;113;0
WireConnection;97;2;71;0
WireConnection;53;0;50;1
WireConnection;56;0;55;0
WireConnection;56;1;57;0
WireConnection;58;0;56;0
WireConnection;0;2;96;0
WireConnection;0;9;97;0
ASEEND*/
//CHKSM=2027373BA6F4E2E2B0A8CF19844676F8A8919D03