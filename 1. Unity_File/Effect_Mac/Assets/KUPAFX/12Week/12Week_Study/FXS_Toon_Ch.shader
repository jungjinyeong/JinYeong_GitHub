// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/12Week_Toon_Ch"
{
	Properties
	{
		_Vampire_diffuse("Vampire_diffuse", 2D) = "white" {}
		_FXT_Ramp_01("FXT_Ramp_01", 2D) = "white" {}
		_Ramp_Scale("Ramp_Scale", Range( -0.5 , 0.5)) = 0
		_Normal_Tex("Normal_Tex", 2D) = "white" {}
		_Outline_Width("Outline_Width", Range( 0 , 1)) = 0
		_Outline_Color("Outline_Color", Color) = (0,0,0,0)
		_Lim_Color("Lim_Color", Color) = (1,1,1,0)
		_Lim_Scale("Lim_Scale", Range( 0 , 5)) = 1
		_Lim_Pow("Lim_Pow", Range( 1 , 10)) = 7.141176
		_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Vampire_emission("Vampire_emission", 2D) = "white" {}
		_Emi_Ins("Emi_Ins", Range( 0 , 5)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		ZTest Always
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		struct Input
		{
			half filler;
		};
		uniform float _Outline_Width;
		uniform float4 _Outline_Color;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float outlineVar = _Outline_Width;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _Outline_Color.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _Vampire_emission;
		uniform float4 _Vampire_emission_ST;
		uniform float _Emi_Ins;
		uniform float4 _Tint_Color;
		uniform sampler2D _Vampire_diffuse;
		uniform float4 _Vampire_diffuse_ST;
		uniform sampler2D _FXT_Ramp_01;
		uniform sampler2D _Normal_Tex;
		uniform float4 _Normal_Tex_ST;
		uniform float _Ramp_Scale;
		uniform float _Lim_Scale;
		uniform float _Lim_Pow;
		uniform float4 _Lim_Color;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_Vampire_diffuse = i.uv_texcoord * _Vampire_diffuse_ST.xy + _Vampire_diffuse_ST.zw;
			float2 uv_Normal_Tex = i.uv_texcoord * _Normal_Tex_ST.xy + _Normal_Tex_ST.zw;
			float3 newWorldNormal3 = (WorldNormalVector( i , tex2D( _Normal_Tex, uv_Normal_Tex ).rgb ));
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5 = dot( newWorldNormal3 , ase_worldlightDir );
			float2 temp_cast_2 = ((dotResult5*_Ramp_Scale + _Ramp_Scale)).xx;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV19 = dot( newWorldNormal3, ase_worldViewDir );
			float fresnelNode19 = ( 0.0 + _Lim_Scale * pow( 1.0 - fresnelNdotV19, _Lim_Pow ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			UnityGI gi38 = gi;
			float3 diffNorm38 = ase_worldNormal;
			gi38 = UnityGI_Base( data, 1, diffNorm38 );
			float3 indirectDiffuse38 = gi38.indirect.diffuse + diffNorm38 * 0.0001;
			c.rgb = ( ( _Tint_Color * tex2D( _Vampire_diffuse, uv_Vampire_diffuse ) ) * ( ( ( tex2D( _FXT_Ramp_01, temp_cast_2 ) + ( saturate( fresnelNode19 ) * _Lim_Color ) ) * ase_lightColor ) + float4( indirectDiffuse38 , 0.0 ) ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_Vampire_emission = i.uv_texcoord * _Vampire_emission_ST.xy + _Vampire_emission_ST.zw;
			o.Emission = ( tex2D( _Vampire_emission, uv_Vampire_emission ) * _Emi_Ins ).rgb;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;449;1920;570;2016.36;444.1034;1.64712;True;True
Node;AmplifyShaderEditor.SamplerNode;10;-2323.62,-421.7248;Float;True;Property;_Normal_Tex;Normal_Tex;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;6;-1966.3,-373.1318;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;25;-1595.979,498.618;Float;False;Property;_Lim_Pow;Lim_Pow;9;0;Create;True;0;0;False;0;7.141176;6.25;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1603.679,418.6354;Float;False;Property;_Lim_Scale;Lim_Scale;8;0;Create;True;0;0;False;0;1;4.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;3;-2002.289,-595.611;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FresnelNode;19;-1323.703,307.7686;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1365.645,-263.5577;Float;True;Property;_Ramp_Scale;Ramp_Scale;2;0;Create;True;0;0;False;0;0;-0.341;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;5;-1675.675,-452.8582;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-1029.589,310.2101;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;8;-963.6943,-306.0176;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;22;-1065.589,565.2102;Float;False;Property;_Lim_Color;Lim_Color;7;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-842.1212,312.0161;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;-750.0851,-238.3532;Float;True;Property;_FXT_Ramp_01;FXT_Ramp_01;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-396.5535,-203.6498;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;33;-455.5034,-708.6995;Float;False;643.0511;463.2872;Albedo;3;1;30;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightColorNode;27;-411.464,51.01991;Float;True;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;31;-315.3211,-658.6995;Float;False;Property;_Tint_Color;Tint_Color;10;0;Create;True;0;0;False;0;1,1,1,0;0.3867925,0.37767,0.37767,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-173.1327,-185.3721;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-405.5034,-475.4122;Float;True;Property;_Vampire_diffuse;Vampire_diffuse;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;37;-439.6827,-1102.135;Float;False;622.1487;367.514;Comment;3;34;35;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;38;-28.28705,200.7438;Float;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-367.7228,-850.6212;Float;False;Property;_Emi_Ins;Emi_Ins;12;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;202.3097,19.56067;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;673.495,14.11554;Float;False;Property;_Outline_Width;Outline_Width;5;0;Create;True;0;0;False;0;0;0.037;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-389.6828,-1052.135;Float;True;Property;_Vampire_emission;Vampire_emission;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-47.45233,-561.2874;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;18;708.495,-171.8844;Float;False;Property;_Outline_Color;Outline_Color;6;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-52.53402,-1004.34;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;371.5956,-229.7375;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2613.382,-498.2716;Float;False;Property;_Normal_Scale;Normal_Scale;4;0;Create;True;0;0;False;0;0.2310431;0.495;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;16;947.4951,-139.8844;Float;False;0;True;None;0;7;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;702.0131,-474.2938;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;KUPAFX_Study/12Week_Toon_Ch;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;10;0
WireConnection;19;0;3;0
WireConnection;19;2;24;0
WireConnection;19;3;25;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;20;0;19;0
WireConnection;8;0;5;0
WireConnection;8;1;9;0
WireConnection;8;2;9;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;7;1;8;0
WireConnection;23;0;7;0
WireConnection;23;1;21;0
WireConnection;29;0;23;0
WireConnection;29;1;27;0
WireConnection;39;0;29;0
WireConnection;39;1;38;0
WireConnection;30;0;31;0
WireConnection;30;1;1;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;32;0;30;0
WireConnection;32;1;39;0
WireConnection;16;0;18;0
WireConnection;16;1;17;0
WireConnection;0;2;35;0
WireConnection;0;13;32;0
WireConnection;0;11;16;0
ASEEND*/
//CHKSM=09C3A5EFDEF7DCA1EB3075ACC7CB0CCB4230552D