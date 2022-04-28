// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Gra_Shokwave_04"
{
	Properties
	{
		_Gra_Texture("Gra_Texture", 2D) = "white" {}
		_Gra_Offset("Gra_Offset", Range( -1 , 1)) = 0
		_Gra_Ins("Gra_Ins", Range( 1 , 10)) = 0
		_Gra_Pow("Gra_Pow", Range( 1 , 20)) = 1
		[HDR]_Gra_Color("Gra_Color", Color) = (1,1,1,0)
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_Sub_Color("Sub_Color", Color) = (1,1,1,0)
		_Sub_Ins("Sub_Ins", Range( 0 , 20)) = 0
		_Sub_Pow("Sub_Pow", Range( 1 , 10)) = 1
		_Sub_VPanner("Sub_VPanner", Float) = 0
		_Sub_UPanner("Sub_UPanner", Float) = 0
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Ins("Mask_Ins", Float) = 1
		_Mask_Pow("Mask_Pow", Float) = 5.41
		_Mask_UPanner("Mask_UPanner", Float) = 1
		_Mask_VPanner("Mask_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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

		uniform float _CullMode;
		uniform sampler2D _Sub_Texture;
		uniform float _Sub_UPanner;
		uniform float _Sub_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _Gra_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Gra_Texture_ST;
		uniform float _Gra_Offset;
		uniform float _Gra_Pow;
		uniform float _Gra_Ins;
		uniform float4 _Gra_Color;
		uniform sampler2D _Mask_Texture;
		uniform float _Mask_UPanner;
		uniform float _Mask_VPanner;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Ins;
		uniform float _Mask_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult57 = (float2(_Sub_UPanner , _Sub_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner54 = ( 1.0 * _Time.y * appendResult57 + uv0_Sub_Texture);
			float2 appendResult26 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult26 + uv0_Noise_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch61 = i.uv_tex4coord.w;
			#else
				float staticSwitch61 = _Noise_Val;
			#endif
			float2 uv0_Gra_Texture = i.uv_texcoord * _Gra_Texture_ST.xy + _Gra_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch60 = i.uv_tex4coord.z;
			#else
				float staticSwitch60 = _Gra_Offset;
			#endif
			float2 appendResult7 = (float2(0.0 , staticSwitch60));
			float4 tex2DNode1 = tex2D( _Gra_Texture, (( ( (UnpackNormal( tex2D( _Noise_Texture, panner23 ) )).xy * staticSwitch61 ) + uv0_Gra_Texture )*1.0 + appendResult7) );
			float4 temp_cast_0 = (_Gra_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner54 ).r , _Sub_Pow ) * _Sub_Ins ) * _Sub_Color ) + tex2DNode1.r ) * tex2DNode1.r ) , temp_cast_0 ) * _Gra_Ins ) * _Gra_Color ) ).rgb;
			float2 appendResult70 = (float2(_Mask_UPanner , _Mask_VPanner));
			float2 uv0_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float2 panner66 = ( 1.0 * _Time.y * appendResult70 + uv0_Mask_Texture);
			o.Alpha = ( i.vertexColor.a * ( tex2D( _Mask_Texture, panner66 ) * pow( saturate( ( ( ( uv0_Mask_Texture.y * 1.0 ) * ( 1.0 - uv0_Mask_Texture.y ) * _Mask_Ins ) * 4.0 ) ) , _Mask_Pow ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;2444.667;-802.6705;1.839855;True;False
Node;AmplifyShaderEditor.RangedFloatNode;25;-3348.148,-141.8199;Float;False;Property;_Noise_VPanner;Noise_VPanner;8;0;Create;True;0;0;False;0;0;-0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-3348.146,-238.0198;Float;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3123.245,-483.72;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-3123.248,-245.8198;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-2781.347,-449.9199;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-3089.513,-762.7437;Float;False;Property;_Sub_UPanner;Sub_UPanner;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-3105.183,-681.7786;Float;False;Property;_Sub_VPanner;Sub_VPanner;14;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-3022.912,-958.6276;Float;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;59;-2652.14,74.05206;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-2533.164,-224.0765;Float;False;Property;_Noise_Val;Noise_Val;7;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-2909.3,-760.132;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;-2531.748,-462.9204;Float;True;Property;_Noise_Texture;Noise_Texture;6;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;61;-2162.297,-223.5867;Float;False;Property;_Use_Custom;Use_Custom;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2273.461,172.0562;Float;False;Property;_Gra_Offset;Gra_Offset;2;0;Create;True;0;0;False;0;0;0.32;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;-2166.448,-460.3203;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;54;-2669.016,-915.5329;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;43;-2303.835,-894.2932;Float;True;Property;_Sub_Texture;Sub_Texture;10;0;Create;True;0;0;False;0;None;5e4d5add93f992a418137beb6013c2ec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1836.248,-448.6198;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-2281.152,-670.6713;Float;False;Property;_Sub_Pow;Sub_Pow;13;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1829.129,135.0562;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;60;-1974.483,312.0396;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1930.129,-104.9438;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1560.129,150.0562;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1601.332,-123.0379;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;44;-1925.445,-890.5652;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1968.423,-667.3661;Float;False;Property;_Sub_Ins;Sub_Ins;12;0;Create;True;0;0;False;0;0;1.4;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-903.71,1883.108;Float;False;Constant;_Float2;Float 2;24;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;64;-1229.023,1540.114;Float;False;0;65;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1612.164,-881.8837;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;49;-1605.07,-648.4896;Float;False;Property;_Sub_Color;Sub_Color;11;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.221192,4.491502,0.9935119,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-1351.129,-22.94382;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1328.164,-882.8837;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;77;-923.7104,2078.207;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-752.8419,1849.99;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-726.6324,2372.096;Float;False;Property;_Mask_Ins;Mask_Ins;17;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1134.867,-35.74114;Float;True;Property;_Gra_Texture;Gra_Texture;1;0;Create;True;0;0;False;0;1f7bfb2ae7e94e345b708a040e18d5ea;bf7680e5aec3acf49a734b4f6bb6160c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-535.6293,2096.565;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1363.615,1893.08;Float;False;Property;_Mask_VPanner;Mask_VPanner;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1367.904,1764.396;Float;False;Property;_Mask_UPanner;Mask_UPanner;19;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-852.6021,-435.791;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-279.1577,2097.928;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-688.9665,-24.73421;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-723.0547,219.9654;Float;False;Property;_Gra_Pow;Gra_Pow;4;0;Create;True;0;0;False;0;1;2;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;70;-1140.562,1815.87;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;66;-649.4183,1547.778;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-21.22289,2348.755;Float;False;Property;_Mask_Pow;Mask_Pow;18;0;Create;True;0;0;False;0;5.41;3.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;80;-5.860804,2091.012;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-354.1643,11.88372;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-407.491,281.4837;Float;False;Property;_Gra_Ins;Gra_Ins;3;0;Create;True;0;0;False;0;0;1.68;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;75;192.6033,2089.319;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-84.49103,17.48373;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;65;-364.1691,1539.199;Float;True;Property;_Mask_Texture;Mask_Texture;16;0;Create;True;0;0;False;0;c7d564bbc661feb448e7dcb86e2aa438;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-100.7945,268.3624;Float;False;Property;_Gra_Color;Gra_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.1683873,0.8301887,0.3962206,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;42;-1634.526,562.3415;Float;False;1793.199;875.8582;Mask;1;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;15;205.3867,-215.8946;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;148.5089,6.483727;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;291.2144,1596.242;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-1127.376,612.3415;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1298.21,807.448;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;-353.0885,622.4626;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;-39.32531,1003.702;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-645.5518,855.7322;Float;False;Constant;_Mask_Pow_1;Mask_Pow_1;10;0;Create;True;0;0;False;0;8;9.750306;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-641.5481,1014.101;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1590.167,859.2838;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;512.2132,290.8541;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;63;-1316.254,1138.769;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;38;-342.9672,1000.328;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1037.103,14.26195;Float;False;Property;_CullMode;CullMode;22;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;34;-41.01229,625.8364;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1131.474,1009.886;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-619.6186,614.0281;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;31;-854.0974,614.0281;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;470.1803,-7.228267;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;62;-860.4623,1007.428;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;803.2681,11.39092;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Gra_Shokwave_04;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;58;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;23;0;20;0
WireConnection;23;2;26;0
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;18;1;23;0
WireConnection;61;1;22;0
WireConnection;61;0;59;4
WireConnection;19;0;18;0
WireConnection;54;0;53;0
WireConnection;54;2;57;0
WireConnection;43;1;54;0
WireConnection;21;0;19;0
WireConnection;21;1;61;0
WireConnection;60;1;6;0
WireConnection;60;0;59;3
WireConnection;7;0;8;0
WireConnection;7;1;60;0
WireConnection;17;0;21;0
WireConnection;17;1;3;0
WireConnection;44;0;43;1
WireConnection;44;1;45;0
WireConnection;46;0;44;0
WireConnection;46;1;47;0
WireConnection;4;0;17;0
WireConnection;4;2;7;0
WireConnection;48;0;46;0
WireConnection;48;1;49;0
WireConnection;77;0;64;2
WireConnection;81;0;64;2
WireConnection;81;1;82;0
WireConnection;1;1;4;0
WireConnection;78;0;81;0
WireConnection;78;1;77;0
WireConnection;78;2;72;0
WireConnection;50;0;48;0
WireConnection;50;1;1;1
WireConnection;83;0;78;0
WireConnection;51;0;50;0
WireConnection;51;1;1;1
WireConnection;70;0;67;0
WireConnection;70;1;68;0
WireConnection;66;0;64;0
WireConnection;66;2;70;0
WireConnection;80;0;83;0
WireConnection;9;0;51;0
WireConnection;9;1;12;0
WireConnection;75;0;80;0
WireConnection;75;1;76;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;65;1;66;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;73;0;65;0
WireConnection;73;1;75;0
WireConnection;29;0;27;2
WireConnection;29;1;30;0
WireConnection;32;0;28;0
WireConnection;32;1;33;0
WireConnection;40;0;38;0
WireConnection;37;0;62;0
WireConnection;41;0;15;4
WireConnection;41;1;73;0
WireConnection;63;0;27;2
WireConnection;38;0;37;0
WireConnection;38;1;33;0
WireConnection;34;0;32;0
WireConnection;36;0;27;2
WireConnection;36;1;63;0
WireConnection;28;0;31;0
WireConnection;31;0;29;0
WireConnection;16;0;15;0
WireConnection;16;1;11;0
WireConnection;62;0;36;0
WireConnection;0;2;16;0
WireConnection;0;9;41;0
ASEEND*/
//CHKSM=BCA777F62A9BCB59F6C0E3975BF45905E4589856