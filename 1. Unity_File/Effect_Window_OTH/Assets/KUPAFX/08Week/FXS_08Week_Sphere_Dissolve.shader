// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "t"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Normal_Texture("Normal_Texture", 2D) = "bump" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (0.9150943,0.361477,0.08201315,0)
		_Fresnel_Pow("Fresnel_Pow", Float) = 3.71
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Normal_Texture;
		uniform float4 _Normal_Texture_ST;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv0_Normal_Texture = i.uv_texcoord * _Normal_Texture_ST.xy + _Normal_Texture_ST.zw;
			float2 panner13 = ( 1.0 * _Time.y * float2( 6,0 ) + uv0_Normal_Texture);
			float fresnelNdotV1 = dot( UnpackNormal( tex2D( _Normal_Texture, (panner13*float2( 0.11,2 ) + 0.0) ) ), i.viewDir );
			float fresnelNode1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1, _Fresnel_Pow ) );
			float temp_output_10_0 = floor( ( saturate( fresnelNode1 ) * 35.0 ) );
			o.Emission = ( _Tint_Color * temp_output_10_0 ).rgb;
			o.Alpha = temp_output_10_0;
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * float2( 1,0 ) + uv0_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch28 = i.uv_tex4coord.z;
			#else
				float staticSwitch28 = _Dissolve;
			#endif
			clip( saturate( ( tex2D( _Dissolve_Texture, panner25 ).r + staticSwitch28 ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;782.4293;361.7739;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1567,-223.5;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;14;-1497,-55.5;Float;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;False;0;6,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;6;-1344,35.5;Float;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;0.11,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;13;-1342,-201.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;5;-1135,-61.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-948,-144.5;Float;True;Property;_Normal_Texture;Normal_Texture;1;0;Create;True;0;0;False;0;ca13f4c0cd8f4eb4fb22f7b62e6e0d7e;ca13f4c0cd8f4eb4fb22f7b62e6e0d7e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;3;-875,75.5;Float;True;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;8;-602,162.5;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;3;0;Create;True;0;0;False;0;3.71;2.79;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;29;-192.8169,814.3821;Float;False;589;322;커스텀 x가 디졸브다;2;27;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-662.817,350.3821;Float;False;0;20;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;26;-615.817,544.3821;Float;False;Constant;_Vector2;Vector 2;6;0;Create;True;0;0;False;0;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FresnelNode;1;-533,-89.5;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-237,184.5;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;35;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;25;-419.817,361.3821;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;27;-142.8169,911.3821;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-200.817,539.3821;Float;False;Property;_Dissolve;Dissolve;5;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;7;-244,-90.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-86.81702,334.3821;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;4;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-38,64.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;28;133.1831,864.3821;Float;True;Property;_Use_Custom;Use_Custom;6;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;48,-382.5;Float;False;Property;_Tint_Color;Tint_Color;2;1;[HDR];Create;True;0;0;False;0;0.9150943,0.361477,0.08201315,0;0.608393,0.2420831,0.05733547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;343.183,348.3821;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;10;148,-78.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;324,-344.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;22;555.2829,359.8821;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;651,-280;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;t;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;4;0
WireConnection;13;2;14;0
WireConnection;5;0;13;0
WireConnection;5;1;6;0
WireConnection;2;1;5;0
WireConnection;1;0;2;0
WireConnection;1;4;3;0
WireConnection;1;3;8;0
WireConnection;25;0;24;0
WireConnection;25;2;26;0
WireConnection;7;0;1;0
WireConnection;20;1;25;0
WireConnection;11;0;7;0
WireConnection;11;1;12;0
WireConnection;28;1;23;0
WireConnection;28;0;27;3
WireConnection;21;0;20;1
WireConnection;21;1;28;0
WireConnection;10;0;11;0
WireConnection;18;0;19;0
WireConnection;18;1;10;0
WireConnection;22;0;21;0
WireConnection;0;2;18;0
WireConnection;0;9;10;0
WireConnection;0;10;22;0
ASEEND*/
//CHKSM=23D90B9C68F3CA7C54200B0D899DF2EF34CBF895