// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Aphablend_Shokewave_Water"
{
	Properties
	{
		_Offset("Offset", Range( -1 , 1)) = -0.5647059
		_White_Range("White_Range", Float) = 0.19
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Float) = 0.15
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Color_Range("Color_Range", Range( -0.1 , 1.1)) = 0.4
		[HDR]_ColorA("ColorA", Color) = (0,0,0,0)
		[HDR]_ColorB("ColorB", Color) = (1,1,1,0)
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Vertex_Normal_Texture("Vertex_Normal_Texture", 2D) = "white" {}
		_Vertex_Normal_Range("Vertex_Normal_Range", Range( 1 , 20)) = 4.95
		_Vertex_Normal_Offset("Vertex_Normal_Offset", Range( -1 , 1)) = 0.01176472
		_Vertex_Normal_Str("Vertex_Normal_Str", Range( 1 , 10)) = 0
		_Disseolve_Texture("Disseolve_Texture", 2D) = "white" {}
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
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
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv2_tex4coord2;
			float2 uv_texcoord;
		};

		uniform sampler2D _Vertex_Normal_Texture;
		uniform float _Vertex_Normal_Offset;
		uniform float _Vertex_Normal_Range;
		uniform float _Vertex_Normal_Str;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform float _Color_Range;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _Offset;
		uniform float _White_Range;
		uniform sampler2D _Disseolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Disseolve_Texture_ST;
		uniform float _Dissolve;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch78 = v.texcoord1.z;
			#else
				float staticSwitch78 = _Vertex_Normal_Offset;
			#endif
			float2 appendResult45 = (float2(0.0 , staticSwitch78));
			v.vertex.xyz += ( ase_vertexNormal * ( ( pow( tex2Dlod( _Vertex_Normal_Texture, float4( (v.texcoord.xy*1.0 + appendResult45), 0, 0.0) ).r , _Vertex_Normal_Range ) * saturate( pow( v.texcoord.xy.y , 6.0 ) ) ) * _Vertex_Normal_Str ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			#ifdef _USE_CUSTOM_ON
				float staticSwitch80 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch80 = _Color_Range;
			#endif
			float2 appendResult36 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult22 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner18 = ( 1.0 * _Time.y * appendResult22 + uv0_Noise_Texture);
			float2 temp_output_12_0 = (UnpackNormal( tex2D( _Noise_Texture, panner18 ) )).xy;
			float2 panner33 = ( 1.0 * _Time.y * appendResult36 + ( uv0_Main_Texture + ( temp_output_12_0 * 0.05 ) ));
			float4 lerpResult27 = lerp( _ColorA , _ColorB , step( staticSwitch80 , tex2D( _Main_Texture, panner33 ).r ));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch76 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch76 = _Offset;
			#endif
			float temp_output_2_0 = ( ( ( temp_output_12_0 * _Noise_Str ) + i.uv_texcoord ).y + staticSwitch76 );
			float temp_output_4_0 = step( 0.0 , temp_output_2_0 );
			o.Emission = ( i.vertexColor * ( lerpResult27 + saturate( ( temp_output_4_0 - step( _White_Range , temp_output_2_0 ) ) ) ) ).rgb;
			float4 appendResult63 = (float4(_Diss_UPanner , _Diss_VPanner , 0.0 , 0.0));
			float2 uv0_Disseolve_Texture = i.uv_texcoord * _Disseolve_Texture_ST.xy + _Disseolve_Texture_ST.zw;
			float2 panner59 = ( 1.0 * _Time.y * appendResult63.xy + uv0_Disseolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch77 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch77 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * ( temp_output_4_0 * step( 0.1 , saturate( ( tex2D( _Disseolve_Texture, panner59 ).r + staticSwitch77 ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;2619.689;-980.612;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;23;-2778.42,236.6535;Float;False;2744.699;721.2002;Oitside;22;37;9;6;4;8;7;2;16;3;15;13;1;12;14;11;18;22;17;20;21;67;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2703.885,563.5362;Float;False;Property;_Noise_VPanner;Noise_VPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2704.885,483.5362;Float;False;Property;_Noise_UPanner;Noise_UPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-2728.42,287.6534;Float;False;0;11;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;22;-2521.885,503.5362;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;18;-2488.42,319.6534;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-2303.421,291.6534;Float;True;Property;_Noise_Texture;Noise_Texture;2;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;71;-2253.916,1036.994;Float;False;1559.345;494.6334;Dissolve_Tex;11;58;59;60;63;62;61;65;64;66;69;70;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;12;-2018.422,286.6534;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1970.422,476.6535;Float;False;Property;_Noise_Str;Noise_Str;3;0;Create;True;0;0;False;0;0.15;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;54;-2191.145,1633.109;Float;False;1939.639;720.7906;Vertex_Normal;17;43;44;41;45;42;40;38;39;51;53;46;52;47;49;48;50;78;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1849.422,558.6534;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;75;-553.9211,1005.257;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1774.407,286.3453;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-2195.916,1325.627;Float;False;Property;_Diss_UPanner;Diss_UPanner;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-2203.917,1390.627;Float;False;Property;_Diss_VPanner;Diss_VPanner;18;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2176.178,-85.51521;Float;False;Constant;_Float3;Float 3;16;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2165.618,2051.109;Float;False;Property;_Vertex_Normal_Offset;Vertex_Normal_Offset;14;0;Create;True;0;0;False;0;0.01176472;0.21;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-2143.856,-455.6002;Float;True;0;24;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-1886.196,-1.27047;Float;False;Property;_Main_UPanner;Main_UPanner;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1552.422,740.6533;Float;False;Property;_Offset;Offset;0;0;Create;True;0;0;False;0;-0.5647059;-0.6176399;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-2178.916,1149.627;Float;False;0;58;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2006.692,-97.14655;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;78;-2019.979,2173.922;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1952.618,1947.109;Float;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;63;-1993.916,1348.627;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1555.084,468.9616;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1881.196,79.72957;Float;False;Property;_Main_VPanner;Main_VPanner;11;0;Create;True;0;0;False;0;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-2141.145,1745.759;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;45;-1789.618,1970.109;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-1796.936,-196.1717;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;59;-1913.916,1194.627;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-1702.196,17.72952;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;16;-1324.88,446.7595;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;76;-1410.389,832.0368;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1682.916,1367.627;Float;False;Property;_Dissolve;Dissolve;19;0;Create;True;0;0;False;0;0;0.35;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-1707.916,1175.627;Float;True;Property;_Disseolve_Texture;Disseolve_Texture;16;0;Create;True;0;0;False;0;None;c2f5e06ce5d539b418dc5ebfbfeeee94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1078.086,-313.9494;Float;False;Property;_Color_Range;Color_Range;7;0;Create;True;0;0;False;0;0.4;0.36;-0.1;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;42;-1749.619,1850.109;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;33;-1479.231,-189.2352;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1707.249,2187.469;Float;False;Constant;_Float2;Float 2;15;0;Create;True;0;0;False;0;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-993.42,521.6535;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1158.621,662.0536;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-993.42,330.6534;Float;False;Property;_White_Range;White_Range;1;0;Create;True;0;0;False;0;0.19;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;77;-1558.01,1443.304;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;4;-810.0211,677.054;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-1127.463,-200.6482;Float;True;Property;_Main_Texture;Main_Texture;6;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;6;-854.121,250.4534;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;80;-795.237,75.60886;Float;False;Property;_Use_Custom;Use_Custom;20;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1504.198,2030.273;Float;False;Property;_Vertex_Normal_Range;Vertex_Normal_Range;13;0;Create;True;0;0;False;0;4.95;20;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-1506.094,1817.929;Float;True;Property;_Vertex_Normal_Texture;Vertex_Normal_Texture;12;0;Create;True;0;0;False;0;None;d61ec99fe9b65c3418d84b417801c585;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;48;-1430.162,2099.899;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-1382.916,1196.627;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;25;-829.0854,-208.9494;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;-678.0856,-556.9493;Float;False;Property;_ColorA;ColorA;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.0235849,0.5094917,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-1137.571,1086.994;Float;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-551.4212,292.0531;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;-1193.592,2098.592;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;66;-1185.416,1192.827;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;-685.0856,-365.9494;Float;False;Property;_ColorB;ColorB;9;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;39;-1194.734,1845.812;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-961.7885,2091.305;Float;False;Property;_Vertex_Normal_Str;Vertex_Normal_Str;15;0;Create;True;0;0;False;0;0;9.52;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;27;-390.4852,-251.9494;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-943.4175,1833.586;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;37;-255.4007,316.187;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;69;-929.5712,1096.094;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-78.08514,-184.9494;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-663.7883,1926.305;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-346.9718,670.2936;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;72;-40.60573,-352.0592;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;46;-1145.62,1683.109;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-486.5053,1720.407;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;171.8676,-333.5358;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;182.5775,23.45626;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;513.9656,-224.3298;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Aphablend_Shokewave_Water;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;18;0;17;0
WireConnection;18;2;22;0
WireConnection;11;1;18;0
WireConnection;12;0;11;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;56;0;12;0
WireConnection;56;1;57;0
WireConnection;78;1;44;0
WireConnection;78;0;75;3
WireConnection;63;0;61;0
WireConnection;63;1;62;0
WireConnection;15;0;13;0
WireConnection;15;1;1;0
WireConnection;45;0;43;0
WireConnection;45;1;78;0
WireConnection;55;0;32;0
WireConnection;55;1;56;0
WireConnection;59;0;60;0
WireConnection;59;2;63;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;16;0;15;0
WireConnection;76;1;3;0
WireConnection;76;0;75;1
WireConnection;58;1;59;0
WireConnection;42;0;41;0
WireConnection;42;2;45;0
WireConnection;33;0;55;0
WireConnection;33;2;36;0
WireConnection;2;0;16;1
WireConnection;2;1;76;0
WireConnection;77;1;65;0
WireConnection;77;0;75;2
WireConnection;4;0;7;0
WireConnection;4;1;2;0
WireConnection;24;1;33;0
WireConnection;6;0;8;0
WireConnection;6;1;2;0
WireConnection;80;1;26;0
WireConnection;80;0;75;4
WireConnection;38;1;42;0
WireConnection;48;0;41;2
WireConnection;48;1;49;0
WireConnection;64;0;58;1
WireConnection;64;1;77;0
WireConnection;25;0;80;0
WireConnection;25;1;24;1
WireConnection;9;0;4;0
WireConnection;9;1;6;0
WireConnection;50;0;48;0
WireConnection;66;0;64;0
WireConnection;39;0;38;1
WireConnection;39;1;40;0
WireConnection;27;0;29;0
WireConnection;27;1;30;0
WireConnection;27;2;25;0
WireConnection;51;0;39;0
WireConnection;51;1;50;0
WireConnection;37;0;9;0
WireConnection;69;0;70;0
WireConnection;69;1;66;0
WireConnection;31;0;27;0
WireConnection;31;1;37;0
WireConnection;52;0;51;0
WireConnection;52;1;53;0
WireConnection;67;0;4;0
WireConnection;67;1;69;0
WireConnection;47;0;46;0
WireConnection;47;1;52;0
WireConnection;73;0;72;0
WireConnection;73;1;31;0
WireConnection;74;0;72;4
WireConnection;74;1;67;0
WireConnection;0;2;73;0
WireConnection;0;9;74;0
WireConnection;0;11;47;0
ASEEND*/
//CHKSM=B18B25E0BA49982B7916A642D73A22D9B10D2A30