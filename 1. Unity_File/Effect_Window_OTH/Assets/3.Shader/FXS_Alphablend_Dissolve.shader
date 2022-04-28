// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Dissolve"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Power("Main_Power", Range( 1 , 10)) = 4
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0.1540282
		[Toggle(_USE_COSTOM_ON)] _Use_Costom("Use_Costom", Float) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 0.8767233
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Diss_UPanner("Diss_UPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_COSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissove_Texture_ST;
		uniform float _Dissolve;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float4 tex2DNode7 = tex2D( _Main_Texture, uv0_Main_Texture );
			float4 temp_cast_0 = (_Main_Power).xxxx;
			#ifdef _USE_COSTOM_ON
				float staticSwitch8 = i.uv_tex4coord.z;
			#else
				float staticSwitch8 = _Main_Ins;
			#endif
			float2 appendResult31 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner28 = ( 1.0 * _Time.y * appendResult31 + uv0_Dissove_Texture);
			#ifdef _USE_COSTOM_ON
				float staticSwitch9 = i.uv_tex4coord.w;
			#else
				float staticSwitch9 = _Dissolve;
			#endif
			float temp_output_16_0 = saturate( ( tex2D( _Dissove_Texture, panner28 ).r + staticSwitch9 ) );
			o.Emission = ( saturate( ( ( _Tint_Color * ( pow( tex2DNode7 , temp_cast_0 ) * staticSwitch8 ) ) * temp_output_16_0 ) ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( tex2DNode7.r * temp_output_16_0 ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;836.5539;381.6337;1.029405;True;False
Node;AmplifyShaderEditor.RangedFloatNode;30;-1740.371,829.5284;Float;False;Property;_Diss_VPanner;Diss_VPanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1728.67,677.4283;Float;False;Property;_Diss_UPanner;Diss_UPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-1538.87,750.2283;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1694.553,447.3131;Float;False;0;11;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;28;-1417.971,452.5283;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1602.105,-244.2572;Float;False;0;7;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-1132.724,648.3213;Float;False;Property;_Dissolve;Dissolve;5;0;Create;True;0;0;False;0;0.1540282;0.21;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;3;-1056.909,269.5997;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;9;-723.0721,509.908;Float;False;Property;_Use_Costom;Use_Costom;6;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-1165.617,444.4675;Float;True;Property;_Dissove_Texture;Dissove_Texture;4;0;Create;True;0;0;False;0;0c5c899619e886b41a798555299abd18;cb3db7b0a3d7e1e4cb96977896ea78b7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1130.471,153.725;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;5.72;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1167.41,-211.019;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;69eea4a9bab8d17439ec9db3891a8c40;019a46b174c20524da7e64a1f435f5c4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1150.963,3.981527;Float;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;False;0;4;1.43;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;8;-719.9908,203.1497;Float;False;Property;_Use_Costom;Use_Costom;6;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-428.1446,430.5736;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-744.4098,-214.019;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-446.1057,-463.1572;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;2.608238,2.608238,2.608238,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-466.0099,-215.1956;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;16;-153.1665,432.6242;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;176.7932,188.7405;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-171.6648,-216.9247;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;90.866,501.2958;Float;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;0.8767233;0.29;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;186.5775,-225.1352;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;459.3676,270.9519;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;18;471.9682,-20.58862;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;22;736.3477,270.2319;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;432.1986,-234.5329;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;711.7576,-175.2193;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;974.0981,158.0605;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1269.689,-238.637;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Dissolve;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;29;0
WireConnection;31;1;30;0
WireConnection;28;0;4;0
WireConnection;28;2;31;0
WireConnection;9;1;2;0
WireConnection;9;0;3;4
WireConnection;11;1;28;0
WireConnection;7;1;1;0
WireConnection;8;1;5;0
WireConnection;8;0;3;3
WireConnection;12;0;11;1
WireConnection;12;1;9;0
WireConnection;10;0;7;0
WireConnection;10;1;6;0
WireConnection;13;0;10;0
WireConnection;13;1;8;0
WireConnection;16;0;12;0
WireConnection;24;0;7;1
WireConnection;24;1;16;0
WireConnection;27;0;14;0
WireConnection;27;1;13;0
WireConnection;17;0;27;0
WireConnection;17;1;16;0
WireConnection;20;0;24;0
WireConnection;20;1;23;0
WireConnection;22;0;20;0
WireConnection;25;0;17;0
WireConnection;19;0;25;0
WireConnection;19;1;18;0
WireConnection;21;0;18;4
WireConnection;21;1;22;0
WireConnection;0;2;19;0
WireConnection;0;9;21;0
ASEEND*/
//CHKSM=3E10A07CE541923996900022D61117A7A9D8A616