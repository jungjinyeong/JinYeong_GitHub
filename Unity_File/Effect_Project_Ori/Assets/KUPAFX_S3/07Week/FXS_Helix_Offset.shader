// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Helix_Offset"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Src("Src", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 0
		_FXT_Helix01_Clamp("FXT_Helix01_Clamp", 2D) = "white" {}
		_UOffset("UOffset", Range( -1 , 1)) = 0
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Mask_Range("Mask_Range", Range( 1 , 10)) = 3
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Ins("Ins", Range( 1 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
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
		uniform float _Src;
		uniform float _Dst;
		uniform float4 _Main_Color;
		uniform sampler2D _FXT_Helix01_Clamp;
		uniform float _UOffset;
		uniform float _Ins;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch26 = i.uv_tex4coord.z;
			#else
				float staticSwitch26 = _UOffset;
			#endif
			float2 appendResult10 = (float2(staticSwitch26 , 0.0));
			float4 tex2DNode5 = tex2D( _FXT_Helix01_Clamp, (i.uv_texcoord*1.0 + appendResult10) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch29 = i.uv_tex4coord.w;
			#else
				float staticSwitch29 = _Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _Main_Color * ( tex2DNode5.r * staticSwitch29 ) ) ).rgb;
			o.Alpha = saturate( ( i.vertexColor.a * ( tex2DNode5.r * saturate( pow( ( ( saturate( ( 1.0 - i.uv_texcoord.x ) ) * saturate( i.uv_texcoord.x ) ) * 4.0 ) , _Mask_Range ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;30;1920;989;2436.419;124.1407;1.673186;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1970.791,490.149;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;17;-1689.091,301.4491;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-1853.391,119.349;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1903,-5.5;Inherit;False;Property;_UOffset;UOffset;5;0;Create;True;0;0;0;False;0;False;0;-0.058;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;-1466.191,313.2489;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-1681.586,554.8519;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;26;-1570.391,87.349;Inherit;False;Property;_Use_Custom;Use_Custom;8;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1381,146.5;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1299.944,532.8842;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1237.125,779.0571;Inherit;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1058.187,773.3295;Inherit;False;Property;_Mask_Range;Mask_Range;7;0;Create;True;0;0;0;False;0;False;3;4;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1449,-263.5;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1201,90.5;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1039.125,525.0571;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;20;-805.7547,500.2598;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;7;-1050,-108.5;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1055.391,153.349;Inherit;False;Property;_Ins;Ins;9;0;Create;True;0;0;0;False;0;False;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-546.2594,477.0084;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-836,-107.5;Inherit;True;Property;_FXT_Helix01_Clamp;FXT_Helix01_Clamp;4;0;Create;True;0;0;0;False;0;False;-1;176a84c10bbc70f46a3eaac7efe0ca5a;176a84c10bbc70f46a3eaac7efe0ca5a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;29;-690.3911,145.349;Inherit;False;Property;_Use_Custom;Use_Custom;8;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;13;-596,-475.5;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-252.5908,199.8489;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-472.3911,-76.651;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-793,-316.5;Inherit;False;Property;_Main_Color;Main_Color;6;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;14.75442,6.102615,2.471945,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-315,-269.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1;350,-217.75;Inherit;False;241;282;Enum;3;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-79.50001,42.79996;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;379,-184.75;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;385,-110.75;Inherit;False;Property;_Src;Src;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;386,-36.75;Inherit;False;Property;_Dst;Dst;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-141,-469.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;30;-33.34522,-38.31568;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;113,-240;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Helix_Offset;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;4;10;True;3;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;2;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;16;1
WireConnection;24;0;17;0
WireConnection;39;0;16;1
WireConnection;26;1;8;0
WireConnection;26;0;25;3
WireConnection;31;0;24;0
WireConnection;31;1;39;0
WireConnection;10;0;26;0
WireConnection;10;1;9;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;20;0;32;0
WireConnection;20;1;21;0
WireConnection;7;0;6;0
WireConnection;7;2;10;0
WireConnection;22;0;20;0
WireConnection;5;1;7;0
WireConnection;29;1;28;0
WireConnection;29;0;25;4
WireConnection;23;0;5;1
WireConnection;23;1;22;0
WireConnection;27;0;5;1
WireConnection;27;1;29;0
WireConnection;11;0;12;0
WireConnection;11;1;27;0
WireConnection;15;0;13;4
WireConnection;15;1;23;0
WireConnection;14;0;13;0
WireConnection;14;1;11;0
WireConnection;30;0;15;0
WireConnection;0;2;14;0
WireConnection;0;9;30;0
ASEEND*/
//CHKSM=1A3227B051E8D2954726A24E8A72F9A4F8AD7EEB