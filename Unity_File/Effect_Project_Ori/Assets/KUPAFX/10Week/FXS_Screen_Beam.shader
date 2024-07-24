// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Screen_Beam"
{
	Properties
	{
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 10
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Space_Tex_UPanner("Space_Tex_UPanner", Float) = 0
		_Space_Tex_VPanner("Space_Tex_VPanner", Float) = 0
		_Tile("Tile", Range( 1 , 10)) = 0
		_Sapce_Tex_Pow("Sapce_Tex_Pow", Range( 1 , 10)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float4 screenPos;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform float _Fresnel_Pow;
		uniform sampler2D _TextureSample0;
		uniform float _Space_Tex_UPanner;
		uniform float _Space_Tex_VPanner;
		uniform float _Tile;
		uniform float _Sapce_Tex_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1, _Fresnel_Pow ) );
			float2 appendResult13 = (float2(_Space_Tex_UPanner , _Space_Tex_VPanner));
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 panner9 = ( 1.0 * _Time.y * appendResult13 + ( ase_screenPosNorm * _Tile ).xy);
			float4 temp_cast_1 = (_Sapce_Tex_Pow).xxxx;
			o.Emission = ( ( _Tint_Color * ( saturate( fresnelNode1 ) + pow( tex2D( _TextureSample0, panner9 ) , temp_cast_1 ) ) ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;66;1920;953;1540.417;790.3171;1.9;True;True
Node;AmplifyShaderEditor.RangedFloatNode;12;-891,515.5;Float;False;Property;_Space_Tex_VPanner;Space_Tex_VPanner;4;0;Create;True;0;0;False;0;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-918,430.5;Float;False;Property;_Space_Tex_UPanner;Space_Tex_UPanner;3;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;7;-1080,122.5;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1126,313.5;Float;False;Property;_Tile;Tile;5;0;Create;True;0;0;False;0;0;3.8;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-805,124.5;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-633,493.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;9;-551,305.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-743,-60.5;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;0;0;Create;True;0;0;False;0;10;1.847059;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-250.754,443.9505;Float;False;Property;_Sapce_Tex_Pow;Sapce_Tex_Pow;6;0;Create;True;0;0;False;0;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-371,147.5;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;02898dfb4fcd1e249b2c981ed0c5c828;02898dfb4fcd1e249b2c981ed0c5c828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;1;-433,-182.5;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-21.95404,282.7506;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;2;-143,-180.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-190,-421.5;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.474109,1.141245,1.515717,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;118.4,-151.8;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;263,-304.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;18;370.6458,51.35049;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;615.0458,-302.2494;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;896.8,-161.9;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Screen_Beam;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;7;0
WireConnection;14;1;15;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;9;0;14;0
WireConnection;9;2;13;0
WireConnection;6;1;9;0
WireConnection;1;3;3;0
WireConnection;16;0;6;0
WireConnection;16;1;17;0
WireConnection;2;0;1;0
WireConnection;8;0;2;0
WireConnection;8;1;16;0
WireConnection;4;0;5;0
WireConnection;4;1;8;0
WireConnection;20;0;4;0
WireConnection;20;1;18;0
WireConnection;0;2;20;0
WireConnection;0;9;18;4
ASEEND*/
//CHKSM=81DE2A5FC3B4B37596BF506D7D76E956012C6BDF