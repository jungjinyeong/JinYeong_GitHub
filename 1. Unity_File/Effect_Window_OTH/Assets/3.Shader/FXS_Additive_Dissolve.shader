// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Dissolve"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Power("Main_Power", Range( 1 , 10)) = 4
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_COSTOM_ON)] _Use_Costom("Use_Costom", Float) = 0
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_COSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Dissove_Texture_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_COSTOM_ON
				float staticSwitch20 = i.uv_tex4coord.z;
			#else
				float staticSwitch20 = _Main_Ins;
			#endif
			float2 appendResult35 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv0_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * appendResult35 + uv0_Dissove_Texture);
			#ifdef _USE_COSTOM_ON
				float staticSwitch21 = i.uv_tex4coord.w;
			#else
				float staticSwitch21 = _Dissolve;
			#endif
			o.Emission = ( ( ( _Tint_Color * ( pow( tex2D( _Main_Texture, uv0_Main_Texture ).r , _Main_Power ) * staticSwitch20 ) ) * saturate( ( tex2D( _Dissove_Texture, panner32 ).r + staticSwitch21 ) ) ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;73;1244;643;1316.846;811.2994;2.365505;True;False
Node;AmplifyShaderEditor.RangedFloatNode;34;-1985.083,728.9493;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1986.083,629.9493;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;8;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1596.228,-307.9736;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1938.626,391.6967;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;35;-1766.083,656.9493;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1146.136,-55.83489;Float;False;Property;_Main_Power;Main_Power;4;0;Create;True;0;0;False;0;4;9.3;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1127.897,588.5048;Float;False;Property;_Dissolve;Dissolve;6;0;Create;True;0;0;False;0;0;-0.1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1125.644,93.90864;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;32;-1541.083,391.9493;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;-1162.583,-270.8354;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;69eea4a9bab8d17439ec9db3891a8c40;90241a8eae19f654a85af8028794d6ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-1052.082,209.7833;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-1160.79,384.6511;Float;True;Property;_Dissove_Texture;Dissove_Texture;5;0;Create;True;0;0;False;0;0c5c899619e886b41a798555299abd18;0c5c899619e886b41a798555299abd18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;22;-739.5825,-273.8354;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-715.1635,144.6773;Float;False;Property;_Use_Costom;Use_Costom;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;21;-718.2448,450.0916;Float;False;Property;_Use_Costom;Use_Costom;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-441.2784,-522.9736;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.3018868,0.1381365,0.08401567,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-423.3173,370.7572;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-430.1826,-274.0121;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-174.5824,-275.8354;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;27;-161.7789,372.8078;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;29;201.6786,57.54502;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;149.8046,-266.7516;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;453.9846,-263.6358;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1095.97,-269.599;Float;False;Property;_Cull_Mode;Cull_Mode;10;1;[Enum];Create;True;0;1;;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;834,-275;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Dissolve;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;36;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;32;0;15;0
WireConnection;32;2;35;0
WireConnection;18;1;13;0
WireConnection;23;1;32;0
WireConnection;22;0;18;1
WireConnection;22;1;17;0
WireConnection;20;1;14;0
WireConnection;20;0;19;3
WireConnection;21;1;16;0
WireConnection;21;0;19;4
WireConnection;26;0;23;1
WireConnection;26;1;21;0
WireConnection;25;0;22;0
WireConnection;25;1;20;0
WireConnection;28;0;24;0
WireConnection;28;1;25;0
WireConnection;27;0;26;0
WireConnection;30;0;28;0
WireConnection;30;1;27;0
WireConnection;31;0;30;0
WireConnection;31;1;29;0
WireConnection;0;2;31;0
WireConnection;0;9;29;4
ASEEND*/
//CHKSM=E55908C97A8D7AF3E402586990B86365A0EDEEC0