// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "m"
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
		_Position("Position", Vector) = (0,0,0,0)
		_Vertex_Position_Val("Vertex_Position_Val", Range( -5 , 5)) = 0
		_Vertex_Noise("Vertex_Noise", Range( 0 , 1)) = 1.8
		_Use_Color("Use_Color", Range( 0 , 1)) = 0
		[HDR]_VertexOffset_ColorB("VertexOffset_ColorB", Color) = (0,0,0,0)
		[HDR]_VertexOffset_ColorA("VertexOffset_ColorA", Color) = (0,0,0,0)
		[Toggle(_USE_MOVEOFFSET_ON)] _Use_MoveOffset("Use_MoveOffset", Float) = 0
		_VertexNoise_Texture("VertexNoise_Texture", 2D) = "white" {}
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
		#pragma shader_feature _USE_MOVEOFFSET_ON
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			float4 screenPosition;
		};

		uniform float3 _Position;
		uniform sampler2D _VertexNoise_Texture;
		uniform float4 _VertexNoise_Texture_ST;
		uniform float _Vertex_Noise;
		uniform float _Vertex_Position_Val;
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
		uniform float4 _VertexOffset_ColorA;
		uniform float4 _VertexOffset_ColorB;
		uniform float _Use_Color;
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
			float3 worldToObj57 = mul( unity_WorldToObject, float4( _Position, 1 ) ).xyz;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_output_56_0 = ( worldToObj57 - ase_vertex3Pos );
			#ifdef _USE_MOVEOFFSET_ON
				float3 staticSwitch85 = ( ase_vertex3Pos + temp_output_56_0 );
			#else
				float3 staticSwitch85 = temp_output_56_0;
			#endif
			float3 normalizeResult64 = normalize( temp_output_56_0 );
			float3 ase_vertexNormal = v.normal.xyz;
			float dotResult63 = dot( normalizeResult64 , ase_vertexNormal );
			float2 uv0_VertexNoise_Texture = v.texcoord.xy * _VertexNoise_Texture_ST.xy + _VertexNoise_Texture_ST.zw;
			float2 panner89 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + uv0_VertexNoise_Texture);
			float temp_output_76_0 = ( dotResult63 + ( tex2Dlod( _VertexNoise_Texture, float4( panner89, 0, 0.0) ).r * _Vertex_Noise ) );
			float3 lerpResult58 = lerp( float3( 0,0,0 ) , staticSwitch85 , saturate( ( temp_output_76_0 + _Vertex_Position_Val ) ));
			v.vertex.xyz += lerpResult58;
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
			float3 worldToObj57 = mul( unity_WorldToObject, float4( _Position, 1 ) ).xyz;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 temp_output_56_0 = ( worldToObj57 - ase_vertex3Pos );
			float3 normalizeResult64 = normalize( temp_output_56_0 );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float dotResult63 = dot( normalizeResult64 , ase_vertexNormal );
			float2 uv0_VertexNoise_Texture = i.uv_texcoord * _VertexNoise_Texture_ST.xy + _VertexNoise_Texture_ST.zw;
			float2 panner89 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + uv0_VertexNoise_Texture);
			float temp_output_76_0 = ( dotResult63 + ( tex2D( _VertexNoise_Texture, panner89 ).r * _Vertex_Noise ) );
			float4 lerpResult80 = lerp( _VertexOffset_ColorA , _VertexOffset_ColorB , saturate( temp_output_76_0 ));
			o.Emission = ( ( lerpResult3 + ( ( temp_output_37_0 - step( 0.15 , temp_output_35_0 ) ) * _Edge_Color ) ) + ( lerpResult80 * _Use_Color ) ).rgb;
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
0;0;1920;1019;2833.874;1133.985;3.094982;True;False
Node;AmplifyShaderEditor.CommentaryNode;53;-1517.722,-1370.041;Float;False;2195.519;691.8272;Comment;18;7;3;46;48;49;19;22;13;14;47;17;20;9;2;4;8;6;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;86;-1643.714,154.2357;Float;False;2504.976;1468.664;Vertex_Offset;25;68;71;61;58;85;66;80;81;82;79;67;77;76;78;63;72;64;56;57;54;55;87;89;90;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1467.722,-1033.773;Float;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1446.513,-968.5822;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;12;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1808.345,-651.6161;Float;False;1028.295;379.0001;Dissolve;5;35;33;32;31;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;55;-1256.581,430.1155;Float;False;Property;_Position;Position;17;0;Create;True;0;0;False;0;0,0,0;0,10,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-1758.345,-597.8987;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;22;-1238.722,-1142.774;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1410.722,-1305.774;Float;True;0;47;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;90;-1240.457,1277.695;Float;False;Constant;_Vector0;Vector 0;24;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TransformPositionNode;57;-1109.207,442.593;Float;False;World;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;88;-1310.922,1067.727;Float;False;0;87;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;54;-1282.449,605.2308;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;89;-1070.457,1215.695;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1138.291,-898.6266;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;7;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-1526.05,-573.6157;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-1130.722,-1305.774;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1194.038,-794.2131;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;8;0;Create;True;0;0;False;0;2;4.1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;56;-895.9161,453.834;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;32;-1362.769,-611.0772;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;13;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;c2f5e06ce5d539b418dc5ebfbfeeee94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;61;-814.0496,915.1404;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;64;-591.7294,545.2242;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-590.4377,1288.302;Float;False;Property;_Vertex_Noise;Vertex_Noise;19;0;Create;True;0;0;False;0;1.8;0.385;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;87;-900.7739,1155.895;Float;True;Property;_VertexNoise_Texture;VertexNoise_Texture;24;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;2;-821.0288,-930.692;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-833.5226,-1030.073;Float;False;Property;_Noise_Tex_Str;Noise_Tex_Str;10;0;Create;True;0;0;False;0;0.85;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1315.05,-388.6155;Float;False;Property;_Dissolve;Dissolve;14;0;Create;True;0;0;False;0;0;0.32;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;26;-766.4092,-659.5589;Float;False;1719.073;609.2741;Edge;10;45;24;23;41;39;40;38;37;34;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;47;-997.5131,-1251.44;Float;True;Property;_Noise_Texture;Noise_Texture;9;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-349.0239,1131.51;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-698.1517,-320.1797;Float;False;Constant;_Float2;Float 2;17;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-618.1367,-1196.473;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;63;-546.0518,921.8535;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-990.2177,-622.6552;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-742.4716,-608.0228;Float;False;Property;_Edge_Thnkinee;Edge_Thnkinee;16;0;Create;True;0;0;False;0;0.1;0.0274;0;0.14;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-530.5378,-970.6131;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-54.55399,912.106;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-463.7916,-1209.701;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;38;-452.6456,-306.235;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;37;-464.2425,-520.0837;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-223.6248,-969.8614;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-215.3099,-1151.761;Float;False;Property;_Fresnel_Out_Color;Fresnel_Out_Color;6;1;[HDR];Create;True;0;0;False;0;1,0.03301889,0.03301889,0;1.304119,0.4642937,1.051489,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-221.5137,-1309.15;Float;False;Property;_Fresnel_In_Color;Fresnel_In_Color;5;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.0260324,0.03813933,0.1226415,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;-144.3684,-312.8998;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;81;235.7551,204.2357;Float;False;Property;_VertexOffset_ColorA;VertexOffset_ColorA;22;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.2641509,0.06501,0.06354573,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;79;255.7551,511.236;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;82;239.7551,374.2357;Float;False;Property;_VertexOffset_ColorB;VertexOffset_ColorB;21;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.5471698,0.5471698,0.5471698,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-92.37087,1264.729;Float;False;Property;_Vertex_Position_Val;Vertex_Position_Val;18;0;Create;True;0;0;False;0;0;-4.35;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;78;-874.877,277.1669;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;-244.1573,-562.407;Float;False;Property;_Edge_Color;Edge_Color;15;1;[HDR];Create;True;0;0;False;0;1,1,1,0;3.24901,1.578528,2.534659,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;49.38663,-570.5236;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;80;549.755,268.2357;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;92;675.5812,389.2422;Float;False;Property;_Use_Color;Use_Color;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;712.7439,-1115.41;Float;False;585.7868;437.9435;Comment;5;11;10;51;50;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;3;66.48631,-1080.15;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;223.2762,-528.3106;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;181.6285,1041.719;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-577.2643,295.2282;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;66;443.0967,822.8842;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;442.7965,-1101.63;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;776.7438,-905.1517;Float;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;False;0;0;0.152;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;85;-164.0146,487.6952;Float;False;Property;_Use_MoveOffset;Use_MoveOffset;23;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DitheringNode;24;471.6679,-454.0697;Float;False;0;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;762.7438,-820.1517;Float;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;False;0;0;0.475;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;963.5813,260.2422;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;50;1066.228,-875.4669;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;51;1075.228,-788.4669;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;58;596.2628,557.0331;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;1346.543,-401.7177;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;619.1259,-333.7129;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;1065.531,-1065.41;Float;False;Property;_Albedo_Color;Albedo_Color;1;0;Create;True;0;0;False;0;0.509434,0.509434,0.509434,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1647,-400;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;m;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;19;0
WireConnection;22;1;20;0
WireConnection;57;0;55;0
WireConnection;89;0;88;0
WireConnection;89;2;90;0
WireConnection;31;0;30;0
WireConnection;14;0;13;0
WireConnection;14;2;22;0
WireConnection;56;0;57;0
WireConnection;56;1;54;0
WireConnection;32;1;31;0
WireConnection;64;0;56;0
WireConnection;87;1;89;0
WireConnection;2;2;8;0
WireConnection;2;3;9;0
WireConnection;47;1;14;0
WireConnection;71;0;87;1
WireConnection;71;1;72;0
WireConnection;49;0;47;1
WireConnection;49;1;17;0
WireConnection;63;0;64;0
WireConnection;63;1;61;0
WireConnection;35;0;32;1
WireConnection;35;1;33;0
WireConnection;4;0;2;0
WireConnection;76;0;63;0
WireConnection;76;1;71;0
WireConnection;46;0;49;0
WireConnection;46;1;4;0
WireConnection;38;0;36;0
WireConnection;38;1;35;0
WireConnection;37;0;34;0
WireConnection;37;1;35;0
WireConnection;48;0;46;0
WireConnection;48;1;4;0
WireConnection;40;0;37;0
WireConnection;40;1;38;0
WireConnection;79;0;76;0
WireConnection;41;0;40;0
WireConnection;41;1;39;0
WireConnection;80;0;81;0
WireConnection;80;1;82;0
WireConnection;80;2;79;0
WireConnection;3;0;7;0
WireConnection;3;1;6;0
WireConnection;3;2;48;0
WireConnection;67;0;76;0
WireConnection;67;1;68;0
WireConnection;77;0;78;0
WireConnection;77;1;56;0
WireConnection;66;0;67;0
WireConnection;44;0;3;0
WireConnection;44;1;41;0
WireConnection;85;1;56;0
WireConnection;85;0;77;0
WireConnection;24;0;23;0
WireConnection;91;0;80;0
WireConnection;91;1;92;0
WireConnection;50;0;10;0
WireConnection;51;0;11;0
WireConnection;58;1;85;0
WireConnection;58;2;66;0
WireConnection;84;0;44;0
WireConnection;84;1;91;0
WireConnection;45;0;24;0
WireConnection;45;1;37;0
WireConnection;0;0;1;0
WireConnection;0;2;84;0
WireConnection;0;3;50;0
WireConnection;0;4;51;0
WireConnection;0;10;45;0
WireConnection;0;11;58;0
ASEEND*/
//CHKSM=271A9C1694536EABA8874B3977689B55271CD3A1