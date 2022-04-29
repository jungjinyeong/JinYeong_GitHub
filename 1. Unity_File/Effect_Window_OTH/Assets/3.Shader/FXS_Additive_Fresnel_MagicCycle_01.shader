// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Tint_Dissolve_MagicCycle_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -1 , 1)) = 1
		_Mask_Pow("Mask_Pow", Float) = 1.6
		_Nomal_Texture("Nomal_Texture", 2D) = "bump" {}
		_Noise_Ins("Noise_Ins", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Flow_Texture_1("Flow_Texture_1", 2D) = "white" {}
		_Flow_Time_1("Flow_Time_1", Float) = 0
		_Flow_Texture_2("Flow_Texture_2", 2D) = "white" {}
		_Flow_Time_2("Flow_Time_2", Float) = 0
		_Flow_Pow("Flow_Pow", Float) = 1.03
		_Flow_Ins("Flow_Ins", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Float1("Float 1", Range( 0 , 20)) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
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
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Nomal_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Nomal_Texture_ST;
		uniform float _Noise_Ins;
		uniform sampler2D _Flow_Texture_1;
		uniform float4 _Flow_Texture_1_ST;
		uniform float _Flow_Time_1;
		uniform float _Flow_Pow;
		uniform float _Flow_Ins;
		uniform sampler2D _Flow_Texture_2;
		uniform float4 _Flow_Texture_2_ST;
		uniform float _Flow_Time_2;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve_Val;
		uniform float _Mask_Pow;
		uniform float _Float1;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult80 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Nomal_Texture = i.uv_texcoord * _Nomal_Texture_ST.xy + _Nomal_Texture_ST.zw;
			float2 panner77 = ( 1.0 * _Time.y * appendResult80 + uv0_Nomal_Texture);
			float4 tex2DNode1 = tex2D( _Main_Texture, ( uv0_Main_Texture + ( (UnpackNormal( tex2D( _Nomal_Texture, panner77 ) )).xy * _Noise_Ins ) ) );
			float2 uv0_Flow_Texture_1 = i.uv_texcoord * _Flow_Texture_1_ST.xy + _Flow_Texture_1_ST.zw;
			float mulTime96 = _Time.y * _Flow_Time_1;
			float cos93 = cos( mulTime96 );
			float sin93 = sin( mulTime96 );
			float2 rotator93 = mul( uv0_Flow_Texture_1 - float2( 0.5,0.5 ) , float2x2( cos93 , -sin93 , sin93 , cos93 )) + float2( 0.5,0.5 );
			float4 temp_cast_0 = (_Flow_Pow).xxxx;
			float2 uv0_Flow_Texture_2 = i.uv_texcoord * _Flow_Texture_2_ST.xy + _Flow_Texture_2_ST.zw;
			float mulTime99 = _Time.y * _Flow_Time_2;
			float cos101 = cos( mulTime99 );
			float sin101 = sin( mulTime99 );
			float2 rotator101 = mul( uv0_Flow_Texture_2 - float2( 0.5,0.5 ) , float2x2( cos101 , -sin101 , sin101 , cos101 )) + float2( 0.5,0.5 );
			float4 temp_cast_1 = (_Flow_Pow).xxxx;
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch20 = i.uv_tex4coord.z;
			#else
				float staticSwitch20 = _Dissolve_Val;
			#endif
			o.Emission = ( ( _Main_Color * ( ( ( tex2DNode1 + ( tex2DNode1 * ( pow( saturate( tex2D( _Flow_Texture_1, rotator93 ) ) , temp_cast_0 ) * _Flow_Ins ) * ( _Flow_Ins * pow( saturate( tex2D( _Flow_Texture_2, rotator101 ) ) , temp_cast_1 ) ) ) ) * saturate( ( tex2D( _Dissolve_Texture, uv0_Dissolve_Texture ) + staticSwitch20 ) ) ) * i.vertexColor ) ) * saturate( ( pow( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) * ( 1.0 * i.uv_texcoord.x ) ) ) * 4.0 ) , _Mask_Pow ) * pow( ( saturate( ( ( 1.0 - i.uv_texcoord.y ) * ( i.uv_texcoord.y * 1.0 ) ) ) * 4.0 ) , _Mask_Pow ) ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * ( tex2DNode1 * _Float1 ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;350;1920;669;2824.681;-24.62204;1.801554;True;False
Node;AmplifyShaderEditor.RangedFloatNode;79;-4598.288,-631.2692;Float;False;Property;_Noise_VPanner;Noise_VPanner;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-4598.288,-791.2692;Float;False;Property;_Noise_UPanner;Noise_UPanner;7;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-4678.288,-167.2692;Float;False;Property;_Flow_Time_1;Flow_Time_1;9;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-4662.288,264.7308;Float;False;Property;_Flow_Time_2;Flow_Time_2;11;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;80;-4374.288,-727.2692;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-4566.288,-999.2692;Float;False;0;75;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;77;-4262.289,-999.2692;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-4518.288,-55.26923;Float;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;100;-4486.288,104.7308;Float;False;Constant;_Vector0;Vector 0;17;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;86;-4550.288,-487.2692;Float;False;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;99;-4454.288,264.7308;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;96;-4486.288,-167.2692;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;94;-4518.288,-327.2692;Float;False;Constant;_Flow_Position;Flow_Position;17;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;101;-4214.289,104.7308;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;75;-4038.287,-999.2692;Float;True;Property;_Nomal_Texture;Nomal_Texture;5;0;Create;True;0;0;False;0;None;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;93;-4230.289,-327.2692;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;102;-3990.287,88.73077;Float;True;Property;_Flow_Texture_2;Flow_Texture_2;10;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;82;-3686.287,-999.2692;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;72;-3131.386,1311.286;Float;False;2058.847;981.9049;Mask;17;55;52;62;54;53;61;56;63;68;69;58;64;60;59;65;66;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-3638.287,-599.2692;Float;False;Property;_Noise_Ins;Noise_Ins;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;85;-3958.287,-359.2692;Float;True;Property;_Flow_Texture_1;Flow_Texture_1;8;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-3031.391,1901.203;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-3081.386,1707.21;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;73;-3435.126,471.7944;Float;False;1254.651;652.8643;Tint_Dissolve;7;117;41;14;20;13;115;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-3398.287,-615.2692;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;108;-3670.287,-359.2692;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;74;-3414.287,-839.2692;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;105;-3670.287,-119.2692;Float;True;Property;_Flow_Pow;Flow_Pow;12;0;Create;True;0;0;False;0;1.03;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;109;-3654.287,120.7308;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-3323.903,775.0334;Float;False;Property;_Dissolve_Val;Dissolve_Val;3;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-3446.287,-119.2692;Float;True;Property;_Flow_Ins;Flow_Ins;13;0;Create;True;0;0;False;0;0;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-3333.135,917.7889;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;62;-2688.822,1361.286;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;53;-2719.711,1798.921;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-2736.874,2039.191;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-2731.563,1573.651;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-3206.287,-599.2692;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;107;-3478.287,-343.2692;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-3381.19,537.8745;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;110;-3446.287,120.7308;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-2444.961,1436.463;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-2998.112,840.2997;Float;False;Property;_Use_Custom;Use_Custom;15;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2463.001,1891.552;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-3142.287,88.73077;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-3126.287,-503.2692;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;40526e53665b54f4ab08530fa57888a3;881d985a758544b40991e70cf9130a76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-3174.287,-279.2692;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;14;-3037.702,521.7944;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;2;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;d010bcc6d54f28a41aa8be3558cfd9f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2870.287,-183.2692;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;68;-2237.336,1441.816;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;69;-2230.456,1890.808;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2613.742,596.8718;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;117;-2358.722,585.108;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2070.98,1728.557;Float;False;Property;_Mask_Pow;Mask_Pow;4;0;Create;True;0;0;False;0;1.6;0.92;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-2613.692,-207.5671;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2072.271,1438.196;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-2031.821,1912.208;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;-1813.273,1894.531;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;65;-1812.303,1447.651;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-2037.377,-83.32419;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;2;-1791.816,151.4811;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;-1357.551,-203.64;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.148698,1.148698,1.148698,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1486.397,-5.355162;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1495.583,1673.453;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-2102.258,466.0028;Float;False;Property;_Float1;Float 1;17;0;Create;True;0;0;False;0;0;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;-1805.344,350.7412;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;67;-1270.538,1682.656;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1121.515,11.87197;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-457.676,75.77728;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-1451.897,359.7111;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-178.0107,63.11458;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Tint_Dissolve_MagicCycle_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;16;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;78;0
WireConnection;80;1;79;0
WireConnection;77;0;76;0
WireConnection;77;2;80;0
WireConnection;99;0;97;0
WireConnection;96;0;90;0
WireConnection;101;0;98;0
WireConnection;101;1;100;0
WireConnection;101;2;99;0
WireConnection;75;1;77;0
WireConnection;93;0;86;0
WireConnection;93;1;94;0
WireConnection;93;2;96;0
WireConnection;102;1;101;0
WireConnection;82;0;75;0
WireConnection;85;1;93;0
WireConnection;83;0;82;0
WireConnection;83;1;84;0
WireConnection;108;0;85;0
WireConnection;109;0;102;0
WireConnection;62;0;52;1
WireConnection;53;0;52;2
WireConnection;54;0;52;2
WireConnection;54;1;55;0
WireConnection;61;0;55;0
WireConnection;61;1;52;1
WireConnection;81;0;74;0
WireConnection;81;1;83;0
WireConnection;107;0;108;0
WireConnection;107;1;105;0
WireConnection;110;0;109;0
WireConnection;110;1;105;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;20;1;115;0
WireConnection;20;0;19;3
WireConnection;56;0;53;0
WireConnection;56;1;54;0
WireConnection;111;0;106;0
WireConnection;111;1;110;0
WireConnection;1;1;81;0
WireConnection;104;0;107;0
WireConnection;104;1;106;0
WireConnection;14;1;13;0
WireConnection;89;0;1;0
WireConnection;89;1;104;0
WireConnection;89;2;111;0
WireConnection;68;0;63;0
WireConnection;69;0;56;0
WireConnection;41;0;14;0
WireConnection;41;1;20;0
WireConnection;117;0;41;0
WireConnection;88;0;1;0
WireConnection;88;1;89;0
WireConnection;64;0;68;0
WireConnection;58;0;69;0
WireConnection;59;0;58;0
WireConnection;59;1;60;0
WireConnection;65;0;64;0
WireConnection;65;1;60;0
WireConnection;116;0;88;0
WireConnection;116;1;117;0
WireConnection;45;0;116;0
WireConnection;45;1;2;0
WireConnection;66;0;65;0
WireConnection;66;1;59;0
WireConnection;120;0;1;0
WireConnection;120;1;121;0
WireConnection;67;0;66;0
WireConnection;70;0;71;0
WireConnection;70;1;45;0
WireConnection;113;0;70;0
WireConnection;113;1;67;0
WireConnection;122;0;2;4
WireConnection;122;1;120;0
WireConnection;0;2;113;0
WireConnection;0;9;122;0
ASEEND*/
//CHKSM=3107AF0E85AC91B1170962ADEE4A77076B6E717A