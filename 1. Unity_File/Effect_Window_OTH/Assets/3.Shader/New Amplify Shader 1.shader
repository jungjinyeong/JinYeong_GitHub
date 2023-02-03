// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Addtive_Transition"
{
	Properties
	{
		_Dissolve_Main_Texture("Dissolve_Main_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 0)) = -0.6184701
		_Dissolve_Line("Dissolve_Line", Range( 0 , 0.1)) = 0.17
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Dissolve_Line_Color("Dissolve_Line_Color", Color) = (0.764151,0.2054557,0.2054557,0)
		_Dissolve_Line_Texture("Dissolve_Line_Texture", 2D) = "white" {}
		_Dissolve_UPanner("Dissolve_UPanner", Float) = 0
		_Dissolve_VPanner("Dissolve_VPanner", Float) = 0
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Dissolve_Pow("Dissolve_Pow", Float) = 1.57
		_Flow_Texture_1("Flow_Texture_1", 2D) = "white" {}
		_Flow_Texture_2("Flow_Texture_2", 2D) = "white" {}
		_Flow_Pow("Flow_Pow", Float) = 0
		_Diss_Ins_Val("Diss_Ins_Val", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		ZWrite Off
		Blend SrcAlpha One
		
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
			float4 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Flow_Texture_1;
		uniform float4 _Flow_Texture_1_ST;
		uniform float _Flow_Pow;
		uniform sampler2D _Flow_Texture_2;
		uniform float4 _Flow_Texture_2_ST;
		uniform float4 _Dissolve_Line_Color;
		uniform sampler2D _Dissolve_Main_Texture;
		uniform float4 _Dissolve_Main_Texture_ST;
		uniform float _Dissolve_Pow;
		uniform float _Diss_Ins_Val;
		uniform sampler2D _Dissolve_Line_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Line_Texture_ST;
		uniform float _Dissolve_Line;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 uvs_Main_Texture = i.uv_texcoord;
			uvs_Main_Texture.xy = i.uv_texcoord.xy * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float4 tex2DNode16 = tex2D( _Main_Texture, uvs_Main_Texture.xy );
			float4 uvs_Flow_Texture_1 = i.uv_texcoord;
			uvs_Flow_Texture_1.xy = i.uv_texcoord.xy * _Flow_Texture_1_ST.xy + _Flow_Texture_1_ST.zw;
			float2 temp_cast_0 = (0.5).xx;
			float cos44 = cos( _Time.y );
			float sin44 = sin( _Time.y );
			float2 rotator44 = mul( uvs_Flow_Texture_1.xy - temp_cast_0 , float2x2( cos44 , -sin44 , sin44 , cos44 )) + temp_cast_0;
			float4 temp_cast_1 = (_Flow_Pow).xxxx;
			float4 uvs_Flow_Texture_2 = i.uv_texcoord;
			uvs_Flow_Texture_2.xy = i.uv_texcoord.xy * _Flow_Texture_2_ST.xy + _Flow_Texture_2_ST.zw;
			float2 temp_cast_2 = (0.5).xx;
			float mulTime51 = _Time.y * -1.0;
			float cos46 = cos( mulTime51 );
			float sin46 = sin( mulTime51 );
			float2 rotator46 = mul( uvs_Flow_Texture_2.xy - temp_cast_2 , float2x2( cos46 , -sin46 , sin46 , cos46 )) + temp_cast_2;
			float4 temp_cast_3 = (_Flow_Pow).xxxx;
			float4 temp_output_62_0 = ( tex2DNode16 + ( tex2DNode16 * ( pow( saturate( tex2D( _Flow_Texture_1, rotator44 ) ) , temp_cast_1 ) * pow( saturate( tex2D( _Flow_Texture_2, rotator46 ) ) , temp_cast_3 ) ) ) );
			float4 uvs_Dissolve_Main_Texture = i.uv_texcoord;
			uvs_Dissolve_Main_Texture.xy = i.uv_texcoord.xy * _Dissolve_Main_Texture_ST.xy + _Dissolve_Main_Texture_ST.zw;
			float4 temp_cast_4 = (_Dissolve_Pow).xxxx;
			float2 appendResult28 = (float2(_Dissolve_UPanner , _Dissolve_VPanner));
			float4 uvs_Dissolve_Line_Texture = i.uv_texcoord;
			uvs_Dissolve_Line_Texture.xy = i.uv_texcoord.xy * _Dissolve_Line_Texture_ST.xy + _Dissolve_Line_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult28 + uvs_Dissolve_Line_Texture.xy);
			float4 temp_output_23_0 = ( ( pow( tex2D( _Dissolve_Main_Texture, uvs_Dissolve_Main_Texture.xy ) , temp_cast_4 ) * _Diss_Ins_Val ) * tex2D( _Dissolve_Line_Texture, panner25 ) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch34 = i.uv_texcoord.z;
			#else
				float staticSwitch34 = _Dissolve;
			#endif
			float4 temp_cast_5 = (staticSwitch34).xxxx;
			float4 temp_output_11_0 = saturate( floor( ( ( temp_output_23_0 + _Dissolve_Line ) - temp_cast_5 ) ) );
			float4 temp_cast_6 = (staticSwitch34).xxxx;
			o.Emission = ( ( ( _Main_Color * temp_output_62_0 ) * ( temp_output_62_0 + ( _Dissolve_Line_Color * ( temp_output_11_0 - saturate( floor( ( temp_output_23_0 - temp_cast_6 ) ) ) ) ) ) ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_11_0 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1006;688;3447.278;-131.491;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-3487.877,1067.173;Float;False;Property;_Dissolve_UPanner;Dissolve_UPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3495.232,1167.197;Float;False;Property;_Dissolve_VPanner;Dissolve_VPanner;8;0;Create;True;0;0;0;False;0;False;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-3391.709,795.2661;Inherit;False;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-3242.229,1074.527;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-3145.181,463.2529;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;25;-3077.483,795.0477;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2668.975,638.494;Float;False;Property;_Dissolve_Pow;Dissolve_Pow;12;0;Create;True;0;0;0;False;0;False;1.57;7.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2798.74,439.9478;Inherit;True;Property;_Dissolve_Main_Texture;Dissolve_Main_Texture;1;0;Create;True;0;0;0;False;0;False;-1;ada7d7b9960604d429f82277e242d1ef;2b088034f60d33a4ea929615e8faa704;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;40;-2496.97,445.9511;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2448.879,707.491;Inherit;False;Property;_Diss_Ins_Val;Diss_Ins_Val;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2959.082,-143.7721;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2964.38,-36.3168;Float;False;Constant;_Float2;Float 2;15;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-2836.937,766.3984;Inherit;True;Property;_Dissolve_Line_Texture;Dissolve_Line_Texture;6;0;Create;True;0;0;0;False;0;False;-1;None;d66bfe10b05fc6e46b051b9afca6d29b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-2766.849,-407.1129;Inherit;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-2741.881,74.15237;Inherit;False;0;47;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2200.879,449.891;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-2695.74,-228.5251;Float;False;Constant;_Float0;Float 0;14;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;50;-2733.578,-143.7721;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;39;-2051.155,811.8817;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;51;-2741.904,-24.2091;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;35;-2016.521,1095.859;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1657.664,638.3383;Float;False;Property;_Dissolve;Dissolve;2;0;Create;True;0;0;0;False;0;False;-0.6184701;-1;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;44;-2424.833,-407.1128;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1934.971,531.3988;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;46;-2408.184,-71.1257;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2198.677,881.2944;Float;False;Property;_Dissolve_Line;Dissolve_Line;3;0;Create;True;0;0;0;False;0;False;0.17;0.025;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-2090.581,-376.7039;Inherit;True;Property;_Flow_Texture_1;Flow_Texture_1;13;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;34;-1469.025,840.3928;Float;False;Property;_Use_Custom;Use_Custom;11;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1537.018,1145.379;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;47;-2096.412,-34.80276;Inherit;True;Property;_Flow_Texture_2;Flow_Texture_2;14;0;Create;True;0;0;0;False;0;False;-1;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1237.161,1154.167;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;55;-1660.276,-42.3303;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;54;-1620.449,-375.5656;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1593.422,-145.6181;Float;False;Property;_Flow_Pow;Flow_Pow;15;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-1234.238,576.5677;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;57;-1429.945,-375.8208;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;58;-1416.599,-28.84854;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;9;-960.0992,1154.161;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;8;-950.8432,575.3594;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1309.364,-639.678;Inherit;False;0;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1022.122,-178.5019;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-1004.837,-647.7173;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;b661ce021aa40ea40875646ad1cdf161;208bac7389793b6479de721b5a7902d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;11;-734.089,1140.483;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;10;-730.0152,575.5004;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-683.5596,-356.8474;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-526.1882,573.7729;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-650.9998,150.4097;Float;False;Property;_Dissolve_Line_Color;Dissolve_Line_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;0.764151,0.2054557,0.2054557,0;9.734288,1.630875,1.732805,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-455.9766,-524.0107;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;33;-272.8474,-610.2079;Float;False;Property;_Main_Color;Main_Color;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;2.058988,1.114285,0.4564737,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-215.4348,169.9897;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;5.014981,-100.3647;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;16.41553,-357.5634;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;273.2615,-335.3487;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;36;312.556,-94.76132;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;664.0145,-323.4879;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;637.6723,79.25378;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;29;1178.851,-338.085;Float;False;Property;_Cull_Mode;Cull_Mode;9;1;[Enum];Create;True;0;0;1;;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;949.9828,-358.0222;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Addtive_Transition;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;True;29;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;25;0;24;0
WireConnection;25;2;28;0
WireConnection;1;1;2;0
WireConnection;40;0;1;0
WireConnection;40;1;41;0
WireConnection;22;1;25;0
WireConnection;64;0;40;0
WireConnection;64;1;65;0
WireConnection;50;0;48;0
WireConnection;39;0;22;0
WireConnection;51;0;52;0
WireConnection;44;0;43;0
WireConnection;44;1;45;0
WireConnection;44;2;50;0
WireConnection;23;0;64;0
WireConnection;23;1;39;0
WireConnection;46;0;60;0
WireConnection;46;1;45;0
WireConnection;46;2;51;0
WireConnection;42;1;44;0
WireConnection;34;1;5;0
WireConnection;34;0;35;3
WireConnection;13;0;23;0
WireConnection;13;1;14;0
WireConnection;47;1;46;0
WireConnection;4;0;13;0
WireConnection;4;1;34;0
WireConnection;55;0;47;0
WireConnection;54;0;42;0
WireConnection;3;0;23;0
WireConnection;3;1;34;0
WireConnection;57;0;54;0
WireConnection;57;1;59;0
WireConnection;58;0;55;0
WireConnection;58;1;59;0
WireConnection;9;0;4;0
WireConnection;8;0;3;0
WireConnection;53;0;57;0
WireConnection;53;1;58;0
WireConnection;16;1;21;0
WireConnection;11;0;9;0
WireConnection;10;0;8;0
WireConnection;63;0;16;0
WireConnection;63;1;53;0
WireConnection;12;0;11;0
WireConnection;12;1;10;0
WireConnection;62;0;16;0
WireConnection;62;1;63;0
WireConnection;17;0;15;0
WireConnection;17;1;12;0
WireConnection;18;0;62;0
WireConnection;18;1;17;0
WireConnection;32;0;33;0
WireConnection;32;1;62;0
WireConnection;30;0;32;0
WireConnection;30;1;18;0
WireConnection;37;0;30;0
WireConnection;37;1;36;0
WireConnection;38;0;36;4
WireConnection;38;1;11;0
WireConnection;0;2;37;0
WireConnection;0;9;38;0
ASEEND*/
//CHKSM=04CF1ED8FF750D1D34A5165A4DAF0B7BDF033764