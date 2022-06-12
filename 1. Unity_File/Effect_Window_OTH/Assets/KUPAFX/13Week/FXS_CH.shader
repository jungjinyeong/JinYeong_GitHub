// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/CH_FX"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Vampire_diffuse("Vampire_diffuse", 2D) = "white" {}
		_Albedo_Color("Albedo_Color", Color) = (1,1,1,0)
		_Vampire_normal("Vampire_normal", 2D) = "bump" {}
		_Normal_Str("Normal_Str", Range( 1 , 10)) = 1
		_Vampire_emission("Vampire_emission", 2D) = "white" {}
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,0)
		_Fresnel_Norma_Tex("Fresnel_Norma_Tex", 2D) = "bump" {}
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 0
		_F_Normal_Tex_VTiling("F_Normal_Tex_VTiling", Float) = 0
		_F_Normal_Tex_UTiling("F_Normal_Tex_UTiling", Float) = 0
		_F_Normal_Tex_Str("F_Normal_Tex_Str", Range( 1 , 10)) = 0
		_Fresnel_Val("Fresnel_Val", Range( 0 , 1)) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thnkinee("Edge_Thnkinee", Range( 0 , 0.14)) = 0.1
		[HDR]_Hit_Fx("Hit_Fx", Color) = (1,1,1,0)
		_Hit_Val("Hit_Val", Range( 0 , 1)) = 0
		_Vertex_Dissolve("Vertex_Dissolve", Range( -10 , 10)) = -0.5292548
		_Vertex_Diss_Edge("Vertex_Diss_Edge", Float) = 0.1
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		[Toggle(_USE_VERTEX_DISSOVE_ON)] _Use_Vertex_Dissove("Use_Vertex_Dissove", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_VERTEX_DISSOVE_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _Normal_Str;
		uniform sampler2D _Vampire_normal;
		uniform float4 _Vampire_normal_ST;
		uniform sampler2D _Vampire_diffuse;
		uniform float4 _Vampire_diffuse_ST;
		uniform float4 _Albedo_Color;
		uniform float4 _Hit_Fx;
		uniform float _Hit_Val;
		uniform sampler2D _Vampire_emission;
		uniform float4 _Vampire_emission_ST;
		uniform float4 _Emi_Color;
		uniform float _F_Normal_Tex_Str;
		uniform sampler2D _Fresnel_Norma_Tex;
		uniform float _F_Normal_Tex_UTiling;
		uniform float _F_Normal_Tex_VTiling;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float4 _Fresnel_Color;
		uniform float _Fresnel_Val;
		uniform float _Edge_Thnkinee;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float4 _Edge_Color;
		uniform float _Vertex_Diss_Edge;
		uniform float _Vertex_Dissolve;
		uniform float4 _Tint_Color;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Vampire_normal = i.uv_texcoord * _Vampire_normal_ST.xy + _Vampire_normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Vampire_normal, uv_Vampire_normal ), _Normal_Str );
			float2 uv_Vampire_diffuse = i.uv_texcoord * _Vampire_diffuse_ST.xy + _Vampire_diffuse_ST.zw;
			float4 lerpResult51 = lerp( ( tex2D( _Vampire_diffuse, uv_Vampire_diffuse ) * _Albedo_Color ) , _Hit_Fx , _Hit_Val);
			o.Albedo = lerpResult51.rgb;
			float2 uv_Vampire_emission = i.uv_texcoord * _Vampire_emission_ST.xy + _Vampire_emission_ST.zw;
			float4 temp_cast_1 = (3.0).xxxx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult25 = (float2(_F_Normal_Tex_UTiling , _F_Normal_Tex_VTiling));
			float fresnelNdotV15 = dot( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Fresnel_Norma_Tex, (i.uv_texcoord*appendResult25 + 0.0) ), _F_Normal_Tex_Str ) )), ase_worldViewDir );
			float fresnelNode15 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV15, _Fresnel_Pow ) );
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float temp_output_37_0 = ( tex2D( _Dissolve_Texture, (uv0_Dissolve_Texture*1.0 + 0.0) ).r + _Dissolve );
			float temp_output_40_0 = step( _Edge_Thnkinee , temp_output_37_0 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_60_0 = saturate( ( ( 1.0 - ase_vertex3Pos.y ) + _Vertex_Dissolve ) );
			float temp_output_61_0 = step( _Vertex_Diss_Edge , temp_output_60_0 );
			#ifdef _USE_VERTEX_DISSOVE_ON
				float4 staticSwitch70 = ( ( temp_output_61_0 - step( 0.15 , temp_output_60_0 ) ) * _Tint_Color );
			#else
				float4 staticSwitch70 = ( ( temp_output_40_0 - step( 0.15 , temp_output_37_0 ) ) * _Edge_Color );
			#endif
			o.Emission = ( ( ( pow( tex2D( _Vampire_emission, uv_Vampire_emission ) , temp_cast_1 ) * _Emi_Color ) + ( ( saturate( fresnelNode15 ) * _Fresnel_Color ) * _Fresnel_Val ) ) + staticSwitch70 ).rgb;
			o.Alpha = 1;
			#ifdef _USE_VERTEX_DISSOVE_ON
				float staticSwitch71 = temp_output_61_0;
			#else
				float staticSwitch71 = temp_output_40_0;
			#endif
			clip( staticSwitch71 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
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
2065;70;1920;763;909.7247;909.0132;2.858545;True;False
Node;AmplifyShaderEditor.CommentaryNode;30;-177.9193,-146.3725;Float;False;2205.473;508.4;Fresnel;16;32;19;33;20;16;15;18;17;21;22;31;23;25;27;26;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-122.9194,51.07559;Float;False;Property;_F_Normal_Tex_UTiling;F_Normal_Tex_UTiling;12;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-127.9194,132.0756;Float;False;Property;_F_Normal_Tex_VTiling;F_Normal_Tex_VTiling;11;0;Create;True;0;0;False;0;0;3.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-17.67585,-89.14694;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;69;-136.789,800.774;Float;False;2160.533;661.0801;Comment;13;71;66;61;62;65;67;63;60;64;57;59;58;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;117.0807,88.07559;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;39;966.2189,384.5094;Float;False;1028.295;379.0001;Dissolve;5;36;34;37;38;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;31;184.1657,181.2749;Float;False;Property;_F_Normal_Tex_Str;F_Normal_Tex_Str;13;0;Create;True;0;0;False;0;0;1.46;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;1016.219,438.2268;Float;True;0;34;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;56;-86.78899,946.7749;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;206.5528,-80.37259;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;393.5526,-96.37258;Float;True;Property;_Fresnel_Norma_Tex;Fresnel_Norma_Tex;7;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;59;185.211,946.7749;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;36;1248.514,462.5098;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;76.41102,1208.775;Float;False;Property;_Vertex_Dissolve;Vertex_Dissolve;21;0;Create;True;0;0;False;0;-0.5292548;-1.2;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;617.5528,151.6274;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;9;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;393.2111,946.7749;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;1446.514,434.5097;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;15;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;48;2047.537,-146.0234;Float;False;1294.053;575.6569;Edge;8;70;40;46;45;44;41;42;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;18;621.5528,233.6275;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;10;0;Create;True;0;0;False;0;0;3.04;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1459.514,647.5102;Float;False;Property;_Dissolve;Dissolve;16;0;Create;True;0;0;False;0;0;0.61;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;21;723.5517,-82.37259;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;60;617.2111,946.7749;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;713.2111,1186.775;Float;False;Constant;_Float4;Float 4;22;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;770.9111,858.5739;Float;False;Property;_Vertex_Diss_Edge;Vertex_Diss_Edge;22;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;2098.615,212.5208;Float;False;Constant;_Float2;Float 2;17;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;15;945.3937,-80.0397;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;2062.714,-8.048835;Float;False;Property;_Edge_Thnkinee;Edge_Thnkinee;18;0;Create;True;0;0;False;0;0.1;0.1383;0;0.14;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;1174.88,-689.3325;Float;False;819.8;486.3999;Emission;5;2;10;11;9;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;1767.845,453.1791;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;1207.552,164.6274;Float;False;Property;_Fresnel_Color;Fresnel_Color;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.548243,2.191489,4.867144,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;41;2393.839,209.061;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;1392.679,-444.9324;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;1224.88,-639.3325;Float;True;Property;_Vampire_emission;Vampire_emission;5;0;Create;True;0;0;False;0;338e7235dd349f64db419d21d404671f;338e7235dd349f64db419d21d404671f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;61;926.5781,918.7619;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;63;937.2111,1186.775;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;40;2348.407,-43.87195;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;1240.552,-77.37259;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;1517.679,-635.9326;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;1450.95,161.869;Float;False;Property;_Fresnel_Val;Fresnel_Val;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;2565.075,141.6279;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;1529.679,-414.9326;Float;False;Property;_Emi_Color;Emi_Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.216786,1.216786,1.216786,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;67;1161.211,1202.775;Float;False;Property;_Tint_Color;Tint_Color;23;1;[HDR];Create;True;0;0;False;0;0,0,0,0;4.988257,3.82916,0.8693229,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;1161.211,962.7748;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;46;2540.963,-109.0544;Float;False;Property;_Edge_Color;Edge_Color;17;1;[HDR];Create;True;0;0;False;0;1,1,1,0;11.8926,5.045683,2.075595,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;12;2090.642,-1253.547;Float;False;575.0001;450;Albedo;3;1;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;1402.552,-81.9726;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;6;2225.642,-1015.547;Float;False;Property;_Albedo_Color;Albedo_Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;1686.251,-86.43089;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;2140.642,-1203.547;Float;True;Property;_Vampire_diffuse;Vampire_diffuse;1;0;Create;True;0;0;False;0;ddc020db4cfe91f4cb336620630db7a7;ddc020db4cfe91f4cb336620630db7a7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1394.628,981.5129;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2861.618,109.9852;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;1759.679,-633.9326;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;13;2078.071,-770.5711;Float;False;620.5997;280;Normal;2;3;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;70;3046.697,-96.66251;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;24;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;2456.316,-1115.597;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;2100.871,-673.9711;Float;False;Property;_Normal_Str;Normal_Str;4;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;49;2762.76,-870.8857;Float;False;Property;_Hit_Fx;Hit_Fx;19;1;[HDR];Create;True;0;0;False;0;1,1,1,0;6.498019,6.498019,6.498019,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;2744.531,-686.5161;Float;False;Property;_Hit_Val;Hit_Val;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;2576.337,-401.1786;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;51;3117.854,-861.7917;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;2378.671,-720.5707;Float;True;Property;_Vampire_normal;Vampire_normal;3;0;Create;True;0;0;False;0;15c51cdbc0767604eb8f450edea3ae77;15c51cdbc0767604eb8f450edea3ae77;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;47;3103.131,-388.4749;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;71;1675.629,1136.068;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3428.683,-451.6206;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/CH_FX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;23;0;24;0
WireConnection;23;1;25;0
WireConnection;22;1;23;0
WireConnection;22;5;31;0
WireConnection;59;0;56;2
WireConnection;36;0;35;0
WireConnection;57;0;59;0
WireConnection;57;1;58;0
WireConnection;34;1;36;0
WireConnection;21;0;22;0
WireConnection;60;0;57;0
WireConnection;15;0;21;0
WireConnection;15;2;17;0
WireConnection;15;3;18;0
WireConnection;37;0;34;1
WireConnection;37;1;38;0
WireConnection;41;0;43;0
WireConnection;41;1;37;0
WireConnection;61;0;62;0
WireConnection;61;1;60;0
WireConnection;63;0;64;0
WireConnection;63;1;60;0
WireConnection;40;0;42;0
WireConnection;40;1;37;0
WireConnection;16;0;15;0
WireConnection;10;0;2;0
WireConnection;10;1;11;0
WireConnection;44;0;40;0
WireConnection;44;1;41;0
WireConnection;65;0;61;0
WireConnection;65;1;63;0
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;32;0;19;0
WireConnection;32;1;33;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;45;0;44;0
WireConnection;45;1;46;0
WireConnection;8;0;10;0
WireConnection;8;1;9;0
WireConnection;70;1;45;0
WireConnection;70;0;66;0
WireConnection;5;0;1;0
WireConnection;5;1;6;0
WireConnection;28;0;8;0
WireConnection;28;1;32;0
WireConnection;51;0;5;0
WireConnection;51;1;49;0
WireConnection;51;2;52;0
WireConnection;3;5;7;0
WireConnection;47;0;28;0
WireConnection;47;1;70;0
WireConnection;71;1;40;0
WireConnection;71;0;61;0
WireConnection;0;0;51;0
WireConnection;0;1;3;0
WireConnection;0;2;47;0
WireConnection;0;10;71;0
ASEEND*/
//CHKSM=D389F582BCBB310D4F10D6FC03D480C8D6AD8ECF