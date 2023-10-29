// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/13Week_Fresnel"
{
	Properties
	{
		[HDR]_Fresel_Color("Fresel_Color", Color) = (1,0,0,1)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 0.6117647
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 1
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		[HDR]_In_Fresnel("In_Fresnel", Color) = (0,0,0,0)
		_IN_Pow("IN_Pow", Float) = 4
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform float4 _Fresel_Color;
		uniform sampler2D _TextureSample0;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform float _IN_Pow;
		uniform float4 _In_Fresnel;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 temp_cast_0 = (0.5).xx;
			float cos13 = cos( 0.9 );
			float sin13 = sin( 0.9 );
			float2 rotator13 = mul( i.uv_texcoord - temp_cast_0 , float2x2( cos13 , -sin13 , sin13 , cos13 )) + temp_cast_0;
			float2 panner16 = ( 1.0 * _Time.y * float2( 2.29,0 ) + rotator13);
			float3 newWorldNormal8 = (WorldNormalVector( i , UnpackNormal( tex2D( _TextureSample0, (panner16*float2( 0.15,2.62 ) + 0.0) ) ) ));
			float fresnelNdotV1 = dot( newWorldNormal8, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV1, _Fresnel_Pow ) );
			float fresnelNdotV20 = dot( newWorldNormal8, ase_worldViewDir );
			float fresnelNode20 = ( 0.0 + 1.65 * pow( 1.0 - fresnelNdotV20, 2.0 ) );
			o.Emission = ( ( _Fresel_Color * saturate( fresnelNode1 ) ) + ( pow( ( 1.0 - saturate( fresnelNode20 ) ) , _IN_Pow ) * _In_Fresnel ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
3;155;1920;772;270.8156;140.6943;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1693.013,-423.0173;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1501.949,-189.5351;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1515.649,-265.2351;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;17;-1459.242,36.11885;Float;False;Constant;_Vector1;Vector 1;4;0;Create;True;0;0;False;0;2.29,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;13;-1359.221,-420.9289;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;16;-1210.417,-337.6835;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;12;-1190.193,-139.8533;Float;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0.15,2.62;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;10;-1027.786,-259.9164;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;9;-828,-261.5;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;f99cd2cad01a9ec4c9f1d25eebf10402;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;8;-490,-256.5;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;22;-456.2527,377.2706;Float;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-459.2527,294.2706;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;1.65;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;20;-245.2527,183.2706;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-629,98.5;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;2;0;Create;True;0;0;False;0;1;1.71;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;70.74731,170.2706;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-657,20.5;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;1;0;Create;True;0;0;False;0;0.6117647;0.674;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;236.7473,157.2706;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1;-236,-152.5;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;212.7473,440.2706;Float;False;Property;_IN_Pow;IN_Pow;5;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;104,-298.5;Float;False;Property;_Fresel_Color;Fresel_Color;0;1;[HDR];Create;True;0;0;False;0;1,0,0,1;2,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;25;405.7473,164.2706;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2;407,-136.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;440.7473,412.2706;Float;False;Property;_In_Fresnel;In_Fresnel;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.01625109,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;682.7473,190.2706;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;631,-197.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;871.7473,74.2706;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1145,-270;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/13Week_Fresnel;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;11;0
WireConnection;13;1;14;0
WireConnection;13;2;15;0
WireConnection;16;0;13;0
WireConnection;16;2;17;0
WireConnection;10;0;16;0
WireConnection;10;1;12;0
WireConnection;9;1;10;0
WireConnection;8;0;9;0
WireConnection;20;0;8;0
WireConnection;20;2;21;0
WireConnection;20;3;22;0
WireConnection;23;0;20;0
WireConnection;18;0;23;0
WireConnection;1;0;8;0
WireConnection;1;2;6;0
WireConnection;1;3;7;0
WireConnection;25;0;18;0
WireConnection;25;1;26;0
WireConnection;2;0;1;0
WireConnection;24;0;25;0
WireConnection;24;1;27;0
WireConnection;3;0;5;0
WireConnection;3;1;2;0
WireConnection;28;0;3;0
WireConnection;28;1;24;0
WireConnection;0;2;28;0
ASEEND*/
//CHKSM=77F18BEDD80FFE3A68C74FBBCB8FDE224AE55B2B