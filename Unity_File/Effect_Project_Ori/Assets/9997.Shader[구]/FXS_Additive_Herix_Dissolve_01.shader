// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Herix_Dissovle_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Main_Pow("Main_Pow", Range( 0 , 10)) = 0
		_Main_Ins("Main_Ins", Range( 0 , 10)) = 0
		_Main_Herix_UMove("Main_Herix_UMove", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Main_Herix_VMove("Main_Herix_VMove", Float) = 0
		_Main_Upanner("Main_Upanner", Float) = 0
		_Main_Vpanner("Main_Vpanner", Float) = 0
		_Mask_U_Rang("Mask_U_Rang", Float) = 1
		_Mask_V_Rang("Mask_V_Rang", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
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
			float4 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_Upanner;
		uniform float _Main_Vpanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Herix_UMove;
		uniform float _Main_Herix_VMove;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float _Mask_U_Rang;
		uniform float _Mask_V_Rang;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult43 = (float2(_Main_Upanner , _Main_Vpanner));
			float4 uvs_Main_Texture = i.uv_texcoord;
			uvs_Main_Texture.xy = i.uv_texcoord.xy * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner40 = ( 1.0 * _Time.y * appendResult43 + uvs_Main_Texture.xy);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch19 = i.uv_texcoord.z;
			#else
				float staticSwitch19 = _Main_Herix_UMove;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch24 = i.uv_texcoord.w;
			#else
				float staticSwitch24 = _Main_Herix_VMove;
			#endif
			float2 appendResult8 = (float2(staticSwitch19 , staticSwitch24));
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( ( _Tint_Color * ( pow( tex2D( _Main_Texture, (panner40*1.0 + appendResult8) ) , temp_cast_0 ) * _Main_Ins ) ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( 1.0 - i.uv_texcoord.xy.y ) * ( i.uv_texcoord.xy.y * _Mask_U_Rang ) ) * 4.0 ) ) * saturate( ( ( ( 1.0 - i.uv_texcoord.xy.x ) * ( i.uv_texcoord.xy.x * _Mask_V_Rang ) ) * 4.0 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1011;605;3377.942;833.6537;3.025249;True;False
Node;AmplifyShaderEditor.RangedFloatNode;20;-2264.702,24.7704;Float;False;Property;_Main_Herix_UMove;Main_Herix_UMove;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2475.83,-315.8995;Inherit;False;Property;_Main_Upanner;Main_Upanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-2475.829,-185.3119;Inherit;False;Property;_Main_Vpanner;Main_Vpanner;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;18;-2275.051,220.8862;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2301.441,525.1108;Float;False;Property;_Main_Herix_VMove;Main_Herix_VMove;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-2051.912,546.0786;Float;False;Property;_Use_Custom;Use_Custom;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;19;-2028.173,126.7381;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-2067.146,-298.0755;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2184.642,-506.9325;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;40;-1762.209,-338.1969;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1672.21,296.9225;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-936.4568,950.5423;Float;False;Property;_Mask_U_Rang;Mask_U_Rang;8;0;Create;True;0;0;0;False;0;False;1;1.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2;-1403.337,48.98778;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-931.4341,690.8867;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-937.4536,1331.176;Float;False;Property;_Mask_V_Rang;Mask_V_Rang;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-572.7006,1174.246;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-599.0198,684.6444;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-609.4074,1425.705;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1136.731,35.38892;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;None;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-608.5266,931.3035;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-939.5148,302.6713;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;0;False;0;False;0;2.63;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-337.1445,1254.974;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-349.3185,811.0556;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-577.6499,34.67316;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-591.7947,294.5724;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;0;False;0;False;0;0.6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-266.3326,42.35849;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-280.3979,-201.1526;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;4.237095,4.237095,4.237095,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-107.7314,1258.096;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-119.9054,814.1769;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;92.34079,815.7375;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;7.024441,33.2445;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;16;298.4296,316.4818;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;39;104.5148,1259.656;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;533.805,38.66929;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;535.9131,513.2855;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;910.7161,53.93851;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Herix_Dissovle_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;11;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;1;23;0
WireConnection;24;0;18;4
WireConnection;19;1;20;0
WireConnection;19;0;18;3
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;40;0;4;0
WireConnection;40;2;43;0
WireConnection;8;0;19;0
WireConnection;8;1;24;0
WireConnection;2;0;40;0
WireConnection;2;2;8;0
WireConnection;34;0;25;1
WireConnection;28;0;25;2
WireConnection;35;0;25;1
WireConnection;35;1;36;0
WireConnection;1;1;2;0
WireConnection;26;0;25;2
WireConnection;26;1;27;0
WireConnection;37;0;34;0
WireConnection;37;1;35;0
WireConnection;29;0;28;0
WireConnection;29;1;26;0
WireConnection;10;0;1;0
WireConnection;10;1;13;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;38;0;37;0
WireConnection;30;0;29;0
WireConnection;32;0;30;0
WireConnection;12;0;15;0
WireConnection;12;1;11;0
WireConnection;39;0;38;0
WireConnection;17;0;12;0
WireConnection;17;1;16;0
WireConnection;33;0;16;4
WireConnection;33;1;32;0
WireConnection;33;2;39;0
WireConnection;0;2;17;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=0C3F41E7E2C13B29FE571B81E7082261864331E0