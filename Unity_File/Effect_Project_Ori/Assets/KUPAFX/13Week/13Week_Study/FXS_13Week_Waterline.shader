// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/13Week_Waterline"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_VPanner("Main_VPanner", Float) = 0
		_DissTex_VPanner("DissTex_VPanner", Float) = 0
		[HDR]_Color_A("Color_A", Color) = (0,0,0,0)
		_Color_B("Color_B", Color) = (1,0,0,0)
		_VertexNormal_Str("VertexNormal_Str", Range( 0 , 1)) = 0
		_Dissolve_Texure("Dissolve_Texure", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform sampler2D _Main_Texture;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _VertexNormal_Str;
		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _Dissolve_Texure;
		uniform float _DissTex_VPanner;
		uniform float4 _Dissolve_Texure_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult7 = (float2(0.0 , _Main_VPanner));
			float2 uv0_Main_Texture = v.texcoord.xy * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner2 = ( 1.0 * _Time.y * appendResult7 + uv0_Main_Texture);
			float4 tex2DNode1 = tex2Dlod( _Main_Texture, float4( panner2, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2DNode1.r * ase_vertexNormal ) * _VertexNormal_Str );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult7 = (float2(0.0 , _Main_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner2 = ( 1.0 * _Time.y * appendResult7 + uv0_Main_Texture);
			float4 tex2DNode1 = tex2D( _Main_Texture, panner2 );
			float4 lerpResult10 = lerp( _Color_A , _Color_B , step( 0.31 , tex2DNode1.r ));
			o.Emission = lerpResult10.rgb;
			float2 appendResult25 = (float2(0.0 , _DissTex_VPanner));
			float2 uv0_Dissolve_Texure = i.uv_texcoord * _Dissolve_Texure_ST.xy + _Dissolve_Texure_ST.zw;
			float2 panner27 = ( 1.0 * _Time.y * appendResult25 + uv0_Dissolve_Texure);
			o.Alpha = saturate( step( tex2D( _Dissolve_Texure, panner27 ).r , i.uv_tex4coord.z ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;281;1920;738;395.3492;-400.8259;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;24;-165.5522,946.6727;Float;False;Property;_DissTex_VPanner;DissTex_VPanner;2;0;Create;True;0;0;False;0;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-172.5522,869.6727;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-858,165.5;Float;False;Property;_Main_VPanner;Main_VPanner;1;0;Create;True;0;0;False;0;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-865,88.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;6.447865,818.6727;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-958,-104.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-686,37.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-166.5521,689.6728;Float;False;0;19;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;27;157.4479,700.6728;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-535,-80.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;30;394.8768,965.3597;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;355.0131,665.0089;Float;True;Property;_Dissolve_Texure;Dissolve_Texure;6;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-244,89.5;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;0.31;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-366,-115.5;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;15;-71.33423,251.9415;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;149.6658,374.9415;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;5;0;Create;True;0;0;False;0;0;0.274;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;176.6658,91.94153;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;14;-110.3342,-389.0585;Float;False;Property;_Color_B;Color_B;4;0;Create;True;0;0;False;0;1,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-108.3342,-591.0585;Float;False;Property;_Color_A;Color_A;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.06875221,0.290881,0.9716981,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;8;-59.39999,-98.09999;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;28;670.3877,700.2458;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;371.6575,861.5017;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;452.6658,200.9415;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;10;182.3116,-377.463;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;22;1051.657,598.5017;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1051.335,-275.8347;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/13Week_Waterline;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;27;0;26;0
WireConnection;27;2;25;0
WireConnection;2;0;3;0
WireConnection;2;2;7;0
WireConnection;19;1;27;0
WireConnection;1;1;2;0
WireConnection;16;0;1;1
WireConnection;16;1;15;0
WireConnection;8;0;9;0
WireConnection;8;1;1;1
WireConnection;28;0;19;1
WireConnection;28;1;30;3
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;10;0;13;0
WireConnection;10;1;14;0
WireConnection;10;2;8;0
WireConnection;22;0;28;0
WireConnection;0;2;10;0
WireConnection;0;9;22;0
WireConnection;0;11;17;0
ASEEND*/
//CHKSM=388F2B111254A8133210084574F9B30B01BAE4D9