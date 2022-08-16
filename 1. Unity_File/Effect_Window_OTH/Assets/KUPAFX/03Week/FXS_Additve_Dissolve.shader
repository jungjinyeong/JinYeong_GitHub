// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additve_Dissolve"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 4
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
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
		uniform float _Main_Pow;
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
			#ifdef _USE_CUSTOM_ON
				float staticSwitch7 = i.uv_tex4coord.z;
			#else
				float staticSwitch7 = _Main_Ins;
			#endif
			float2 appendResult23 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv0_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner20 = ( 1.0 * _Time.y * appendResult23 + uv0_Dissove_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch19 = i.uv_tex4coord.w;
			#else
				float staticSwitch19 = _Dissolve;
			#endif
			o.Emission = ( ( ( _Tint_Color * ( pow( tex2D( _Main_Texture, i.uv_texcoord ).r , _Main_Pow ) * staticSwitch7 ) ) * saturate( ( tex2D( _Dissove_Texture, panner20 ).r + staticSwitch19 ) ) ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;624.3682;381.0773;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-1240.319,742.6825;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1214.319,669.6825;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;5;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-1004.319,759.6825;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1233.542,442.1154;Float;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1122.903,-300.262;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;-937.441,592.6176;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-701.9416,731.4155;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-904.712,-304.4665;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;d4003115653d0f549a9ad4aa3dae1c47;b32ac9c7987c0714b9a0509bf57063c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-898.7681,-78.43391;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;4;4;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-608.968,209.8661;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-613.9176,265.9009;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;7;-255.9176,221.9009;Float;False;Property;_Use_Custom;Use_Custom;9;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;19;-267.4362,604.2782;Float;False;Property;_Use_Custom;Use_Custom;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;-372.968,-103.1339;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-655.7416,475.5154;Float;True;Property;_Dissove_Texture;Dissove_Texture;4;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-128.6649,-280.4263;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;12.50823,22.59551,25.68894,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-8.041565,505.4154;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-112.968,-84.13391;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;86.3351,-131.4263;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;17;223.5584,456.8154;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;312.8585,-55.98455;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;11;436.3351,206.5737;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;649.3351,-83.4263;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1023,-135;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additve_Dissolve;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;9;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;20;0;14;0
WireConnection;20;2;23;0
WireConnection;2;1;1;0
WireConnection;7;1;4;0
WireConnection;7;0;5;3
WireConnection;19;1;16;0
WireConnection;19;0;5;4
WireConnection;6;0;2;1
WireConnection;6;1;3;0
WireConnection;13;1;20;0
WireConnection;15;0;13;1
WireConnection;15;1;19;0
WireConnection;9;0;6;0
WireConnection;9;1;7;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;17;0;15;0
WireConnection;18;0;10;0
WireConnection;18;1;17;0
WireConnection;12;0;18;0
WireConnection;12;1;11;0
WireConnection;0;2;12;0
WireConnection;0;9;11;4
ASEEND*/
//CHKSM=EFAEF84B2238952B1ADCE08EBC01BBA7414E9EF4