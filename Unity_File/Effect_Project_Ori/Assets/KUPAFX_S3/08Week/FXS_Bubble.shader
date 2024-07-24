// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Bubble"
{
	Properties
	{
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 0 , 20)) = 6.235294
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,0)
		_MainTex_VPanner("MainTex_VPanner", Float) = 0.15
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Chromatic("Chromatic", Range( 0 , 0.1)) = 0
		_Vertex_Str("Vertex_Str", Float) = 1
		_VertexTex_VPanner("VertexTex_VPanner", Float) = 0
		_VertexTex_Pow("VertexTex_Pow", Float) = 2
		_VertexTex("VertexTex", 2D) = "white" {}
		_Noise_Tex("Noise_Tex", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 2.32
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _VertexTex;
		uniform float _VertexTex_VPanner;
		uniform float _VertexTex_Pow;
		uniform float4 _VertexTex_ST;
		uniform float _Vertex_Str;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _Noise_Tex;
		uniform float _MainTex_VPanner;
		uniform float4 _Noise_Tex_ST;
		uniform float _Noise_Val;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float4 _Fresnel_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Chromatic;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult43 = (float2(0.0 , _VertexTex_VPanner));
			float2 panner39 = ( 1.0 * _Time.y * appendResult43 + v.texcoord.xy);
			float2 uv_VertexTex = v.texcoord * _VertexTex_ST.xy + _VertexTex_ST.zw;
			float4 temp_cast_1 = (3.0).xxxx;
			v.vertex.xyz += ( ( float4( ase_vertexNormal , 0.0 ) * ( saturate( pow( tex2Dlod( _VertexTex, float4( panner39, 0, 0.0) ).r , _VertexTex_Pow ) ) * saturate( pow( tex2Dlod( _VertexTex, float4( uv_VertexTex, 0, 0.0) ) , temp_cast_1 ) ) ) ) * _Vertex_Str ).rgb;
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult27 = (float2(0.0 , _MainTex_VPanner));
			float2 uv_Noise_Tex = i.uv_texcoord * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
			float2 panner61 = ( 1.0 * _Time.y * appendResult27 + uv_Noise_Tex);
			float4 screenColor52 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _Noise_Tex, panner61 ), _Noise_Val ) , 0.0 ) ).xy);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV1, _Fresnel_Pow ) );
			float4 temp_output_11_0 = ( saturate( fresnelNode1 ) * _Fresnel_Color );
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult27 + uv_Main_Texture);
			float2 temp_cast_2 = (_Chromatic).xx;
			float3 appendResult18 = (float3(tex2D( _Main_Texture, ( panner23 + _Chromatic ) ).r , tex2D( _Main_Texture, panner23 ).g , tex2D( _Main_Texture, ( panner23 - temp_cast_2 ) ).b));
			o.Emission = ( screenColor52 + ( temp_output_11_0 * ( temp_output_11_0 + float4( appendResult18 , 0.0 ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;42;1920;977;2036.885;1314.041;2.10092;True;False
Node;AmplifyShaderEditor.CommentaryNode;45;-1059.668,893.3723;Inherit;False;1270.144;748.4772;VertexTex;12;32;35;37;36;38;39;40;41;43;42;46;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-964.6682,1441.849;Inherit;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-960.6682,1525.849;Inherit;False;Property;_VertexTex_VPanner;VertexTex_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1669.334,207.9736;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1693.937,298.8939;Inherit;False;Property;_MainTex_VPanner;MainTex_VPanner;3;0;Create;True;0;0;0;False;0;False;0.15;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1656.683,42.38702;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-1481.076,228.2969;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-1009.668,1286.849;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;43;-788.6683,1487.849;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;46;-869.076,1083.187;Inherit;True;Property;_VertexTex;VertexTex;9;0;Create;True;0;0;0;False;0;False;None;fe7348c5b1084654894bc778e5cc4284;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.PannerNode;39;-729.6684,1315.849;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-969.3102,-364.092;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;0;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;23;-1242.574,143.2228;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-953.3102,-280.0919;Inherit;False;Property;_Fresnel_Pow;Fresnel_Pow;1;0;Create;True;0;0;0;False;0;False;6.235294;1.3;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1357.868,416.4507;Inherit;False;Property;_Chromatic;Chromatic;5;0;Create;True;0;0;0;False;0;False;0;0.0082;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1463.024,-681.4327;Inherit;False;0;55;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-889.8682,62.45068;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;17;-982.2156,305.9758;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FresnelNode;1;-651.1,-422;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;30;-880.8682,575.4507;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;35;-590.5892,1154.045;Inherit;True;Property;_VertexTex__;VertexTex__;7;0;Create;True;0;0;0;False;0;False;-1;fe7348c5b1084654894bc778e5cc4284;fe7348c5b1084654894bc778e5cc4284;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-208.076,1689.187;Inherit;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;47;-417.076,1454.187;Inherit;True;Property;_VertexTex__1;VertexTex__;7;0;Create;True;0;0;0;False;0;False;-1;fe7348c5b1084654894bc778e5cc4284;fe7348c5b1084654894bc778e5cc4284;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-477.842,1352.827;Inherit;False;Property;_VertexTex_Pow;VertexTex_Pow;8;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-413.31,-108.092;Inherit;False;Property;_Fresnel_Color;Fresnel_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.8825352,0.836504,1.515717,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;-978.3423,-613.0271;Inherit;False;Property;_Noise_Val;Noise_Val;11;0;Create;True;0;0;0;False;0;False;2.32;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-623.2156,67.9758;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-627.2156,308.9758;Inherit;True;Property;_TextureSample1;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-629.2156,561.9758;Inherit;True;Property;_TextureSample2;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;10;-360.3099,-417.092;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;48;-97.07605,1459.187;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;36;-298.842,1188.827;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;61;-1210.823,-671.0331;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;50;131.924,1457.187;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-153.4364,-418.5542;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-131.4662,97.30905;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;53;-494.9153,-945.3822;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;-615.1554,-702.5172;Inherit;True;Property;_Noise_Tex;Noise_Tex;10;0;Create;True;0;0;0;False;0;False;-1;None;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;38;-73.84207,1185.827;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-220.9153,-804.3822;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;182.924,1180.187;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;63.41687,7.852783;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;32;-370.594,943.3723;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;415.1346,1093.848;Inherit;False;Property;_Vertex_Str;Vertex_Str;6;0;Create;True;0;0;0;False;0;False;1;0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;191.0007,-425.7311;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;52;242.0847,-719.3822;Inherit;False;Global;_GrabScreen0;Grab Screen 0;10;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;354.6658,952.2093;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;500.4753,944.284;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;443.8556,-508.51;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1081.092,-313.0582;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Bubble;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;25;0
WireConnection;27;1;26;0
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;39;0;40;0
WireConnection;39;2;43;0
WireConnection;23;0;28;0
WireConnection;23;2;27;0
WireConnection;29;0;23;0
WireConnection;29;1;31;0
WireConnection;1;2;7;0
WireConnection;1;3;8;0
WireConnection;30;0;23;0
WireConnection;30;1;31;0
WireConnection;35;0;46;0
WireConnection;35;1;39;0
WireConnection;47;0;46;0
WireConnection;13;0;17;0
WireConnection;13;1;29;0
WireConnection;14;0;17;0
WireConnection;14;1;23;0
WireConnection;15;0;17;0
WireConnection;15;1;30;0
WireConnection;10;0;1;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;36;0;35;1
WireConnection;36;1;37;0
WireConnection;61;0;62;0
WireConnection;61;2;27;0
WireConnection;50;0;48;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;18;0;13;1
WireConnection;18;1;14;2
WireConnection;18;2;15;3
WireConnection;55;1;61;0
WireConnection;55;5;56;0
WireConnection;38;0;36;0
WireConnection;54;0;53;0
WireConnection;54;1;55;0
WireConnection;51;0;38;0
WireConnection;51;1;50;0
WireConnection;21;0;11;0
WireConnection;21;1;18;0
WireConnection;22;0;11;0
WireConnection;22;1;21;0
WireConnection;52;0;54;0
WireConnection;44;0;32;0
WireConnection;44;1;51;0
WireConnection;33;0;44;0
WireConnection;33;1;34;0
WireConnection;63;0;52;0
WireConnection;63;1;22;0
WireConnection;0;2;63;0
WireConnection;0;11;33;0
ASEEND*/
//CHKSM=98CAE62DDBD38D01B815960536C710B148594EA6