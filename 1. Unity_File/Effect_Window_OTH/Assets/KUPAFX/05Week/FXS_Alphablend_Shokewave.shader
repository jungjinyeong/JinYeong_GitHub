// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Shokewave"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
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
		[Toggle(_MASK_ADD_MULTY_ON)] _Mask_Add_Multy("Mask_Add_Multy", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma shader_feature _MASK_ADD_MULTY_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
		};

		uniform float _CullMode;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texture_ST;
		uniform float _Mian_UVPow;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Range;
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
			float2 appendResult6 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult49 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner45 = ( 1.0 * _Time.y * appendResult49 + uv0_Noise_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult63 = (float2(uv0_Main_Texture.x , pow( uv0_Main_Texture.y , _Mian_UVPow )));
			float2 panner3 = ( 1.0 * _Time.y * appendResult6 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner45 ) )).xy * _Noise_Val ) + appendResult63 ));
			float4 tex2DNode1 = tex2D( _Main_Texture, panner3 );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch71 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch71 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _Main_Color * ( pow( tex2DNode1.r , _Main_Pow ) * staticSwitch71 ) ) ).rgb;
			float2 uv0_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float temp_output_17_0 = saturate( pow( tex2D( _Mask_Texture, uv0_Mask_Texture ).r , _Mask_Range ) );
			float2 appendResult59 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner56 = ( 1.0 * _Time.y * appendResult59 + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch72 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch72 = _Dissolve;
			#endif
			#ifdef _MASK_ADD_MULTY_ON
				float staticSwitch77 = ( ( ( ( tex2DNode1.r * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, panner56 ).r + staticSwitch72 ) ) ) + temp_output_17_0 ) * temp_output_17_0 );
			#else
				float staticSwitch77 = temp_output_17_0;
			#endif
			o.Alpha = saturate( ( i.vertexColor.a * staticSwitch77 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
4;-8;1920;1013;210.6653;-334.7627;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;69;-2382.392,-886.0003;Float;False;1369;444.9999;Noise;9;48;47;49;46;45;41;42;44;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2324.392,-591.0004;Float;False;Property;_Noise_VPanner;Noise_VPanner;13;0;Create;True;0;0;False;0;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2332.392,-673.0004;Float;False;Property;_Noise_UPanner;Noise_UPanner;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-2302.392,-836.0004;Float;False;0;41;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;49;-2120.392,-634.0004;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;45;-2038.391,-766.0004;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1813.633,-133.829;Float;False;Property;_Mian_UVPow;Mian_UVPow;6;0;Create;True;0;0;False;0;1.84;0.25;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;67;-1143.47,414.3179;Float;False;1330.868;445.7848;Dissolve;9;58;57;59;56;50;52;51;53;55;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1769.951,-422.4265;Float;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;-1823.39,-772.0004;Float;True;Property;_Noise_Texture;Noise_Texture;10;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;57;-1093.47,641.7181;Float;False;Property;_Diss_UPanner;Diss_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;42;-1517.389,-775.0004;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;61;-1460.389,-235.3328;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1089.47,721.7181;Float;False;Property;_Diss_VPanner;Diss_VPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1573.389,-557.0004;Float;False;Property;_Noise_Val;Noise_Val;11;0;Create;True;0;0;False;0;0;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;63;-1193.623,-400.2291;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-1048.47,464.3179;Float;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1248.389,-745.0004;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1003,-161.5;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-927.4701,662.7181;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1005,-83.5;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;False;0;0.5;0.156;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;-751.47,534.718;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-970.7889,-472.7028;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;28;-913.3305,901.5666;Float;False;1097.737;419.5788;Comment;5;29;12;17;14;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-818,-129.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-674.2447,737.1027;Float;False;Property;_Dissolve;Dissolve;15;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;70;-1067.695,-3.27714;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-690,-327.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-833.6074,957.648;Float;False;0;12;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-535.2007,519.3494;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;14;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;72;-355.7794,791.276;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;68;-425.0151,-14.31448;Float;False;994.3589;312.2493;Opacity;3;10;54;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-199.6017,580.1028;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-479,-418.5;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-546.5563,1143.145;Float;False;Property;_Mask_Range;Mask_Range;9;0;Create;True;0;0;False;0;0;20;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-375.0153,52.68553;Float;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;1;8.87;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-581.3305,951.5665;Float;True;Property;_Mask_Texture;Mask_Texture;8;0;Create;True;0;0;False;0;a2b434f2424cfc145872c7207c36c447;6904366d56281b64b949da6521ac47d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;14;-258.1942,988.4492;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-68.01514,35.68553;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;-10.60173,579.1028;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;137.8476,42.77225;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;-13.59377,984.3652;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-196.8989,-286.3614;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;0;5.68;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-472,-498.5;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;1;2.23;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;464.614,442.109;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;769.1362,660.5598;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;71;154.4908,-211.8253;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-177,-513.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;77;958.1165,943.163;Float;False;Property;_Mask_Add_Multy;Mask_Add_Multy;20;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;64;400.7034,-755.7206;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;75.1011,-640.3613;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.4134617,0.2817394,0.69886,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;126.1011,-465.3614;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;548.8115,-240.2626;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;334.1011,-563.3614;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;39;1164.684,-509.8358;Float;False;1209.298;751.2979;Maks 공부;8;36;37;32;33;38;34;31;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;33;2113.686,6.694061;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1802.408,-216.2809;Float;False;Constant;_Mask_Range_;Mask_Range_;9;0;Create;True;0;0;False;0;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1785.607,-13.53799;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;1214.684,-450.8402;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;34;1410.113,-146.853;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;2120.358,-205.862;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;2413.351,-490.2773;Float;False;Property;_CullMode;CullMode;19;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;75;775.8851,-230.914;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;2118.945,-406.7101;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;621.7034,-680.7206;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1564.607,-12.53799;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;73;-1448.117,198.1531;Float;False;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;942.0999,-510.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Shokewave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;74;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;45;0;46;0
WireConnection;45;2;49;0
WireConnection;41;1;45;0
WireConnection;42;0;41;0
WireConnection;61;0;2;2
WireConnection;61;1;62;0
WireConnection;63;0;2;1
WireConnection;63;1;61;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;59;0;57;0
WireConnection;59;1;58;0
WireConnection;56;0;55;0
WireConnection;56;2;59;0
WireConnection;40;0;43;0
WireConnection;40;1;63;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;3;0;40;0
WireConnection;3;2;6;0
WireConnection;50;1;56;0
WireConnection;72;1;52;0
WireConnection;72;0;70;2
WireConnection;51;0;50;1
WireConnection;51;1;72;0
WireConnection;1;1;3;0
WireConnection;12;1;29;0
WireConnection;14;0;12;1
WireConnection;14;1;20;0
WireConnection;9;0;1;1
WireConnection;9;1;10;0
WireConnection;53;0;51;0
WireConnection;54;0;9;0
WireConnection;54;1;53;0
WireConnection;17;0;14;0
WireConnection;76;0;54;0
WireConnection;76;1;17;0
WireConnection;22;0;76;0
WireConnection;22;1;17;0
WireConnection;71;1;24;0
WireConnection;71;0;70;1
WireConnection;7;0;1;1
WireConnection;7;1;8;0
WireConnection;77;1;17;0
WireConnection;77;0;22;0
WireConnection;23;0;7;0
WireConnection;23;1;71;0
WireConnection;66;0;64;4
WireConnection;66;1;77;0
WireConnection;25;0;27;0
WireConnection;25;1;23;0
WireConnection;33;0;37;0
WireConnection;33;1;38;0
WireConnection;37;0;36;0
WireConnection;34;0;30;2
WireConnection;32;0;34;0
WireConnection;32;1;38;0
WireConnection;75;0;66;0
WireConnection;31;0;30;2
WireConnection;31;1;38;0
WireConnection;65;0;64;0
WireConnection;65;1;25;0
WireConnection;36;0;34;0
WireConnection;36;1;30;2
WireConnection;73;1;62;0
WireConnection;73;0;70;3
WireConnection;0;2;65;0
WireConnection;0;9;75;0
ASEEND*/
//CHKSM=F5AE43DF3C5B2A58E67A1AAAD3AE3CCA437E5ED3