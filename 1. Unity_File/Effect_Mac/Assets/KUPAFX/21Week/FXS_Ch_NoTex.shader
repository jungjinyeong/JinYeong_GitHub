// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/CH_FX01_NoTex"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Albedo_Color("Albedo_Color", Color) = (0.509434,0.509434,0.509434,0)
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Opacity("Opacity", Range( -1 , 1)) = 0
		[HDR]_Fresnel_In_Color("Fresnel_In_Color", Color) = (0,0,0,0)
		[HDR]_Fresnel_Out_Color("Fresnel_Out_Color", Color) = (1,0.03301889,0.03301889,0)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 2
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Tex_Str("Noise_Tex_Str", Range( 0 , 1)) = 0.85
		_Noise_Tex_UPanner("Noise_Tex_UPanner", Float) = 0
		_Noise_Tex_VPanner("Noise_Tex_VPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Thnkinee("Edge_Thnkinee", Range( 0 , 0.14)) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			float4 screenPosition;
		};

		uniform float4 _Albedo_Color;
		uniform float4 _Fresnel_In_Color;
		uniform float4 _Fresnel_Out_Color;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_Tex_UPanner;
		uniform float _Noise_Tex_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Tex_Str;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float _Edge_Thnkinee;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve;
		uniform float4 _Edge_Color;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform float _Opacity;
		uniform float _Cutoff = 0.5;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Albedo_Color.rgb;
			float2 appendResult22 = (float2(_Noise_Tex_UPanner , _Noise_Tex_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner14 = ( 1.0 * _Time.y * appendResult22 + uv0_Noise_Texture);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV2 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode2 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV2, _Fresnel_Pow ) );
			float temp_output_4_0 = saturate( fresnelNode2 );
			float4 lerpResult3 = lerp( _Fresnel_In_Color , _Fresnel_Out_Color , ( ( ( tex2D( _Noise_Texture, panner14 ).r * _Noise_Tex_Str ) + temp_output_4_0 ) * temp_output_4_0 ));
			float temp_output_35_0 = ( tex2D( _Dissolve_Texture, (i.uv_texcoord*1.0 + 0.0) ).r + _Dissolve );
			float temp_output_37_0 = step( _Edge_Thnkinee , temp_output_35_0 );
			o.Emission = ( lerpResult3 + ( ( temp_output_37_0 - step( 0.15 , temp_output_35_0 ) ) * _Edge_Color ) ).rgb;
			o.Metallic = saturate( _Metallic );
			o.Smoothness = saturate( _Smoothness );
			o.Alpha = 1;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen24 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither24 = Dither4x4Bayer( fmod(clipScreen24.x, 4), fmod(clipScreen24.y, 4) );
			dither24 = step( dither24, _Opacity );
			clip( ( dither24 * temp_output_37_0 ) - _Cutoff );
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
				float2 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float3 worldPos : TEXCOORD3;
				float3 worldNormal : TEXCOORD4;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyzw = customInputData.screenPosition;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.screenPosition = IN.customPack2.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
0;18;1920;1001;1961.761;457.3477;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;25;-1645.362,365.5833;Float;False;1028.295;379.0001;Dissolve;5;35;33;32;31;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1807,15;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;12;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1809,-67;Float;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-1580,-176;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1752,-339;Float;True;0;47;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-1595.362,419.3008;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-1506.5,249.4;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;8;0;Create;True;0;0;False;0;2;4.1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1347.5,171.4;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;7;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-1363.067,443.5837;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-1472,-339;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;26;-593.8215,367.2457;Float;False;1294.053;575.6569;Edge;7;41;40;39;38;37;36;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;32;-1165.067,415.5836;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;13;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;c2f5e06ce5d539b418dc5ebfbfeeee94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-1220.753,-353.2668;Float;True;Property;_Noise_Texture;Noise_Texture;9;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1174.8,-63.3;Float;False;Property;_Noise_Tex_Str;Noise_Tex_Str;10;0;Create;True;0;0;False;0;0.85;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2;-1150.3,72.09999;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1152.067,628.584;Float;False;Property;_Dissolve;Dissolve;14;0;Create;True;0;0;False;0;0;0.34;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-827.2348,394.5443;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-843,73;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-525.5635,706.6248;Float;False;Constant;_Float2;Float 2;17;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-841.7532,-167.2668;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-569.8834,418.7818;Float;False;Property;_Edge_Thnkinee;Edge_Thnkinee;16;0;Create;True;0;0;False;0;0.1;0.118;0;0.14;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;37;-291.6544,506.7207;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;38;-280.0573,720.5695;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-581.7532,-125.2668;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-194,-209;Float;False;Property;_Fresnel_Out_Color;Fresnel_Out_Color;6;1;[HDR];Create;True;0;0;False;0;1,0.03301889,0.03301889,0;9.734288,3.465611,7.848588,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-193,-388;Float;False;Property;_Fresnel_In_Color;Fresnel_In_Color;5;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.0260324,0.03813933,0.1226415,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;484.7101,75.8759;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;28.21959,713.9047;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-276.7532,37.73315;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-71.56924,464.3975;Float;False;Property;_Edge_Color;Edge_Color;15;1;[HDR];Create;True;0;0;False;0;1,1,1,0;3.24901,1.578528,2.534659,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;416,-364;Float;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;False;0;0;0.475;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;221.9747,456.2809;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;430,-449;Float;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;False;0;0;0.152;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;95,-159;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DitheringNode;24;749.9102,70.87591;Float;False;0;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;935.788,75.9731;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;825,-611;Float;False;Property;_Albedo_Color;Albedo_Color;1;0;Create;True;0;0;False;0;0.509434,0.509434,0.509434,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;44;464.1064,-187.6834;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;51;728.4839,-332.3152;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;719.4839,-419.3152;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1146,-332;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/CH_FX01_NoTex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;19;0
WireConnection;22;1;20;0
WireConnection;31;0;30;0
WireConnection;14;0;13;0
WireConnection;14;2;22;0
WireConnection;32;1;31;0
WireConnection;47;1;14;0
WireConnection;2;2;8;0
WireConnection;2;3;9;0
WireConnection;35;0;32;1
WireConnection;35;1;33;0
WireConnection;4;0;2;0
WireConnection;49;0;47;1
WireConnection;49;1;17;0
WireConnection;37;0;34;0
WireConnection;37;1;35;0
WireConnection;38;0;36;0
WireConnection;38;1;35;0
WireConnection;46;0;49;0
WireConnection;46;1;4;0
WireConnection;40;0;37;0
WireConnection;40;1;38;0
WireConnection;48;0;46;0
WireConnection;48;1;4;0
WireConnection;41;0;40;0
WireConnection;41;1;39;0
WireConnection;3;0;7;0
WireConnection;3;1;6;0
WireConnection;3;2;48;0
WireConnection;24;0;23;0
WireConnection;45;0;24;0
WireConnection;45;1;37;0
WireConnection;44;0;3;0
WireConnection;44;1;41;0
WireConnection;51;0;11;0
WireConnection;50;0;10;0
WireConnection;0;0;1;0
WireConnection;0;2;44;0
WireConnection;0;3;50;0
WireConnection;0;4;51;0
WireConnection;0;10;45;0
ASEEND*/
//CHKSM=25234E0E0D80261D1DD10B6EE728C06E84B5B702