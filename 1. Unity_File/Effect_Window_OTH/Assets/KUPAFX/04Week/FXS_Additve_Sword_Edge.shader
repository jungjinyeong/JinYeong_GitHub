// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additve_Sword_Edge"
{
	Properties
	{
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Edge_Range("Edge_Range", Range( -1 , 1)) = -0.9058824
		_Edge_Ins("Edge_Ins", Range( 1 , 10)) = 1
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float _Edge_Range;
		uniform sampler2D _Sword_Texture;
		uniform float4 _Sword_Texture_ST;
		uniform float _Edge_Ins;
		uniform float4 _Edge_Color;
		uniform sampler2D _TextureSample0;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Sword_Texture = i.uv_texcoord * _Sword_Texture_ST.xy + _Sword_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch27 = i.uv_tex4coord.z;
			#else
				float staticSwitch27 = _Edge_Ins;
			#endif
			float2 panner20 = ( 1.0 * _Time.y * float2( 0.1,0 ) + i.uv_texcoord);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch26 = i.uv_tex4coord.w;
			#else
				float staticSwitch26 = _Dissolve;
			#endif
			o.Emission = ( i.vertexColor * ( ( ( ( step( 0.0 , ( i.uv_texcoord.y + _Edge_Range ) ) * tex2D( _Sword_Texture, uv0_Sword_Texture ).r ) * staticSwitch27 ) * _Edge_Color ) * saturate( ( tex2D( _TextureSample0, panner20 ).r + staticSwitch26 ) ) ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;1600.318;267.0964;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1354.773,-579.9659;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1439.772,-289.966;Float;True;Property;_Edge_Range;Edge_Range;2;0;Create;True;0;0;False;0;-0.9058824;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1109.773,-464.966;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;22;-1082.504,342.1985;Float;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;0.1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1180.703,-90.62634;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1232.004,190.0985;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-662.7032,-127.6263;Float;False;Property;_Edge_Ins;Edge_Ins;3;0;Create;True;0;0;False;0;1;10;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-812.5043,-5.801636;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;-909.604,212.1985;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-816.9813,451.2629;Float;False;Property;_Dissolve;Dissolve;6;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-971.7726,-156.966;Float;True;Property;_Sword_Texture;Sword_Texture;1;0;Create;True;0;0;False;0;fbd881075d1df3b41ae412d200105292;fbd881075d1df3b41ae412d200105292;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;8;-883.7726,-516.966;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;26;-453.318,433.9036;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-738.902,195.1624;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-630.7726,-364.966;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;27;-450.318,1.903625;Float;False;Property;_Use_Custom;Use_Custom;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-424.5813,206.2629;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-404.7032,-364.6263;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-280.7032,-157.6263;Float;False;Property;_Edge_Color;Edge_Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;18;-232.5813,205.2629;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-23.20327,-364.3263;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;23;130.3958,-94.60162;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;21.19611,175.7985;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;437.1958,-173.9016;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;599.4,-179.3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additve_Sword_Edge;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;2
WireConnection;3;1;4;0
WireConnection;20;0;21;0
WireConnection;20;2;22;0
WireConnection;1;1;14;0
WireConnection;8;1;3;0
WireConnection;26;1;17;0
WireConnection;26;0;25;4
WireConnection;15;1;20;0
WireConnection;5;0;8;0
WireConnection;5;1;1;1
WireConnection;27;1;10;0
WireConnection;27;0;25;3
WireConnection;16;0;15;1
WireConnection;16;1;26;0
WireConnection;9;0;5;0
WireConnection;9;1;27;0
WireConnection;18;0;16;0
WireConnection;11;0;9;0
WireConnection;11;1;13;0
WireConnection;19;0;11;0
WireConnection;19;1;18;0
WireConnection;24;0;23;0
WireConnection;24;1;19;0
WireConnection;0;2;24;0
WireConnection;0;9;23;4
ASEEND*/
//CHKSM=D1A3672667A1505C240FC30C477E4C03CEFD3E9B