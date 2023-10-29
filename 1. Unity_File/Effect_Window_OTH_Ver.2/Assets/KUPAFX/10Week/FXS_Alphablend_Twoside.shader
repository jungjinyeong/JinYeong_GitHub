// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Aplhablend_Twoside"
{
	Properties
	{
		[HDR]_Front_Color("Front_Color", Color) = (1,1,1,0)
		[HDR]_Back_Color("Back_Color", Color) = (1,1,1,0)
		_Dissolve_Texure("Dissolve_Texure", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Diss_Tex_UPanner("Diss_Tex_UPanner", Range( -5 , 5)) = 0
		_Diss_Tex_VPanner("Diss_Tex_VPanner", Range( -5 , 5)) = 0
		_Dissove("Dissove", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Dissolve_U_Rotate("Dissolve_U_Rotate", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		AlphaToMask On
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float4 uv_texcoord;
		};

		uniform float4 _Front_Color;
		uniform float4 _Back_Color;
		uniform sampler2D _Dissolve_Texure;
		uniform float _Diss_Tex_UPanner;
		uniform float _Diss_Tex_VPanner;
		uniform float _Dissolve_U_Rotate;
		uniform float4 _Dissolve_Texure_ST;
		uniform float _Dissove;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 switchResult1 = (((i.ASEVFace>0)?(_Front_Color):(_Back_Color)));
			o.Emission = ( switchResult1 * i.vertexColor ).rgb;
			o.Alpha = 1;
			float2 appendResult29 = (float2(_Diss_Tex_UPanner , _Diss_Tex_VPanner));
			float4 uvs_Dissolve_Texure = i.uv_texcoord;
			uvs_Dissolve_Texure.xy = i.uv_texcoord.xy * _Dissolve_Texure_ST.xy + _Dissolve_Texure_ST.zw;
			float temp_output_41_0 = ( uvs_Dissolve_Texure.xy.y * 1.0 );
			float2 appendResult44 = (float2(( ( _Dissolve_U_Rotate * ( uvs_Dissolve_Texure.xy.x * 1.0 ) ) + temp_output_41_0 ) , temp_output_41_0));
			float2 panner6 = ( 1.0 * _Time.y * appendResult29 + appendResult44);
			float4 tex2DNode5 = tex2D( _Dissolve_Texure, panner6 );
			float temp_output_13_0 = saturate( ( 1.0 - i.uv_texcoord.xy.y ) );
			float temp_output_24_0 = saturate( pow( ( ( temp_output_13_0 * i.uv_texcoord.xy.y ) * 4.0 ) , 6.0 ) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch35 = i.uv_texcoord.z;
			#else
				float staticSwitch35 = _Dissove;
			#endif
			clip( ( i.vertexColor.a * ( pow( ( ( tex2DNode5.r + temp_output_13_0 ) * temp_output_13_0 ) , 4.0 ) * saturate( ( ( ( tex2DNode5.r + temp_output_24_0 ) * temp_output_24_0 ) + staticSwitch35 ) ) ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1085;711;2638.135;894.1744;1.696439;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1381.9,234.6;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;-2194.173,-289.7382;Inherit;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2254.536,-431.0868;Inherit;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1956.898,-464.8009;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1967.026,-652.8846;Inherit;False;Property;_Dissolve_U_Rotate;Dissolve_U_Rotate;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;-1039.025,267.7825;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;13;-838.9882,276.8528;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1954.005,-336.0358;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1791.963,-618.1614;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-634.2095,922.7902;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1807.799,41.26854;Float;False;Property;_Diss_Tex_VPanner;Diss_Tex_VPanner;5;0;Create;True;0;0;0;False;0;False;0;1.86;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1668.986,-463.354;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1805.799,-41.73147;Float;False;Property;_Diss_Tex_UPanner;Diss_Tex_UPanner;4;0;Create;True;0;0;0;False;0;False;0;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-705.7093,691.3902;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;44;-1511.284,-302.7595;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-461.3095,719.9903;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-404.1096,961.7903;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1531.974,-25.02279;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;6;-1372.6,-118.1;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;22;-254.6096,738.1903;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1135.6,-65.09999;Inherit;True;Property;_Dissolve_Texure;Dissolve_Texure;2;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;24;-6.309546,739.4904;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;276.9608,982.7222;Float;False;Property;_Dissove;Dissove;6;0;Create;True;0;0;0;False;0;False;0;0.3058824;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;34;352.5146,1082.425;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;25;149.6905,570.4902;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-621.6874,-14.66496;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;395.578,710.7474;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;35;607.5146,1040.425;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;681.8652,762.8179;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-308.0001,417.2001;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-287.1974,209.9499;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-320,-378.5;Float;False;Property;_Front_Color;Front_Color;0;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;16;-14.43477,214.3124;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-315,-145.5;Float;False;Property;_Back_Color;Back_Color;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.433962,0.6966854,0.4261303,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;32;863.4282,712.4059;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;498.9864,179.8035;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;1;103.4585,-234.2529;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;36;513.1545,-88.89806;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;812.4395,-119.8005;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;725.8461,89.46292;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;936.5184,-157.3853;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Aplhablend_Twoside;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;3;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;7;1
WireConnection;40;1;42;0
WireConnection;12;0;9;2
WireConnection;13;0;12;0
WireConnection;41;0;7;2
WireConnection;41;1;42;0
WireConnection;45;0;47;0
WireConnection;45;1;40;0
WireConnection;46;0;45;0
WireConnection;46;1;41;0
WireConnection;19;0;13;0
WireConnection;19;1;9;2
WireConnection;44;0;46;0
WireConnection;44;1;41;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;6;0;44;0
WireConnection;6;2;29;0
WireConnection;22;0;20;0
WireConnection;22;1;23;0
WireConnection;5;1;6;0
WireConnection;24;0;22;0
WireConnection;25;0;5;1
WireConnection;25;1;24;0
WireConnection;14;0;5;1
WireConnection;14;1;13;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;35;1;33;0
WireConnection;35;0;34;3
WireConnection;31;0;26;0
WireConnection;31;1;35;0
WireConnection;15;0;14;0
WireConnection;15;1;13;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;32;0;31;0
WireConnection;39;0;16;0
WireConnection;39;1;32;0
WireConnection;1;0;3;0
WireConnection;1;1;4;0
WireConnection;37;0;1;0
WireConnection;37;1;36;0
WireConnection;38;0;36;4
WireConnection;38;1;39;0
WireConnection;0;2;37;0
WireConnection;0;10;38;0
ASEEND*/
//CHKSM=17A9A8678A09D2859D1B8ADBE461E0BCCADFEF8D