// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Smoke_Exp02"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Color_Range("Color_Range", Range( -0.2 , 1)) = 0.1105882
		[HDR]_ColorA("ColorA", Color) = (1,1,1,0)
		[HDR]_ColorB("ColorB", Color) = (1,0.2696729,0,0)
		[HDR]_ColorA_01("ColorA_01", Color) = (0.990566,0.5212692,0.1448469,0)
		_UpColor_Range("UpColor_Range", Range( -0.2 , 1)) = 0.7741176
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_VertexNomal_Texture("VertexNomal_Texture", 2D) = "white" {}
		_VertexNormal_Str("VertexNormal_Str", Range( -5 , 5)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _VertexNomal_Texture;
		uniform float4 _VertexNomal_Texture_ST;
		uniform float _VertexNormal_Str;
		uniform float4 _ColorA;
		uniform float4 _ColorA_01;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _UpColor_Range;
		uniform float4 _ColorB;
		uniform float _Color_Range;
		uniform sampler2D _TextureSample0;
		uniform float _Dissolve;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv_VertexNomal_Texture = v.texcoord * _VertexNomal_Texture_ST.xy + _VertexNomal_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch34 = v.texcoord1.w;
			#else
				float staticSwitch34 = _VertexNormal_Str;
			#endif
			v.vertex.xyz += ( ( ase_vertexNormal * tex2Dlod( _VertexNomal_Texture, float4( uv_VertexNomal_Texture, 0, 0.0) ).r ) * staticSwitch34 );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner13 = ( 1.0 * _Time.y * float2( 0.1,-0.156 ) + uv0_Main_Texture);
			float4 tex2DNode1 = tex2D( _Main_Texture, panner13 );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch31 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch31 = _UpColor_Range;
			#endif
			float4 lerpResult9 = lerp( _ColorA , _ColorA_01 , step( tex2DNode1.r , staticSwitch31 ));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch32 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch32 = _Color_Range;
			#endif
			float4 lerpResult4 = lerp( lerpResult9 , _ColorB , step( tex2DNode1.r , staticSwitch32 ));
			o.Emission = ( lerpResult4 * i.vertexColor ).rgb;
			float2 panner20 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + i.uv_texcoord);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch33 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch33 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor * step( tex2D( _TextureSample0, panner20 ).r , staticSwitch33 ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;558.2054;489.9843;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1657.003,-447.5976;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;15;-1512.003,-297.5976;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0.1,-0.156;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;11;-1215.938,-753.5;Float;False;Property;_UpColor_Range;UpColor_Range;5;0;Create;True;0;0;False;0;0.7741176;0.56;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;30;-2300.662,-17.15783;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;13;-1356.003,-442.5976;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-851.9113,-361.7339;Float;False;Property;_Color_Range;Color_Range;1;0;Create;True;0;0;False;0;0.1105882;0.23;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;31;-905.2281,-732.7871;Float;False;Property;_Use_Custom;Use_Custom;10;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;22;-767.0905,-41.59751;Float;False;Constant;_Vector1;Vector 1;8;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-793.2855,-152.4226;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1140,-460.5;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;c079a36dd2193c547a1f8e9e9a31caf6;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-592.9072,73.96767;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;32;-595.0037,-282.0698;Float;False;Property;_Use_Custom;Use_Custom;10;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;20;-566.5977,-131.2651;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;12;-552.0601,-770.4673;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-895,-905.5;Float;False;Property;_ColorA_01;ColorA_01;4;1;[HDR];Create;True;0;0;False;0;0.990566,0.5212692,0.1448469,0;2.377595,1.379005,0.463631,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-903,-1091.5;Float;False;Property;_ColorA;ColorA;2;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-112.255,457.0729;Float;True;Property;_VertexNomal_Texture;VertexNomal_Texture;8;0;Create;True;0;0;False;0;7ead229491461f64fb8abd86dfcd7d4b;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;33;-238.5571,112.0749;Float;False;Property;_Use_Custom;Use_Custom;10;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;25;-6.255005,290.0729;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-13.255,667.0729;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;9;0;Create;True;0;0;False;0;0;0.78;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;2;-396,-559.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-159,-372.5;Float;False;Property;_ColorB;ColorB;3;1;[HDR];Create;True;0;0;False;0;1,0.2696729,0,0;0.2924528,0.1123395,0.04552332,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-413,-901.5;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-402.3392,-131.2088;Float;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;34;283.3722,764.2936;Float;False;Property;_Use_Custom;Use_Custom;11;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;220.745,361.0729;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;19;-20.61,-98.1021;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;4;85,-641.5;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;35;448.7946,-274.9843;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;726.7946,-57.98425;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;738.7946,-350.9843;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;517.745,442.0729;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;951,-147;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Smoke_Exp02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;13;2;15;0
WireConnection;31;1;11;0
WireConnection;31;0;30;1
WireConnection;1;1;13;0
WireConnection;32;1;3;0
WireConnection;32;0;30;2
WireConnection;20;0;21;0
WireConnection;20;2;22;0
WireConnection;12;0;1;1
WireConnection;12;1;31;0
WireConnection;33;1;18;0
WireConnection;33;0;30;3
WireConnection;2;0;1;1
WireConnection;2;1;32;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;9;2;12;0
WireConnection;16;1;20;0
WireConnection;34;1;29;0
WireConnection;34;0;30;4
WireConnection;27;0;25;0
WireConnection;27;1;26;1
WireConnection;19;0;16;1
WireConnection;19;1;33;0
WireConnection;4;0;9;0
WireConnection;4;1;8;0
WireConnection;4;2;2;0
WireConnection;37;0;35;0
WireConnection;37;1;19;0
WireConnection;36;0;4;0
WireConnection;36;1;35;0
WireConnection;28;0;27;0
WireConnection;28;1;34;0
WireConnection;0;2;36;0
WireConnection;0;9;37;0
WireConnection;0;11;28;0
ASEEND*/
//CHKSM=04C148FCA481D44CC16733D8A8F2B175CA585E5A