// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Ref"
{
	Properties
	{
		_FXT_Circle_Normal("FXT_Circle_Normal", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 5)) = 1
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Float0("Float 0", Float) = 0.89
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 screenPos;
			float4 uv_tex4coord;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _GrabTexture;
		uniform float _Normal_Scale;
		uniform sampler2D _FXT_Circle_Normal;
		uniform float4 _FXT_Circle_Normal_ST;
		uniform float _Float0;


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
			#ifdef _USE_CUSTOM_ON
				float staticSwitch8 = i.uv_tex4coord.z;
			#else
				float staticSwitch8 = _Normal_Scale;
			#endif
			float2 uv_FXT_Circle_Normal = i.uv_texcoord * _FXT_Circle_Normal_ST.xy + _FXT_Circle_Normal_ST.zw;
			float4 screenColor2 = tex2D( _GrabTexture, ( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _FXT_Circle_Normal, uv_FXT_Circle_Normal ), staticSwitch8 ) , 0.0 ) ).xy );
			o.Emission = ( screenColor2 * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( pow( ( ( ( ( i.uv_texcoord.y + 0.0 ) * ( 1.0 - i.uv_texcoord.y ) ) * ( ( i.uv_texcoord.x + 0.0 ) * ( 1.0 - i.uv_texcoord.x ) ) ) * 16.0 ) , _Float0 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;242;1920;993;2067.093;488.9749;1.504135;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1703.045,726.6475;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;14;-1287.045,886.6476;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1335.045,598.6476;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;-1303.045,1462.647;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1319.045,1190.647;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1120.184,17.15377;Float;False;Property;_Normal_Scale;Normal_Scale;1;0;Create;True;0;0;False;0;1;0.69;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;6;-1141.184,118.1538;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-999.0447,838.6476;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-983.0447,1206.647;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-727.0446,838.6476;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;8;-839.1843,180.1538;Float;False;Property;_Use_Custom;Use_Custom;2;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;3;-313,-190.5;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-359,54.5;Float;True;Property;_FXT_Circle_Normal;FXT_Circle_Normal;0;0;Create;True;0;0;False;0;c12d25eccac6f9d4ea9e7b0250a35c48;36e410a4104337f46aa27e8016b7fd69;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-407.0446,1110.647;Float;False;Property;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.89;0.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-471.0447,838.6476;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;30,-77.5;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;22;-167.0447,854.6476;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;69.59908,847.6616;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;2;348,-191.5;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;9;448.3273,222.0897;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;711.2074,-19.58857;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;868.1368,508.6721;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1219.464,-62.84391;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Ref;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;13;2
WireConnection;17;0;13;2
WireConnection;16;0;13;1
WireConnection;15;0;13;1
WireConnection;19;0;17;0
WireConnection;19;1;14;0
WireConnection;18;0;15;0
WireConnection;18;1;16;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;8;1;5;0
WireConnection;8;0;6;3
WireConnection;1;5;8;0
WireConnection;21;0;20;0
WireConnection;4;0;3;0
WireConnection;4;1;1;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;24;0;22;0
WireConnection;2;0;4;0
WireConnection;10;0;2;0
WireConnection;10;1;9;0
WireConnection;26;0;9;4
WireConnection;26;1;24;0
WireConnection;0;2;10;0
WireConnection;0;9;26;0
ASEEND*/
//CHKSM=D19C3A6C3CDA0ED673D6D1EB70437CEC82D5B1B2