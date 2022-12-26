// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Trail"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Trail_Texture("Trail_Texture", 2D) = "white" {}
		[HDR]_Lerp_Tint_Color_B("Lerp_Tint_Color_B", Color) = (1,1,1,1)
		[HDR]_Lerp_Tint_Color_A("Lerp_Tint_Color_A", Color) = (1,1,1,1)
		_Trail_Tex_Ins("Trail_Tex_Ins", Range( 1 , 10)) = 1
		_Trail_Tex_Pow("Trail_Tex_Pow", Range( 1 , 10)) = 1
		_Trail_UOffset("Trail_UOffset", Float) = 0
		_Trail_VOffset("Trail_VOffset", Float) = 0
		_Trail_VPanner("Trail_VPanner", Float) = 0
		_Trail_UPanner("Trail_UPanner", Float) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 0
		_Noise_Texure("Noise_Texure", 2D) = "bump" {}
		[Toggle(_USE_CUSTOM_LERP_ON)] _Use_Custom_Lerp("Use_Custom_Lerp", Float) = 0
		_Noise_Str("Noise_Str", Float) = 0.58
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_NoiseTex_UPanner("NoiseTex_UPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		[Toggle(_USE_TOON_DISOOVE_ON)] _Use_Toon_Disoove("Use_Toon_Disoove", Float) = 0
		_Lerp_Val("Lerp_Val", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_LERP_ON
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma shader_feature_local _USE_TOON_DISOOVE_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv3_texcoord3;
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float _CullMode;
		uniform float4 _Lerp_Tint_Color_A;
		uniform float4 _Lerp_Tint_Color_B;
		uniform float _Lerp_Val;
		uniform float _Trail_Tex_Ins;
		uniform sampler2D _Trail_Texture;
		uniform float _Trail_UPanner;
		uniform float _Trail_VPanner;
		uniform sampler2D _Noise_Texure;
		uniform float _NoiseTex_UPanner;
		uniform float4 _Noise_Texure_ST;
		uniform float _Noise_Str;
		uniform float4 _Trail_Texture_ST;
		uniform float _Trail_UOffset;
		uniform float _Trail_VOffset;
		uniform float _Trail_Tex_Pow;
		uniform float _Opacity;
		uniform float _Mask_Pow;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_LERP_ON
				float staticSwitch67 = i.uv3_texcoord3.z;
			#else
				float staticSwitch67 = _Lerp_Val;
			#endif
			float2 appendResult7 = (float2(_Trail_UPanner , _Trail_VPanner));
			float4 appendResult28 = (float4(_NoiseTex_UPanner , 0.0 , 0.0 , 0.0));
			float2 uv_Noise_Texure = i.uv_texcoord * _Noise_Texure_ST.xy + _Noise_Texure_ST.zw;
			float2 panner24 = ( 1.0 * _Time.y * appendResult28.xy + uv_Noise_Texure);
			float2 uv_Trail_Texture = i.uv_texcoord * _Trail_Texture_ST.xy + _Trail_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch39 = i.uv2_texcoord2.x;
			#else
				float staticSwitch39 = _Trail_UOffset;
			#endif
			float2 appendResult37 = (float2(staticSwitch39 , _Trail_VOffset));
			float2 panner3 = ( 1.0 * _Time.y * appendResult7 + (( ( (UnpackNormal( tex2D( _Noise_Texure, panner24 ) )).xy * _Noise_Str ) + uv_Trail_Texture )*1.0 + appendResult37));
			float4 tex2DNode2 = tex2D( _Trail_Texture, panner3 );
			float temp_output_61_0 = ( _Trail_Tex_Ins * pow( tex2DNode2.r , _Trail_Tex_Pow ) );
			float4 lerpResult63 = lerp( _Lerp_Tint_Color_A , _Lerp_Tint_Color_B , ( staticSwitch67 * temp_output_61_0 ));
			o.Emission = ( ( lerpResult63 * temp_output_61_0 ) * i.vertexColor ).rgb;
			float temp_output_10_0 = ( tex2DNode2.r * pow( i.uv_texcoord.x , _Mask_Pow ) );
			float2 appendResult45 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 temp_cast_2 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch57 = i.uv2_texcoord2.w;
			#else
				float staticSwitch57 = 0.0;
			#endif
			float cos55 = cos( staticSwitch57 );
			float sin55 = sin( staticSwitch57 );
			float2 rotator55 = mul( uv_Dissolve_Texture - temp_cast_2 , float2x2( cos55 , -sin55 , sin55 , cos55 )) + temp_cast_2;
			float2 panner44 = ( 1.0 * _Time.y * appendResult45 + rotator55);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch54 = i.uv2_texcoord2.y;
			#else
				float staticSwitch54 = _Dissolve;
			#endif
			#ifdef _USE_TOON_DISOOVE_ON
				float staticSwitch53 = floor( ( ( temp_output_10_0 * saturate( ( tex2D( _Dissolve_Texture, panner44 ).r + staticSwitch54 ) ) ) * 4.0 ) );
			#else
				float staticSwitch53 = temp_output_10_0;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( ( _Opacity * staticSwitch53 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1462;578;1535.191;573.1322;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;33;-2664.121,-610.844;Inherit;False;1336;549;Comment;9;29;22;24;28;27;26;23;31;32;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2614.121,-258.8442;Float;False;Property;_NoiseTex_UPanner;NoiseTex_UPanner;16;0;Create;True;0;0;0;False;0;False;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2608.121,-177.8441;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-2542.121,-560.8441;Inherit;True;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2397.121,-253.8442;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;24;-2332.121,-424.8442;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-2135.122,-456.8442;Inherit;True;Property;_Noise_Texure;Noise_Texure;12;0;Create;True;0;0;0;False;0;False;-1;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-1904.276,1246.06;Float;False;Constant;_Float3;Float 3;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1809.121,-253.8442;Float;False;Property;_Noise_Str;Noise_Str;14;0;Create;True;0;0;0;False;0;False;0.58;0.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;29;-1827.121,-464.8442;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2016.208,142.8918;Float;False;Property;_Trail_UOffset;Trail_UOffset;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;38;-2000.701,894.0797;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-1442.496,1164.987;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1592.844,878.2266;Inherit;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;57;-1577.526,1439.076;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1828.725,-15.14478;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;-1480.649,1239.113;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1403.811,1000.652;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1832.208,302.8918;Float;False;Property;_Trail_VOffset;Trail_VOffset;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1563.121,-459.8442;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;39;-1818.208,140.8918;Float;False;Property;_Use_Custom;Use_Custom;15;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1515.208,226.8918;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;55;-1254.912,855.8896;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1372.815,132.8552;Float;False;Property;_Trail_UPanner;Trail_UPanner;9;0;Create;True;0;0;0;False;0;False;1;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1371.815,217.8552;Float;False;Property;_Trail_VPanner;Trail_VPanner;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1594.208,-75.10818;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-1211.397,1146.456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;44;-1026.435,963.3835;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-954.1753,1206.092;Float;False;Property;_Dissolve;Dissolve;18;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1188.815,177.8552;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;21;-1375.784,5.133514;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;54;-642.2947,1284.819;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-773.2475,996.0739;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;17;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1264.815,411.8552;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1286.815,718.8552;Float;False;Property;_Mask_Pow;Mask_Pow;11;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;3;-1165.815,23.85522;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;11;-929.8149,547.8552;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-465.5466,1011.381;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-969.6778,297.682;Inherit;True;Property;_Trail_Texture;Trail_Texture;1;0;Create;True;0;0;0;False;0;False;-1;9f3f000a6eaa69049b39200d056f7e80;6e5ba6ace0150bf44a336e963f73ac12;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-553.2601,343.6404;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;-281.7242,1022.103;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-96.52312,858.0287;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;1.639943,1110.676;Float;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-684.366,151.1236;Float;False;Property;_Trail_Tex_Pow;Trail_Tex_Pow;5;0;Create;True;0;0;0;False;0;False;1;1.21;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;201.64,1019.676;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-464.096,6.688366;Float;False;Property;_Trail_Tex_Ins;Trail_Tex_Ins;4;0;Create;True;0;0;0;False;0;False;1;1.24;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;-363.6897,80.49004;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-571.1034,-296.3624;Inherit;False;Property;_Lerp_Val;Lerp_Val;22;0;Create;True;0;0;0;False;0;False;0;-0.07;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;66;-847.9808,-307.8435;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;67;-284.3492,-264.4207;Float;False;Property;_Use_Custom_Lerp;Use_Custom_Lerp;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-95.49983,41.69601;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;50;397.64,858.6756;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;62;-299.4601,-454.029;Float;False;Property;_Lerp_Tint_Color_B;Lerp_Tint_Color_B;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;5.033322,1.638204,4.758631,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;53;395.3744,355.5274;Float;True;Property;_Use_Toon_Disoove;Use_Toon_Disoove;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-305.2404,-643.7484;Float;False;Property;_Lerp_Tint_Color_A;Lerp_Tint_Color_A;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1.197087,1.473974,4.976126,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-8.303589,-245.3624;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;346.7819,180.8949;Float;False;Property;_Opacity;Opacity;10;0;Create;True;0;0;0;False;0;False;0;2.52;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;643.8601,190.8269;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;63;77.52807,-415.9135;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;16;-255.1114,-157.1089;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;798.3122,188.0154;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;243.2243,-273.8165;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;419.1933,-183.3849;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;384.9457,-50.73885;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;5681.234,-1816.449;Float;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;879.9843,-181.089;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Trail;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;24;0;23;0
WireConnection;24;2;28;0
WireConnection;22;1;24;0
WireConnection;29;0;22;0
WireConnection;57;1;58;0
WireConnection;57;0;38;4
WireConnection;31;0;29;0
WireConnection;31;1;32;0
WireConnection;39;1;35;0
WireConnection;39;0;38;1
WireConnection;37;0;39;0
WireConnection;37;1;36;0
WireConnection;55;0;43;0
WireConnection;55;1;56;0
WireConnection;55;2;57;0
WireConnection;34;0;31;0
WireConnection;34;1;4;0
WireConnection;45;0;46;0
WireConnection;45;1;47;0
WireConnection;44;0;55;0
WireConnection;44;2;45;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;21;0;34;0
WireConnection;21;2;37;0
WireConnection;54;1;42;0
WireConnection;54;0;38;2
WireConnection;40;1;44;0
WireConnection;3;0;21;0
WireConnection;3;2;7;0
WireConnection;11;0;9;1
WireConnection;11;1;12;0
WireConnection;41;0;40;1
WireConnection;41;1;54;0
WireConnection;2;1;3;0
WireConnection;10;0;2;1
WireConnection;10;1;11;0
WireConnection;48;0;41;0
WireConnection;49;0;10;0
WireConnection;49;1;48;0
WireConnection;51;0;49;0
WireConnection;51;1;52;0
WireConnection;59;0;2;1
WireConnection;59;1;60;0
WireConnection;67;1;65;0
WireConnection;67;0;66;3
WireConnection;61;0;20;0
WireConnection;61;1;59;0
WireConnection;50;0;51;0
WireConnection;53;1;10;0
WireConnection;53;0;50;0
WireConnection;64;0;67;0
WireConnection;64;1;61;0
WireConnection;13;0;14;0
WireConnection;13;1;53;0
WireConnection;63;0;8;0
WireConnection;63;1;62;0
WireConnection;63;2;64;0
WireConnection;15;0;13;0
WireConnection;19;0;63;0
WireConnection;19;1;61;0
WireConnection;17;0;19;0
WireConnection;17;1;16;0
WireConnection;18;0;16;4
WireConnection;18;1;15;0
WireConnection;0;2;17;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=A48BB3E680F2C97CBC9F924F2F7ECE9BAD9ED79C