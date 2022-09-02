// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Herix_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Main_Pow("Main_Pow", Range( 0 , 10)) = 0
		_Main_Ins("Main_Ins", Range( 0 , 10)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Main_Herix_UMove("Main_Herix_UMove", Float) = 0
		_Main_Herix_VMove("Main_Herix_VMove", Float) = 0
		_Mask_U_Rang("Mask_U_Rang", Float) = 1
		_Mask_V_Rang("Mask_V_Rang", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
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
			#ifdef _USE_CUSTOM_ON
				float staticSwitch19 = i.uv_tex4coord.z;
			#else
				float staticSwitch19 = _Main_Herix_UMove;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch24 = i.uv_tex4coord.w;
			#else
				float staticSwitch24 = _Main_Herix_VMove;
			#endif
			float2 appendResult8 = (float2(staticSwitch19 , staticSwitch24));
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( ( _Tint_Color * ( pow( tex2D( _Main_Texture, (i.uv_texcoord*1.0 + appendResult8) ) , temp_cast_0 ) * _Main_Ins ) ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( 1.0 - i.uv_texcoord.y ) * ( i.uv_texcoord.y * _Mask_U_Rang ) ) * 4.0 ) ) * saturate( ( ( ( 1.0 - i.uv_texcoord.x ) * ( i.uv_texcoord.x * _Mask_V_Rang ) ) * 4.0 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;1745.438;-53.1226;1.6;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;18;-2260.051,225.8557;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2264.702,24.7704;Float;False;Property;_Main_Herix_UMove;Main_Herix_UMove;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2301.441,525.1108;Float;False;Property;_Main_Herix_VMove;Main_Herix_VMove;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-2051.912,546.0786;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;19;-2028.173,126.7381;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1672.21,296.9225;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1777.97,-45.23358;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-931.4341,690.8867;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2;-1403.337,48.98778;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-936.4568,950.5423;Float;False;Property;_Mask_U_Rang;Mask_U_Rang;8;0;Create;True;0;0;False;0;1;2.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-937.4536,1331.176;Float;False;Property;_Mask_V_Rang;Mask_V_Rang;9;0;Create;True;0;0;False;0;1;2.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-572.7006,1174.246;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-608.5266,931.3035;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;-599.0198,684.6444;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-609.4074,1425.705;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1136.731,35.38892;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;None;fb5672145722d694b9337ee256453050;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-939.5148,302.6713;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;0;3.94;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-337.1445,1254.974;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-349.3185,811.0556;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-577.6499,34.67316;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-591.7947,294.5724;Float;False;Property;_Main_Ins;Main_Ins;4;0;Create;True;0;0;False;0;0;0.88;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-107.7314,1258.096;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-119.9054,814.1769;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-280.3979,-201.1526;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,0;6.724853,3.665045,1.882959,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-266.3326,42.35849;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;32;92.34079,815.7375;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;7.024441,33.2445;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;16;298.4296,316.4818;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;39;104.5148,1259.656;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;533.805,38.66929;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;535.9131,513.2855;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;910.7161,53.93851;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Herix_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;1;23;0
WireConnection;24;0;18;4
WireConnection;19;1;20;0
WireConnection;19;0;18;3
WireConnection;8;0;19;0
WireConnection;8;1;24;0
WireConnection;2;0;4;0
WireConnection;2;2;8;0
WireConnection;34;0;25;1
WireConnection;26;0;25;2
WireConnection;26;1;27;0
WireConnection;28;0;25;2
WireConnection;35;0;25;1
WireConnection;35;1;36;0
WireConnection;1;1;2;0
WireConnection;37;0;34;0
WireConnection;37;1;35;0
WireConnection;29;0;28;0
WireConnection;29;1;26;0
WireConnection;10;0;1;0
WireConnection;10;1;13;0
WireConnection;38;0;37;0
WireConnection;30;0;29;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
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
//CHKSM=1E8E70AF4BD2D6A18EEACA28E141F7AD61696C93