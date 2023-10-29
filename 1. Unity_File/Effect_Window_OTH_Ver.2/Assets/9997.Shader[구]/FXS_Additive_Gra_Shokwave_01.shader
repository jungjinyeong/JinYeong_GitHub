// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Gra_Shokwave_01"
{
	Properties
	{
		_Gra_Texture("Gra_Texture", 2D) = "white" {}
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
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 0
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
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_Val;
		uniform float _Mask_Pow;

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
			float2 appendResult26 = (float2(_Noise_UPanner , _Noise_VPanner));
			float4 uvs_Noise_Texture = i.uv_texcoord;
			uvs_Noise_Texture.xy = i.uv_texcoord.xy * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult26 + uvs_Noise_Texture.xy);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch61 = i.uv_texcoord.w;
			#else
				float staticSwitch61 = _Noise_Val;
			#endif
			float4 uvs_Gra_Texture = i.uv_texcoord;
			uvs_Gra_Texture.xy = i.uv_texcoord.xy * _Gra_Texture_ST.xy + _Gra_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch60 = i.uv_texcoord.z;
			#else
				float staticSwitch60 = _Gra_Offset;
			#endif
			float2 appendResult7 = (float2(0.0 , staticSwitch60));
			float4 tex2DNode1 = tex2D( _Gra_Texture, (( ( (tex2D( _Noise_Texture, panner23 )).rga * staticSwitch61 ) + float3( uvs_Gra_Texture.xy ,  0.0 ) )*1.0 + float3( appendResult7 ,  0.0 )).xy );
			float4 temp_cast_3 = (_Gra_Pow).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch75 = i.uv_texcoord.x;
			#else
				float staticSwitch75 = _Dissolve_Val;
			#endif
			o.Emission = ( i.vertexColor * ( ( ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner54 ).r , _Sub_Pow ) * _Sub_Ins ) * _Sub_Color ) + tex2DNode1.r ) * tex2DNode1.r ) , temp_cast_3 ) * _Gra_Ins ) * _Gra_Color ) * saturate( ( tex2D( _Dissolve_Texture, i.uv_texcoord.xy ) + staticSwitch75 ) ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( pow( ( saturate( ( i.uv_texcoord.xy.y * ( 1.0 - i.uv_texcoord.xy.y ) ) ) * 4.0 ) , _Mask_Pow ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1423;625;3834.604;284.9037;2.09931;True;False
Node;AmplifyShaderEditor.RangedFloatNode;25;-3348.148,-141.8199;Float;False;Property;_Noise_VPanner;Noise_VPanner;8;0;Create;True;0;0;0;False;0;False;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-3348.146,-238.0198;Float;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-3123.245,-483.72;Inherit;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-3123.248,-245.8198;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-2781.347,-449.9199;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-3089.513,-762.7437;Float;False;Property;_Sub_UPanner;Sub_UPanner;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-3105.183,-681.7786;Float;False;Property;_Sub_VPanner;Sub_VPanner;15;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2533.164,-224.0765;Float;False;Property;_Noise_Val;Noise_Val;7;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-2531.748,-462.9204;Inherit;True;Property;_Noise_Texture;Noise_Texture;6;0;Create;True;0;0;0;False;0;False;-1;None;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;57;-2909.3,-760.132;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;59;-2652.14,74.05206;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-3022.912,-958.6276;Inherit;False;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;19;-2166.448,-460.3203;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;54;-2669.016,-915.5329;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;61;-2162.297,-223.5867;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2273.461,172.0562;Float;False;Property;_Gra_Offset;Gra_Offset;2;0;Create;True;0;0;0;False;0;False;0;-0.524;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1836.248,-448.6198;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1930.129,-104.9438;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-2281.152,-670.6713;Float;False;Property;_Sub_Pow;Sub_Pow;14;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1829.129,135.0562;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;60;-1974.483,313.7011;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-2303.835,-894.2932;Inherit;True;Property;_Sub_Texture;Sub_Texture;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1601.332,-123.0379;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1968.423,-667.3661;Float;False;Property;_Sub_Ins;Sub_Ins;13;0;Create;True;0;0;0;False;0;False;0;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1529.265,136.829;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;44;-1925.445,-890.5652;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-1351.129,-22.94382;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;49;-1605.07,-648.4896;Float;False;Property;_Sub_Color;Sub_Color;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;42;-1551.905,1100.047;Inherit;False;1793.199;875.8582;Mask;14;31;34;32;29;28;30;40;38;33;37;62;36;63;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1612.164,-881.8837;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1328.164,-882.8837;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1507.546,1396.989;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1134.867,-35.74114;Inherit;True;Property;_Gra_Texture;Gra_Texture;1;0;Create;True;0;0;0;False;0;False;-1;1f7bfb2ae7e94e345b708a040e18d5ea;a661d79a3837b3547a5550ceab1cd351;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;63;-1233.633,1676.474;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-852.6021,-435.791;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2273.662,854.2581;Inherit;False;Property;_Dissolve_Val;Dissolve_Val;21;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;66;-2296.135,574.549;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;75;-1734.095,823.2366;Float;False;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-825.2483,213.954;Float;False;Property;_Gra_Pow;Gra_Pow;4;0;Create;True;0;0;0;False;0;False;1;2.9;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-688.9665,-24.73421;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;64;-1875.808,591.607;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;20;0;Create;True;0;0;0;False;0;False;-1;None;cc86ef0fc250b1d4a9457c3ba98421bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1048.853,1547.591;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-1466.54,610.5722;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;62;-777.841,1545.133;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-509.6847,275.4723;Float;False;Property;_Gra_Ins;Gra_Ins;3;0;Create;True;0;0;0;False;0;False;0;2.43;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-456.358,5.872332;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-562.9305,1393.437;Float;False;Property;_Mask_Pow;Mask_Pow;10;0;Create;True;0;0;0;False;0;False;8;1.4;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-186.6846,11.47234;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-558.9268,1551.806;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-202.9881,262.351;Float;False;Property;_Gra_Color;Gra_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;4.594794,4.594794,4.594794,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;73;-1260.387,617.0772;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;74;129.0512,605.1452;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;38;-260.346,1538.033;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;46.31529,0.4723363;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;40;43.29594,1541.407;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;381.3167,1.243458;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;15;487.9221,-215.8946;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;31;-771.4761,1151.733;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-1044.755,1150.047;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;-270.4673,1160.168;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1215.589,1345.153;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;752.7155,-7.228267;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;28;-536.9973,1151.733;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;34;41.60896,1163.542;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1319.639,14.26195;Float;False;Property;_CullMode;CullMode;17;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;739.6444,253.2832;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;76;-2300.011,23.69486;Float;False;Property;_Use_Custom1;Use_Custom;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1085.804,11.39092;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Gra_Shokwave_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;58;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;23;0;20;0
WireConnection;23;2;26;0
WireConnection;18;1;23;0
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;19;0;18;0
WireConnection;54;0;53;0
WireConnection;54;2;57;0
WireConnection;61;1;22;0
WireConnection;61;0;59;4
WireConnection;21;0;19;0
WireConnection;21;1;61;0
WireConnection;60;1;6;0
WireConnection;60;0;59;3
WireConnection;43;1;54;0
WireConnection;17;0;21;0
WireConnection;17;1;3;0
WireConnection;7;0;8;0
WireConnection;7;1;60;0
WireConnection;44;0;43;1
WireConnection;44;1;45;0
WireConnection;4;0;17;0
WireConnection;4;2;7;0
WireConnection;46;0;44;0
WireConnection;46;1;47;0
WireConnection;48;0;46;0
WireConnection;48;1;49;0
WireConnection;1;1;4;0
WireConnection;63;0;27;2
WireConnection;50;0;48;0
WireConnection;50;1;1;1
WireConnection;75;1;70;0
WireConnection;75;0;59;1
WireConnection;51;0;50;0
WireConnection;51;1;1;1
WireConnection;64;1;66;0
WireConnection;36;0;27;2
WireConnection;36;1;63;0
WireConnection;69;0;64;0
WireConnection;69;1;75;0
WireConnection;62;0;36;0
WireConnection;9;0;51;0
WireConnection;9;1;12;0
WireConnection;10;0;9;0
WireConnection;10;1;13;0
WireConnection;37;0;62;0
WireConnection;73;0;69;0
WireConnection;74;0;73;0
WireConnection;38;0;37;0
WireConnection;38;1;33;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;40;0;38;0
WireConnection;71;0;11;0
WireConnection;71;1;74;0
WireConnection;31;0;29;0
WireConnection;29;0;27;2
WireConnection;29;1;30;0
WireConnection;32;0;28;0
WireConnection;32;1;33;0
WireConnection;16;0;15;0
WireConnection;16;1;71;0
WireConnection;28;0;31;0
WireConnection;34;0;32;0
WireConnection;41;0;15;4
WireConnection;41;1;40;0
WireConnection;76;0;59;2
WireConnection;0;2;16;0
WireConnection;0;9;41;0
ASEEND*/
//CHKSM=2D21B3299961B2F486493D36A2F5EB04D930AB7E