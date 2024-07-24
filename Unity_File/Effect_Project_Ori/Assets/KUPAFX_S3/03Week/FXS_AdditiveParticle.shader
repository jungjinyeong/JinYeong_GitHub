// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/AdditiveParticle"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_Ins("Main_Ins", Range( 1 , 50)) = 1
		_Main_Pow("Main_Pow", Float) = 2.53
		_Dissolve_Texture1("Dissolve_Texture", 2D) = "white" {}
		[Toggle(_USE_CUSTOMDATA_ON)] _Use_Customdata("Use_Customdata", Float) = 0
		_Dissolve1("Dissolve", Range( -1 , 1)) = 1
		_FadeIstance("FadeIstance", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOMDATA_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 screenPos;
		};

		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform sampler2D _Dissolve_Texture1;
		uniform float4 _Dissolve_Texture1_ST;
		uniform float _Dissolve1;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeIstance;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			#ifdef _USE_CUSTOMDATA_ON
				float staticSwitch32 = i.uv_tex4coord.z;
			#else
				float staticSwitch32 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( ( pow( tex2D( _Main_Texture, uv_Main_Texture ) , temp_cast_0 ) * staticSwitch32 ) * _Main_Color ) ).rgb;
			float2 uv_Dissolve_Texture1 = i.uv_texcoord * _Dissolve_Texture1_ST.xy + _Dissolve_Texture1_ST.zw;
			#ifdef _USE_CUSTOMDATA_ON
				float staticSwitch28 = i.uv_tex4coord.w;
			#else
				float staticSwitch28 = _Dissolve1;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth35 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth35 = abs( ( screenDepth35 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeIstance ) );
			o.Alpha = ( ( i.vertexColor.a * saturate( ( tex2D( _Dissolve_Texture1, uv_Dissolve_Texture1 ).r + staticSwitch28 ) ) ) * saturate( distanceDepth35 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;0;1920;1019;1201.7;669.8467;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;34;-1406.079,-441.133;Inherit;False;1373.505;724.0028;Main;9;3;9;4;14;2;5;6;32;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-865.6057,434.0065;Inherit;False;1165.947;636.0408;Dissolve;7;29;25;27;30;24;31;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1356.079,-391.133;Inherit;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-740.7958,731.8421;Inherit;False;Property;_Dissolve1;Dissolve;8;0;Create;True;0;0;0;False;0;False;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-815.6057,485.0065;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;26;-1409.658,307.9634;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1087.563,-121.3485;Inherit;False;Property;_Main_Pow;Main_Pow;4;0;Create;True;0;0;0;False;0;False;2.53;1.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1129.379,-324.933;Inherit;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;0;False;0;False;-1;7fb8a7829cf63804c85da7511368967e;7fb8a7829cf63804c85da7511368967e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1134.307,25.8462;Inherit;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;0;False;0;False;1;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-600.6057,484.0065;Inherit;True;Property;_Dissolve_Texture1;Dissolve_Texture;6;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;28;-463.1325,811.0473;Inherit;True;Property;_Use_Customdata;Use_Customdata;9;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-296.388,514.4759;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;425.1719,468.5895;Inherit;False;Property;_FadeIstance;FadeIstance;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;32;-844.7698,23.86981;Inherit;True;Property;_Use_Customdata;Use_Customdata;7;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;5;-821.3794,-313.933;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;9;-317.5742,-368.7846;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-457.5742,59.2154;Inherit;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.0541,0.4144324,0.045047,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;35;466.3879,355.8332;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;-97.58028,506.6706;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-486.5742,-153.7846;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;65.34126,436.8531;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-267.5742,-151.7846;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;23;705.4844,-508.338;Inherit;False;576.2848;431.8;Scale And Offset;7;16;17;15;18;19;20;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;36;718.3373,437.1581;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;761.4586,-280.4341;Inherit;False;Property;_UOffset;UOffset;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;761.3808,-449.5121;Inherit;False;Property;_UTile;UTile;5;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;15;1064.77,-458.338;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1.574215,-364.7846;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;19;755.4843,-364.6152;Inherit;False;Property;_VTile;VTile;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;758.4584,-192.5377;Inherit;False;Property;_VOffset;VOffset;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;913.7694,-434.5379;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;913.7694,-283.5376;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;439.1719,245.5895;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;458,-246;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/AdditiveParticle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;1;14;0
WireConnection;29;1;25;0
WireConnection;28;1;27;0
WireConnection;28;0;26;4
WireConnection;30;0;29;1
WireConnection;30;1;28;0
WireConnection;32;1;4;0
WireConnection;32;0;26;3
WireConnection;5;0;2;0
WireConnection;5;1;6;0
WireConnection;35;0;37;0
WireConnection;24;0;30;0
WireConnection;3;0;5;0
WireConnection;3;1;32;0
WireConnection;31;0;9;4
WireConnection;31;1;24;0
WireConnection;7;0;3;0
WireConnection;7;1;8;0
WireConnection;36;0;35;0
WireConnection;15;1;16;0
WireConnection;15;2;17;0
WireConnection;10;0;9;0
WireConnection;10;1;7;0
WireConnection;16;0;18;0
WireConnection;16;1;19;0
WireConnection;17;0;20;0
WireConnection;17;1;21;0
WireConnection;38;0;31;0
WireConnection;38;1;36;0
WireConnection;0;2;10;0
WireConnection;0;9;38;0
ASEEND*/
//CHKSM=C13D07C2F8C0096FCD4604239BF7C5A6D297D2D1