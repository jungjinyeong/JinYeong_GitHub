// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Monster_M"
{
	Properties
	{
		_Noise("Noise", 2D) = "white" {}
		_Dissolve_int("Dissolve_int", Range( 0 , 1)) = 1
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_step_int("step_int", Float) = 0.05
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Color0("Color 0", Color) = (1,1,1,1)
		_glow("glow", Range( 0 , 10)) = 3
		_Fresnel_Power("Fresnel_Power", Range( 0 , 10)) = 1
		_Fresnel_glow("Fresnel_glow", Range( 0 , 10)) = 1
		_Fresnel_Color("Fresnel_Color ", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Fresnel_Power;
		uniform float4 _Fresnel_Color;
		uniform float _Fresnel_glow;
		uniform sampler2D _Main_Tex;
		uniform float4 _Main_Tex_ST;
		uniform float _Dissolve_int;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform float _step_int;
		uniform float4 _Color0;
		uniform float _glow;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV51 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode51 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV51, (0.0 + (_Fresnel_Power - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) ) );
			float2 uv_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float4 tex2DNode8 = tex2D( _Main_Tex, uv_Main_Tex );
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float4 tex2DNode1 = tex2D( _Noise, uv_Noise );
			float temp_output_3_0_g11 = ( _Dissolve_int - tex2DNode1.r );
			float temp_output_29_0 = saturate( ( temp_output_3_0_g11 / fwidth( temp_output_3_0_g11 ) ) );
			float temp_output_3_0_g10 = ( ( _Dissolve_int + _step_int ) - tex2DNode1.r );
			float temp_output_30_0 = saturate( ( temp_output_3_0_g10 / fwidth( temp_output_3_0_g10 ) ) );
			o.Emission = ( ( ( ( saturate( fresnelNode51 ) * _Fresnel_Color * _Fresnel_glow * 3.0 ) + tex2DNode8 ) * temp_output_29_0 * i.vertexColor ) + ( ( temp_output_30_0 - temp_output_29_0 ) * _Color0 * tex2DNode8.r * _glow * i.vertexColor.a ) ).rgb;
			o.Alpha = temp_output_30_0;
			clip( temp_output_30_0 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
527;105;1341;901;2143.148;972.0959;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;57;-2185.58,-632.2294;Inherit;False;Property;_Fresnel_Power;Fresnel_Power;7;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;56;-1845.08,-632.9293;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1523.068,421.5249;Inherit;False;Property;_step_int;step_int;3;0;Create;True;0;0;False;0;0.05;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;51;-1567.661,-728.5192;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1537.528,207.5366;Inherit;False;Property;_Dissolve_int;Dissolve_int;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1278.433,320.5734;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1597.393,-324.7761;Inherit;False;Property;_Fresnel_glow;Fresnel_glow;8;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1472.347,-224.596;Inherit;False;Constant;_Plus_glow;Plus_glow;10;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1560.313,-32.18467;Inherit;True;Property;_Noise;Noise;0;0;Create;True;0;0;False;0;-1;None;14555296d5c25524fa9b2a283f32c683;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;43;-1524.476,-502.316;Inherit;False;Property;_Fresnel_Color;Fresnel_Color ;9;0;Create;True;0;0;False;0;0,0,0,0;1,0.7058824,0.3915094,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;60;-1308.495,-836.1924;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;30;-1123.922,297.0813;Inherit;True;Step Antialiasing;-1;;10;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;29;-1128.002,-8.964947;Inherit;True;Step Antialiasing;-1;;11;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1187.316,-727.3093;Inherit;True;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-1202.482,-313.3377;Inherit;True;Property;_Main_Tex;Main_Tex;2;0;Create;True;0;0;False;0;-1;None;4405f351d5ccd4742816ab976f164eac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-848.9774,362.3564;Inherit;False;Property;_Color0;Color 0;5;0;Create;True;0;0;False;0;1,1,1,1;0.3726415,0.5588253,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-881.2557,-542.882;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-911.1237,564.1697;Inherit;False;Property;_glow;glow;6;0;Create;True;0;0;False;0;3;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-840.5552,131.5148;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;13;-831.3575,-92.62651;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-535.6667,234.2643;Inherit;True;5;5;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-648.7185,-297.3993;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-335.7209,-181.1876;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;139.2035,-215.7226;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Monster_M;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;4;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;57;0
WireConnection;51;3;56;0
WireConnection;6;0;3;0
WireConnection;6;1;5;0
WireConnection;60;0;51;0
WireConnection;30;1;1;1
WireConnection;30;2;6;0
WireConnection;29;1;1;1
WireConnection;29;2;3;0
WireConnection;40;0;60;0
WireConnection;40;1;43;0
WireConnection;40;2;42;0
WireConnection;40;3;61;0
WireConnection;54;0;40;0
WireConnection;54;1;8;0
WireConnection;7;0;30;0
WireConnection;7;1;29;0
WireConnection;21;0;7;0
WireConnection;21;1;16;0
WireConnection;21;2;8;1
WireConnection;21;3;28;0
WireConnection;21;4;13;4
WireConnection;12;0;54;0
WireConnection;12;1;29;0
WireConnection;12;2;13;0
WireConnection;27;0;12;0
WireConnection;27;1;21;0
WireConnection;0;2;27;0
WireConnection;0;9;30;0
WireConnection;0;10;30;0
ASEEND*/
//CHKSM=67F02AFF5032AF2B1009E28893FF7BD79C305BD2