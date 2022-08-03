// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/CH_FX_Toon"
{
	Properties
	{
		_FXT_Lut01("FXT_Lut01", 2D) = "white" {}
		_Outline_Width("Outline_Width", Range( 0 , 0.1)) = 0
		_Outline_Color("Outline_Color", Color) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 0
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0
		_Noise_Tex_Pow("Noise_Tex_Pow", Range( 1 , 10)) = 0
		_Noise_Tex_Ins("Noise_Tex_Ins", Range( 1 , 10)) = 0
		[HDR]_Noise_Tex_Color("Noise_Tex_Color", Color) = (0,0,0,0)
		_Noise_Tex_VTiling("Noise_Tex_VTiling", Float) = 0
		_Noise_Tex_UTiling("Noise_Tex_UTiling", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		_Emi_Val("Emi_Val", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
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
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldNormal;
			float3 viewDir;
			float3 worldPos;
		};

		uniform sampler2D _FXT_Lut01;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float4 _Fresnel_Color;
		uniform sampler2D _TextureSample0;
		uniform float _Noise_Tex_VPanner;
		uniform float _Noise_Tex_UTiling;
		uniform float _Noise_Tex_VTiling;
		uniform float _Noise_Tex_Pow;
		uniform float _Noise_Tex_Ins;
		uniform float4 _Noise_Tex_Color;
		uniform float _Emi_Val;
		uniform float _Outline_Width;
		uniform float4 _Outline_Color;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float dotResult4 = dot( ase_vertexNormal , i.viewDir );
			float2 temp_cast_0 = (dotResult4).xx;
			o.Albedo = tex2D( _FXT_Lut01, temp_cast_0 ).rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV14 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode14 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV14, _Fresnel_Pow ) );
			float2 appendResult34 = (float2(0.0 , _Noise_Tex_VPanner));
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 appendResult31 = (float2(_Noise_Tex_UTiling , _Noise_Tex_VTiling));
			float2 panner11 = ( 1.0 * _Time.y * appendResult34 + (ase_vertex3Pos*float3( appendResult31 ,  0.0 ) + 0.0).xy);
			o.Emission = ( ( ( saturate( fresnelNode14 ) * _Fresnel_Color ) + ( ( pow( tex2D( _TextureSample0, panner11 ).r , _Noise_Tex_Pow ) * _Noise_Tex_Ins ) * _Noise_Tex_Color ) ) * _Emi_Val ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;1300.457;269.0377;1.118369;True;False
Node;AmplifyShaderEditor.RangedFloatNode;33;-1924.132,780.9625;Float;False;Property;_Noise_Tex_UTiling;Noise_Tex_UTiling;11;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1909.132,858.9625;Float;False;Property;_Noise_Tex_VTiling;Noise_Tex_VTiling;10;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-1736.132,809.9625;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1587.132,1010.963;Float;False;Constant;_Float1;Float 1;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1589.132,1085.963;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;12;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;29;-1861.132,593.9625;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;34;-1403.132,962.9625;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;28;-1612.132,635.9625;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;1,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;11;-1386.697,691.3841;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1506.708,434.3386;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;5;0;Create;True;0;0;False;0;0;5.5;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1513.708,360.3386;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;6;0;Create;True;0;0;False;0;0;0.8352941;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1200.132,896.9625;Float;False;Property;_Noise_Tex_Pow;Noise_Tex_Pow;7;0;Create;True;0;0;False;0;0;6.28;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1203.396,680.084;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;c2f5e06ce5d539b418dc5ebfbfeeee94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-888.1318,937.9625;Float;False;Property;_Noise_Tex_Ins;Noise_Tex_Ins;8;0;Create;True;0;0;False;0;0;5.42;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;20;-916.1318,701.9625;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;14;-1177.039,217.5573;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;6;-1057.6,-479;Float;False;487;436;VertexNormal;3;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-687.1318,693.9625;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;-874.7078,219.3386;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-570.1321,955.9625;Float;False;Property;_Noise_Tex_Color;Noise_Tex_Color;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.459523,2.486594,4.000174,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-993.7078,468.3386;Float;False;Property;_Fresnel_Color;Fresnel_Color;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.041279,1.56081,2.659654,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-1031.6,-438;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;3;-1028.6,-248;Float;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-459.1321,676.9625;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-672.7078,211.3386;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-433.2994,159.3624;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-115,722.1;Float;False;Property;_Outline_Width;Outline_Width;1;0;Create;True;0;0;False;0;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-54,547.1;Float;False;Property;_Outline_Color;Outline_Color;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;-452.7334,450.0735;Float;False;Property;_Emi_Val;Emi_Val;13;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;4;-787.5999,-342;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-533.5999,-373;Float;True;Property;_FXT_Lut01;FXT_Lut01;0;0;Create;True;0;0;False;0;f2096819c1bb1314ab53917155b185c7;ae551726e7cab524688cc6b6ab4f87c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OutlineNode;7;180,621.1;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-147.4187,291.265;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;64.89999,-104.7;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/CH_FX_Toon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;33;0
WireConnection;31;1;32;0
WireConnection;34;0;36;0
WireConnection;34;1;35;0
WireConnection;28;0;29;0
WireConnection;28;1;31;0
WireConnection;11;0;28;0
WireConnection;11;2;34;0
WireConnection;10;1;11;0
WireConnection;20;0;10;1
WireConnection;20;1;21;0
WireConnection;14;2;19;0
WireConnection;14;3;18;0
WireConnection;22;0;20;0
WireConnection;22;1;23;0
WireConnection;15;0;14;0
WireConnection;25;0;22;0
WireConnection;25;1;27;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;24;0;16;0
WireConnection;24;1;25;0
WireConnection;4;0;2;0
WireConnection;4;1;3;0
WireConnection;1;1;4;0
WireConnection;7;0;8;0
WireConnection;7;1;9;0
WireConnection;37;0;24;0
WireConnection;37;1;38;0
WireConnection;0;0;1;0
WireConnection;0;2;37;0
WireConnection;0;11;7;0
ASEEND*/
//CHKSM=7F6F1B123C7ADC583A6E64F13E1589BE37E99A41