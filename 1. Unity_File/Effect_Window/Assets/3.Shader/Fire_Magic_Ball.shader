// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fire_Magic_Ball"
{
	Properties
	{
		_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		_Fresnel_Base("Fresnel_Base", Float) = 0
		_Fresnel_Power("Fresnel_Power", Float) = 15
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Panner_1_Speed("Panner_1_Speed", Vector) = (-0.24,-0.34,0,0)
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Panner_2_Speed("Panner_2_Speed", Vector) = (0.25,0.26,0,0)
		_Flow_Str("Flow_Str", Float) = 0
		_Start_Power("Start_Power", Float) = 0
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _TextureSample2;
		uniform float2 _Panner_2_Speed;
		uniform sampler2D _TextureSample1;
		uniform float2 _Panner_1_Speed;
		uniform float _Flow_Str;
		uniform float4 _Fresnel_Color;
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
			float2 panner20 = ( _Time.y * _Panner_2_Speed + i.uv_texcoord);
			float2 panner26 = ( _Time.y * _Panner_1_Speed + i.uv_texcoord);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV6 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode6 = ( _Fresnel_Base + _Fresnel_Scale * pow( 1.0 - fresnelNdotV6, _Fresnel_Power ) );
			o.Emission = ( ( ( ( tex2D( _TextureSample2, panner20 ).r * tex2D( _TextureSample1, panner26 ).r ) * _Flow_Str ) * ( _Fresnel_Color * fresnelNode6 ) ) * i.vertexColor * _Start_Power ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1927;16;1913;991;2071.404;1009.69;1.6;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1791.749,-766.3204;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;22;-1770.73,-461.5383;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1804.468,-1243.661;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;28;-1783.449,-938.8774;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;24;-1772.166,-622.3726;Inherit;False;Property;_Panner_2_Speed;Panner_2_Speed;7;0;Create;True;0;0;0;False;0;False;0.25,0.26;0.25,0.26;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;30;-1790.633,-1096.839;Inherit;False;Property;_Panner_1_Speed;Panner_1_Speed;5;0;Create;True;0;0;0;False;0;False;-0.24,-0.34;-0.24,-0.34;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;20;-1537.764,-617.4322;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;26;-1550.483,-1094.772;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;27;-1222.93,-1093.021;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;80de6813d0d510e40a5a7296b105d853;80de6813d0d510e40a5a7296b105d853;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;-1210.211,-615.6806;Inherit;True;Property;_TextureSample2;Texture Sample 2;6;0;Create;True;0;0;0;False;0;False;-1;0c5c899619e886b41a798555299abd18;0c5c899619e886b41a798555299abd18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-1458.991,719.0062;Inherit;False;Property;_Fresnel_Power;Fresnel_Power;3;0;Create;True;0;0;0;False;0;False;15;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1456.167,267.0508;Inherit;False;Property;_Fresnel_Base;Fresnel_Base;2;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1453.342,497.2659;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;1;0;Create;True;0;0;0;False;0;False;1;2.63;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;6;-1098.868,283.8034;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-797.4651,-832.8049;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-658.8522,-573.316;Inherit;False;Property;_Flow_Str;Flow_Str;8;0;Create;True;0;0;0;False;0;False;0;5.46;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1081.07,-64.2486;Inherit;False;Property;_Fresnel_Color;Fresnel_Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.9716981,0.2748282,0.06875221,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-736.8521,9.08386;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-482.0521,-770.916;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;-665.5992,430.4571;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-514.5521,-375.7159;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-584.7337,272.1012;Inherit;False;Property;_Start_Power;Start_Power;9;0;Create;True;0;0;0;False;0;False;0;1.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-244.3583,163.3286;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;134.4638,205.7458;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Fire_Magic_Ball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;True;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;23;0
WireConnection;20;2;24;0
WireConnection;20;1;22;0
WireConnection;26;0;29;0
WireConnection;26;2;30;0
WireConnection;26;1;28;0
WireConnection;27;1;26;0
WireConnection;21;1;20;0
WireConnection;6;1;7;0
WireConnection;6;2;8;0
WireConnection;6;3;10;0
WireConnection;32;0;21;1
WireConnection;32;1;27;1
WireConnection;39;0;4;0
WireConnection;39;1;6;0
WireConnection;37;0;32;0
WireConnection;37;1;38;0
WireConnection;40;0;37;0
WireConnection;40;1;39;0
WireConnection;15;0;40;0
WireConnection;15;1;16;0
WireConnection;15;2;17;0
WireConnection;0;2;15;0
WireConnection;0;9;16;4
ASEEND*/
//CHKSM=A16E5639523ACD4847DA043C5A9A6233E4DCECCE