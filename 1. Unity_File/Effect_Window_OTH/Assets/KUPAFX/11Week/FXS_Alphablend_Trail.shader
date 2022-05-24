// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Trail"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Trail_Texture("Trail_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Trail_Tex_Ins("Trail_Tex_Ins", Range( 1 , 10)) = 1
		_Trail_Tex_Pow("Trail_Tex_Pow", Range( 1 , 10)) = 1
		_Trail_UOffset("Trail_UOffset", Float) = 0
		_Trail_VOffset("Trail_VOffset", Float) = 0
		_Trail_VPanner("Trail_VPanner", Float) = 0
		_Trail_UPanner("Trail_UPanner", Float) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 0
		_Noise_Texure("Noise_Texure", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Float) = 0.58
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_NoiseTex_UPanner("NoiseTex_UPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		[Toggle(_USE_TOON_DISOOVE_ON)] _Use_Toon_Disoove("Use_Toon_Disoove", Float) = 0
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
		#pragma shader_feature _USE_TOON_DISOOVE_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _CullMode;
		uniform float4 _Tint_Color;
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
			float2 appendResult7 = (float2(_Trail_UPanner , _Trail_VPanner));
			float4 appendResult28 = (float4(_NoiseTex_UPanner , 0.0 , 0.0 , 0.0));
			float2 uv0_Noise_Texure = i.uv_texcoord * _Noise_Texure_ST.xy + _Noise_Texure_ST.zw;
			float2 panner24 = ( 1.0 * _Time.y * appendResult28.xy + uv0_Noise_Texure);
			float2 uv0_Trail_Texture = i.uv_texcoord * _Trail_Texture_ST.xy + _Trail_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch39 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch39 = _Trail_UOffset;
			#endif
			float2 appendResult37 = (float2(staticSwitch39 , _Trail_VOffset));
			float2 panner3 = ( 1.0 * _Time.y * appendResult7 + (( ( (UnpackNormal( tex2D( _Noise_Texure, panner24 ) )).xy * _Noise_Str ) + uv0_Trail_Texture )*1.0 + appendResult37));
			float4 tex2DNode2 = tex2D( _Trail_Texture, panner3 );
			o.Emission = ( ( _Tint_Color * ( _Trail_Tex_Ins * pow( tex2DNode2.r , _Trail_Tex_Pow ) ) ) * i.vertexColor ).rgb;
			float temp_output_10_0 = ( tex2DNode2.r * pow( i.uv_texcoord.x , _Mask_Pow ) );
			float2 appendResult45 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 temp_cast_2 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch57 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch57 = 0.0;
			#endif
			float cos55 = cos( staticSwitch57 );
			float sin55 = sin( staticSwitch57 );
			float2 rotator55 = mul( uv0_Dissolve_Texture - temp_cast_2 , float2x2( cos55 , -sin55 , sin55 , cos55 )) + temp_cast_2;
			float2 panner44 = ( 1.0 * _Time.y * appendResult45 + rotator55);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch54 = i.uv2_tex4coord2.y;
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
Version=16700
0;0;1920;1019;1796.138;422.4206;1.412671;True;True
Node;AmplifyShaderEditor.CommentaryNode;33;-2664.121,-610.844;Float;False;1336;549;Comment;9;29;22;24;28;27;26;23;31;32;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2614.121,-258.8442;Float;False;Property;_NoiseTex_UPanner;NoiseTex_UPanner;13;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2608.121,-177.8441;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-2542.121,-560.8441;Float;True;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2397.121,-253.8442;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;24;-2332.121,-424.8442;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-2135.122,-456.8442;Float;True;Property;_Noise_Texure;Noise_Texure;11;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;38;-2000.701,894.0797;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-1904.276,1246.06;Float;False;Constant;_Float3;Float 3;21;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1809.121,-253.8442;Float;False;Property;_Noise_Str;Noise_Str;12;0;Create;True;0;0;False;0;0.58;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;29;-1827.121,-464.8442;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2016.208,142.8918;Float;False;Property;_Trail_UOffset;Trail_UOffset;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1592.844,878.2266;Float;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;39;-1818.208,140.8918;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;57;-1577.526,1439.076;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1828.725,-15.14478;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-1442.496,1164.987;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;16;0;Create;True;0;0;False;0;0;5.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1480.649,1239.113;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1403.811,1000.652;Float;False;Constant;_Float2;Float 2;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1832.208,302.8918;Float;False;Property;_Trail_VOffset;Trail_VOffset;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1563.121,-459.8442;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1371.815,217.8552;Float;False;Property;_Trail_VPanner;Trail_VPanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-1211.397,1146.456;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;55;-1254.912,855.8896;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1372.815,132.8552;Float;False;Property;_Trail_UPanner;Trail_UPanner;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1515.208,226.8918;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1594.208,-75.10818;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1188.815,177.8552;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;21;-1375.784,5.133514;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;44;-1026.435,963.3835;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-954.1753,1206.092;Float;False;Property;_Dissolve;Dissolve;15;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-773.2475,996.0739;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;14;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1286.815,718.8552;Float;False;Property;_Mask_Pow;Mask_Pow;10;0;Create;True;0;0;False;0;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;54;-645.6748,1284.819;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1264.815,411.8552;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-1165.815,23.85522;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-969.6778,297.682;Float;True;Property;_Trail_Texture;Trail_Texture;1;0;Create;True;0;0;False;0;9f3f000a6eaa69049b39200d056f7e80;ec464f500e2764c418833e93af659696;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-465.5466,1011.381;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;11;-929.8149,547.8552;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-553.2601,343.6404;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;-281.7242,1022.103;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-96.52312,858.0287;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;1.639943,1110.676;Float;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;201.64,1019.676;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-684.366,151.1236;Float;False;Property;_Trail_Tex_Pow;Trail_Tex_Pow;4;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;50;397.64,858.6756;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;53;395.3744,355.5274;Float;True;Property;_Use_Toon_Disoove;Use_Toon_Disoove;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;346.7819,180.8949;Float;False;Property;_Opacity;Opacity;9;0;Create;True;0;0;False;0;0;2.52;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;-363.6897,80.49004;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-464.096,6.688366;Float;False;Property;_Trail_Tex_Ins;Trail_Tex_Ins;3;0;Create;True;0;0;False;0;1;2.08;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-671.8147,-392.1448;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.9695544,0.4711215,1.447504,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;643.8601,190.8269;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-75.5049,36.69728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-63.36502,-280.4815;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;16;-255.1114,-157.1089;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;798.3122,188.0154;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;112.6039,-190.0499;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;384.9457,-50.73885;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;5681.234,-1816.449;Float;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;879.9843,-181.089;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Trail;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;24;0;23;0
WireConnection;24;2;28;0
WireConnection;22;1;24;0
WireConnection;29;0;22;0
WireConnection;39;1;35;0
WireConnection;39;0;38;1
WireConnection;57;1;58;0
WireConnection;57;0;38;4
WireConnection;31;0;29;0
WireConnection;31;1;32;0
WireConnection;45;0;46;0
WireConnection;45;1;47;0
WireConnection;55;0;43;0
WireConnection;55;1;56;0
WireConnection;55;2;57;0
WireConnection;37;0;39;0
WireConnection;37;1;36;0
WireConnection;34;0;31;0
WireConnection;34;1;4;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;21;0;34;0
WireConnection;21;2;37;0
WireConnection;44;0;55;0
WireConnection;44;2;45;0
WireConnection;40;1;44;0
WireConnection;54;1;42;0
WireConnection;54;0;38;2
WireConnection;3;0;21;0
WireConnection;3;2;7;0
WireConnection;2;1;3;0
WireConnection;41;0;40;1
WireConnection;41;1;54;0
WireConnection;11;0;9;1
WireConnection;11;1;12;0
WireConnection;10;0;2;1
WireConnection;10;1;11;0
WireConnection;48;0;41;0
WireConnection;49;0;10;0
WireConnection;49;1;48;0
WireConnection;51;0;49;0
WireConnection;51;1;52;0
WireConnection;50;0;51;0
WireConnection;53;1;10;0
WireConnection;53;0;50;0
WireConnection;59;0;2;1
WireConnection;59;1;60;0
WireConnection;13;0;14;0
WireConnection;13;1;53;0
WireConnection;61;0;20;0
WireConnection;61;1;59;0
WireConnection;19;0;8;0
WireConnection;19;1;61;0
WireConnection;15;0;13;0
WireConnection;17;0;19;0
WireConnection;17;1;16;0
WireConnection;18;0;16;4
WireConnection;18;1;15;0
WireConnection;0;2;17;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=07AF33428FC4F885DFDC756BAE4E17DBB73B44CE