// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/CH_Position_FX"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Vampire_diffuse("Vampire_diffuse", 2D) = "white" {}
		_Albedo_Color("Albedo_Color", Color) = (1,1,1,0)
		_Vampire_normal("Vampire_normal", 2D) = "bump" {}
		_Normal_Str("Normal_Str", Range( 1 , 10)) = 1
		_Normal_Scale("Normal_Scale", Range( 0 , 3)) = 0.7882353
		_Vampire_emission("Vampire_emission", 2D) = "white" {}
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,0)
		_Fresnel_Normal_Tex("Fresnel_Normal_Tex", 2D) = "bump" {}
		_Fresnel_Val("Fresnel_Val", Range( 0 , 1)) = 0
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 0
		_F_Normal_Tex_UTiling("F_Normal_Tex_UTiling", Float) = 0
		_F_Normal_Tex_VTiling("F_Normal_Tex_VTiling", Float) = 0
		_Ice_Texture("Ice_Texture", 2D) = "white" {}
		[HDR]_Ice_Color("Ice_Color", Color) = (1,1,1,0)
		_Parallax_Texture("Parallax_Texture", 2D) = "white" {}
		_Parallax_Scale("Parallax_Scale", Range( -10 , 10)) = 0
		_Ice_Tex_Normal("Ice_Tex_Normal", 2D) = "bump" {}
		_F_Normal_Tex_Str("F_Normal_Tex_Str", Range( 1 , 10)) = 0
		_Ice_Tex_VPanner("Ice_Tex_VPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thnkinee("Edge_Thnkinee", Range( 0 , 0.14)) = 0.1
		[HDR]_Hit_Fx("Hit_Fx", Color) = (1,1,1,0)
		_Hit_Val("Hit_Val", Range( 0 , 1)) = 0
		_Vertex_Dissolve("Vertex_Dissolve", Range( -10 , 10)) = -0.5292548
		_Vertex_Diss_Edge("Vertex_Diss_Edge", Float) = 0.1
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
		[Toggle(_USE_VERTEX_DISSOVE_ON)] _Use_Vertex_Dissove("Use_Vertex_Dissove", Float) = 0
		[Toggle(_USE_LERP_FX_ON)] _Use_Lerp_FX("Use_Lerp_FX", Float) = 0
		_VertexNoise_Texture("VertexNoise_Texture", 2D) = "white" {}
		_Position("Position", Vector) = (0,0,0,0)
		_Vertex_Position_Val("Vertex_Position_Val", Range( -5 , 5)) = 0
		[Toggle(_USE_MOVEOFFSET_ON)] _Use_MoveOffset("Use_MoveOffset", Float) = 0
		_Vertex_Noise("Vertex_Noise", Range( 0 , 1)) = 1.8
		_Use_Vertex_Color("Use_Vertex_Color", Range( 0 , 1)) = 0
		[HDR]_VertexOffset_ColorA("VertexOffset_ColorA", Color) = (0,0,0,0)
		[HDR]_VertexOffset_ColorB("VertexOffset_ColorB", Color) = (0,0,0,0)
		_VertexPosi_UPanner("VertexPosi_UPanner", Float) = 0
		_VertexPosi_VPanner("VertexPosi_VPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_MOVEOFFSET_ON
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

		uniform float3 _Position;
		uniform sampler2D _VertexNoise_Texture;
		uniform float _VertexPosi_UPanner;
		uniform float _VertexPosi_VPanner;
		uniform float4 _VertexNoise_Texture_ST;
		uniform float _Vertex_Noise;
		uniform float _Vertex_Position_Val;
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
		uniform float4 _Ice_Color;
		uniform float4 _Albedo_Color;
		uniform float4 _Hit_Fx;
		uniform float _Hit_Val;
		uniform float4 _Emi_Color;
		uniform float4 _Fresnel_Color;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Fresnel_Normal_Tex;
		uniform float _F_Normal_Tex_UTiling;
		uniform float _F_Normal_Tex_VTiling;
		uniform float _F_Normal_Tex_Str;
		uniform float _Fresnel_Val;
		uniform float _Edge_Thnkinee;
		uniform float4 _Edge_Color;
		uniform float _Vertex_Diss_Edge;
		uniform float _Vertex_Dissolve;
		uniform float4 _Tint_Color;
		uniform float4 _VertexOffset_ColorA;
		uniform float4 _VertexOffset_ColorB;
		uniform float _Use_Vertex_Color;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 worldToObj113 = mul( unity_WorldToObject, float4( _Position, 1 ) ).xyz;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_output_117_0 = ( worldToObj113 - ase_vertex3Pos );
			#ifdef _USE_MOVEOFFSET_ON
				float3 staticSwitch134 = ( ase_vertex3Pos + temp_output_117_0 );
			#else
				float3 staticSwitch134 = temp_output_117_0;
			#endif
			float3 normalizeResult119 = normalize( temp_output_117_0 );
			float3 ase_vertexNormal = v.normal.xyz;
			float dotResult123 = dot( normalizeResult119 , ase_vertexNormal );
			float2 appendResult143 = (float2(_VertexPosi_UPanner , _VertexPosi_VPanner));
			float2 uv_VertexNoise_Texture = v.texcoord.xy * _VertexNoise_Texture_ST.xy + _VertexNoise_Texture_ST.zw;
			float2 panner116 = ( 1.0 * _Time.y * appendResult143 + uv_VertexNoise_Texture);
			float temp_output_124_0 = ( dotResult123 + ( tex2Dlod( _VertexNoise_Texture, float4( panner116, 0, 0.0) ).r * _Vertex_Noise ) );
			float3 lerpResult135 = lerp( float3( 0,0,0 ) , staticSwitch134 , saturate( ( temp_output_124_0 + _Vertex_Position_Val ) ));
			v.vertex.xyz += lerpResult135;
			v.vertex.w = 1;
		}

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
			float4 temp_output_98_0 = ( tex2D( _Ice_Texture, panner100 ) * _Ice_Color );
			float4 lerpResult104 = lerp( temp_output_98_0 , ( tex2D( _Vampire_diffuse, uv_Vampire_diffuse ) * _Albedo_Color ) , temp_output_41_0);
			float4 lerpResult51 = lerp( lerpResult104 , _Hit_Fx , _Hit_Val);
			o.Albedo = lerpResult51.rgb;
			float4 temp_cast_1 = (3.0).xxxx;
			float fresnelNdotV88 = dot( tex2DNode83, i.viewDir );
			float fresnelNode88 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV88, _Fresnel_Pow ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult25 = (float2(_F_Normal_Tex_UTiling , _F_Normal_Tex_VTiling));
			float fresnelNdotV15 = dot( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Fresnel_Normal_Tex, (i.uv_texcoord*appendResult25 + 0.0) ), _F_Normal_Tex_Str ) )), ase_worldViewDir );
			float fresnelNode15 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV15, _Fresnel_Pow ) );
			float4 lerpResult106 = lerp( ( ( _Fresnel_Color * saturate( fresnelNode88 ) ) + temp_output_98_0 ) , ( ( saturate( fresnelNode15 ) * _Fresnel_Color ) * _Fresnel_Val ) , temp_output_41_0);
			float temp_output_40_0 = step( _Edge_Thnkinee , temp_output_37_0 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_60_0 = saturate( ( ( 1.0 - ase_vertex3Pos.x ) + _Vertex_Dissolve ) );
			float temp_output_61_0 = step( _Vertex_Diss_Edge , temp_output_60_0 );
			#ifdef _USE_VERTEX_DISSOVE_ON
				float4 staticSwitch70 = ( ( temp_output_61_0 - step( 0.15 , temp_output_60_0 ) ) * _Tint_Color );
			#else
				float4 staticSwitch70 = ( ( temp_output_40_0 - temp_output_41_0 ) * _Edge_Color );
			#endif
			float3 worldToObj113 = mul( unity_WorldToObject, float4( _Position, 1 ) ).xyz;
			float3 temp_output_117_0 = ( worldToObj113 - ase_vertex3Pos );
			float3 normalizeResult119 = normalize( temp_output_117_0 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float dotResult123 = dot( normalizeResult119 , ase_vertexNormal );
			float2 appendResult143 = (float2(_VertexPosi_UPanner , _VertexPosi_VPanner));
			float2 uv_VertexNoise_Texture = i.uv_texcoord * _VertexNoise_Texture_ST.xy + _VertexNoise_Texture_ST.zw;
			float2 panner116 = ( 1.0 * _Time.y * appendResult143 + uv_VertexNoise_Texture);
			float temp_output_124_0 = ( dotResult123 + ( tex2D( _VertexNoise_Texture, panner116 ).r * _Vertex_Noise ) );
			float4 lerpResult130 = lerp( _VertexOffset_ColorA , _VertexOffset_ColorB , saturate( temp_output_124_0 ));
			o.Emission = ( ( ( ( pow( tex2D( _Vampire_emission, uv_Vampire_emission ) , temp_cast_1 ) * _Emi_Color ) + lerpResult106 ) + staticSwitch70 ) + ( lerpResult130 * _Use_Vertex_Color ) ).rgb;
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
				vertexDataFunc( v, customInputData );
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
0;73;1460;639;-1525.98;-345.5769;1.469375;True;False
Node;AmplifyShaderEditor.CommentaryNode;30;-349.4125,-1086.987;Inherit;False;2205.473;508.4;Fresnel;16;32;19;33;20;16;15;18;17;21;22;31;23;25;27;26;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-294.4127,-889.5389;Float;False;Property;_F_Normal_Tex_UTiling;F_Normal_Tex_UTiling;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-299.4127,-808.5389;Float;False;Property;_F_Normal_Tex_VTiling;F_Normal_Tex_VTiling;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;74;-777.5831,-3239.938;Inherit;False;2616.026;1150.571;Ice_FX;26;86;80;82;78;76;77;75;73;85;83;95;98;93;89;97;99;88;100;103;101;102;91;90;79;81;105;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-189.1691,-1029.761;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;73;-515.9005,-2503.788;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;25;-54.41254,-852.5389;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;78;-315.6863,-2516.22;Inherit;True;Property;_Parallax_Texture;Parallax_Texture;17;0;Create;True;0;0;0;False;0;False;-1;None;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;75;-224.5364,-2252.145;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;69;-308.2823,-139.8404;Inherit;False;2160.533;661.0801;Comment;12;66;61;62;65;67;63;60;64;57;59;58;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-291.5354,-2325.145;Float;False;Property;_Parallax_Scale;Parallax_Scale;18;0;Create;True;0;0;0;False;0;False;0;-0.25;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;794.7257,-556.105;Inherit;False;1028.295;379.0001;Dissolve;5;36;34;37;38;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;35.05954,-1020.987;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;12.67244,-759.3395;Float;False;Property;_F_Normal_Tex_Str;F_Normal_Tex_Str;20;0;Create;True;0;0;0;False;0;False;0;3.89;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;2021.008,-134.6216;Inherit;False;3172.201;1294.949;Vertex_Offset;27;137;135;134;133;132;131;130;129;128;127;126;125;124;123;122;121;120;119;118;117;116;115;114;113;111;136;141;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-256.5354,-2641.144;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-727.5829,-3189.939;Inherit;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;82;28.4635,-2533.144;Inherit;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;844.7258,-502.3876;Inherit;True;0;34;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;79;-470.6159,-2791.506;Float;False;Property;_Normal_Scale;Normal_Scale;5;0;Create;True;0;0;0;False;0;False;0.7882353;0.7882353;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;292.0594,-1032.063;Inherit;True;Property;_Fresnel_Normal_Tex;Fresnel_Normal_Tex;8;0;Create;True;0;0;0;False;0;False;-1;None;291b26790b4e30e43b6347b381849af8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;102;621.0338,-2602.393;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;111;2408.142,141.2582;Float;False;Property;_Position;Position;35;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;80;155.4639,-2271.145;Float;False;Constant;_Vector1;Vector 1;9;0;Create;True;0;0;0;False;0;False;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;141;2346.455,1061.573;Float;False;Property;_VertexPosi_UPanner;VertexPosi_UPanner;42;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;623.0338,-2508.392;Float;False;Property;_Ice_Tex_VPanner;Ice_Tex_VPanner;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;56;-258.2822,6.160468;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;142;2343.455,1137.573;Float;False;Property;_VertexPosi_VPanner;VertexPosi_VPanner;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;86;401.6131,-2644.331;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;36;1077.021,-478.1046;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-95.08223,268.1606;Float;False;Property;_Vertex_Dissolve;Vertex_Dissolve;28;0;Create;True;0;0;0;False;0;False;-0.5292548;-0.5292548;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;59;13.71774,6.160468;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;450.0596,-706.9869;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;12;0;Create;True;0;0;0;False;0;False;0;2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;115;2382.274,316.3734;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;114;2353.801,778.8698;Inherit;False;0;121;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;85;75.05359,-2952.24;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;21;552.0585,-1022.987;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;83;-76.54381,-3107.324;Inherit;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;19;0;Create;True;0;0;0;False;0;False;-1;a193986083da480468d48b2feb42d6cd;a193986083da480468d48b2feb42d6cd;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;103;818.0338,-2611.393;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;17;446.0596,-788.9871;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;11;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;2588.455,1090.573;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformPositionNode;113;2555.516,153.7357;Inherit;False;World;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;38;1288.021,-293.1042;Float;False;Property;_Dissolve;Dissolve;23;0;Create;True;0;0;0;False;0;False;1;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;116;2594.266,926.8378;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;1275.021,-506.1047;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;22;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;15;773.9005,-1020.654;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;1876.044,-1086.638;Inherit;False;1294.053;575.6569;Edge;8;70;40;46;45;44;41;42;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;117;2768.807,164.9767;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;88;301.5318,-3086.692;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;100;942.6299,-2733.135;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;221.7178,6.160468;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;1105.606,-2772.001;Inherit;True;Property;_Ice_Texture;Ice_Texture;15;0;Create;True;0;0;0;False;0;False;-1;27b83114de59fc44dab96ecdeda996a0;27b83114de59fc44dab96ecdeda996a0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;118;2850.673,626.2831;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;120;3074.285,999.4445;Float;False;Property;_Vertex_Noise;Vertex_Noise;38;0;Create;True;0;0;0;False;0;False;1.8;0.077;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;119;3072.993,256.3669;Inherit;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;60;445.7179,6.160468;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;99;1075.218,-2540.409;Float;False;Property;_Ice_Color;Ice_Color;16;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.7578583,0.7578583,0.7578583,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;121;2763.949,867.0377;Inherit;True;Property;_VertexNoise_Texture;VertexNoise_Texture;34;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;541.718,246.1606;Float;False;Constant;_Float4;Float 4;22;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;1000.062,-1997.428;Inherit;False;819.8;486.3999;Emission;5;2;10;11;9;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;62;599.4179,-82.04051;Float;False;Property;_Vertex_Diss_Edge;Vertex_Diss_Edge;29;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;1069.059,-1017.987;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;89;589.5157,-3098.275;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;1879.302,-740.2588;Float;False;Constant;_Float2;Float 2;17;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;945.4249,-784.3791;Float;False;Property;_Fresnel_Color;Fresnel_Color;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.9098039,1.239216,1.905882,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;1960.982,-1039.102;Float;False;Property;_Edge_Thnkinee;Edge_Thnkinee;25;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0.14;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;1601.853,-531.144;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;1466.23,-2753.084;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;63;765.718,246.1606;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;61;755.085,-21.85252;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;1217.861,-1753.029;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;1250.924,-765.3182;Float;False;Property;_Fresnel_Val;Fresnel_Val;9;0;Create;True;0;0;0;False;0;False;0;0.736;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;123;3118.671,632.9962;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;40;2007.311,-939.6628;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;1290.563,-2921.819;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;1231.059,-1022.587;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;1050.062,-1947.428;Inherit;True;Property;_Vampire_emission;Vampire_emission;6;0;Create;True;0;0;0;False;0;False;-1;338e7235dd349f64db419d21d404671f;338e7235dd349f64db419d21d404671f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;3315.699,842.6527;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;41;2042.508,-720.4139;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;1564.167,-2964.127;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;1520.782,-1006.508;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;2398.296,-989.4862;Float;False;Property;_Edge_Color;Edge_Color;24;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;124;3610.169,623.2487;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;67;989.7178,262.1606;Float;False;Property;_Tint_Color;Tint_Color;30;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;1354.861,-1723.029;Float;False;Property;_Emi_Color;Emi_Color;7;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.02209709,0.02209709,0.02209709,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;989.7178,22.16035;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;1342.861,-1944.029;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;12;1919.149,-2194.161;Inherit;False;575.0001;450;Albedo;3;1;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;2369.084,-813.9789;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;127;3904.478,85.37839;Float;False;Property;_VertexOffset_ColorB;VertexOffset_ColorB;41;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;2.191489,0.1019297,5.55517,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;1965.745,-2142.459;Inherit;True;Property;_Vampire_diffuse;Vampire_diffuse;1;0;Create;True;0;0;0;False;0;False;-1;ddc020db4cfe91f4cb336620630db7a7;ddc020db4cfe91f4cb336620630db7a7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;1584.861,-1942.029;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;125;3900.478,-84.62152;Float;False;Property;_VertexOffset_ColorA;VertexOffset_ColorA;40;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.9753099,0.5503583,0.3082347,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;1223.135,40.89839;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;13;1906.578,-1711.186;Inherit;False;620.5997;280;Normal;2;3;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;128;3572.352,975.8715;Float;False;Property;_Vertex_Position_Val;Vertex_Position_Val;36;0;Create;True;0;0;0;False;0;False;0;-2.93;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;2054.149,-1956.161;Float;False;Property;_Albedo_Color;Albedo_Color;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2622.44,-955.5027;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;126;3920.478,222.3787;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;129;2789.846,-11.69038;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;106;1862.923,-1362.52;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;2271.823,-2069.211;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;70;2912.532,-812.1266;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;31;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;130;4214.476,-20.62153;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;137;4188.648,-97.69397;Float;False;Property;_Use_Vertex_Color;Use_Vertex_Color;39;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;3087.458,6.371017;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;2798.124,-1360.03;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;1929.378,-1614.585;Float;False;Property;_Normal_Str;Normal_Str;4;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;3846.351,752.8617;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;3326.805,-900.2111;Float;False;Constant;_Float6;Float 6;38;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;104;2618.881,-2410.793;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;4485.577,17.88988;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;49;3032.899,-1964.914;Float;False;Property;_Hit_Fx;Hit_Fx;26;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;2985.086,-1782.06;Float;False;Property;_Hit_Val;Hit_Val;27;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;2232.458,-1673.755;Inherit;True;Property;_Vampire_normal;Vampire_normal;3;0;Create;True;0;0;0;False;0;False;-1;15c51cdbc0767604eb8f450edea3ae77;15c51cdbc0767604eb8f450edea3ae77;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;134;3500.708,198.8379;Float;False;Property;_Use_MoveOffset;Use_MoveOffset;37;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;71;3066.642,-524.9307;Float;True;Property;_Use_Vertex_Dissove;Use_Vertex_Dissove;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;4255.87,-486.7648;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;133;4107.817,534.0269;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;109;2734.538,-1699.839;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;4564.894,-485.3807;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;135;4582.704,453.7839;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;107;3623.649,-939;Float;True;Property;_Use_Lerp_FX;Use_Lerp_FX;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;90;-608.6171,-2919.506;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;-0.05,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;105;1415.366,-2521.037;Float;False;Property;_Change_Ice;Change_Ice;32;0;Create;True;0;0;0;False;0;False;0;0.355;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;91;-416.616,-2963.506;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;51;3297.378,-1935.903;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5328.643,-682.2656;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;OTH/CH_Position_FX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;86;0;82;0
WireConnection;86;1;80;0
WireConnection;36;0;35;0
WireConnection;59;0;56;1
WireConnection;21;0;22;0
WireConnection;83;1;81;0
WireConnection;83;5;79;0
WireConnection;103;0;102;0
WireConnection;103;1;101;0
WireConnection;143;0;141;0
WireConnection;143;1;142;0
WireConnection;113;0;111;0
WireConnection;116;0;114;0
WireConnection;116;2;143;0
WireConnection;34;1;36;0
WireConnection;15;0;21;0
WireConnection;15;2;17;0
WireConnection;15;3;18;0
WireConnection;117;0;113;0
WireConnection;117;1;115;0
WireConnection;88;0;83;0
WireConnection;88;4;85;0
WireConnection;88;2;17;0
WireConnection;88;3;18;0
WireConnection;100;0;86;0
WireConnection;100;2;103;0
WireConnection;57;0;59;0
WireConnection;57;1;58;0
WireConnection;97;1;100;0
WireConnection;119;0;117;0
WireConnection;60;0;57;0
WireConnection;121;1;116;0
WireConnection;16;0;15;0
WireConnection;89;0;88;0
WireConnection;37;0;34;1
WireConnection;37;1;38;0
WireConnection;98;0;97;0
WireConnection;98;1;99;0
WireConnection;63;0;64;0
WireConnection;63;1;60;0
WireConnection;61;0;62;0
WireConnection;61;1;60;0
WireConnection;123;0;119;0
WireConnection;123;1;118;0
WireConnection;40;0;42;0
WireConnection;40;1;37;0
WireConnection;93;0;20;0
WireConnection;93;1;89;0
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;122;0;121;1
WireConnection;122;1;120;0
WireConnection;41;0;43;0
WireConnection;41;1;37;0
WireConnection;95;0;93;0
WireConnection;95;1;98;0
WireConnection;32;0;19;0
WireConnection;32;1;33;0
WireConnection;124;0;123;0
WireConnection;124;1;122;0
WireConnection;65;0;61;0
WireConnection;65;1;63;0
WireConnection;10;0;2;0
WireConnection;10;1;11;0
WireConnection;44;0;40;0
WireConnection;44;1;41;0
WireConnection;8;0;10;0
WireConnection;8;1;9;0
WireConnection;66;0;65;0
WireConnection;66;1;67;0
WireConnection;45;0;44;0
WireConnection;45;1;46;0
WireConnection;126;0;124;0
WireConnection;106;0;95;0
WireConnection;106;1;32;0
WireConnection;106;2;41;0
WireConnection;5;0;1;0
WireConnection;5;1;6;0
WireConnection;70;1;45;0
WireConnection;70;0;66;0
WireConnection;130;0;125;0
WireConnection;130;1;127;0
WireConnection;130;2;126;0
WireConnection;132;0;129;0
WireConnection;132;1;117;0
WireConnection;28;0;8;0
WireConnection;28;1;106;0
WireConnection;131;0;124;0
WireConnection;131;1;128;0
WireConnection;104;0;98;0
WireConnection;104;1;5;0
WireConnection;104;2;41;0
WireConnection;136;0;130;0
WireConnection;136;1;137;0
WireConnection;3;5;7;0
WireConnection;134;1;117;0
WireConnection;134;0;132;0
WireConnection;71;1;40;0
WireConnection;71;0;61;0
WireConnection;47;0;28;0
WireConnection;47;1;70;0
WireConnection;133;0;131;0
WireConnection;109;0;83;0
WireConnection;109;1;3;0
WireConnection;109;2;41;0
WireConnection;140;0;47;0
WireConnection;140;1;136;0
WireConnection;135;1;134;0
WireConnection;135;2;133;0
WireConnection;107;1;71;0
WireConnection;107;0;108;0
WireConnection;91;0;81;0
WireConnection;91;1;90;0
WireConnection;51;0;104;0
WireConnection;51;1;49;0
WireConnection;51;2;52;0
WireConnection;0;0;51;0
WireConnection;0;1;109;0
WireConnection;0;2;140;0
WireConnection;0;10;107;0
WireConnection;0;11;135;0
ASEEND*/
//CHKSM=39F95E49EBD0E7D6A70CC481745790F0167C47A2