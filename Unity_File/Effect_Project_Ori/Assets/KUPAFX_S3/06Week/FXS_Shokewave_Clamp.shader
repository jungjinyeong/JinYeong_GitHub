// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Shokewave_Clamp"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Src("Src", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 0
		_VOffset("VOffset", Range( -1.5 , 1)) = 0
		[HDR]_Gra_Color("Gra_Color", Color) = (1,1,1,0)
		_Gra_Pow("Gra_Pow", Range( 1 , 10)) = 1
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Str("Noise_Str", Range( 0 , 5)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Gra_Tetutre("Gra_Tetutre", 2D) = "white" {}
		_Chromatic("Chromatic", Range( 0 , 0.1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Opacity("Opacity", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
		};

		uniform float _Src;
		uniform float _CullMode;
		uniform float _Dst;
		uniform float4 _Gra_Color;
		uniform sampler2D _Gra_Tetutre;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Gra_Tetutre_ST;
		uniform float _VOffset;
		uniform float _Chromatic;
		uniform float _Gra_Pow;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult94 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner91 = ( 1.0 * _Time.y * appendResult94 + uv_Noise_Texture);
			float2 uv_Gra_Tetutre = i.uv_texcoord * _Gra_Tetutre_ST.xy + _Gra_Tetutre_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch109 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch109 = _VOffset;
			#endif
			float2 appendResult83 = (float2(0.0 , staticSwitch109));
			float3 temp_output_79_0 = (( ( (tex2D( _Noise_Texture, panner91 )).rga * _Noise_Str ) + float3( uv_Gra_Tetutre ,  0.0 ) )*1.0 + float3( appendResult83 ,  0.0 ));
			float4 tex2DNode77 = tex2D( _Gra_Tetutre, ( temp_output_79_0 + _Chromatic ).xy );
			float3 temp_cast_4 = (_Chromatic).xxx;
			float3 appendResult100 = (float3(tex2DNode77.r , tex2D( _Gra_Tetutre, temp_output_79_0.xy ).g , tex2D( _Gra_Tetutre, ( temp_output_79_0 - temp_cast_4 ).xy ).b));
			o.Emission = ( i.vertexColor * ( _Gra_Color * float4( appendResult100 , 0.0 ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * ( pow( tex2DNode77.r , _Gra_Pow ) * _Opacity ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
1913;116;1920;903;2348.24;1103.79;1.192137;True;False
Node;AmplifyShaderEditor.CommentaryNode;95;-2272.88,-837.6597;Inherit;False;1200;402.0001;Comment;9;90;91;92;93;94;86;87;89;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-2219.88,-551.6594;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-2222.88,-630.6594;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;94;-2026.88,-638.6594;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;90;-2217.88,-782.6595;Inherit;False;0;86;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;91;-1998.88,-776.6596;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;86;-1831.88,-783.6595;Inherit;True;Property;_Noise_Texture;Noise_Texture;7;0;Create;True;0;0;0;False;0;False;-1;None;04018d4e5ecda6049b39579f207e2114;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;-1684.88,-568.6595;Inherit;False;Property;_Noise_Str;Noise_Str;8;0;Create;True;0;0;0;False;0;False;0;0.59;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-1773.386,-36.61411;Inherit;False;Property;_VOffset;VOffset;4;0;Create;True;0;0;0;False;0;False;0;-0.04;-1.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;108;-1786.07,113.1153;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;87;-1507.579,-767.5853;Inherit;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;80;-1400.753,-405.8672;Inherit;False;0;97;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1307.88,-787.6595;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;109;-1475.07,100.1153;Inherit;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1485.386,-139.6141;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-1297.386,-129.6141;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-1150.145,-422.9526;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-744.6221,-3.045764;Inherit;False;Property;_Chromatic;Chromatic;12;0;Create;True;0;0;0;False;0;False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;79;-910.9585,-247.994;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;97;-532.0908,-261.5515;Inherit;True;Property;_Gra_Tetutre;Gra_Tetutre;11;0;Create;True;0;0;0;False;0;False;None;6ded42a1292c65c46b9098e9699c9ec1;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleSubtractOpNode;102;-444.5171,-31.4256;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;-421.5171,-473.4256;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;77;-155.1158,-464.7098;Inherit;True;Property;_FXT_GraTexure;FXT_GraTexure;4;0;Create;True;0;0;0;False;0;False;-1;f67296ec8cc86e149905ff5e9142a83f;f67296ec8cc86e149905ff5e9142a83f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;85;289.8842,55.29021;Inherit;False;Property;_Gra_Pow;Gra_Pow;6;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-148.0604,-252.8481;Inherit;True;Property;_FXT_GraTexure1;FXT_GraTexure;4;0;Create;True;0;0;0;False;0;False;-1;f67296ec8cc86e149905ff5e9142a83f;f67296ec8cc86e149905ff5e9142a83f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-152.0604,-24.84814;Inherit;True;Property;_FXT_GraTexure2;FXT_GraTexure;4;0;Create;True;0;0;0;False;0;False;-1;f67296ec8cc86e149905ff5e9142a83f;f67296ec8cc86e149905ff5e9142a83f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;100;354.9396,-530.8481;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;111;732.7531,57.0881;Inherit;False;Property;_Opacity;Opacity;14;0;Create;True;0;0;0;False;0;False;1;1.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;84;507.8841,-234.7098;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;78;349.3842,-710.7098;Inherit;False;Property;_Gra_Color;Gra_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.009433985,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;912.0361,-76.28099;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;717.4829,-524.4256;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;105;690.2536,-718.3304;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;76;1691.879,-528.5458;Inherit;False;241;282;Enum;3;75;74;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;75;1727.879,-347.5458;Inherit;False;Property;_Dst;Dst;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;1049.457,-255.7283;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1726.879,-421.5458;Inherit;False;Property;_Src;Src;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;908.2536,-710.3304;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;73;1720.879,-495.5458;Inherit;False;Property;_CullMode;CullMode;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1464.924,-530.8806;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Shokewave_Clamp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;74;10;True;75;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;True;73;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;94;0;92;0
WireConnection;94;1;93;0
WireConnection;91;0;90;0
WireConnection;91;2;94;0
WireConnection;86;1;91;0
WireConnection;87;0;86;0
WireConnection;88;0;87;0
WireConnection;88;1;89;0
WireConnection;109;1;82;0
WireConnection;109;0;108;1
WireConnection;83;0;81;0
WireConnection;83;1;109;0
WireConnection;96;0;88;0
WireConnection;96;1;80;0
WireConnection;79;0;96;0
WireConnection;79;2;83;0
WireConnection;102;0;79;0
WireConnection;102;1;103;0
WireConnection;101;0;79;0
WireConnection;101;1;103;0
WireConnection;77;0;97;0
WireConnection;77;1;101;0
WireConnection;98;0;97;0
WireConnection;98;1;79;0
WireConnection;99;0;97;0
WireConnection;99;1;102;0
WireConnection;100;0;77;1
WireConnection;100;1;98;2
WireConnection;100;2;99;3
WireConnection;84;0;77;1
WireConnection;84;1;85;0
WireConnection;110;0;84;0
WireConnection;110;1;111;0
WireConnection;104;0;78;0
WireConnection;104;1;100;0
WireConnection;107;0;105;4
WireConnection;107;1;110;0
WireConnection;106;0;105;0
WireConnection;106;1;104;0
WireConnection;0;2;106;0
WireConnection;0;9;107;0
ASEEND*/
//CHKSM=0817B3FDAF803D833BDEAC78C8C00115576E5CAE