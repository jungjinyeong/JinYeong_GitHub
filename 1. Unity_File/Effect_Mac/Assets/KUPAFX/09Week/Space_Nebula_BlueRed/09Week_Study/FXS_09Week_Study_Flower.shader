// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/09Week_Vertex_Wave"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Panner("Panner", Float) = 0
		_TintColor("Tint Color", Color) = (1,1,1,0)
		_Wave_Pow("Wave_Pow", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Panner;
		uniform float _Wave_Pow;
		uniform float4 _TintColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult17 = (float2(_Panner , 0.0));
			float2 panner2 = ( 1.0 * _Time.y * appendResult17 + v.texcoord.xy);
			v.vertex.xyz += ( ( ( ase_vertexNormal * pow( tex2Dlod( _TextureSample0, float4( panner2, 0, 0.0) ).r , _Wave_Pow ) ) * 4.0 ) * saturate( pow( v.texcoord.xy.x , 4.0 ) ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _TintColor.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;48;1920;971;700.006;726.0854;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;19;-1179.961,167.9033;Float;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1179.961,84.90336;Float;False;Property;_Panner;Panner;1;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1213.892,-226.2169;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1012.961,86.90336;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-933.8918,-202.2169;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-618.0057,210.9146;Float;False;Property;_Wave_Pow;Wave_Pow;3;0;Create;True;0;0;False;0;1;7.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-778.8918,-83.21682;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;6904366d56281b64b949da6521ac47d2;371833fbab316d14f80a74792f0fdeca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-88,402.5;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;5;-224,-361.5;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;20;-390.0057,38.91464;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-302,237.5;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;13;70,255.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;100,102.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;36,-195.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;15;303,258.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;284,-48.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;4;-1255.892,-44.21683;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0.15,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;635.9309,50.62018;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;8;73,-529.5;Float;False;Property;_TintColor;Tint Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1019.627,-318.8644;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/09Week_Vertex_Wave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;18;0
WireConnection;17;1;19;0
WireConnection;2;0;3;0
WireConnection;2;2;17;0
WireConnection;1;1;2;0
WireConnection;20;0;1;1
WireConnection;20;1;21;0
WireConnection;13;0;11;1
WireConnection;13;1;14;0
WireConnection;6;0;5;0
WireConnection;6;1;20;0
WireConnection;15;0;13;0
WireConnection;9;0;6;0
WireConnection;9;1;10;0
WireConnection;16;0;9;0
WireConnection;16;1;15;0
WireConnection;0;2;8;0
WireConnection;0;11;16;0
ASEEND*/
//CHKSM=672B1B1C6A80117F3DAD74DFD78835B2C581B9A6