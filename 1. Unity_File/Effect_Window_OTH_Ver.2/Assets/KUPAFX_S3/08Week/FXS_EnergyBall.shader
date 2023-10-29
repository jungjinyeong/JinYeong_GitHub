// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/EnergyBall"
{
	Properties
	{
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		_UTiling("UTiling", Float) = 1.42
		_VTiling("VTiling", Float) = 0.25
		_Rot("Rot", Float) = 27.37
		_Noise_Val1("Noise_Val", Range( 0 , 5)) = 0.3353674
		_Normal_Tex_UPanner("Normal_Tex_UPanner", Float) = 0
		_Normal_Tex_VPanner("Normal_Tex_VPanner", Float) = 0.15
		[HDR]_Fresnel_Color1("Fresnel_Color", Color) = (1,1,1,0)
		_Fresnel_Scale1("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow1("Fresnel_Pow", Range( 0 , 20)) = 6.235294
		[HDR]_FresnelIN_Color("FresnelIN_Color", Color) = (1,1,1,0)
		_FresnelIN_Scale("FresnelIN_Scale", Range( 0 , 20)) = 1
		_FresnelIN_Pow("FresnelIN_Pow", Range( 0 , 20)) = 6.235294
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal_Tex;
		uniform float _Normal_Tex_UPanner;
		uniform float _Normal_Tex_VPanner;
		uniform float _Rot;
		uniform float _UTiling;
		uniform float _VTiling;
		uniform float _Noise_Val1;
		uniform float _Fresnel_Scale1;
		uniform float _Fresnel_Pow1;
		uniform float4 _Fresnel_Color1;
		uniform float _FresnelIN_Scale;
		uniform float _FresnelIN_Pow;
		uniform float4 _FresnelIN_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult18 = (float2(_Normal_Tex_UPanner , _Normal_Tex_VPanner));
			float2 temp_cast_0 = (0.5).xx;
			float cos12 = cos( _Rot );
			float sin12 = sin( _Rot );
			float2 rotator12 = mul( i.uv_texcoord - temp_cast_0 , float2x2( cos12 , -sin12 , sin12 , cos12 )) + temp_cast_0;
			float2 appendResult34 = (float2(_UTiling , _VTiling));
			float2 panner10 = ( 1.0 * _Time.y * appendResult18 + (rotator12*appendResult34 + 0.0));
			float3 newWorldNormal7 = (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Normal_Tex, panner10 ), _Noise_Val1 ) ));
			float fresnelNdotV6 = dot( newWorldNormal7, ase_worldViewDir );
			float fresnelNode6 = ( 0.0 + _Fresnel_Scale1 * pow( 1.0 - fresnelNdotV6, _Fresnel_Pow1 ) );
			float fresnelNdotV21 = dot( newWorldNormal7, ase_worldViewDir );
			float fresnelNode21 = ( 0.0 + _FresnelIN_Scale * pow( 1.0 - fresnelNdotV21, _FresnelIN_Pow ) );
			o.Emission = ( i.vertexColor * ( ( saturate( fresnelNode6 ) * _Fresnel_Color1 ) + ( saturate( ( 1.0 - fresnelNode21 ) ) * _FresnelIN_Color ) ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;0;1920;1019;2715.5;1366.557;2.095088;True;False
Node;AmplifyShaderEditor.RangedFloatNode;33;-2177.001,-89.57648;Inherit;False;Property;_VTiling;VTiling;2;0;Create;True;0;0;0;False;0;False;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2117.017,-456.9322;Inherit;False;Property;_Rot;Rot;3;0;Create;True;0;0;0;False;0;False;27.37;27.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2121.017,-566.9323;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2106.205,-684.3624;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-2172.001,-170.5765;Inherit;False;Property;_UTiling;UTiling;1;0;Create;True;0;0;0;False;0;False;1.42;1.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-1955.001,-164.5765;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;12;-1887.017,-631.9322;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1724.017,-356.9322;Inherit;False;Property;_Normal_Tex_UPanner;Normal_Tex_UPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1739.017,-272.9323;Inherit;False;Property;_Normal_Tex_VPanner;Normal_Tex_VPanner;6;0;Create;True;0;0;0;False;0;False;0.15;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;15;-1693.017,-599.9323;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-1587.017,-366.9323;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1410.523,-287.9568;Inherit;False;Property;_Noise_Val1;Noise_Val;4;0;Create;True;0;0;0;False;0;False;0.3353674;1.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;10;-1501.004,-484.9628;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-1313.336,-517.4469;Inherit;True;Property;_Normal_Tex;Normal_Tex;0;0;Create;True;0;0;0;False;0;False;-1;1dbf1177420b46f47b20959a7c02ae71;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1187.945,132.106;Inherit;False;Property;_FresnelIN_Scale;FresnelIN_Scale;11;0;Create;True;0;0;0;False;0;False;1;2.480526;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;7;-1023.017,-487.9323;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;23;-1180.945,221.1061;Inherit;False;Property;_FresnelIN_Pow;FresnelIN_Pow;12;0;Create;True;0;0;0;False;0;False;6.235294;0.5981737;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;21;-761.9446,119.106;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1054.531,-263.2039;Inherit;False;Property;_Fresnel_Scale1;Fresnel_Scale;8;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1056.531,-167.2038;Inherit;False;Property;_Fresnel_Pow1;Fresnel_Pow;9;0;Create;True;0;0;0;False;0;False;6.235294;4.61;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;25;-465.4023,121.2896;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;6;-724.3208,-314.1119;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-376.5138,-317.7717;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-437.5139,-95.7717;Inherit;False;Property;_Fresnel_Color1;Fresnel_Color;7;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.316908,0.2331921,0.1801431,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;28;-331.4023,339.2896;Inherit;False;Property;_FresnelIN_Color;FresnelIN_Color;10;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0.2963397,1.758175,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;26;-287.4023,126.2896;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-45.40234,124.2896;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-183.6403,-318.2339;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;217.5977,-53.71039;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;30;247.9989,-245.5765;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;452.9989,-209.5765;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;632,-206;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/EnergyBall;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;12;0;8;0
WireConnection;12;1;14;0
WireConnection;12;2;13;0
WireConnection;15;0;12;0
WireConnection;15;1;34;0
WireConnection;18;0;19;0
WireConnection;18;1;20;0
WireConnection;10;0;15;0
WireConnection;10;2;18;0
WireConnection;11;1;10;0
WireConnection;11;5;9;0
WireConnection;7;0;11;0
WireConnection;21;0;7;0
WireConnection;21;2;22;0
WireConnection;21;3;23;0
WireConnection;25;0;21;0
WireConnection;6;0;7;0
WireConnection;6;2;1;0
WireConnection;6;3;2;0
WireConnection;4;0;6;0
WireConnection;26;0;25;0
WireConnection;27;0;26;0
WireConnection;27;1;28;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;29;0;5;0
WireConnection;29;1;27;0
WireConnection;31;0;30;0
WireConnection;31;1;29;0
WireConnection;0;2;31;0
WireConnection;0;9;30;4
ASEEND*/
//CHKSM=A2B4AA679F5BDD646A919945F63172C21EECF214