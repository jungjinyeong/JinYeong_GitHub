// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/CH_FX"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Ice_Texture("Ice_Texture", 2D) = "white" {}
		_Ice_Tex_Normal("Ice_Tex_Normal", 2D) = "bump" {}
		_Vampire_diffuse("Vampire_diffuse", 2D) = "white" {}
		_Float1("Float 1", Range( 0 , 1)) = 1
		[HDR]_Albedo_Color("Albedo_Color", Color) = (1,1,1,0)
		_Float3("Float 3", Range( 1 , 10)) = 6.188235
		_Vampire_normal("Vampire_normal", 2D) = "bump" {}
		_Normal_Str("Normal_Str", Range( 1 , 10)) = 1
		_Normal_Scale("Normal_Scale", Range( 0 , 3)) = 0.7882353
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_Vampire_emission("Vampire_emission", 2D) = "white" {}
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,0)
		[HDR]_Color1("Color 1", Color) = (1,1,1,0)
		_Emi_Pow("Emi_Pow", Float) = 3
		_Emi_Ins("Emi_Ins", Float) = 0
		_Fresnel_Normal_Tex("Fresnel_Normal_Tex", 2D) = "bump" {}
		_Parallax_Texture("Parallax_Texture", 2D) = "white" {}
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Parallax_Scale("Parallax_Scale", Range( -10 , 10)) = 0
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 0
		_F_Normal_Tex_VTiling("F_Normal_Tex_VTiling", Float) = 0
		_F_Normal_Tex_UTiling("F_Normal_Tex_UTiling", Float) = 0
		_Ice_Tex_VPanner("Ice_Tex_VPanner", Float) = 0
		_F_Normal_Tex_Str("F_Normal_Tex_Str", Range( 1 , 10)) = 0
		_Fresnel_Val("Fresnel_Val", Range( 0 , 1)) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thnkinee("Edge_Thnkinee", Range( 0 , 0.14)) = 0.1
		[HDR]_Hit_Fx("Hit_Fx", Color) = (1,1,1,0)
		_Hit_Val("Hit_Val", Range( 0 , 1)) = 0
		[Toggle(_USE_VERTEX_DISSOVE_ON)] _Use_Vertex_Dissove("Use_Vertex_Dissove", Float) = 0
		_Vertex_Dissolve("Vertex_Dissolve", Range( -10 , 10)) = -0.5292548
		_Vertex_Diss_Edge("Vertex_Diss_Edge", Float) = 0.1
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		[Toggle(_USE_LERP_FX_ON)] _Use_Lerp_FX("Use_Lerp_FX", Float) = 0
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
		#pragma shader_feature_local _USE_VERTEX_DISSOVE_ON
		#pragma shader_feature_local _USE_LERP_FX_ON
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
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Ice_Tex_Normal;
		uniform sampler2D _Vampire_emission;
		uniform float4 _Vampire_emission_ST;
		uniform float _Normal_Scale;
		uniform sampler2D _Vampire_normal;
		uniform float4 _Vampire_normal_ST;
		uniform float _Normal_Str;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _Ice_Texture;
		uniform float _Ice_Tex_VPanner;
		uniform sampler2D _Vampire_diffuse;
		uniform float4 _Vampire_diffuse_ST;
		uniform sampler2D _Parallax_Texture;
		uniform float _Parallax_Scale;
		uniform float4 _Color1;
		uniform float4 _Albedo_Color;
		uniform float4 _Hit_Fx;
		uniform float _Hit_Val;
		uniform float _Emi_Pow;
		uniform float _Emi_Ins;
		uniform float4 _Emi_Color;
		uniform float4 _Color0;
		uniform float _Float1;
		uniform float _Float3;
		uniform sampler2D _Fresnel_Normal_Tex;
		uniform float _F_Normal_Tex_UTiling;
		uniform float _F_Normal_Tex_VTiling;
		uniform float _F_Normal_Tex_Str;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float4 _Fresnel_Color;
		uniform float _Fresnel_Val;
		uniform float _Edge_Thnkinee;
		uniform float4 _Edge_Color;
		uniform float _Vertex_Diss_Edge;
		uniform float _Vertex_Dissolve;
		uniform float4 _Tint_Color;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Vampire_emission = i.uv_texcoord * _Vampire_emission_ST.xy + _Vampire_emission_ST.zw;
			float3 tex2DNode83 = UnpackScaleNormal( tex2D( _Ice_Tex_Normal, uv_Vampire_emission ), _Normal_Scale );
			float2 uv_Vampire_normal = i.uv_texcoord * _Vampire_normal_ST.xy + _Vampire_normal_ST.zw;
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float temp_output_37_0 = ( tex2D( _Dissolve_Texture, (uv_Dissolve_Texture*1.0 + 0.0) ).r + _Dissolve );
			float temp_output_41_0 = step( 0.15 , temp_output_37_0 );
			float3 lerpResult109 = lerp( tex2DNode83 , UnpackScaleNormal( tex2D( _Vampire_normal, uv_Vampire_normal ), _Normal_Str ) , temp_output_41_0);
			o.Normal = lerpResult109;
			float2 appendResult103 = (float2(0.0 , _Ice_Tex_VPanner));
			float2 uv_Vampire_diffuse = i.uv_texcoord * _Vampire_diffuse_ST.xy + _Vampire_diffuse_ST.zw;
			float2 Offset82 = ( ( tex2D( _Parallax_Texture, i.uv_texcoord ).r - 1 ) * i.viewDir.xy * _Parallax_Scale ) + uv_Vampire_diffuse;
			float2 panner100 = ( 1.0 * _Time.y * appendResult103 + (Offset82*float2( 2,2 ) + 0.0));
			float4 temp_output_98_0 = ( tex2D( _Ice_Texture, panner100 ) * _Color1 );
			float4 lerpResult104 = lerp( temp_output_98_0 , ( tex2D( _Vampire_diffuse, uv_Vampire_diffuse ) * _Albedo_Color ) , temp_output_41_0);
			float4 lerpResult51 = lerp( lerpResult104 , _Hit_Fx , _Hit_Val);
			o.Albedo = lerpResult51.rgb;
			float4 temp_cast_1 = (_Emi_Pow).xxxx;
			float fresnelNdotV88 = dot( tex2DNode83, i.viewDir );
			float fresnelNode88 = ( 0.0 + _Float1 * pow( 1.0 - fresnelNdotV88, _Float3 ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult25 = (float2(_F_Normal_Tex_UTiling , _F_Normal_Tex_VTiling));
			float fresnelNdotV15 = dot( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Fresnel_Normal_Tex, (i.uv_texcoord*appendResult25 + 0.0) ), _F_Normal_Tex_Str ) )), ase_worldViewDir );
			float fresnelNode15 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV15, _Fresnel_Pow ) );
			float4 lerpResult106 = lerp( ( ( _Color0 * saturate( fresnelNode88 ) ) + temp_output_98_0 ) , ( ( saturate( fresnelNode15 ) * _Fresnel_Color ) * _Fresnel_Val ) , temp_output_41_0);
			float temp_output_40_0 = step( _Edge_Thnkinee , temp_output_37_0 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_60_0 = saturate( ( ( 1.0 - ase_vertex3Pos.x ) + _Vertex_Dissolve ) );
			float temp_output_61_0 = step( _Vertex_Diss_Edge , temp_output_60_0 );
			#ifdef _USE_VERTEX_DISSOVE_ON
				float4 staticSwitch70 = ( ( temp_output_61_0 - step( 0.15 , temp_output_60_0 ) ) * _Tint_Color );
			#else
				float4 staticSwitch70 = ( ( temp_output_40_0 - temp_output_41_0 ) * _Edge_Color );
			#endif
			o.Emission = ( ( ( ( pow( tex2D( _Vampire_emission, uv_Vampire_emission ) , temp_cast_1 ) * _Emi_Ins ) * _Emi_Color ) + lerpResult106 ) + staticSwitch70 ).rgb;
			o.Alpha = 1;
			#ifdef _USE_VERTEX_DISSOVE_ON
				float staticSwitch71 = temp_output_61_0;
			#else
				float staticSwitch71 = temp_output_40_0;
			#endif
			#ifdef _USE_LERP_FX_ON
				float staticSwitch107 = 1.0;
			#else
				float staticSwitch107 = staticSwitch71;
			#endif
			clip( staticSwitch107 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xboxseries playstation switch nomrt 
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
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
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
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
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
Version=18935
0;73;1462;639;-1366.451;1093.403;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-122.9194,51.07559;Float;False;Property;_F_Normal_Tex_UTiling;F_Normal_Tex_UTiling;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-127.9194,132.0756;Float;False;Property;_F_Normal_Tex_VTiling;F_Normal_Tex_VTiling;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;117.0807,88.07559;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-4147.725,-1156.17;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-17.67585,-89.14694;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;184.1657,181.2749;Float;False;Property;_F_Normal_Tex_Str;F_Normal_Tex_Str;25;0;Create;True;0;0;0;False;0;False;0;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;78;-3947.511,-1168.602;Inherit;True;Property;_Parallax_Texture;Parallax_Texture;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;76;-3923.36,-977.5266;Float;False;Property;_Parallax_Scale;Parallax_Scale;19;0;Create;True;0;0;0;False;0;False;0;0;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;75;-3856.361,-904.5269;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;206.5528,-80.37259;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-3888.36,-1293.526;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;1016.219,438.2268;Inherit;True;0;34;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;80;-3476.361,-923.5269;Float;False;Constant;_Vector1;Vector 1;9;0;Create;True;0;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;102;-2958.269,-1143.324;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;82;-3603.361,-1185.526;Inherit;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;56;-86.78899,946.7749;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;101;-2956.269,-1049.323;Float;False;Property;_Ice_Tex_VPanner;Ice_Tex_VPanner;24;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-4237.737,-2062.056;Inherit;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;393.5526,-97.44853;Inherit;True;Property;_Fresnel_Normal_Tex;Fresnel_Normal_Tex;16;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;79;-3980.77,-1663.623;Float;False;Property;_Normal_Scale;Normal_Scale;9;0;Create;True;0;0;0;False;0;False;0.7882353;0.7882353;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;621.5528,233.6275;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;21;0;Create;True;0;0;0;False;0;False;0;1.57;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;83;-3688.601,-1848.423;Inherit;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;2;0;Create;True;0;0;0;False;0;False;-1;a193986083da480468d48b2feb42d6cd;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;59;185.211,946.7749;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;86;-3299.361,-965.5269;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;21;723.5517,-82.37259;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;103;-2761.269,-1152.324;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-3617.771,-1417.623;Float;False;Property;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;617.5528,151.6274;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;36;1248.514,462.5098;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;85;-3556.771,-1604.623;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;58;76.41102,1208.775;Float;False;Property;_Vertex_Dissolve;Vertex_Dissolve;34;0;Create;True;0;0;0;False;0;False;-0.5292548;10;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-3622.771,-1331.622;Float;False;Property;_Float3;Float 3;6;0;Create;True;0;0;0;False;0;False;6.188235;6.188235;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;88;-3277.771,-1627.623;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;1446.514,434.5097;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;27;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;100;-2636.673,-1274.066;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;393.2111,946.7749;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;748.7221,-1074.34;Inherit;False;1104.61;486.3999;Emission;7;9;10;2;11;111;112;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode;15;945.3937,-80.0397;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;1459.514,647.5102;Float;False;Property;_Dissolve;Dissolve;29;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;1116.918,156.2354;Float;False;Property;_Fresnel_Color;Fresnel_Color;18;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;3.819985,2.360463,0.8829212,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;89;-2989.787,-1639.206;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;60;617.2111,946.7749;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-2442.697,-1309.932;Inherit;True;Property;_Ice_Texture;Ice_Texture;1;0;Create;True;0;0;0;False;0;False;-1;27b83114de59fc44dab96ecdeda996a0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;2132.475,-98.48731;Float;False;Property;_Edge_Thnkinee;Edge_Thnkinee;31;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0.14;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;713.2111,1186.775;Float;False;Constant;_Float4;Float 4;22;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;92;-2522.74,-1600.75;Float;False;Property;_Color0;Color 0;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;99;-2366.085,-1026.34;Float;False;Property;_Color1;Color 1;13;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;16;1240.552,-77.37259;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;798.7221,-1024.341;Inherit;True;Property;_Vampire_emission;Vampire_emission;11;0;Create;True;0;0;0;False;0;False;-1;338e7235dd349f64db419d21d404671f;c7c62bb5723ba83498c4a1a0262ddd24;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;770.9111,858.5739;Float;False;Property;_Vertex_Diss_Edge;Vertex_Diss_Edge;35;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;2050.795,200.3557;Float;False;Constant;_Float2;Float 2;17;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;966.5212,-829.941;Float;False;Property;_Emi_Pow;Emi_Pow;14;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;1773.346,409.4704;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;1198.007,-786.538;Float;False;Property;_Emi_Ins;Emi_Ins;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;12;2090.642,-1253.547;Inherit;False;575.0001;450;Albedo;1;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-2288.74,-1462.75;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;1402.552,-81.9726;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;1422.417,175.2962;Float;False;Property;_Fresnel_Val;Fresnel_Val;26;0;Create;True;0;0;0;False;0;False;0;0.638;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;41;2214.001,220.2005;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-2113.073,-1294.015;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;63;937.2111,1186.775;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;1091.521,-1020.942;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;40;2178.804,0.9516387;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;61;926.5781,918.7619;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;2137.238,-1201.845;Inherit;True;Property;_Vampire_diffuse;Vampire_diffuse;3;0;Create;True;0;0;0;False;0;False;-1;ddc020db4cfe91f4cb336620630db7a7;c7c62bb5723ba83498c4a1a0262ddd24;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;67;1161.211,1202.775;Float;False;Property;_Tint_Color;Tint_Color;36;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;1161.211,962.7748;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;46;2569.789,-48.87164;Float;False;Property;_Edge_Color;Edge_Color;30;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;1383.173,-1025.337;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-2015.136,-1505.059;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;2540.578,126.6356;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;1411.885,-782.2548;Float;False;Property;_Emi_Color;Emi_Color;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;1692.275,-65.89359;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;6;2225.642,-1015.547;Float;False;Property;_Albedo_Color;Albedo_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.515717,1.515717,1.515717,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1394.628,981.5129;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;2443.316,-1128.597;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;106;2674.633,-399.5323;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2793.933,-14.8881;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;2100.871,-673.9711;Float;False;Property;_Normal_Str;Normal_Str;8;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;1651.724,-1022.401;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;52;3156.579,-841.4457;Float;False;Property;_Hit_Val;Hit_Val;33;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;2969.617,-419.4156;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;71;3238.135,415.6837;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;28;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;70;3084.026,128.4879;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;49;3204.392,-1024.3;Float;False;Property;_Hit_Fx;Hit_Fx;32;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;2403.952,-733.1411;Inherit;True;Property;_Vampire_normal;Vampire_normal;7;0;Create;True;0;0;0;False;0;False;-1;15c51cdbc0767604eb8f450edea3ae77;44de87b6046a01a43abb13a147974cd2;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;108;3534.298,83.40341;Float;False;Constant;_Float6;Float 6;38;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;104;2790.374,-1470.178;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;51;3468.871,-995.2884;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;105;2092.84,-1473.484;Float;False;Property;_Change_Ice;Change_Ice;37;0;Create;True;0;0;0;False;0;False;0;0.355;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;90;-4118.771,-1791.623;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;-0.05,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;109;2906.031,-759.225;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;107;3795.142,1.614521;Float;True;Property;_Use_Lerp_FX;Use_Lerp_FX;38;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;91;-3926.77,-1835.623;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;3413.482,-404.5806;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4295.094,-477.5379;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;OTH/CH_FX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;48;2047.537,-146.0234;Inherit;False;1294.053;575.6569;Edge;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;39;966.2189,384.5094;Inherit;False;1028.295;379.0001;Dissolve;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;74;-4287.737,-2112.056;Inherit;False;2639.472;1472.956;Ice_FX;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;13;2078.071,-770.5711;Inherit;False;620.5997;280;Normal;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;30;-177.9193,-146.3725;Inherit;False;2205.473;508.4;Fresnel;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;69;-136.789,800.774;Inherit;False;2160.533;661.0801;Comment;0;;1,1,1,1;0;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;78;1;73;0
WireConnection;23;0;24;0
WireConnection;23;1;25;0
WireConnection;82;0;77;0
WireConnection;82;1;78;1
WireConnection;82;2;76;0
WireConnection;82;3;75;0
WireConnection;22;1;23;0
WireConnection;22;5;31;0
WireConnection;83;1;81;0
WireConnection;83;5;79;0
WireConnection;59;0;56;1
WireConnection;86;0;82;0
WireConnection;86;1;80;0
WireConnection;21;0;22;0
WireConnection;103;0;102;0
WireConnection;103;1;101;0
WireConnection;36;0;35;0
WireConnection;88;0;83;0
WireConnection;88;4;85;0
WireConnection;88;2;84;0
WireConnection;88;3;87;0
WireConnection;34;1;36;0
WireConnection;100;0;86;0
WireConnection;100;2;103;0
WireConnection;57;0;59;0
WireConnection;57;1;58;0
WireConnection;15;0;21;0
WireConnection;15;2;17;0
WireConnection;15;3;18;0
WireConnection;89;0;88;0
WireConnection;60;0;57;0
WireConnection;97;1;100;0
WireConnection;16;0;15;0
WireConnection;37;0;34;1
WireConnection;37;1;38;0
WireConnection;93;0;92;0
WireConnection;93;1;89;0
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;41;0;43;0
WireConnection;41;1;37;0
WireConnection;98;0;97;0
WireConnection;98;1;99;0
WireConnection;63;0;64;0
WireConnection;63;1;60;0
WireConnection;10;0;2;0
WireConnection;10;1;11;0
WireConnection;40;0;42;0
WireConnection;40;1;37;0
WireConnection;61;0;62;0
WireConnection;61;1;60;0
WireConnection;65;0;61;0
WireConnection;65;1;63;0
WireConnection;112;0;10;0
WireConnection;112;1;113;0
WireConnection;95;0;93;0
WireConnection;95;1;98;0
WireConnection;44;0;40;0
WireConnection;44;1;41;0
WireConnection;32;0;19;0
WireConnection;32;1;33;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;5;0;1;0
WireConnection;5;1;6;0
WireConnection;106;0;95;0
WireConnection;106;1;32;0
WireConnection;106;2;41;0
WireConnection;45;0;44;0
WireConnection;45;1;46;0
WireConnection;111;0;112;0
WireConnection;111;1;9;0
WireConnection;28;0;111;0
WireConnection;28;1;106;0
WireConnection;71;1;40;0
WireConnection;71;0;61;0
WireConnection;70;1;45;0
WireConnection;70;0;66;0
WireConnection;3;5;7;0
WireConnection;104;0;98;0
WireConnection;104;1;5;0
WireConnection;104;2;41;0
WireConnection;51;0;104;0
WireConnection;51;1;49;0
WireConnection;51;2;52;0
WireConnection;109;0;83;0
WireConnection;109;1;3;0
WireConnection;109;2;41;0
WireConnection;107;1;71;0
WireConnection;107;0;108;0
WireConnection;91;0;81;0
WireConnection;91;1;90;0
WireConnection;47;0;28;0
WireConnection;47;1;70;0
WireConnection;0;0;51;0
WireConnection;0;1;109;0
WireConnection;0;2;47;0
WireConnection;0;10;107;0
ASEEND*/
//CHKSM=60EC03EF1AF5A92968F39358BA3B4C8C3C3846DD