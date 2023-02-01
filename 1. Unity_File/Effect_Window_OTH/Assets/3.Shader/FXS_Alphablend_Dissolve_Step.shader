// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Dissolve_Step"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Power("Main_Power", Range( 1 , 10)) = 4
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Step_Dissolve("Step_Dissolve", Range( 0 , 1)) = 0.4003291
		[Toggle(_USE_COSTOM_ON)] _Use_Costom("Use_Costom", Float) = 0
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_COSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform float _Step_Dissolve;
		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Dissove_Texture_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_COSTOM_ON
				float staticSwitch20 = i.uv2_texcoord2.z;
			#else
				float staticSwitch20 = _Main_Ins;
			#endif
			#ifdef _USE_COSTOM_ON
				float staticSwitch21 = i.uv2_texcoord2.w;
			#else
				float staticSwitch21 = _Step_Dissolve;
			#endif
			float2 appendResult35 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * appendResult35 + uv_Dissove_Texture);
			float temp_output_30_0 = ( ( pow( tex2D( _Main_Texture, uv_Main_Texture ).r , _Main_Power ) * staticSwitch20 ) * saturate( step( staticSwitch21 , tex2D( _Dissove_Texture, panner32 ).r ) ) );
			o.Emission = ( _Tint_Color * ( temp_output_30_0 * i.vertexColor ) ).rgb;
			o.Alpha = saturate( ( temp_output_30_0 * i.vertexColor.a ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1035;616;617.5862;458.8304;1.716892;True;False
Node;AmplifyShaderEditor.RangedFloatNode;34;-1985.083,728.9493;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1986.083,629.9493;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;35;-1766.083,656.9493;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1938.626,391.6967;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1596.228,-307.9736;Inherit;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;32;-1541.083,391.9493;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-992.4884,602.0723;Float;False;Property;_Step_Dissolve;Step_Dissolve;5;0;Create;True;0;0;0;False;0;False;0.4003291;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-1061.082,182.7833;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;-694.4473,334.4749;Float;False;Property;_Use_Costom;Use_Costom;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1162.583,-270.8354;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;69eea4a9bab8d17439ec9db3891a8c40;940bac5719df231488f345777060aac7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1146.136,-55.83489;Float;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;0;False;0;False;4;2.31;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1125.644,93.90864;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;0;False;0;False;1;6.8;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-1160.79,384.6511;Inherit;True;Property;_Dissove_Texture;Dissove_Texture;4;0;Create;True;0;0;0;False;0;False;-1;0c5c899619e886b41a798555299abd18;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;37;-337.3287,370.7978;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-715.1635,144.6773;Float;False;Property;_Use_Costom;Use_Costom;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-739.5825,-273.8354;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-430.1826,-274.0121;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;27;-106.4922,369.9477;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;84.32066,-273.5258;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;29;145.685,-19.47133;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;472.3136,2.698906;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;520.4931,-520.9185;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;448.9695,-265.9365;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;767.1445,-266.958;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1307.228,-293.2599;Float;False;Property;_Cull_Mode;Cull_Mode;9;1;[Enum];Create;True;0;0;1;;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;730.174,20.18242;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1044.608,-315.9526;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Dissolve_Step;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;32;0;15;0
WireConnection;32;2;35;0
WireConnection;21;1;16;0
WireConnection;21;0;19;4
WireConnection;18;1;13;0
WireConnection;23;1;32;0
WireConnection;37;0;21;0
WireConnection;37;1;23;1
WireConnection;20;1;14;0
WireConnection;20;0;19;3
WireConnection;22;0;18;1
WireConnection;22;1;17;0
WireConnection;25;0;22;0
WireConnection;25;1;20;0
WireConnection;27;0;37;0
WireConnection;30;0;25;0
WireConnection;30;1;27;0
WireConnection;38;0;30;0
WireConnection;38;1;29;4
WireConnection;31;0;30;0
WireConnection;31;1;29;0
WireConnection;39;0;24;0
WireConnection;39;1;31;0
WireConnection;40;0;38;0
WireConnection;0;2;39;0
WireConnection;0;9;40;0
ASEEND*/
//CHKSM=6626F1A70AC53427B3488E638A965989B4E7A063