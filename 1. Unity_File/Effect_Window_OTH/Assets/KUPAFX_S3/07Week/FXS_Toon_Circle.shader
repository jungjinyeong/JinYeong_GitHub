// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Toon_Circle_Dissolve"
{
	Properties
	{
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_VOffset("VOffset", Range( -1 , 1)) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 10
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( 0.01 , 1)) = 0.09152944
		[Toggle(USE_CUSTOM_ON)] Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform float _Dissolve;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _VOffset;
		uniform float _Mask_Pow;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = ( i.vertexColor * _Main_Color ).rgb;
			#ifdef USE_CUSTOM_ON
				float staticSwitch24 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch24 = _Dissolve;
			#endif
			float2 appendResult13 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner10 = ( 1.0 * _Time.y * appendResult13 + uv_Main_Texture);
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			#ifdef USE_CUSTOM_ON
				float staticSwitch22 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch22 = _VOffset;
			#endif
			float2 appendResult21 = (float2(0.0 , staticSwitch22));
			o.Alpha = ( i.vertexColor.a * ( step( staticSwitch24 , saturate( ( tex2D( _Main_Texture, panner10 ).r * pow( tex2D( _Mask_Texture, (uv_Mask_Texture*1.0 + appendResult21) ).r , _Mask_Pow ) ) ) ) * _Opacity ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;24;1920;995;2185.141;846.002;1.639821;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;23;-1463.327,415.9533;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-1504.611,270.2764;Inherit;False;Property;_VOffset;VOffset;1;0;Create;True;0;0;0;False;0;False;0;0.241;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1330.611,146.2764;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;22;-1168.013,310.379;Inherit;True;Property;Use_Custom;Use_Custom;9;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1301,-66.5;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1195.611,163.2764;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-970.2695,-278.1348;Inherit;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-990.2695,-356.1348;Inherit;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-928.2695,-494.1348;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;18;-1024.611,110.2764;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-786.2695,-324.1348;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-780,-34.5;Inherit;True;Property;_Mask_Texture;Mask_Texture;0;0;Create;True;0;0;0;False;0;False;-1;df9e34652b2692b4daf5cea2ebeee232;df9e34652b2692b4daf5cea2ebeee232;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-724,190.5;Inherit;False;Property;_Mask_Pow;Mask_Pow;2;0;Create;True;0;0;0;False;0;False;10;1.42;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;10;-669.2695,-473.1348;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;3;-413,12.5;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-515,-503.5;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-173,-192.5;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-182,95.5;Inherit;False;Property;_Dissolve;Dissolve;8;0;Create;True;0;0;0;False;0;False;0.09152944;0.32;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;24;-44.32715,329.9533;Inherit;True;Property;Use_Custom;Use_Custom;9;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;8;51,-165.5;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;6;262,-149.5;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;203,134.5;Inherit;False;Property;_Opacity;Opacity;3;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;254.4625,-374.2941;Inherit;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.7490196,0.7490196,0.7490196,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;25;279.6729,-558.0467;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;483.2,65.60001;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;608.6729,-196.0467;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;530.6729,-460.0467;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;924.9001,-322;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Toon_Circle_Dissolve;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;1;20;0
WireConnection;22;0;23;1
WireConnection;21;0;19;0
WireConnection;21;1;22;0
WireConnection;18;0;14;0
WireConnection;18;2;21;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;2;1;18;0
WireConnection;10;0;9;0
WireConnection;10;2;13;0
WireConnection;3;0;2;1
WireConnection;3;1;4;0
WireConnection;1;1;10;0
WireConnection;5;0;1;1
WireConnection;5;1;3;0
WireConnection;24;1;7;0
WireConnection;24;0;23;2
WireConnection;8;0;5;0
WireConnection;6;0;24;0
WireConnection;6;1;8;0
WireConnection;15;0;6;0
WireConnection;15;1;16;0
WireConnection;27;0;25;4
WireConnection;27;1;15;0
WireConnection;26;0;25;0
WireConnection;26;1;17;0
WireConnection;0;2;26;0
WireConnection;0;9;27;0
ASEEND*/
//CHKSM=3D582A7C302A02D6F9720369275DC84E32171F48