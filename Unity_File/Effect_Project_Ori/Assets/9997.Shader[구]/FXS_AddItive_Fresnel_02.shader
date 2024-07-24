// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/AddItive_Fresnel_02"
{
	Properties
	{
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Upanner("Mask_Upanner", Float) = 0
		_Mask_Vpanner("Mask_Vpanner", Float) = 0
		_Dissolve_Val("Dissolve_Val", Float) = 1
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
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Mask_Texture;
		uniform float _Mask_Upanner;
		uniform float _Mask_Vpanner;
		uniform float _Dissolve_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			float2 appendResult16 = (float2(_Mask_Upanner , _Mask_Vpanner));
			float2 panner13 = ( 1.0 * _Time.y * appendResult16 + i.uv_texcoord);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch38 = i.uv_tex4coord.z;
			#else
				float staticSwitch38 = _Dissolve_Val;
			#endif
			o.Emission = ( ( ( _Main_Color * ( pow( tex2D( _Main_Texture, uv0_Main_Texture ) , temp_cast_0 ) * _Main_Ins ) ) * i.vertexColor ) * saturate( ( tex2D( _Mask_Texture, panner13 ) + staticSwitch38 ) ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;2560;1011;1303.941;-48.6713;1.166323;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1140.644,19.06295;Float;False;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-997.7899,756.6596;Float;False;Property;_Mask_Vpanner;Mask_Vpanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-997.7899,668.913;Float;False;Property;_Mask_Upanner;Mask_Upanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-774.3171,12.87724;Float;True;Property;_Main_Texture;Main_Texture;2;0;Create;True;0;0;False;0;None;ce106e24dc148c945ae58639ae173375;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-630.6442,254.063;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;1;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-776.5053,675.0925;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-839.5345,518.1369;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;37;-376.7531,891.896;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;13;-591.1246,520.6086;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-367.3151,752.7599;Float;False;Property;_Dissolve_Val;Dissolve_Val;8;0;Create;True;0;0;False;0;1;4.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-345.6443,259.063;Float;False;Property;_Main_Ins;Main_Ins;4;0;Create;True;0;0;False;0;1;1.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;28;-439.6443,17.06295;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-176.6443,19.06295;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;11;-275.75,502.0069;Float;True;Property;_Mask_Texture;Mask_Texture;5;0;Create;True;0;0;False;0;None;beb42197c20baf049b1db685f6b520bf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;381.8685,-227.7048;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.297496,1.107352,0.641643,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;38;-114.0933,805.1793;Float;False;Property;_Use_Custom;Use_Custom;9;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;30;107.3557,282.063;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;147.0849,511.86;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;75.35565,20.06295;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;360.3557,9.06295;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;36;559.3778,519.6725;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;745.8691,14.03668;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1285.5,-38.87812;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/AddItive_Fresnel_02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;1;23;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;13;0;12;0
WireConnection;13;2;16;0
WireConnection;28;0;22;0
WireConnection;28;1;26;0
WireConnection;25;0;28;0
WireConnection;25;1;27;0
WireConnection;11;1;13;0
WireConnection;38;1;33;0
WireConnection;38;0;37;3
WireConnection;32;0;11;0
WireConnection;32;1;38;0
WireConnection;29;0;10;0
WireConnection;29;1;25;0
WireConnection;31;0;29;0
WireConnection;31;1;30;0
WireConnection;36;0;32;0
WireConnection;35;0;31;0
WireConnection;35;1;36;0
WireConnection;0;2;35;0
WireConnection;0;9;30;4
ASEEND*/
//CHKSM=F15C5EA4C4C6FB77FCCD4B052D5F81CCC4C6A609