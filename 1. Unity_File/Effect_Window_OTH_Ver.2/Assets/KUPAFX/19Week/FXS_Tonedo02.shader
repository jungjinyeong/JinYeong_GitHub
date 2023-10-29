// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Tonde02"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Tex_UPanner("Main_Tex_UPanner", Float) = 0
		_Main_Tex_VPanner("Main_Tex_VPanner", Float) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 0
		_Mask_Range("Mask_Range", Range( 0.1 , 10)) = 4
		_Vertex_Normal_Str("Vertex_Normal_Str", Range( 0 , 5)) = 0
		_ColorRange_A("ColorRange_A", Range( 0 , 1)) = 0
		[HDR]_ColorB_A("ColorB_A", Color) = (0,0,0,0)
		[HDR]_ColorA_B("ColorA_B", Color) = (0,0.3202362,1,0)
		_ColorRange_B("ColorRange_B", Range( 0 , 1)) = 0
		[HDR]_ColorB_B("ColorB_B", Color) = (0.2293997,1,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Main_Texture;
		uniform float _Main_Tex_UPanner;
		uniform float _Main_Tex_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Vertex_Normal_Str;
		uniform float4 _ColorB_A;
		uniform float4 _ColorB_B;
		uniform float _ColorRange_B;
		uniform float4 _ColorA_B;
		uniform float _ColorRange_A;
		uniform float _Mask_Range;
		uniform float _Opacity;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult7 = (float2(_Main_Tex_UPanner , _Main_Tex_VPanner));
			float2 uv0_Main_Texture = v.texcoord.xy * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner2 = ( 1.0 * _Time.y * appendResult7 + uv0_Main_Texture);
			float4 tex2DNode1 = tex2Dlod( _Main_Texture, float4( panner2, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( saturate( tex2DNode1.r ) * ase_vertexNormal ) * _Vertex_Normal_Str );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult7 = (float2(_Main_Tex_UPanner , _Main_Tex_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner2 = ( 1.0 * _Time.y * appendResult7 + uv0_Main_Texture);
			float4 tex2DNode1 = tex2D( _Main_Texture, panner2 );
			float4 lerpResult31 = lerp( _ColorB_A , _ColorB_B , step( tex2DNode1.r , _ColorRange_B ));
			float4 lerpResult28 = lerp( lerpResult31 , _ColorA_B , step( tex2DNode1.r , _ColorRange_A ));
			o.Emission = lerpResult28.rgb;
			o.Alpha = 1;
			float temp_output_13_0 = pow( ( ( saturate( ( 1.0 - i.uv_texcoord.y ) ) * saturate( i.uv_texcoord.y ) ) * 4.0 ) , _Mask_Range );
			clip( ( ( ( tex2DNode1.r + temp_output_13_0 ) * temp_output_13_0 ) * _Opacity ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;2276.78;931.2986;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-3454.517,614.7965;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;10;-3203.517,465.7965;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-3054.517,750.7965;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2610.191,102.0548;Float;False;Property;_Main_Tex_UPanner;Main_Tex_UPanner;2;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;-3024.517,465.7965;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2901.674,198.6953;Float;False;Property;_Main_Tex_VPanner;Main_Tex_VPanner;3;0;Create;True;0;0;False;0;1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2514.191,-35.94517;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-2374.191,116.0548;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-2801.517,977.7966;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2795.517,641.7965;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2587.517,987.7966;Float;False;Property;_Mask_Range;Mask_Range;5;0;Create;True;0;0;False;0;4;1;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-2579.517,752.7965;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;2;-2262.191,5.054836;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;13;-2262.517,736.7965;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2043.191,-7.945164;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-1891.46,-360.489;Float;False;Property;_ColorRange_B;ColorRange_B;10;0;Create;True;0;0;False;0;0;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1509.46,-44.48898;Float;False;Property;_ColorRange_A;ColorRange_A;7;0;Create;True;0;0;False;0;0;0.4470588;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;-1578.46,-883.489;Float;False;Property;_ColorB_A;ColorB_A;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;32;-1515.46,-417.489;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-1185.458,751.3795;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1679.246,188.0323;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-1578.46,-680.489;Float;False;Property;_ColorB_B;ColorB_B;11;1;[HDR];Create;True;0;0;False;0;0.2293997,1,0,0;0.4808904,0.4575472,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;21;-1271.17,1008.265;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1543.28,698.729;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;0;4.3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-995.3722,1147.283;Float;False;Property;_Vertex_Normal_Str;Vertex_Normal_Str;6;0;Create;True;0;0;False;0;0;0.3;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1557.28,446.7289;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;31;-1222.46,-798.489;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;26;-1161.46,-198.489;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-966.3722,863.2828;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;30;-1161.46,-386.489;Float;False;Property;_ColorA_B;ColorA_B;9;1;[HDR];Create;True;0;0;False;0;0,0.3202362,1,0;1,0.2520667,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-739.3722,851.2828;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1080.28,478.7289;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;28;-845.4604,-389.489;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-164.9769,-30.12206;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Tonde02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;8;2
WireConnection;20;0;8;2
WireConnection;19;0;10;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;9;0;19;0
WireConnection;9;1;20;0
WireConnection;11;0;9;0
WireConnection;11;1;12;0
WireConnection;2;0;3;0
WireConnection;2;2;7;0
WireConnection;13;0;11;0
WireConnection;13;1;14;0
WireConnection;1;1;2;0
WireConnection;32;0;1;1
WireConnection;32;1;33;0
WireConnection;22;0;1;1
WireConnection;15;0;1;1
WireConnection;15;1;13;0
WireConnection;16;0;15;0
WireConnection;16;1;13;0
WireConnection;31;0;29;0
WireConnection;31;1;35;0
WireConnection;31;2;32;0
WireConnection;26;0;1;1
WireConnection;26;1;27;0
WireConnection;23;0;22;0
WireConnection;23;1;21;0
WireConnection;24;0;23;0
WireConnection;24;1;25;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;28;0;31;0
WireConnection;28;1;30;0
WireConnection;28;2;26;0
WireConnection;0;2;28;0
WireConnection;0;10;17;0
WireConnection;0;11;24;0
ASEEND*/
//CHKSM=E1B3B6D02E693C22B24382406ECAF6A9F59FD374