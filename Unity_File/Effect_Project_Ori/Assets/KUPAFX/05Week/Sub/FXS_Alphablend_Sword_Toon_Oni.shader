// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablen_Sword_Toon_Oni"
{
	Properties
	{
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Emi_Offset("Emi_Offset", Range( -1 , 1)) = 0
		[HDR]_Emi_Color("Emi_Color", Color) = (0,0,0,0)
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Diss_UPanner("Diss_UPanner", Float) = -0.15
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 10)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = -0.15
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Emi_Ins("Emi_Ins", Range( 1 , 100)) = 12
		_FXT_Sword_Oni("FXT_Sword_Oni", 2D) = "white" {}
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Sword_Offset("Sword_Offset", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _Emi_Offset;
		uniform float _Emi_Ins;
		uniform float4 _Emi_Color;
		uniform float4 _Tint_Color;
		uniform sampler2D _FXT_Sword_Oni;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float _Sword_Offset;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch91 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch91 = _Emi_Offset;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch98 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch98 = _Emi_Ins;
			#endif
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner35 = ( 1.0 * _Time.y * appendResult38 + uv0_Noise_Texture);
			float2 appendResult116 = (float2(_Sword_Offset , 0.0));
			float4 tex2DNode112 = tex2D( _FXT_Sword_Oni, (( i.uv_texcoord + ( (UnpackNormal( tex2D( _Noise_Texture, panner35 ) )).xy * _Noise_Val ) )*1.0 + appendResult116) );
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( ( ( ( pow( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) + staticSwitch91 ) ) * 0.0 ) , 3.0 ) * staticSwitch98 ) * _Emi_Color ) + ( _Tint_Color * ( pow( tex2DNode112 , temp_cast_0 ) * _Main_Ins ) ) ) * i.vertexColor ).rgb;
			float2 appendResult42 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner44 = ( 1.0 * _Time.y * appendResult42 + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch92 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch92 = _Dissolve;
			#endif
			float temp_output_48_0 = ( ( tex2DNode112.a * _Opacity ) * step( 0.0 , ( tex2D( _Dissolve_Texture, panner44 ).r + staticSwitch92 ) ) );
			o.Alpha = ( i.vertexColor.a * saturate( temp_output_48_0 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;1244.335;1254.979;1.868037;True;False
Node;AmplifyShaderEditor.CommentaryNode;69;-1847.712,-692.0383;Float;False;1372.606;516.9355;UV_Noise;9;37;36;38;34;35;30;33;32;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1797.712,-291.1029;Float;False;Property;_Noise_VPanner;Noise_VPanner;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1797.712,-372.1027;Float;False;Property;_Noise_UPanner;Noise_UPanner;14;0;Create;True;0;0;False;0;-0.15;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-1624.712,-379.1026;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1704.243,-642.0383;Float;True;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;35;-1467.244,-554.0383;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;94;-1079.788,-1455.485;Float;False;1943.922;682.3606;EMI;15;73;77;91;75;74;76;78;80;79;81;83;84;82;85;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;30;-1283.945,-546.6384;Float;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;False;0;291b26790b4e30e43b6347b381849af8;291b26790b4e30e43b6347b381849af8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;33;-1001.945,-541.6384;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1066.619,-348.0786;Float;False;Property;_Noise_Val;Noise_Val;13;0;Create;True;0;0;False;0;0;0.1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;49;-1072.659,394.5561;Float;False;1285.005;501.9355;Dissolve;10;44;43;42;41;40;39;46;45;92;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-1029.788,-1404.461;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;89;-2340.736,689.477;Float;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;-942.522,-1124.433;Float;True;Property;_Emi_Offset;Emi_Offset;3;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1022.659,700.4918;Float;False;Property;_Diss_UPanner;Diss_UPanner;10;0;Create;True;0;0;False;0;-0.15;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1022.659,780.4916;Float;False;Property;_Diss_VPanner;Diss_VPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;77;-822.667,-1401.793;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-566.1426,-1046.396;Float;True;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-739.2919,-438.2081;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;113;-737.0293,-652.1198;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;117;-690.6945,-217.1492;Float;False;Property;_Sword_Offset;Sword_Offset;20;0;Create;True;0;0;False;0;0;-0.1176475;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;114;-485.2917,-636.3102;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;116;-438.3937,-222.1206;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-909.1906,444.5561;Float;True;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-639.1062,-1404.559;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-753.6591,705.4918;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;76;-445.7938,-1405.485;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-600.2247,719.2061;Float;False;Property;_Dissolve;Dissolve;9;0;Create;True;0;0;False;0;1;0.894;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;115;-387.4364,-398.6069;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;44;-680.1899,499.5561;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;70;-370.4163,-740.7635;Float;False;1231.014;573.1254;Main;7;67;66;65;68;112;22;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-240.4156,-289.4957;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;4.99;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-136.5228,-1123.397;Float;False;Property;_Emi_Ins;Emi_Ins;16;0;Create;True;0;0;False;0;12;1;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-265.4782,-1402.245;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-264.8203,-1146.909;Float;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-278.574,725.8356;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-481.5175,471.3387;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;8;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;112;-318.7704,-614.1028;Float;True;Property;_FXT_Sword_Oni;FXT_Sword_Oni;18;0;Create;True;0;0;False;0;70fd1b4d776734a44b323ca1376cf8ee;70fd1b4d776734a44b323ca1376cf8ee;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;79;-52.67994,-1400.048;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;123.2468,-299.7599;Float;False;Property;_Main_Ins;Main_Ins;1;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-125.6112,493.2491;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;65;-2.499286,-580.5764;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;98;41.08551,-1005.44;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;205.5018,147.7669;Float;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;1;4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;625.9377,9.837523;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;84;292.9839,-1160.483;Float;False;Property;_Emi_Color;Emi_Color;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;6.853151,6.853151,6.853151,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;199.4155,-1402.683;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;329.9874,-596.2322;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;103;95.83863,477.564;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;23;478.4527,-348.9571;Float;False;Property;_Tint_Color;Tint_Color;0;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;833.259,10.16977;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;443.4373,-1392.742;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;592.6974,-624.8926;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;59;-1373.209,916.9092;Float;False;1575.824;855.3057;Mask;8;58;56;57;55;54;53;50;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;629.1343,-1027.124;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;72;-1233.571,-97.3922;Float;False;1471.854;438.4681;Sword;6;16;1;4;18;3;90;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;95;1255.854,-663.0767;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;64;-937.5176,1433.792;Float;False;858.7072;309.5375;텍스쳐로 마스크 주는법;3;62;63;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;71;1224.994,3.850022;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;1020.209,391.8949;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;56;-441.2085,1100.909;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-877.9522,1497.102;Float;True;Property;_FXT_Mask01;FXT_Mask01;17;0;Create;True;0;0;False;0;371833fbab316d14f80a74792f0fdeca;371833fbab316d14f80a74792f0fdeca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;62;-516.2556,1502.639;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;58;-206.2083,1102.909;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-630.2086,1315.909;Float;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-680.5713,107.8007;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-274.6016,-14.0903;Float;True;Property;_Sword_Texture;Sword_Texture;5;0;Create;True;0;0;False;0;fbd881075d1df3b41ae412d200105292;430126df2426ab64d94087a5a9e18c81;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;63;-267.2447,1501.749;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-638.2086,1100.909;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-847.2084,1085.909;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-843.1429,-47.3922;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;53;-1029.208,1154.909;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;1646.756,-445.8503;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;50;-1258.209,1035.909;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;90;-908.4787,129.2254;Float;False;Property;_Use_Custom;Use_Custom;17;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;1693.934,-805.601;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-502.218,-15.08401;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-601.2085,-123.9346;Float;False;Constant;_Float3;Float 3;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1179.571,75.80066;Float;False;Property;_Sword_UOffset;Sword_UOffset;6;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2008.539,-717.3134;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablen_Sword_Toon_Oni;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;37;0
WireConnection;38;1;36;0
WireConnection;35;0;34;0
WireConnection;35;2;38;0
WireConnection;30;1;35;0
WireConnection;33;0;30;0
WireConnection;77;0;73;1
WireConnection;91;1;75;0
WireConnection;91;0;89;3
WireConnection;31;0;33;0
WireConnection;31;1;32;0
WireConnection;114;0;113;0
WireConnection;114;1;31;0
WireConnection;116;0;117;0
WireConnection;74;0;77;0
WireConnection;74;1;91;0
WireConnection;42;0;41;0
WireConnection;42;1;40;0
WireConnection;76;0;74;0
WireConnection;115;0;114;0
WireConnection;115;2;116;0
WireConnection;44;0;43;0
WireConnection;44;2;42;0
WireConnection;78;0;76;0
WireConnection;92;1;46;0
WireConnection;92;0;89;2
WireConnection;39;1;44;0
WireConnection;112;1;115;0
WireConnection;79;0;78;0
WireConnection;79;1;80;0
WireConnection;45;0;39;1
WireConnection;45;1;92;0
WireConnection;65;0;112;0
WireConnection;65;1;68;0
WireConnection;98;1;82;0
WireConnection;98;0;89;4
WireConnection;19;0;112;4
WireConnection;19;1;20;0
WireConnection;81;0;79;0
WireConnection;81;1;98;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;103;1;45;0
WireConnection;48;0;19;0
WireConnection;48;1;103;0
WireConnection;83;0;81;0
WireConnection;83;1;84;0
WireConnection;22;0;23;0
WireConnection;22;1;66;0
WireConnection;85;0;83;0
WireConnection;85;1;22;0
WireConnection;71;0;48;0
WireConnection;60;0;48;0
WireConnection;60;1;58;0
WireConnection;56;0;55;0
WireConnection;56;1;57;0
WireConnection;62;0;61;1
WireConnection;62;1;57;0
WireConnection;58;0;56;0
WireConnection;18;0;90;0
WireConnection;1;1;4;0
WireConnection;63;0;62;0
WireConnection;55;0;54;0
WireConnection;54;0;50;1
WireConnection;54;1;53;0
WireConnection;53;0;50;1
WireConnection;97;0;95;4
WireConnection;97;1;71;0
WireConnection;90;1;16;0
WireConnection;90;0;89;1
WireConnection;96;0;85;0
WireConnection;96;1;95;0
WireConnection;4;0;3;0
WireConnection;4;2;18;0
WireConnection;0;2;96;0
WireConnection;0;9;97;0
ASEEND*/
//CHKSM=AFA741E50E03FA12998ED92392F60AD1285D3CEB