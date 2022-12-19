// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Shiled"
{
	Properties
	{
		_Main_Pow("Main_Pow", Range( 1 , 5)) = 0
		_Main_Ins("Main_Ins", Range( 1 , 5)) = 1
		_Grap_Texture("Grap_Texture", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		_Nomal_Texture_Vpanner("Nomal_Texture_Vpanner", Float) = 0
		_Cromatic_Val("Cromatic_Val", Float) = 0
		_Main_Texture_Vpanner("Main_Texture_Vpanner", Float) = 0
		_Main_Texture_UTiling("Main_Texture_UTiling", Float) = 1
		_Main_Texture_VTiling("Main_Texture_VTiling", Float) = 1
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Nomal_Texture_Upanner("Nomal_Texture_Upanner", Float) = 0
		_Main_Texture_Upanner("Main_Texture_Upanner", Float) = 0
		_Nomal_Texture("Nomal_Texture", 2D) = "bump" {}
		_Nomal_Texture_Val("Nomal_Texture_Val", Range( 0 , 0.5)) = 0
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
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform float _Cull_Mode;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _TextureSample0;
		uniform sampler2D _Grap_Texture;
		uniform float4 _Grap_Texture_ST;
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
			float2 uv_Grap_Texture = i.uv_texcoord * _Grap_Texture_ST.xy + _Grap_Texture_ST.zw;
			float2 panner163 = ( 1.0 * _Time.y * float2( 1,0 ) + uv_Grap_Texture);
			float4 screenColor168 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _TextureSample0, panner163 ), 0.5 ) , 0.0 ) ).xy);
			float2 appendResult140 = (float2(_Main_Texture_Upanner , _Main_Texture_Vpanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult156 = (float2(_Nomal_Texture_Upanner , _Nomal_Texture_Vpanner));
			float2 uv_Nomal_Texture = i.uv_texcoord * _Nomal_Texture_ST.xy + _Nomal_Texture_ST.zw;
			float2 panner155 = ( 1.0 * _Time.y * appendResult156 + uv_Nomal_Texture);
			float2 panner132 = ( 1.0 * _Time.y * appendResult140 + ( float3( uv_Main_Texture ,  0.0 ) + ( (UnpackNormal( tex2D( _Nomal_Texture, panner155 ) )).xyz * _Nomal_Texture_Val ) ).xy);
			float2 appendResult153 = (float2(_Main_Texture_UTiling , _Main_Texture_VTiling));
			float2 temp_output_150_0 = (panner132*appendResult153 + 0.0);
			float2 temp_cast_4 = (_Cromatic_Val).xx;
			float3 appendResult137 = (float3(tex2D( _Main_Texture, ( temp_output_150_0 + _Cromatic_Val ) ).r , tex2D( _Main_Texture, temp_output_150_0 ).g , tex2D( _Main_Texture, ( temp_output_150_0 - temp_cast_4 ) ).b));
			float3 temp_cast_5 = (_Main_Pow).xxx;
			o.Emission = ( screenColor168 + float4( ( pow( appendResult137 , temp_cast_5 ) * _Main_Ins ) , 0.0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1576;588;327.3276;494.684;1.524259;True;False
Node;AmplifyShaderEditor.RangedFloatNode;157;-3300.729,-216.5827;Inherit;False;Property;_Nomal_Texture_Upanner;Nomal_Texture_Upanner;35;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-3293.562,-137.7773;Inherit;False;Property;_Nomal_Texture_Vpanner;Nomal_Texture_Vpanner;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;156;-3026.81,-200.5827;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;154;-3060.337,-436.1517;Inherit;False;0;142;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;155;-2782.767,-432.497;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;142;-2517.959,-336.5789;Inherit;True;Property;_Nomal_Texture;Nomal_Texture;37;0;Create;True;0;0;0;False;0;False;-1;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;147;-2199.115,-333.1935;Inherit;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-2252.889,-83.7622;Inherit;False;Property;_Nomal_Texture_Val;Nomal_Texture_Val;38;0;Create;True;0;0;0;False;0;False;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-1792,112;Inherit;False;Property;_Main_Texture_Vpanner;Main_Texture_Vpanner;31;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-1792,32;Inherit;False;Property;_Main_Texture_Upanner;Main_Texture_Upanner;36;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;131;-1738.896,-424.7612;Inherit;False;0;126;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-1947.968,-329.2768;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-1302.3,19.26269;Inherit;False;Property;_Main_Texture_UTiling;Main_Texture_UTiling;32;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;140;-1536,48;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;141;-1511.154,-319.8121;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-1302.991,98.41351;Inherit;False;Property;_Main_Texture_VTiling;Main_Texture_VTiling;33;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;153;-1086.811,10.5035;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;132;-1280,-160;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-671.7459,43.80792;Inherit;False;Property;_Cromatic_Val;Cromatic_Val;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;150;-996.4899,-159.0301;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;162;-768.1055,-800.2627;Inherit;False;0;82;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;126;-553.8875,-381.0153;Inherit;True;Property;_Main_Texture;Main_Texture;34;0;Create;True;0;0;0;False;0;False;None;03344d3d32e85af4faf109e635145a9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;133;-399.746,-187.2877;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;134;-399.7459,32.46356;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;174;-729.891,-656.8263;Inherit;False;Constant;_Vector0;Vector 0;39;0;Create;True;0;0;0;False;0;False;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;164;-424.6221,-562.4;Inherit;False;Constant;_Float1;Float 1;27;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;127;-69.48412,-176.5445;Inherit;True;Property;_TextureSample4;Texture Sample 4;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;163;-434.6802,-779.5988;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;128;-65.85069,34.19105;Inherit;True;Property;_TextureSample5;Texture Sample 5;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;125;-64.34358,-383.3369;Inherit;True;Property;_TextureSample3;Texture Sample 3;29;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;348.5733,33.1059;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;0;False;0;False;0;1;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;165;-88.91833,-886.3956;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;137;393.9649,-230.0734;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;166;-169.9105,-692.9977;Inherit;True;Property;_TextureSample0;Texture Sample 0;21;0;Create;True;0;0;0;False;0;False;-1;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;78;643.7315,31.70744;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;0;False;0;False;1;1;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;176.5547,-830.9236;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;169;646.2314,-233.0405;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;938.9589,-230.8361;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;27;-3900.213,3254.96;Inherit;False;320;275;W : Offset T : Empty;1;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenColorNode;168;471.7651,-830.4107;Float;False;Global;_GrabScreen1;Grab Screen 1;27;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;40;-3494.712,3219.66;Float;True;Property;_Use_Custom;Use_Custom;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-5327.961,1891.969;Inherit;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;0;False;0;False;13;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;9;-5722.702,1776.339;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;84;-1850.456,1534.375;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-5223.813,2204.416;Float;False;Property;_Main_Noise_Str;Main_Noise_Str;12;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;77;-5024.562,2037.869;Inherit;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-6259.516,2071.897;Float;False;Property;_Main_Noise_VPanner;Main_Noise_VPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-2323.084,1863.781;Inherit;False;Property;_Grap_VPanner;Grap_VPanner;25;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-2309.108,1721.809;Inherit;False;Property;_Grap_UPanner;Grap_UPanner;23;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-3017.194,-1694.545;Float;False;Property;_SubTex_Ins;SubTex_Ins;6;0;Create;True;0;0;0;False;0;False;0;0.93;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;99;-2068.296,1739.01;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-893.3323,-592.165;Inherit;False;Property;_Float7;Float 7;22;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1955.764,1958.065;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-1840.398,1751.574;Inherit;False;Constant;_Float0;Float 0;27;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;80;-1504.694,1427.578;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;82;-1585.686,1620.976;Inherit;True;Property;_Grap_Texture;Grap_Texture;20;0;Create;True;0;0;0;False;0;False;-1;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-1239.221,1483.05;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StepOpNode;117;-2300.039,3068.656;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;83;-2183.881,1513.711;Inherit;False;0;82;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;50;-2529.304,1959.134;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-3750.891,2766.534;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-4853.513,2107.416;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1;1974.281,-244.6041;Float;False;Property;_Cull_Mode;Cull_Mode;28;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;60;-2235.641,1952.397;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;121;-1941.782,3056.994;Inherit;False;Property;_Edge_Color;Edge_Color;26;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1.122875,0.1966326,0.1966326,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;53;-3401.391,-1969.057;Inherit;True;Property;_Sub_Texture;Sub_Texture;4;0;Create;True;0;0;0;False;0;False;-1;None;02898dfb4fcd1e249b2c981ed0c5c828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;44;-3776.195,-1850.545;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;31;-3850.213,3304.96;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-5526.65,1918.098;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-3835.351,3112.839;Float;False;Property;_Offset;Offset;1;0;Create;True;0;0;0;False;0;False;-0.2705882;-0.13;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-4010.221,2796.818;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;4;-6059.623,1957.597;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-4007.195,-2083.545;Inherit;False;0;53;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-4577.181,2985.16;Float;False;Property;_Noise_Str;Noise_Str;17;0;Create;True;0;0;0;False;0;False;0.2898407;0.27;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-4882.803,2746.62;Inherit;True;Property;_Noise_Texture;Noise_Texture;10;0;Create;True;0;0;0;False;0;False;13;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-5392.416,2777.247;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;13;-6566.759,1884.469;Float;True;Property;_Normal_Tex;Normal_Tex;11;0;Create;True;0;0;0;False;0;False;82d7a1f26ef85f048b76b9dcc08c906b;82d7a1f26ef85f048b76b9dcc08c906b;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-4273.575,2750.486;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenColorNode;79;-944.0107,1485.031;Float;False;Global;_GrabScreen0;Grab Screen 0;27;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;46;-3685.195,-2068.545;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2744.194,-1979.545;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-5611.916,3072.74;Float;False;Property;_Noise_Tex_VPanner;Noise_Tex_VPanner;18;0;Create;True;0;0;0;False;0;False;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-5926.185,2119.664;Float;False;Property;_Main_Noise_VTiling;Main_Noise_VTiling;14;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-6241.516,1986.897;Float;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;16;-5116.204,2779.226;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-4641.513,1939.416;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;59;-3082.195,-1980.545;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;66;-599.5454,1662.317;Float;False;Property;_Tint_Color;Tint_Color;0;1;[HDR];Create;True;0;0;0;False;0;False;0.9811321,0.03239589,0.03239589,0;1.447504,0.8125139,0.3618759,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-5614.515,2986.24;Float;False;Property;_Noise_Tex_UPanner;Noise_Tex_UPanner;16;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-3987.195,-1800.545;Float;False;Property;_SubTex_VPanner;SubTex_VPanner;8;0;Create;True;0;0;0;False;0;False;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-3370.195,-1710.545;Float;False;Property;_SubTex_Pow;SubTex_Pow;5;0;Create;True;0;0;0;False;0;False;0;2.49;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;62;-2662.281,-1708.226;Float;False;Property;_SubTex_Color;SubTex_Color;9;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;9.716479,3.682501,1.730332,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;76;1052.489,299.8502;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;105;-2199.182,-1984.417;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;159;-907.3083,-450.1928;Inherit;False;Property;_Float6;Float 6;24;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;161;-652.5203,-574.9639;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-5678.392,2042.928;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-5929.185,2043.664;Float;False;Property;_Main_Noise_UTiling;Main_Noise_UTiling;13;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;1263.903,-335.1169;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;23;-4542.275,2746.413;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;-499.9534,1860.376;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;175;1363.075,130.2621;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;111;-2495.131,2861.65;Inherit;False;Property;_Edge_Thinkness;Edge_Thinkness;27;0;Create;True;0;0;0;False;0;False;0.46;0.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;119;-974.1885,2131.58;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-1542.638,2123.068;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;113;-1993.732,2771.434;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-2456.881,-1990.325;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;116;-2307.486,2776.763;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;41;-3535.49,2764.867;Inherit;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;15;-5301.708,2908.14;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-2703.715,2780.604;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-2700.093,3077.331;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;56;-3055.251,2769.439;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-3267.25,2769.439;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;-1736.063,2776.08;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-268.001,1804.007;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-4894.624,1713.505;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;112;-2480.239,3032.914;Inherit;False;Constant;_Float3;Float 3;27;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-3989.195,-1874.545;Float;False;Property;_SubTex_UPanner;SubTex_UPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-6055.308,1775.233;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1629.443,-270.3577;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Shiled;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;156;0;157;0
WireConnection;156;1;158;0
WireConnection;155;0;154;0
WireConnection;155;2;156;0
WireConnection;142;1;155;0
WireConnection;147;0;142;0
WireConnection;148;0;147;0
WireConnection;148;1;149;0
WireConnection;140;0;138;0
WireConnection;140;1;139;0
WireConnection;141;0;131;0
WireConnection;141;1;148;0
WireConnection;153;0;151;0
WireConnection;153;1;152;0
WireConnection;132;0;141;0
WireConnection;132;2;140;0
WireConnection;150;0;132;0
WireConnection;150;1;153;0
WireConnection;133;0;150;0
WireConnection;133;1;135;0
WireConnection;134;0;150;0
WireConnection;134;1;135;0
WireConnection;127;0;126;0
WireConnection;127;1;150;0
WireConnection;163;0;162;0
WireConnection;163;2;174;0
WireConnection;128;0;126;0
WireConnection;128;1;134;0
WireConnection;125;0;126;0
WireConnection;125;1;133;0
WireConnection;137;0;125;1
WireConnection;137;1;127;2
WireConnection;137;2;128;3
WireConnection;166;1;163;0
WireConnection;166;5;164;0
WireConnection;167;0;165;0
WireConnection;167;1;166;0
WireConnection;169;0;137;0
WireConnection;169;1;51;0
WireConnection;170;0;169;0
WireConnection;170;1;78;0
WireConnection;168;0;167;0
WireConnection;40;1;34;0
WireConnection;40;0;31;3
WireConnection;17;0;13;0
WireConnection;17;1;14;0
WireConnection;9;0;7;0
WireConnection;9;2;4;0
WireConnection;84;0;83;0
WireConnection;84;2;99;0
WireConnection;77;0;17;0
WireConnection;99;0;97;0
WireConnection;99;1;98;0
WireConnection;65;0;60;0
WireConnection;82;1;84;0
WireConnection;82;5;104;0
WireConnection;81;0;80;0
WireConnection;81;1;82;0
WireConnection;117;0;112;0
WireConnection;117;1;108;0
WireConnection;32;0;29;0
WireConnection;32;1;28;0
WireConnection;21;0;77;0
WireConnection;21;1;18;0
WireConnection;60;0;50;0
WireConnection;53;1;46;0
WireConnection;44;0;37;0
WireConnection;44;1;33;0
WireConnection;14;0;9;0
WireConnection;14;1;8;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;19;1;16;0
WireConnection;29;0;23;0
WireConnection;29;1;25;0
WireConnection;79;0;81;0
WireConnection;46;0;43;0
WireConnection;46;2;44;0
WireConnection;64;0;59;0
WireConnection;64;1;58;0
WireConnection;16;0;12;0
WireConnection;16;2;15;0
WireConnection;26;0;20;0
WireConnection;26;1;21;0
WireConnection;59;0;53;1
WireConnection;59;1;55;0
WireConnection;105;0;69;0
WireConnection;161;0;160;0
WireConnection;161;1;159;0
WireConnection;8;0;5;0
WireConnection;8;1;6;0
WireConnection;173;0;168;0
WireConnection;173;1;170;0
WireConnection;23;0;19;0
WireConnection;122;0;79;0
WireConnection;122;1;119;0
WireConnection;119;0;91;0
WireConnection;119;1;120;0
WireConnection;91;0;65;0
WireConnection;91;1;56;0
WireConnection;113;0;117;0
WireConnection;113;1;116;0
WireConnection;69;0;64;0
WireConnection;69;1;62;0
WireConnection;116;0;111;0
WireConnection;116;1;107;0
WireConnection;41;0;32;0
WireConnection;15;0;10;0
WireConnection;15;1;11;0
WireConnection;107;0;56;0
WireConnection;108;0;56;0
WireConnection;56;0;48;0
WireConnection;48;0;41;1
WireConnection;48;1;40;0
WireConnection;120;0;113;0
WireConnection;120;1;121;0
WireConnection;67;0;66;0
WireConnection;67;1;122;0
WireConnection;0;2;173;0
ASEEND*/
//CHKSM=740F3EA99D815347E941FD5A1C3760C70ABF1943