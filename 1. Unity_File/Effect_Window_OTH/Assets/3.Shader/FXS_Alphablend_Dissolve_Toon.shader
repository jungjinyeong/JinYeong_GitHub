// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Dissolve_Toon"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_Ins("Main_Ins", Float) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Dissolve_Rotator1("Dissolve_Rotator1", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
			float2 uv_texcoord;
		};

		uniform float _Cull_Mode;
		uniform float4 _Tint_Color;
		uniform float _Main_Ins;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve_Rotator1;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch25 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch25 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _Tint_Color * staticSwitch25 ) ).rgb;
			float2 appendResult30 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner27 = ( 1.0 * _Time.y * appendResult30 + uv0_Main_Texture);
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch15 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch15 = _Dissolve_Rotator1;
			#endif
			float cos13 = cos( staticSwitch15 );
			float sin13 = sin( staticSwitch15 );
			float2 rotator13 = mul( uv0_Dissolve_Texture - temp_cast_1 , float2x2( cos13 , -sin13 , sin13 , cos13 )) + temp_cast_1;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch11 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch11 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( floor( ( ( tex2D( _Main_Texture, panner27 ) * ( tex2D( _Dissolve_Texture, rotator13 ).r + staticSwitch11 ) ) * 2.0 ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;194.589;401.1613;1.170229;True;False
Node;AmplifyShaderEditor.RangedFloatNode;16;-1706.862,742.4692;Float;False;Property;_Dissolve_Rotator1;Dissolve_Rotator1;7;0;Create;True;0;0;False;0;0;5.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;10;-1750.017,887.2933;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-1498.188,327.4837;Float;False;Property;_Main_UPanner;Main_UPanner;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1499.652,561.825;Float;False;Constant;_Anchor;Anchor;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1501.389,399.4837;Float;False;Property;_Main_VPanner;Main_VPanner;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;15;-1482.385,714.5756;Float;False;Property;_Use_Custom;Use_Custom;8;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1717.488,479.472;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1493.389,169.0837;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;13;-1301.74,508.694;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1228.32,767.1997;Float;False;Property;_Dissolve;Dissolve;6;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1262.989,354.6837;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;11;-931.183,761.2794;Float;False;Property;_Use_Custom;Use_Custom;2;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1010.928,527.8905;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;5;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;27;-1115.789,217.0838;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-607.8345,537.7437;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-782.1998,208.4;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;e2edd7b4dad5d0b449ceac40e4a0bb87;545474d14f8c70d48b735f6fa4f4b8b9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-199.1295,212.6069;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-269.0933,758.3243;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;26.30921,447.3744;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-312.4324,62.81686;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;0;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;25;-118.2485,53.43949;Float;False;Property;_Use_Custom;Use_Custom;4;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;6;245.529,452.0388;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;18;-123.2787,-141.6171;Float;False;Property;_Tint_Color;Tint_Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2.561594,1.189312,0.6403986,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;9;428.9887,453.593;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;22;12.31354,-370.5889;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;183.7224,-76.37943;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;400.3054,-267.8171;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;723.6962,370.429;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;31;1248.842,205.8828;Float;False;Property;_Cull_Mode;Cull_Mode;9;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;992.0782,193.9899;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Dissolve_Toon;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;31;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;1;16;0
WireConnection;15;0;10;4
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;13;2;15;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;11;1;4;0
WireConnection;11;0;10;1
WireConnection;2;1;13;0
WireConnection;27;0;26;0
WireConnection;27;2;30;0
WireConnection;3;0;2;1
WireConnection;3;1;11;0
WireConnection;1;1;27;0
WireConnection;5;0;1;0
WireConnection;5;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;25;1;20;0
WireConnection;25;0;10;2
WireConnection;6;0;7;0
WireConnection;9;0;6;0
WireConnection;19;0;18;0
WireConnection;19;1;25;0
WireConnection;23;0;22;0
WireConnection;23;1;19;0
WireConnection;24;0;22;4
WireConnection;24;1;9;0
WireConnection;0;2;23;0
WireConnection;0;9;24;0
ASEEND*/
//CHKSM=37447CF608D853D394CE973ACC60F6F54A3E0F10