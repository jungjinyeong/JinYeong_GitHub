// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Shiled"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Pow("Main_Pow", Range( 1 , 5)) = 0
		_Main_Ins("Main_Ins", Range( 1 , 5)) = 1
		_Grap_Texture("Grap_Texture", 2D) = "bump" {}
		_Grab_Texture_Upanner("Grab_Texture_Upanner", Float) = 1
		_Grab_Texture_Vpanner("Grab_Texture_Vpanner", Float) = 1
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		_Nomal_Texture_Vpanner("Nomal_Texture_Vpanner", Float) = 0
		_Cromatic_Val("Cromatic_Val", Float) = 0
		_Main_Texture_Vpanner("Main_Texture_Vpanner", Float) = 0
		_Main_Texture_UTiling("Main_Texture_UTiling", Float) = 1
		_Main_Texture_VTiling("Main_Texture_VTiling", Float) = 1
		_Nomal_Texture_Upanner("Nomal_Texture_Upanner", Float) = 0
		_Main_Texture_Upanner("Main_Texture_Upanner", Float) = 0
		_Grap_Texture_Scale("Grap_Texture_Scale", Range( 0 , 5)) = 0.7647056
		_Nomal_Texture("Nomal_Texture", 2D) = "bump" {}
		_Nomal_Texture_Val("Nomal_Texture_Val", Range( 0 , 0.5)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Line_Noise_Texture("Line_Noise_Texture", 2D) = "white" {}
		_Line_Offset("Line_Offset", Float) = 1.5
		_Line_Min("Line_Min", Float) = 0.04
		_Line_Max("Line_Max", Float) = 0.1
		_Line_Noise_Vpanner("Line_Noise_Vpanner", Float) = 0
		_Line_Noise_Upanner("Line_Noise_Upanner", Float) = 1
		[HDR]_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPos;
			float4 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Cull_Mode;
		uniform float4 _Main_Color;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _Grap_Texture;
		uniform float _Grab_Texture_Upanner;
		uniform float _Grab_Texture_Vpanner;
		uniform float _Grap_Texture_Scale;
		uniform sampler2D _Main_Texture;
		uniform float _Main_Texture_Upanner;
		uniform float _Main_Texture_Vpanner;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Nomal_Texture;
		uniform float _Nomal_Texture_Upanner;
		uniform float _Nomal_Texture_Vpanner;
		uniform float4 _Nomal_Texture_ST;
		uniform float _Nomal_Texture_Val;
		uniform float _Main_Texture_UTiling;
		uniform float _Main_Texture_VTiling;
		uniform float _Cromatic_Val;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float _Line_Min;
		uniform sampler2D _Line_Noise_Texture;
		uniform float _Line_Noise_Upanner;
		uniform float _Line_Noise_Vpanner;
		uniform float4 _Line_Noise_Texture_ST;
		uniform float _Line_Offset;
		uniform float _Line_Max;
		uniform float4 _Color0;


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


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult161 = (float2(_Grab_Texture_Upanner , _Grab_Texture_Vpanner));
			float2 panner163 = ( 1.0 * _Time.y * appendResult161 + i.uv_texcoord.xy);
			float4 screenColor168 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( (UnpackScaleNormal( tex2D( _Grap_Texture, panner163 ), _Grap_Texture_Scale )).xyz , 0.0 ) ).xy);
			float2 appendResult140 = (float2(_Main_Texture_Upanner , _Main_Texture_Vpanner));
			float4 uvs_Main_Texture = i.uv_texcoord;
			uvs_Main_Texture.xy = i.uv_texcoord.xy * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult156 = (float2(_Nomal_Texture_Upanner , _Nomal_Texture_Vpanner));
			float4 uvs_Nomal_Texture = i.uv_texcoord;
			uvs_Nomal_Texture.xy = i.uv_texcoord.xy * _Nomal_Texture_ST.xy + _Nomal_Texture_ST.zw;
			float2 panner155 = ( 1.0 * _Time.y * appendResult156 + uvs_Nomal_Texture.xy);
			float2 panner132 = ( 1.0 * _Time.y * appendResult140 + ( float3( uvs_Main_Texture.xy ,  0.0 ) + ( (UnpackNormal( tex2D( _Nomal_Texture, panner155 ) )).xyz * _Nomal_Texture_Val ) ).xy);
			float2 appendResult153 = (float2(_Main_Texture_UTiling , _Main_Texture_VTiling));
			float2 temp_output_150_0 = (panner132*appendResult153 + 0.0);
			float2 temp_cast_4 = (_Cromatic_Val).xx;
			float3 appendResult137 = (float3(tex2D( _Main_Texture, ( temp_output_150_0 + _Cromatic_Val ) ).r , tex2D( _Main_Texture, temp_output_150_0 ).g , tex2D( _Main_Texture, ( temp_output_150_0 - temp_cast_4 ) ).b));
			float3 temp_cast_5 = (_Main_Pow).xxx;
			float2 appendResult203 = (float2(_Line_Noise_Upanner , _Line_Noise_Vpanner));
			float4 uvs_Line_Noise_Texture = i.uv_texcoord;
			uvs_Line_Noise_Texture.xy = i.uv_texcoord.xy * _Line_Noise_Texture_ST.xy + _Line_Noise_Texture_ST.zw;
			float2 panner198 = ( 1.0 * _Time.y * appendResult203 + uvs_Line_Noise_Texture.xy);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch222 = i.uv_texcoord.z;
			#else
				float staticSwitch222 = _Line_Offset;
			#endif
			float temp_output_189_0 = saturate( ( ( tex2D( _Line_Noise_Texture, panner198 ) + float4( i.uv_texcoord.xy, 0.0 , 0.0 ) ).g + staticSwitch222 ) );
			float temp_output_195_0 = step( _Line_Min , temp_output_189_0 );
			o.Emission = ( ( _Main_Color * ( screenColor168 + float4( ( pow( appendResult137 , temp_cast_5 ) * _Main_Ins ) , 0.0 ) ) ) + ( ( temp_output_195_0 - step( _Line_Max , temp_output_189_0 ) ) * _Color0 ) ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_195_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
613;27;1298;998;1046.34;1116.609;2.162248;True;False
Node;AmplifyShaderEditor.RangedFloatNode;157;-2917.247,-170.9989;Inherit;False;Property;_Nomal_Texture_Upanner;Nomal_Texture_Upanner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-2910.08,-92.19351;Inherit;False;Property;_Nomal_Texture_Vpanner;Nomal_Texture_Vpanner;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;154;-2675.855,-289.5679;Inherit;False;0;142;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;156;-2599.328,-156.9989;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;155;-2398.285,-285.9132;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;142;-2179.134,-314.9518;Inherit;True;Property;_Nomal_Texture;Nomal_Texture;21;0;Create;True;0;0;0;False;0;False;-1;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;147;-1860.292,-311.5664;Inherit;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-1914.066,-62.13508;Inherit;False;Property;_Nomal_Texture_Val;Nomal_Texture_Val;22;0;Create;True;0;0;0;False;0;False;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-1391.957,-23.4227;Inherit;False;Property;_Main_Texture_Vpanner;Main_Texture_Vpanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-1391.957,-103.4227;Inherit;False;Property;_Main_Texture_Upanner;Main_Texture_Upanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-1609.145,-307.6497;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-768.0225,669.4995;Inherit;False;Property;_Line_Noise_Vpanner;Line_Noise_Vpanner;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-768.1353,540.7487;Inherit;False;Property;_Line_Noise_Upanner;Line_Noise_Upanner;30;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;131;-1597.119,-443.9853;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;204;-699.1019,378.1674;Inherit;False;0;197;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;203;-531.8319,566.6727;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;140;-1135.957,-87.42268;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-1136.9,53.99434;Inherit;False;Property;_Main_Texture_UTiling;Main_Texture_UTiling;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;141;-1349.054,-327.3517;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-1137.591,133.1451;Inherit;False;Property;_Main_Texture_VTiling;Main_Texture_VTiling;17;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;159;-797.0322,-517.3527;Inherit;False;Property;_Grab_Texture_Vpanner;Grab_Texture_Vpanner;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;198;-395.7023,382.5762;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;132;-973.3933,-176.3355;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;153;-921.412,45.23515;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-813.0322,-613.3527;Inherit;False;Property;_Grab_Texture_Upanner;Grab_Texture_Upanner;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-720.7526,46.32109;Inherit;False;Property;_Cromatic_Val;Cromatic_Val;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;150;-748.9431,-174.1091;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;197;-183.4661,342.4059;Inherit;True;Property;_Line_Noise_Texture;Line_Noise_Texture;25;0;Create;True;0;0;0;False;0;False;-1;None;41a89d3615ad8f34e9bd4fd043a70610;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;179;-144.4198,579.1555;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;221;-108.3738,744.7646;Inherit;False;320;275;W : Offset T : Empty;1;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;161;-557.0327,-581.3527;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;162;-628.6627,-738.5733;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;215;75.4584,616.262;Inherit;False;Property;_Line_Offset;Line_Offset;26;0;Create;True;0;0;0;False;0;False;1.5;-0.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;126;-436.2701,-362.5654;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;None;03344d3d32e85af4faf109e635145a9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexCoordVertexDataNode;223;-58.37371,794.765;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;164;-384.4035,-516.7028;Inherit;False;Property;_Grap_Texture_Scale;Grap_Texture_Scale;20;0;Create;True;0;0;0;False;0;False;0.7647056;0.1425436;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;163;-336.4035,-740.7028;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;181.7427,405.7799;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;133;-415.8896,-180.369;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;134;-413.5833,27.85111;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;128;-69.04813,3.415655;Inherit;True;Property;_TextureSample5;Texture Sample 5;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;235;419.7663,407.0394;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;166;-57.34729,-569.8494;Inherit;True;Property;_Grap_Texture;Grap_Texture;9;0;Create;True;0;0;0;False;0;False;-1;None;da5feafade73aad4eb052b907e1945ab;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;127;-69.48412,-176.5445;Inherit;True;Property;_TextureSample4;Texture Sample 4;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;222;285.976,700.1727;Float;True;Property;_Use_Custom;Use_Custom;23;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;125;-70.03902,-358.6566;Inherit;True;Property;_TextureSample3;Texture Sample 3;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;340.9794,-99.78763;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;0;False;0;False;0;1;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;137;378.7771,-330.6927;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;210;366.2828,-557.8124;Inherit;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;165;370.9856,-738.0713;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;214;585.2626,433.3391;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;1058.664,828.9872;Inherit;False;Property;_Line_Max;Line_Max;28;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;189;828.2007,437.0852;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;636.1376,-101.1861;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;0;False;0;False;1;1;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;1052.24,499.2451;Inherit;False;Property;_Line_Min;Line_Min;27;0;Create;True;0;0;0;False;0;False;0.04;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;657.4479,-557.3104;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;169;644.609,-329.2285;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;917.4211,-330.3148;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;196;1245.26,775.8126;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;168;950.8008,-559.2919;Float;False;Global;_GrabScreen1;Grab Screen 1;27;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;195;1228.67,411.662;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;1237.132,-284.3937;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;225;1233.336,-561.5478;Inherit;False;Property;_Main_Color;Main_Color;24;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;194;1483.054,493.2717;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;218;1531.491,748.9631;Inherit;False;Property;_Color0;Color 0;31;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.8490566,0.6317893,0.2122642,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;76;1219.683,8.161602;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;217;1783.705,498.8678;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;1507.737,-308.5692;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;105;1545.051,-1397.087;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;220;1915.9,-266.0441;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-242.9622,-1213.215;Float;False;Property;_SubTex_VPanner;SubTex_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;1483.754,242.7049;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;2329.867,-187.4119;Float;False;Property;_Cull_Mode;Cull_Mode;12;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;662.0379,-1393.215;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;727.0388,-1107.215;Float;False;Property;_SubTex_Ins;SubTex_Ins;5;0;Create;True;0;0;0;False;0;False;0;0.93;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-262.9622,-1496.215;Inherit;False;0;53;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;374.038,-1123.215;Float;False;Property;_SubTex_Pow;SubTex_Pow;4;0;Create;True;0;0;0;False;0;False;0;2.49;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;62;1081.952,-1120.896;Float;False;Property;_SubTex_Color;SubTex_Color;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;9.716479,3.682501,1.730332,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;46;59.03776,-1481.215;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;1000.038,-1392.215;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-244.9622,-1287.215;Float;False;Property;_SubTex_UPanner;SubTex_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;342.8417,-1381.727;Inherit;True;Property;_Sub_Texture;Sub_Texture;3;0;Create;True;0;0;0;False;0;False;-1;None;02898dfb4fcd1e249b2c981ed0c5c828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;44;-31.96223,-1263.215;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;1287.352,-1402.995;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2128.159,-316.0209;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Shiled;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;156;0;157;0
WireConnection;156;1;158;0
WireConnection;155;0;154;0
WireConnection;155;2;156;0
WireConnection;142;1;155;0
WireConnection;147;0;142;0
WireConnection;148;0;147;0
WireConnection;148;1;149;0
WireConnection;203;0;200;0
WireConnection;203;1;201;0
WireConnection;140;0;138;0
WireConnection;140;1;139;0
WireConnection;141;0;131;0
WireConnection;141;1;148;0
WireConnection;198;0;204;0
WireConnection;198;2;203;0
WireConnection;132;0;141;0
WireConnection;132;2;140;0
WireConnection;153;0;151;0
WireConnection;153;1;152;0
WireConnection;150;0;132;0
WireConnection;150;1;153;0
WireConnection;197;1;198;0
WireConnection;161;0;160;0
WireConnection;161;1;159;0
WireConnection;163;0;162;0
WireConnection;163;2;161;0
WireConnection;199;0;197;0
WireConnection;199;1;179;0
WireConnection;133;0;150;0
WireConnection;133;1;135;0
WireConnection;134;0;150;0
WireConnection;134;1;135;0
WireConnection;128;0;126;0
WireConnection;128;1;134;0
WireConnection;235;0;199;0
WireConnection;166;1;163;0
WireConnection;166;5;164;0
WireConnection;127;0;126;0
WireConnection;127;1;150;0
WireConnection;222;1;215;0
WireConnection;222;0;223;3
WireConnection;125;0;126;0
WireConnection;125;1;133;0
WireConnection;137;0;125;1
WireConnection;137;1;127;2
WireConnection;137;2;128;3
WireConnection;210;0;166;0
WireConnection;214;0;235;1
WireConnection;214;1;222;0
WireConnection;189;0;214;0
WireConnection;167;0;165;0
WireConnection;167;1;210;0
WireConnection;169;0;137;0
WireConnection;169;1;51;0
WireConnection;170;0;169;0
WireConnection;170;1;78;0
WireConnection;196;0;193;0
WireConnection;196;1;189;0
WireConnection;168;0;167;0
WireConnection;195;0;191;0
WireConnection;195;1;189;0
WireConnection;173;0;168;0
WireConnection;173;1;170;0
WireConnection;194;0;195;0
WireConnection;194;1;196;0
WireConnection;217;0;194;0
WireConnection;217;1;218;0
WireConnection;224;0;225;0
WireConnection;224;1;173;0
WireConnection;105;0;69;0
WireConnection;220;0;224;0
WireConnection;220;1;217;0
WireConnection;216;0;76;4
WireConnection;216;1;195;0
WireConnection;59;0;53;1
WireConnection;59;1;55;0
WireConnection;46;0;43;0
WireConnection;46;2;44;0
WireConnection;64;0;59;0
WireConnection;64;1;58;0
WireConnection;53;1;46;0
WireConnection;44;0;37;0
WireConnection;44;1;33;0
WireConnection;69;0;64;0
WireConnection;69;1;62;0
WireConnection;0;2;220;0
WireConnection;0;9;216;0
ASEEND*/
//CHKSM=DCB74608DB17605D21624C1EF678689C32F62E26