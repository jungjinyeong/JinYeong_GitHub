// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alpablend_Sword"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 0
		_Main_Power("Main_Power", Range( 1 , 10)) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		[HDR]_Emi_Color("Emi_Color", Color) = (0,0,0,0)
		_Emi_Offset("Emi_Offset", Range( -1 , 1)) = 0
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Sword_UOffset("Sword_UOffset", Range( -1 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 10
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 10)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Emi_Ims("Emi_Ims", Range( 0 , 100)) = 10
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_FX_Mask("FX_Mask", Float) = 2
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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

		uniform float4 _Emi_Color;
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
		uniform float _Emi_Ims;
		uniform float4 _Tint_Color;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _Sword_Texture;
		uniform float4 _Sword_Texture_ST;
		uniform float _Sword_UOffset;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float _FX_Mask;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch79 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch79 = _Emi_Offset;
			#endif
			float2 appendResult22 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult32 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner29 = ( 1.0 * _Time.y * appendResult32 + uv0_Noise_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner17 = ( 1.0 * _Time.y * appendResult22 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner29 ) )).xy * _Noise_Val ) + uv0_Main_Texture ));
			float4 tex2DNode12 = tex2D( _Main_Texture, panner17 );
			float4 temp_cast_0 = (2.0).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch84 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch84 = _Emi_Ims;
			#endif
			float4 temp_cast_1 = (_Main_Power).xxxx;
			o.Emission = ( ( ( _Emi_Color * ( pow( ( ( ( 1.0 - i.uv_texcoord.x ) + staticSwitch79 ) * tex2DNode12 ) , temp_cast_0 ) * staticSwitch84 ) ) + ( _Tint_Color * ( pow( tex2DNode12 , temp_cast_1 ) * _Main_Ins ) ) ) * i.vertexColor ).rgb;
			float2 uv0_Sword_Texture = i.uv_texcoord * _Sword_Texture_ST.xy + _Sword_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch77 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch77 = _Sword_UOffset;
			#endif
			float2 appendResult9 = (float2(staticSwitch77 , 0.0));
			float2 appendResult35 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner34 = ( 1.0 * _Time.y * appendResult35 + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch78 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch78 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * ( ( ( tex2D( _Sword_Texture, (uv0_Sword_Texture*1.0 + appendResult9) ).r * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, panner34 ).r + staticSwitch78 ) ) ) * saturate( pow( ( ( i.uv_texcoord.x * ( 1.0 - i.uv_texcoord.x ) ) * 4.0 ) , _FX_Mask ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;2560;1005;2515.109;1937.616;2.050975;True;False
Node;AmplifyShaderEditor.CommentaryNode;60;-2437.615,-1183.712;Float;False;1637.152;490.2354;UV_Offset;9;31;30;32;28;29;23;26;27;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2382.615,-960.4857;Float;False;Property;_Noise_UPanner;Noise_UPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2387.615,-842.4857;Float;False;Property;_Noise_VPanner;Noise_VPanner;19;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-2179.744,-937.1149;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2266.545,-1133.712;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;29;-2014.26,-1100.181;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;23;-1739.484,-1112.589;Float;True;Property;_Noise_Texture;Noise_Texture;15;0;Create;True;0;0;False;0;None;ca13f4c0cd8f4eb4fb22f7b62e6e0d7e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1299.462,-827.4764;Float;False;Property;_Noise_Val;Noise_Val;16;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;61;-941.0464,-865.3352;Float;False;2243.434;829.1787;Main;13;16;18;19;22;24;17;58;12;59;56;57;13;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;27;-1357.787,-1049.07;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;62;-648.7094,-18.09062;Float;False;1421.3;394.2707;Sword;8;8;9;5;6;11;10;3;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;80;-354.7084,-1594.594;Float;False;1986.05;653.816;Emi;13;63;66;64;67;69;71;68;70;73;72;65;79;84;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;44;-692.136,413.2813;Float;False;1572.364;455.5578;Dissolve;10;34;35;38;33;36;37;40;43;39;78;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-592.5439,-521.7969;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1035.463,-947.4766;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-597.5439,-403.797;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-671.4099,-727.834;Float;False;0;12;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-639.7846,168.9389;Float;False;Property;_Sword_UOffset;Sword_UOffset;9;0;Create;True;0;0;False;0;0;-0.225;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-255.0372,-1345.507;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;65;-304.7084,-1173.7;Float;False;Property;_Emi_Offset;Emi_Offset;7;0;Create;True;0;0;False;0;0;0.01;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-301.6896,-507.5116;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-642.136,752.8391;Float;False;Property;_Diss_VPanner;Diss_VPanner;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-637.136,636.5077;Float;False;Property;_Diss_UPanner;Diss_UPanner;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-371.4552,-746.1721;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;55;-688.8815,907.783;Float;False;1574.266;475.9933;Mask;7;47;50;52;45;48;49;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;75;-1829.239,-103.2174;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-521.066,463.2813;Float;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;66;52.10309,-1303.462;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;79;3.371173,-1162.407;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;17;-113.7999,-558.4897;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;-434.265,659.8784;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-638.8815,957.783;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;77;-358.0089,234.5263;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;34;-268.781,496.8126;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;268.1442,-1327.692;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;122.949,-582.5925;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;None;61924d2b51e42a74bb4f6ccd3f594277;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;9;-115.7965,242.3537;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-13.25883,684.8521;Float;False;Property;_Dissolve;Dissolve;12;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-365.385,44.99886;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;47;-387.1845,1129.776;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;615.7006,-1023.962;Float;False;Property;_Emi_Ims;Emi_Ims;18;0;Create;True;0;0;False;0;10;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;78;226.1282,773.2793;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-35.46258,487.9382;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;11;0;Create;True;0;0;False;0;None;f5b5dc88cfafbeb4d873a97f5ce54184;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;537.9428,-1333.334;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;123.7182,-372.707;Float;True;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;False;0;1;1.73;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-143.3105,978.2321;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;6;-42.38492,47.70081;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;69;610.3414,-1114.643;Float;False;Constant;_Float1;Float 1;17;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;135.5001,974.7239;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;167.3287,31.90938;Float;True;Property;_Sword_Texture;Sword_Texture;8;0;Create;True;0;0;False;0;7b081e079f7aa9c43b1de5daf2815f96;7b081e079f7aa9c43b1de5daf2815f96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;84;918.2234,-1047.493;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;806.133,-1334.905;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;51;175.1693,1244.76;Float;False;Property;_FX_Mask;FX_Mask;20;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;204.2909,252.1801;Float;False;Property;_Opacity;Opacity;10;0;Create;True;0;0;False;0;10;1.09;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;453.1351,-159.204;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;0;1.3;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;372.0187,485.4763;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;56;483.5374,-377.6383;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;766.9282,-365.3056;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;13;758.6754,-575.9459;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.949143,0.2086658,1.662455,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;43;682.2281,487.4833;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;523.2538,49.38008;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;1139.546,-1332.704;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;50;406.8477,972.185;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;73;1149.504,-1544.594;Float;False;Property;_Emi_Color;Emi_Color;6;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.976675,1.490268,0.2483779,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;933.9543,39.93671;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;1396.342,-1327.346;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;1002.2,-366.6712;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;52;687.3849,972.228;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1282.556,39.60078;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;1723.265,-713.2429;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;81;1707.049,-374.5796;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;2027.118,-495.9127;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;2025.026,-134.0054;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;2418.518,-442.2401;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alpablend_Sword;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;29;0;28;0
WireConnection;29;2;32;0
WireConnection;23;1;29;0
WireConnection;27;0;23;0
WireConnection;25;0;27;0
WireConnection;25;1;26;0
WireConnection;22;0;18;0
WireConnection;22;1;19;0
WireConnection;24;0;25;0
WireConnection;24;1;16;0
WireConnection;66;0;63;1
WireConnection;79;1;65;0
WireConnection;79;0;75;3
WireConnection;17;0;24;0
WireConnection;17;2;22;0
WireConnection;35;0;36;0
WireConnection;35;1;37;0
WireConnection;77;1;8;0
WireConnection;77;0;75;1
WireConnection;34;0;38;0
WireConnection;34;2;35;0
WireConnection;64;0;66;0
WireConnection;64;1;79;0
WireConnection;12;1;17;0
WireConnection;9;0;77;0
WireConnection;47;0;45;1
WireConnection;78;1;40;0
WireConnection;78;0;75;2
WireConnection;33;1;34;0
WireConnection;67;0;64;0
WireConnection;67;1;12;0
WireConnection;48;0;45;1
WireConnection;48;1;47;0
WireConnection;6;0;5;0
WireConnection;6;2;9;0
WireConnection;49;0;48;0
WireConnection;3;1;6;0
WireConnection;84;1;71;0
WireConnection;84;0;75;4
WireConnection;68;0;67;0
WireConnection;68;1;69;0
WireConnection;39;0;33;1
WireConnection;39;1;78;0
WireConnection;56;0;12;0
WireConnection;56;1;58;0
WireConnection;57;0;56;0
WireConnection;57;1;59;0
WireConnection;43;0;39;0
WireConnection;10;0;3;1
WireConnection;10;1;11;0
WireConnection;70;0;68;0
WireConnection;70;1;84;0
WireConnection;50;0;49;0
WireConnection;50;1;51;0
WireConnection;41;0;10;0
WireConnection;41;1;43;0
WireConnection;72;0;73;0
WireConnection;72;1;70;0
WireConnection;15;0;13;0
WireConnection;15;1;57;0
WireConnection;52;0;50;0
WireConnection;53;0;41;0
WireConnection;53;1;52;0
WireConnection;74;0;72;0
WireConnection;74;1;15;0
WireConnection;82;0;74;0
WireConnection;82;1;81;0
WireConnection;83;0;81;4
WireConnection;83;1;53;0
WireConnection;2;2;82;0
WireConnection;2;9;83;0
ASEEND*/
//CHKSM=D2C6EE35DE20DDDB277DEE29EEEB53820AEA6E8E