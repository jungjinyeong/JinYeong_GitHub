// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additive_Beam"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Chromatic("Chromatic", Range( 0 , 0.1)) = 0.02
		_Main_Tex_UPanner("Main_Tex_UPanner", Float) = 0
		_Main_Tex_VPanner("Main_Tex_VPanner", Float) = 0
		_VertexNormal_Texure("VertexNormal_Texure", 2D) = "white" {}
		_Vertexnoraml_UPanner("Vertexnoraml_UPanner", Float) = 0
		_Vertexnoraml_VPanner("Vertexnoraml_VPanner", Float) = 0
		_Vertexnormal_Str("Vertexnormal_Str", Float) = 0
		_Mak_Pow("Mak_Pow", Range( 1 , 10)) = 4
		[Toggle(_SELECT_MASK_RG_ON)] _Select_Mask_RG("Select_Mask_RG", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma shader_feature _SELECT_MASK_RG_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _VertexNormal_Texure;
		uniform float _Vertexnoraml_UPanner;
		uniform float _Vertexnoraml_VPanner;
		uniform float4 _VertexNormal_Texure_ST;
		uniform float _Vertexnormal_Str;
		uniform sampler2D _Main_Texture;
		uniform float _Main_Tex_UPanner;
		uniform float _Main_Tex_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Chromatic;
		uniform float _Mak_Pow;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult23 = (float2(_Vertexnoraml_UPanner , _Vertexnoraml_VPanner));
			float2 uv0_VertexNormal_Texure = v.texcoord.xy * _VertexNormal_Texure_ST.xy + _VertexNormal_Texure_ST.zw;
			float2 panner19 = ( 1.0 * _Time.y * appendResult23 + uv0_VertexNormal_Texure);
			v.vertex.xyz += ( ( ase_vertexNormal * tex2Dlod( _VertexNormal_Texure, float4( panner19, 0, 0.0) ).r ) * _Vertexnormal_Str );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color11 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult15 = (float2(_Main_Tex_UPanner , _Main_Tex_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner12 = ( 1.0 * _Time.y * appendResult15 + uv0_Main_Texture);
			float2 temp_cast_0 = (_Chromatic).xx;
			float3 appendResult9 = (float3(tex2D( _Main_Texture, ( panner12 + _Chromatic ) ).r , tex2D( _Main_Texture, panner12 ).g , tex2D( _Main_Texture, ( panner12 - temp_cast_0 ) ).b));
			o.Emission = ( i.vertexColor * ( color11 * float4( appendResult9 , 0.0 ) ) ).rgb;
			#ifdef _SELECT_MASK_RG_ON
				float staticSwitch42 = pow( ( saturate( ( saturate( ( 1.0 - i.uv_texcoord.x ) ) * i.uv_texcoord.x ) ) * 4.0 ) , _Mak_Pow );
			#else
				float staticSwitch42 = pow( saturate( ( ( saturate( ( 1.0 - i.uv_texcoord.y ) ) * i.uv_texcoord.y ) * 4.0 ) ) , _Mak_Pow );
			#endif
			o.Alpha = ( i.vertexColor.b * staticSwitch42 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;-440.2958;-596.1792;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-261.256,971.2145;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;29;247.2093,797.7631;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1476,177.5;Float;False;Property;_Main_Tex_VPanner;Main_Tex_VPanner;4;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1483,99.5;Float;False;Property;_Main_Tex_UPanner;Main_Tex_UPanner;3;0;Create;True;0;0;False;0;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;36;439.558,1288.543;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1269,139.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1518,-54.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;37;599.4581,1284.643;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;30;431.2663,795.8998;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-1248,-53.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-472.6921,720.4651;Float;False;Property;_Vertexnoraml_UPanner;Vertexnoraml_UPanner;6;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-462.6921,802.4651;Float;False;Property;_Vertexnoraml_VPanner;Vertexnoraml_VPanner;7;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-996,-59.5;Float;False;Property;_Chromatic;Chromatic;2;0;Create;True;0;0;False;0;0.02;0.0094;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;854.5581,1314.243;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;636.6184,983.2648;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;893.6263,909.5248;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-657,-217.5;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;45;1128.296,1271.179;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-518.5429,526.2045;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-657,216.5;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-278.6921,736.4651;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-733,-37.5;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;34;1392.926,1174.625;Float;False;Property;_Mak_Pow;Mak_Pow;9;0;Create;True;0;0;False;0;4;6.952942;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;44;1170.296,1041.179;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;1478.958,1329.243;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;19;-215.6429,579.5043;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-378,164.5;Float;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-391,-224.5;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-388,-28.5;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;9;-24,-0.5;Float;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;33;1651.468,907.9665;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;41;1772.8,1289.685;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;8.857048,547.8043;Float;True;Property;_VertexNormal_Texure;VertexNormal_Texure;5;0;Create;True;0;0;False;0;c7d564bbc661feb448e7dcb86e2aa438;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;0,-222.5;Float;False;Constant;_Tint_Color;Tint_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;24;117.3079,400.4651;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;188.9,-86.2;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;426.5767,613.989;Float;False;Property;_Vertexnormal_Str;Vertexnormal_Str;8;0;Create;True;0;0;False;0;0;1.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;403.672,355.5717;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;42;1964.848,919.575;Float;True;Property;_Select_Mask_RG;Select_Mask_RG;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;694.7075,68.97836;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;802.0162,487.804;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1241.761,325.7083;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;789.9572,-193.4957;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1555.5,-219.7001;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additive_Beam;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;28;2
WireConnection;36;0;28;1
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;37;0;36;0
WireConnection;30;0;29;0
WireConnection;12;0;5;0
WireConnection;12;2;15;0
WireConnection;38;0;37;0
WireConnection;38;1;28;1
WireConnection;31;0;30;0
WireConnection;31;1;28;2
WireConnection;32;0;31;0
WireConnection;6;0;12;0
WireConnection;6;1;8;0
WireConnection;45;0;38;0
WireConnection;7;0;12;0
WireConnection;7;1;8;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;44;0;32;0
WireConnection;40;0;45;0
WireConnection;19;0;20;0
WireConnection;19;2;23;0
WireConnection;4;0;1;0
WireConnection;4;1;7;0
WireConnection;2;0;1;0
WireConnection;2;1;6;0
WireConnection;3;0;1;0
WireConnection;3;1;12;0
WireConnection;9;0;2;1
WireConnection;9;1;3;2
WireConnection;9;2;4;3
WireConnection;33;0;44;0
WireConnection;33;1;34;0
WireConnection;41;0;40;0
WireConnection;41;1;34;0
WireConnection;18;1;19;0
WireConnection;10;0;11;0
WireConnection;10;1;9;0
WireConnection;25;0;24;0
WireConnection;25;1;18;1
WireConnection;42;1;33;0
WireConnection;42;0;41;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;35;0;16;3
WireConnection;35;1;42;0
WireConnection;17;0;16;0
WireConnection;17;1;10;0
WireConnection;0;2;17;0
WireConnection;0;9;35;0
WireConnection;0;11;26;0
ASEEND*/
//CHKSM=13D9711FB79547A2790A1195A55C13E930DDF6AE