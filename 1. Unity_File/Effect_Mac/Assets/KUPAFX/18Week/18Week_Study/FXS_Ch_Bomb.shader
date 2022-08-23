// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/Ch_Bomb"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_VertexNormal_Val("VertexNormal_Val", Range( 0 , 10)) = 0
		[HDR]_Color1("Color 1", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _VertexNormal_Val;
		uniform float4 _Color1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv0_TextureSample0 = v.texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 panner5 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + (uv0_TextureSample0*1.0 + 0.0));
			float4 tex2DNode4 = tex2Dlod( _TextureSample0, float4( panner5, 0, 0.0) );
			v.vertex.xyz += ( ( ase_vertexNormal * pow( tex2DNode4.r , 4.0 ) ) * _VertexNormal_Val );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color1 = IsGammaSpace() ? float4(0.745283,0.745283,0.745283,0) : float4(0.5152035,0.5152035,0.5152035,0);
			o.Albedo = color1.rgb;
			float2 uv0_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 panner5 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + (uv0_TextureSample0*1.0 + 0.0));
			float4 tex2DNode4 = tex2D( _TextureSample0, panner5 );
			o.Emission = ( ( _Color1 * pow( tex2DNode4.r , 5.0 ) ) * _VertexNormal_Val ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;1070;521.5;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1069,97.5;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;7;-829,294.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;13;-1072,218.5;Float;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;5;-774,117.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-592,147.5;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;6e5343f0266cf36489aa21b41e5bc1f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-410,371.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-133,-132.5;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-244,275.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;17;-83,-186.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-279,-315.5;Float;False;Property;_Color1;Color 1;2;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.3363452,0.05433268,0.05433268,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-510,-68.5;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-104,0.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;142,-307.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;226,-19.5;Float;False;Property;_VertexNormal_Val;VertexNormal_Val;1;0;Create;True;0;0;False;0;0;3.7;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1073,403.5;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;438,-269.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;595,93.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1;-51,-534.5;Float;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.745283,0.745283,0.745283,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;634,-356;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX_Study/Ch_Bomb;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;6;0
WireConnection;5;0;7;0
WireConnection;5;2;13;0
WireConnection;4;1;5;0
WireConnection;9;0;4;1
WireConnection;9;1;10;0
WireConnection;17;0;4;1
WireConnection;17;1;18;0
WireConnection;3;0;2;0
WireConnection;3;1;9;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;14;0;16;0
WireConnection;14;1;12;0
WireConnection;11;0;3;0
WireConnection;11;1;12;0
WireConnection;0;0;1;0
WireConnection;0;2;14;0
WireConnection;0;11;11;0
ASEEND*/
//CHKSM=253BF43B36611E4F03A096123EF23FA4DDD2BDAA