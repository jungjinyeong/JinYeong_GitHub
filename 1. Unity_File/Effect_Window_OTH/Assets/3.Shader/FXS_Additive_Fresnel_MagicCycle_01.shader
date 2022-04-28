// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Tint_Dissolve_MagicCycle_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Tint_Dissolve_Texture("Tint_Dissolve_Texture", 2D) = "white" {}
		[HDR]_Dissolve_Color("Dissolve_Color", Color) = (0,0,0,0)
		_Dissolve_Int("Dissolve_Int", Range( -1 , 1)) = 0
		_Dissolve_Val("Dissolve_Val", Range( -1 , 2)) = 0
		_Step_Size_Int("Step_Size_Int", Float) = 0
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
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		uniform float _Dissolve_Val;
		uniform sampler2D _Tint_Dissolve_Texture;
		uniform float4 _Tint_Dissolve_Texture_ST;
		uniform float4 _Main_Color;
		uniform float _Step_Size_Int;
		uniform float4 _Dissolve_Color;
		uniform float _Dissolve_Int;
		uniform float _Mask_Pow;
		uniform float _Cutoff = 0.5;

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
			#ifdef _USE_CUSTOM_ON
				float staticSwitch20 = i.uv_tex4coord.z;
			#else
				float staticSwitch20 = _Dissolve_Val;
			#endif
			float2 uv0_Tint_Dissolve_Texture = i.uv_texcoord * _Tint_Dissolve_Texture_ST.xy + _Tint_Dissolve_Texture_ST.zw;
			float4 tex2DNode14 = tex2D( _Tint_Dissolve_Texture, uv0_Tint_Dissolve_Texture );
			float temp_output_3_0_g19 = ( staticSwitch20 - tex2DNode14.r );
			float temp_output_42_0 = saturate( ( temp_output_3_0_g19 / fwidth( temp_output_3_0_g19 ) ) );
			float temp_output_3_0_g20 = ( saturate( ( staticSwitch20 + _Step_Size_Int ) ) - tex2DNode14.r );
			float temp_output_43_0 = saturate( ( temp_output_3_0_g20 / fwidth( temp_output_3_0_g20 ) ) );
			o.Emission = ( ( ( ( ( tex2DNode1 + ( tex2DNode1 * ( pow( saturate( tex2D( _Flow_Texture_1, rotator93 ) ) , temp_cast_0 ) * _Flow_Ins ) * ( _Flow_Ins * pow( saturate( tex2D( _Flow_Texture_2, rotator101 ) ) , temp_cast_1 ) ) ) ) * temp_output_42_0 * i.vertexColor ) * _Main_Color ) + ( i.vertexColor.a * ( temp_output_43_0 - temp_output_42_0 ) * _Dissolve_Color * saturate( _Dissolve_Int ) ) ) * saturate( ( pow( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) * ( 1.0 * i.uv_texcoord.x ) ) ) * 4.0 ) , _Mask_Pow ) * pow( ( saturate( ( ( 1.0 - i.uv_texcoord.y ) * ( i.uv_texcoord.y * 1.0 ) ) ) * 4.0 ) , _Mask_Pow ) ) ) ).rgb;
			o.Alpha = temp_output_43_0;
			clip( temp_output_43_0 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;4086.425;-1.128595;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;79;-4056.195,-615.7657;Float;False;Property;_Noise_VPanner;Noise_VPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-4056.195,-778.5323;Float;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-4148.902,-161.7124;Float;False;Property;_Flow_Time_1;Flow_Time_1;12;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-4122.099,273.8402;Float;False;Property;_Flow_Time_2;Flow_Time_2;14;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;80;-3839.888,-719.4711;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-4030.781,-993.3604;Float;False;0;75;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;100;-3953.156,118.153;Float;False;Constant;_Vector0;Vector 0;17;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;96;-3952.758,-157.3997;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;77;-3734.759,-986.444;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-3981.736,-38.98149;Float;False;0;102;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;86;-4008.538,-474.534;Float;False;0;85;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;99;-3925.957,278.1529;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;94;-3979.958,-317.3995;Float;False;Constant;_Flow_Position;Flow_Position;17;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;101;-3676.356,116.553;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;75;-3508.826,-995.5631;Float;True;Property;_Nomal_Texture;Nomal_Texture;8;0;Create;True;0;0;False;0;None;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;93;-3703.158,-318.9995;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;73;-3329.457,426.1649;Float;False;2210.47;760.9342;Tint_Dissolve;15;47;48;51;49;46;43;42;14;41;13;20;19;16;112;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;82;-3149.394,-983.9747;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-3108.982,-585.2997;Float;False;Property;_Noise_Ins;Noise_Ins;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;85;-3423.475,-347.6139;Float;True;Property;_Flow_Texture_1;Flow_Texture_1;11;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;72;-3131.386,1311.286;Float;False;2058.847;981.9049;Mask;17;55;52;62;54;53;61;56;63;68;69;58;64;60;59;65;66;67;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;102;-3448.677,106.6068;Float;True;Property;_Flow_Texture_2;Flow_Texture_2;13;0;Create;True;0;0;False;0;None;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-3031.391,1901.203;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;109;-3121.352,139.5394;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;74;-2873.088,-820.9295;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-2859.994,-606.8497;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-3139.608,-111.6199;Float;True;Property;_Flow_Pow;Flow_Pow;15;0;Create;True;0;0;False;0;1.03;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-3282.681,745.2061;Float;False;Property;_Dissolve_Val;Dissolve_Val;5;0;Create;True;0;0;False;0;0;0.45;-1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-3269.048,890.8718;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-3081.386,1707.21;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;108;-3136,-352;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;53;-2719.711,1798.921;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-2736.874,2039.191;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;62;-2688.822,1361.286;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3263.307,1078.025;Float;False;Property;_Step_Size_Int;Step_Size_Int;6;0;Create;True;0;0;False;0;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-2731.563,1573.651;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-2914.752,-106.5352;Float;True;Property;_Flow_Ins;Flow_Ins;16;0;Create;True;0;0;False;0;0;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-2938.185,786.3536;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;107;-2944,-336;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-2669.374,-580.9092;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;110;-2904.988,136.7983;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-2606.227,107.1432;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-2599.16,-490.2061;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;40526e53665b54f4ab08530fa57888a3;881d985a758544b40991e70cf9130a76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2682.722,925.49;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-2641.491,-260.7046;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-2444.961,1436.463;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2463.001,1891.552;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-3279.457,506.0216;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-2932.033,476.1649;Float;True;Property;_Tint_Dissolve_Texture;Tint_Dissolve_Texture;2;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;d010bcc6d54f28a41aa8be3558cfd9f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-2335.036,-169.1417;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;69;-2230.456,1890.808;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;68;-2237.336,1441.816;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;112;-2416.497,927.5656;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;42;-2172.164,514.5547;Float;True;Step Antialiasing;-1;;19;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-2031.821,1912.208;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2070.98,1728.557;Float;False;Property;_Mask_Pow;Mask_Pow;7;0;Create;True;0;0;False;0;1.6;2.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2072.271,1438.196;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-1940.529,-266.6626;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1916.673,964.588;Float;False;Property;_Dissolve_Int;Dissolve_Int;4;0;Create;True;0;0;False;0;0;0.29;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2;-1729.031,256.6515;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;43;-2181.528,911.2767;Float;True;Step Antialiasing;-1;;20;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1566.703,0.381012;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;48;-1619.499,558.0449;Float;False;Property;_Dissolve_Color;Dissolve_Color;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;29.50885,19.62107,4.016911,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1848.756,512.969;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-1357.551,218.0791;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.148698,1.148698,1.148698,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;65;-1812.303,1447.651;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;59;-1813.273,1894.531;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;51;-1580.626,856.2661;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1121.515,11.87197;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1495.583,1673.453;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1340.052,460.8074;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;67;-1270.538,1682.656;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-789.1773,40.66563;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-457.676,75.77728;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-178.0107,63.11458;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Tint_Dissolve_MagicCycle_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;19;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;78;0
WireConnection;80;1;79;0
WireConnection;96;0;90;0
WireConnection;77;0;76;0
WireConnection;77;2;80;0
WireConnection;99;0;97;0
WireConnection;101;0;98;0
WireConnection;101;1;100;0
WireConnection;101;2;99;0
WireConnection;75;1;77;0
WireConnection;93;0;86;0
WireConnection;93;1;94;0
WireConnection;93;2;96;0
WireConnection;82;0;75;0
WireConnection;85;1;93;0
WireConnection;102;1;101;0
WireConnection;109;0;102;0
WireConnection;83;0;82;0
WireConnection;83;1;84;0
WireConnection;108;0;85;0
WireConnection;53;0;52;2
WireConnection;54;0;52;2
WireConnection;54;1;55;0
WireConnection;62;0;52;1
WireConnection;61;0;55;0
WireConnection;61;1;52;1
WireConnection;20;1;16;0
WireConnection;20;0;19;3
WireConnection;107;0;108;0
WireConnection;107;1;105;0
WireConnection;81;0;74;0
WireConnection;81;1;83;0
WireConnection;110;0;109;0
WireConnection;110;1;105;0
WireConnection;111;0;106;0
WireConnection;111;1;110;0
WireConnection;1;1;81;0
WireConnection;41;0;20;0
WireConnection;41;1;44;0
WireConnection;104;0;107;0
WireConnection;104;1;106;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;56;0;53;0
WireConnection;56;1;54;0
WireConnection;14;1;13;0
WireConnection;89;0;1;0
WireConnection;89;1;104;0
WireConnection;89;2;111;0
WireConnection;69;0;56;0
WireConnection;68;0;63;0
WireConnection;112;0;41;0
WireConnection;42;1;14;1
WireConnection;42;2;20;0
WireConnection;58;0;69;0
WireConnection;64;0;68;0
WireConnection;88;0;1;0
WireConnection;88;1;89;0
WireConnection;43;1;14;1
WireConnection;43;2;112;0
WireConnection;45;0;88;0
WireConnection;45;1;42;0
WireConnection;45;2;2;0
WireConnection;46;0;43;0
WireConnection;46;1;42;0
WireConnection;65;0;64;0
WireConnection;65;1;60;0
WireConnection;59;0;58;0
WireConnection;59;1;60;0
WireConnection;51;0;49;0
WireConnection;70;0;45;0
WireConnection;70;1;71;0
WireConnection;66;0;65;0
WireConnection;66;1;59;0
WireConnection;47;0;2;4
WireConnection;47;1;46;0
WireConnection;47;2;48;0
WireConnection;47;3;51;0
WireConnection;67;0;66;0
WireConnection;50;0;70;0
WireConnection;50;1;47;0
WireConnection;113;0;50;0
WireConnection;113;1;67;0
WireConnection;0;2;113;0
WireConnection;0;9;43;0
WireConnection;0;10;43;0
ASEEND*/
//CHKSM=C5DFC88806CEBA23B3CFABA3BB96AC23B399DCC8