// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Particle_Depth Fade"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_DepthFade("Depth Fade", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Ins;
		uniform float4 _Tint_Color;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthFade;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			o.Emission = ( tex2D( _Main_Texture, uv_Main_Texture ) * i.vertexColor * _Main_Ins * _Tint_Color ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth23 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth23 = abs( ( screenDepth23 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade ) );
			o.Alpha = ( i.vertexColor.a * saturate( distanceDepth23 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;-105.6344;164.7292;1.125329;True;False
Node;AmplifyShaderEditor.RangedFloatNode;24;466.8546,502.5909;Float;False;Property;_DepthFade;Depth Fade;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;23;650.2817,360.7994;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;694.3041,-499.6382;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.356844,0.4977745,2.573858,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;12;789.1639,151.3258;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;638.7999,-292.3;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;1195516317f46f34b9c06a0dee51c9a5;b32ac9c7987c0714b9a0509bf57063c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;649.3389,-71.15602;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;1061.028,341.6689;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;1121.556,-284.1231;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1175.812,83.96848;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;1405.768,-265.8878;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Particle_Depth Fade;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;24;0
WireConnection;25;0;23;0
WireConnection;21;0;3;0
WireConnection;21;1;12;0
WireConnection;21;2;7;0
WireConnection;21;3;10;0
WireConnection;22;0;12;4
WireConnection;22;1;25;0
WireConnection;2;2;21;0
WireConnection;2;9;22;0
ASEEND*/
//CHKSM=037E6DD3BC0FAEFF65DB35CBBDDA0A9CD9D3E1BC