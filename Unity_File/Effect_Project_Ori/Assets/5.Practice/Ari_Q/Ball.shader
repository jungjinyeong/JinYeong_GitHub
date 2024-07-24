// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ball"
{
	Properties
	{
		_Bias("Bias", Float) = 0
		_Scale("Scale", Float) = 1
		_Power("Power", Float) = 5
		_int("int", Float) = 1
		_Color0("Color 0", Color) = (1,1,1,0)
		_Color1("Color 1", Color) = (1,1,1,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _Bias;
		uniform float _Scale;
		uniform float _Power;
		uniform float _int;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV14 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode14 = ( _Bias + _Scale * pow( 1.0 - fresnelNdotV14, _Power ) );
			float4 lerpResult24 = lerp( _Color0 , _Color1 , pow( fresnelNode14 , 0.5 ));
			o.Emission = ( lerpResult24 * i.vertexColor * i.vertexColor.a * _int ).rgb;
			o.Alpha = ( lerpResult24 * i.vertexColor.a ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
2567;13;1913;1003;2227.153;1013.581;1.897568;True;False
Node;AmplifyShaderEditor.RangedFloatNode;15;-1617.831,19.53326;Inherit;False;Property;_Bias;Bias;0;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1612.831,187.5333;Inherit;False;Property;_Power;Power;2;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1615.831,105.5333;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;0;False;0;False;1;38.53;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;14;-1435.276,-18.73655;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1094.318,-25.78785;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;-1079.087,-244.9069;Inherit;False;Property;_Color1;Color 1;5;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.4764151,0.8152054,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;-1065.087,-450.9069;Inherit;False;Property;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.1429779,0.2461808,0.4811321,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;3;-561.446,203.3043;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-539.2372,418.9683;Inherit;False;Property;_int;int;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;-709.0867,-103.9069;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-226.5047,430.4841;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-210.7124,-30.2744;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;170,-126;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Ball;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;15;0
WireConnection;14;2;18;0
WireConnection;14;3;19;0
WireConnection;22;0;14;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;24;2;22;0
WireConnection;27;0;24;0
WireConnection;27;1;3;4
WireConnection;2;0;24;0
WireConnection;2;1;3;0
WireConnection;2;2;3;4
WireConnection;2;3;21;0
WireConnection;0;2;2;0
WireConnection;0;9;27;0
ASEEND*/
//CHKSM=617C1C936030B120876AB5B2DC082B322270D51A