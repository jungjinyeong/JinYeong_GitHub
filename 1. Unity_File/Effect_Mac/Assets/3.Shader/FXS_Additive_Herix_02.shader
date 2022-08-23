// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Herix_02"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Herix_UMove("Main_Herix_UMove", Float) = 0
		_Main_Herix_VMove("Main_Herix_VMove", Float) = 0
		_Main_Ins("Main_Ins", Range( 0 , 10)) = 0
		_Main_Pow("Main_Pow", Range( 0 , 10)) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Mask_Val("Mask_Val", Float) = 2.5
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
		uniform float _Mask_Val;

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
			o.Alpha = ( i.vertexColor.a * saturate( pow( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) * ( i.uv_texcoord.x * 1.0 ) ) ) * 4.0 ) , _Mask_Val ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;2;1920;1014;2118.701;-47.00812;1.743132;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;18;-2260.051,225.8557;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-2264.702,24.7704;Float;False;Property;_Main_Herix_UMove;Main_Herix_UMove;1;0;Create;True;0;0;False;0;0;17.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2301.441,525.1108;Float;False;Property;_Main_Herix_VMove;Main_Herix_VMove;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-2051.912,546.0786;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;19;-2028.173,126.7381;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1284.132,914.3406;Float;False;Constant;_Float;Float;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1229.509,680.428;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1672.21,296.9225;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1777.97,-45.23358;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;28;-897.0954,674.1857;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-964.2021,917.6448;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2;-1403.337,48.98778;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-704.9176,800.5969;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;-457.4961,810.4999;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1136.731,35.38892;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-939.5148,302.6713;Float;False;Property;_Main_Pow;Main_Pow;4;0;Create;True;0;0;False;0;0;5.03;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-591.7947,294.5724;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;0;1.71;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-577.6499,34.67316;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-252.3834,815.92;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-232.6321,1071.97;Float;False;Property;_Mask_Val;Mask_Val;6;0;Create;True;0;0;False;0;2.5;6.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-266.3326,42.35849;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;34;-37.40129,817.4728;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-280.3979,-201.1526;Float;False;Property;_Tint_Color;Tint_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;6.498301,6.029955,3.717496,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;32;210.874,817.4808;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;298.4296,316.4818;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;7.024441,33.2445;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;533.805,38.66929;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;535.9131,513.2855;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;910.7161,53.93851;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Herix_02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;8;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;1;23;0
WireConnection;24;0;18;4
WireConnection;19;1;20;0
WireConnection;19;0;18;3
WireConnection;8;0;19;0
WireConnection;8;1;24;0
WireConnection;28;0;25;1
WireConnection;26;0;25;1
WireConnection;26;1;27;0
WireConnection;2;0;4;0
WireConnection;2;2;8;0
WireConnection;29;0;28;0
WireConnection;29;1;26;0
WireConnection;36;0;29;0
WireConnection;1;1;2;0
WireConnection;10;0;1;0
WireConnection;10;1;13;0
WireConnection;30;0;36;0
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;34;0;30;0
WireConnection;34;1;35;0
WireConnection;32;0;34;0
WireConnection;12;0;15;0
WireConnection;12;1;11;0
WireConnection;17;0;12;0
WireConnection;17;1;16;0
WireConnection;33;0;16;4
WireConnection;33;1;32;0
WireConnection;0;2;17;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=D477EDA1AF1BF32328CCD9D07197663728B3CC7C