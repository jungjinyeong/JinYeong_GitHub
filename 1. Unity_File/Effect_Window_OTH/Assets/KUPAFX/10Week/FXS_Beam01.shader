// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Beam01"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Beam_Fresnel_Pow("Beam_Fresnel_Pow", Range( 1 , 10)) = 2.270588
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Float) = 0
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Float) = 0
		_Vertex_Normal("Vertex_Normal", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float4 _Dissove_Texture_ST;
		uniform float _Vertex_Normal;
		uniform float4 _Tint_Color;
		uniform float _Beam_Fresnel_Pow;
		uniform float _Dissolve;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult14 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv0_Dissove_Texture = v.texcoord.xy * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner9 = ( 1.0 * _Time.y * appendResult14 + uv0_Dissove_Texture);
			float4 tex2DNode6 = tex2Dlod( _Dissove_Texture, float4( panner9, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2DNode6.r * ase_vertexNormal ) * _Vertex_Normal );
		}

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
			float fresnelNode1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1, _Beam_Fresnel_Pow ) );
			o.Emission = ( _Tint_Color * saturate( fresnelNode1 ) ).rgb;
			o.Alpha = 1;
			float2 appendResult14 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float2 uv0_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner9 = ( 1.0 * _Time.y * appendResult14 + uv0_Dissove_Texture);
			float4 tex2DNode6 = tex2D( _Dissove_Texture, panner9 );
			clip( ( tex2DNode6.r + _Dissolve ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;84;1920;935;884.0168;341.9812;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;13;-795,456.5;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;5;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-786,375.5;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-546,350.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-738,200.5;Float;False;0;6;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-613,-18.5;Float;False;Property;_Beam_Fresnel_Pow;Beam_Fresnel_Pow;1;0;Create;True;0;0;False;0;2.270588;2.270588;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-482,212.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;6;-242,217.5;Float;True;Property;_Dissove_Texture;Dissove_Texture;3;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;1;-249,-131.5;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;15;91,642.5;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;480,438.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;5;-43,-334.5;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;3.554463,1.493534,0.1173644,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-262,449.5;Float;False;Property;_Dissolve;Dissolve;4;0;Create;True;0;0;False;0;0;0.84;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;490,686.5;Float;False;Property;_Vertex_Normal;Vertex_Normal;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2;9,-131.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;289,-330.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;690,437.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;80,256.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;611,-298;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Beam01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;9;0;10;0
WireConnection;9;2;14;0
WireConnection;6;1;9;0
WireConnection;1;3;3;0
WireConnection;16;0;6;1
WireConnection;16;1;15;0
WireConnection;2;0;1;0
WireConnection;4;0;5;0
WireConnection;4;1;2;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;7;0;6;1
WireConnection;7;1;8;0
WireConnection;0;2;4;0
WireConnection;0;10;7;0
WireConnection;0;11;17;0
ASEEND*/
//CHKSM=385757E3F75069C70115F4AB67ED5205419F67DB