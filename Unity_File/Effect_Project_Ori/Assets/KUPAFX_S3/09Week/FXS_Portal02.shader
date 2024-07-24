// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Portal02"
{
	Properties
	{
		_Main_Texure("Main_Texure", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color ", Color) = (1,1,1,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Mask_Pow("Mask_Pow", Range( 1 , 20)) = 1
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Sub_Texure("Sub_Texure", 2D) = "white" {}
		[HDR]_Sub_Color("Sub_Color ", Color) = (1,1,1,0)
		_Sub_Ins("Sub_Ins", Float) = 1
		_Sub_Pow("Sub_Pow", Float) = 8
		_Sub_UPanner("Sub_UPanner", Float) = 0
		_Sub_VPanner("Sub_VPanner", Float) = 0
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Sub_Texure;
		uniform float _Sub_UPanner;
		uniform float _Sub_VPanner;
		uniform float4 _Sub_Texure_ST;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _Main_Texure;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texure_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform float _Mask_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult41 = (float2(_Sub_UPanner , _Sub_VPanner));
			float2 uv_Sub_Texure = i.uv_texcoord * _Sub_Texure_ST.xy + _Sub_Texure_ST.zw;
			float2 panner43 = ( 1.0 * _Time.y * appendResult41 + uv_Sub_Texure);
			float3 desaturateInitialColor30 = tex2D( _Sub_Texure, panner43 ).rgb;
			float desaturateDot30 = dot( desaturateInitialColor30, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar30 = lerp( desaturateInitialColor30, desaturateDot30.xxx, 0.25 );
			float3 temp_cast_1 = (_Sub_Pow).xxx;
			float2 appendResult6 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult27 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner28 = ( 1.0 * _Time.y * appendResult27 + uv_Noise_Texture);
			float2 uv_Main_Texure = i.uv_texcoord * _Main_Texure_ST.xy + _Main_Texure_ST.zw;
			float2 panner3 = ( 1.0 * _Time.y * appendResult6 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner28 ) )).xy * _Noise_Val ) + uv_Main_Texure ));
			float4 temp_cast_3 = (_Main_Pow).xxxx;
			o.Emission = ( ( ( float4( ( pow( desaturateVar30 , temp_cast_1 ) * _Sub_Ins ) , 0.0 ) * _Sub_Color ) + ( ( pow( tex2D( _Main_Texure, panner3 ) , temp_cast_3 ) * _Main_Ins ) * _Main_Color ) ) * pow( saturate( ( 1.0 - i.uv_texcoord.y ) ) , _Mask_Pow ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;1;1920;1019;2033.141;1289.242;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-2225.9,-391.679;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2234.9,-313.679;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2304.9,-664.679;Inherit;True;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-2002.9,-378.679;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;28;-1988.9,-583.679;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-1798.3,-640.679;Inherit;True;Property;_Noise_Texture;Noise_Texture;7;0;Create;True;0;0;0;False;0;False;-1;1dbf1177420b46f47b20959a7c02ae71;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-1494.3,-552.679;Inherit;False;Property;_Noise_Val;Noise_Val;8;0;Create;True;0;0;0;False;0;False;0;0.058;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;22;-1422.3,-639.679;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1053.135,-797.6478;Inherit;False;Property;_Sub_UPanner;Sub_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1062.135,-719.6478;Inherit;False;Property;_Sub_VPanner;Sub_VPanner;16;0;Create;True;0;0;0;False;0;False;0;-0.58;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-1133.135,-1071.648;Inherit;True;0;19;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;41;-830.135,-784.6478;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1392,-332.5;Inherit;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1213,-60.5;Inherit;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1222,17.5;Inherit;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;0;False;0;False;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1180.3,-626.679;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-990,-47.5;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-1086.3,-444.679;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;43;-816.135,-989.6478;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-530.5826,-490.9723;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;3;-930,-229.5;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;19;-655.9138,-698.3195;Inherit;True;Property;_Sub_Texure;Sub_Texure;11;0;Create;True;0;0;0;False;0;False;-1;ff43c8a762114ad42a9677b19874a99c;ff43c8a762114ad42a9677b19874a99c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-244.5826,-447.9723;Inherit;False;Property;_Sub_Pow;Sub_Pow;14;0;Create;True;0;0;0;False;0;False;8;13.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;30;-337.5826,-693.9723;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-717,-263.5;Inherit;True;Property;_Main_Texure;Main_Texure;0;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;3f18438c964b0ef4b90cb76d9b2bd0cb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-735,-1.5;Inherit;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;32;-72.58264,-683.9723;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;35;12.41736,-452.9723;Inherit;False;Property;_Sub_Ins;Sub_Ins;13;0;Create;True;0;0;0;False;0;False;1;3.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-146.9059,356.5557;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;7;-428,-255.5;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-438,48.5;Inherit;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;0;False;0;False;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;71.09412,397.5557;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-161,-202.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;12;-121,24.5;Inherit;False;Property;_Main_Color;Main_Color ;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.479919,0.4036142,2.266449,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;91.41736,-401.9723;Inherit;False;Property;_Sub_Color;Sub_Color ;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;3.471288,2.306267,4.541205,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;199.4174,-622.9723;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;16;225.0941,391.5557;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;116.0942,616.5559;Inherit;False;Property;_Mask_Pow;Mask_Pow;6;0;Create;True;0;0;0;False;0;False;1;2.7;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;335.4174,-487.9723;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;54,-195.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;17;391.0941,392.5557;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;436.4174,-236.9723;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;610,212.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;873,-267;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Portal02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;26;0
WireConnection;27;1;25;0
WireConnection;28;0;29;0
WireConnection;28;2;27;0
WireConnection;21;1;28;0
WireConnection;22;0;21;0
WireConnection;41;0;40;0
WireConnection;41;1;39;0
WireConnection;23;0;22;0
WireConnection;23;1;24;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;20;0;23;0
WireConnection;20;1;2;0
WireConnection;43;0;42;0
WireConnection;43;2;41;0
WireConnection;3;0;20;0
WireConnection;3;2;6;0
WireConnection;19;1;43;0
WireConnection;30;0;19;0
WireConnection;30;1;31;0
WireConnection;1;1;3;0
WireConnection;32;0;30;0
WireConnection;32;1;33;0
WireConnection;7;0;1;0
WireConnection;7;1;10;0
WireConnection;15;0;13;2
WireConnection;8;0;7;0
WireConnection;8;1;11;0
WireConnection;34;0;32;0
WireConnection;34;1;35;0
WireConnection;16;0;15;0
WireConnection;36;0;34;0
WireConnection;36;1;37;0
WireConnection;9;0;8;0
WireConnection;9;1;12;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;38;0;36;0
WireConnection;38;1;9;0
WireConnection;14;0;38;0
WireConnection;14;1;17;0
WireConnection;0;2;14;0
ASEEND*/
//CHKSM=1C8DEE5BDA1724A3F350F095B8144FC6F036BBD2