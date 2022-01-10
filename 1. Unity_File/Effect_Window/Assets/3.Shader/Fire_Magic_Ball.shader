// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fire_Magic_Ball"
{
	Properties
	{
		_Lerp_A("Lerp_A", Color) = (0,0,0,0)
		_Lerp_B("Lerp_B", Color) = (0,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		_Fresnel_Base("Fresnel_Base", Float) = 0
		_Fresnel_Power("Fresnel_Power", Float) = 15
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Panner_1_Speed("Panner_1_Speed", Vector) = (-0.24,-0.34,0,0)
		[HDR]_Panner_1_Color("Panner_1_Color", Color) = (0,0,0,0)
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Panner_2_Speed("Panner_2_Speed", Vector) = (0.25,0.26,0,0)
		[HDR]_Panner_2_Color("Panner_2_Color", Color) = (0,0,0,0)
		_Start_Power("Start_Power", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend One One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _TextureSample1;
		uniform float2 _Panner_1_Speed;
		uniform float4 _Panner_1_Color;
		uniform sampler2D _TextureSample2;
		uniform float2 _Panner_2_Speed;
		uniform float4 _Panner_2_Color;
		uniform float4 _Lerp_A;
		uniform float4 _Lerp_B;
		uniform float _Fresnel_Base;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Power;
		uniform float _Start_Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner26 = ( _Time.y * _Panner_1_Speed + i.uv_texcoord);
			float2 panner20 = ( _Time.y * _Panner_2_Speed + i.uv_texcoord);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV6 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode6 = ( _Fresnel_Base + _Fresnel_Scale * pow( 1.0 - fresnelNdotV6, _Fresnel_Power ) );
			float4 lerpResult2 = lerp( _Lerp_A , _Lerp_B , fresnelNode6);
			o.Emission = ( ( ( ( tex2D( _TextureSample1, panner26 ) * _Panner_1_Color ) * ( tex2D( _TextureSample2, panner20 ) * _Panner_2_Color ) ) + lerpResult2 ) * i.vertexColor * i.vertexColor.a * _Start_Power ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;73;1303;918;2415.845;1033.104;2.260644;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1791.749,-766.3204;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;22;-1770.73,-461.5383;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1804.468,-1243.661;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;28;-1783.449,-938.8774;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;24;-1772.166,-622.3726;Inherit;False;Property;_Panner_2_Speed;Panner_2_Speed;10;0;Create;True;0;0;0;False;0;False;0.25,0.26;0.25,0.26;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;30;-1790.633,-1096.839;Inherit;False;Property;_Panner_1_Speed;Panner_1_Speed;7;0;Create;True;0;0;0;False;0;False;-0.24,-0.34;-0.24,-0.34;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;20;-1537.764,-617.4322;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;26;-1550.483,-1094.772;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-1210.211,-615.6806;Inherit;True;Property;_TextureSample2;Texture Sample 2;9;0;Create;True;0;0;0;False;0;False;-1;0c5c899619e886b41a798555299abd18;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-1222.93,-1093.021;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;80de6813d0d510e40a5a7296b105d853;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;33;-1141.401,-892.5994;Inherit;False;Property;_Panner_1_Color;Panner_1_Color;8;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;2.996078,1.662745,0.5333334,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1453.342,497.2659;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1458.991,719.0062;Inherit;False;Property;_Fresnel_Power;Fresnel_Power;5;0;Create;True;0;0;0;False;0;False;15;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1456.167,267.0508;Inherit;False;Property;_Fresnel_Base;Fresnel_Base;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;-1119.404,-420.3635;Inherit;False;Property;_Panner_2_Color;Panner_2_Color;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1,0.06132078,0.06132078,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;6;-1098.868,283.8034;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1090.17,38.4514;Inherit;False;Property;_Lerp_B;Lerp_B;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-757.1652,-717.105;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-775.2801,-1095.095;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;3;-1085.932,-145.1558;Inherit;False;Property;_Lerp_A;Lerp_A;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2;-727.1926,123.1931;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-418.078,-769.759;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-545.7339,658.2012;Inherit;False;Property;_Start_Power;Start_Power;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-248.5389,-335.1814;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;16;-665.5992,430.4571;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-244.3583,163.3286;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;134.4638,205.7458;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Fire_Magic_Ball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;23;0
WireConnection;20;2;24;0
WireConnection;20;1;22;0
WireConnection;26;0;29;0
WireConnection;26;2;30;0
WireConnection;26;1;28;0
WireConnection;21;1;20;0
WireConnection;27;1;26;0
WireConnection;6;1;7;0
WireConnection;6;2;8;0
WireConnection;6;3;10;0
WireConnection;32;0;21;0
WireConnection;32;1;34;0
WireConnection;31;0;27;0
WireConnection;31;1;33;0
WireConnection;2;0;3;0
WireConnection;2;1;4;0
WireConnection;2;2;6;0
WireConnection;36;0;31;0
WireConnection;36;1;32;0
WireConnection;25;0;36;0
WireConnection;25;1;2;0
WireConnection;15;0;25;0
WireConnection;15;1;16;0
WireConnection;15;2;16;4
WireConnection;15;3;17;0
WireConnection;0;2;15;0
ASEEND*/
//CHKSM=C20CF77F8E34CC9B53BB3B8321FE49F0E6903B24