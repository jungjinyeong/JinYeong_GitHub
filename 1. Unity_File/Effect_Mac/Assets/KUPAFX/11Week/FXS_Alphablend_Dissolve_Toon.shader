// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Dissolve_Toon"
{
	Properties
	{
		_Main_Texature("Main_Texature", 2D) = "white" {}
		[HDR]_TintColor("Tint Color", Color) = (1,0.6931067,0,0)
		_Main_UOffset("Main_UOffset", Range( -1 , 1)) = 0
		_Main_VOffset("Main_VOffset", Range( -1 , 1)) = 0
		_Ins("Ins", Range( 1 , 10)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Rotator("Rotator", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Dissolve_Tex_UPanner("Dissolve_Tex_UPanner", Float) = 0
		_Dissolve_Tex_VPanner("Dissolve_Tex_VPanner", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Main_Pow("Main_Pow", Float) = 0
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
			float2 uv_texcoord;
		};

		uniform float _CullMode;
		uniform float4 _TintColor;
		uniform float _Ins;
		uniform sampler2D _Main_Texature;
		uniform float4 _Main_Texature_ST;
		uniform float _Main_UOffset;
		uniform float _Main_VOffset;
		uniform float _Main_Pow;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_Tex_UPanner;
		uniform float _Dissolve_Tex_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Rotator;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch24 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch24 = _Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _TintColor * staticSwitch24 ) ).rgb;
			float2 uv0_Main_Texature = i.uv_texcoord * _Main_Texature_ST.xy + _Main_Texature_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch31 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch31 = _Main_VOffset;
			#endif
			float2 appendResult28 = (float2(_Main_UOffset , staticSwitch31));
			float2 appendResult35 = (float2(_Dissolve_Tex_UPanner , _Dissolve_Tex_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * appendResult35 + uv0_Dissolve_Texture);
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch20 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch20 = _Rotator;
			#endif
			float cos18 = cos( staticSwitch20 );
			float sin18 = sin( staticSwitch20 );
			float2 rotator18 = mul( panner32 - temp_cast_1 , float2x2( cos18 , -sin18 , sin18 , cos18 )) + temp_cast_1;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch13 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch13 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( floor( ( ( pow( tex2D( _Main_Texature, (uv0_Main_Texature*1.0 + appendResult28) ).r , _Main_Pow ) * ( tex2D( _Dissolve_Texture, rotator18 ).r + staticSwitch13 ) ) * 2.0 ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;450;1920;569;2631.467;-106.3798;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;33;-2467.12,306.0746;Float;False;Property;_Dissolve_Tex_UPanner;Dissolve_Tex_UPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2472.12,387.0746;Float;False;Property;_Dissolve_Tex_VPanner;Dissolve_Tex_VPanner;10;0;Create;True;0;0;False;0;0;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;12;-2057,550.5;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-1645.608,-58.5835;Float;False;Property;_Main_VOffset;Main_VOffset;3;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2385,77.5;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;35;-2217.12,309.0746;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1966.233,418.3386;Float;False;Property;_Rotator;Rotator;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;31;-1337.698,21.61755;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1635.608,-146.5835;Float;False;Property;_Main_UOffset;Main_UOffset;2;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1362.608,-111.5835;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;32;-2110.12,86.07458;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1559.608,-488.5835;Float;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;20;-1606.233,406.3386;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1874.233,221.3386;Float;False;Constant;_Rot;Rot;6;0;Create;True;0;0;False;0;0.5;4.44;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;27;-1170.608,-278.5835;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;18;-1401.233,195.3386;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1919,323.5;Float;False;Property;_Dissolve;Dissolve;8;0;Create;True;0;0;False;0;1;0.037;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-933.3,-272.7;Float;True;Property;_Main_Texature;Main_Texature;0;0;Create;True;0;0;False;0;e2edd7b4dad5d0b449ceac40e4a0bb87;37e6f91f3efb0954cbdce254638862ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;-808.1768,-2.953747;Float;False;Property;_Main_Pow;Main_Pow;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;13;-818,380.5;Float;False;Property;_Use_Custom;Use_Custom;4;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1124,117.5;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;7;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-639,136.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;-585.877,-83.55369;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-320,-74.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-183,172.5;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-495.2329,-199.6614;Float;False;Property;_Ins;Ins;4;0;Create;True;0;0;False;0;0;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-12,74.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;6;117,57.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-138.1539,-108.6985;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-227,-402.5;Float;False;Property;_TintColor;Tint Color;1;1;[HDR];Create;True;0;0;False;0;1,0.6931067,0,0;1,0.6931067,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;14;-33.2327,-548.6614;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;105.7671,-172.6614;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;10;305,76.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;401.7673,-342.6614;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;466.7673,-29.66138;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1012.315,-115.1115;Float;False;Property;_CullMode;CullMode;11;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;730,-236;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Dissolve_Toon;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;25;978.2208,-233.8298;Float;False;440.1069;100;x : diiosve y : ins  w :  random rot;0;;1,1,1,1;0;0
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;31;1;30;0
WireConnection;31;0;12;3
WireConnection;28;0;29;0
WireConnection;28;1;31;0
WireConnection;32;0;11;0
WireConnection;32;2;35;0
WireConnection;20;1;21;0
WireConnection;20;0;12;4
WireConnection;27;0;26;0
WireConnection;27;2;28;0
WireConnection;18;0;32;0
WireConnection;18;1;19;0
WireConnection;18;2;20;0
WireConnection;1;1;27;0
WireConnection;13;1;4;0
WireConnection;13;0;12;1
WireConnection;2;1;18;0
WireConnection;3;0;2;1
WireConnection;3;1;13;0
WireConnection;37;0;1;1
WireConnection;37;1;38;0
WireConnection;5;0;37;0
WireConnection;5;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;8;0
WireConnection;6;0;7;0
WireConnection;24;1;23;0
WireConnection;24;0;12;2
WireConnection;22;0;9;0
WireConnection;22;1;24;0
WireConnection;10;0;6;0
WireConnection;16;0;14;0
WireConnection;16;1;22;0
WireConnection;17;0;14;4
WireConnection;17;1;10;0
WireConnection;0;2;16;0
WireConnection;0;9;17;0
ASEEND*/
//CHKSM=ED4DB42E48CAE1563C17C8B02E329E4BEC74DB55