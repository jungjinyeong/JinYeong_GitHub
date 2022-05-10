// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Portal01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Tex_Panner("Main_Tex_Panner", Float) = 0
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 2
		_Main_Ins("Main_Ins", Range( 0 , 10)) = 4
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 4
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 0.5)) = 0
		_Noise_Tex_Panner("Noise_Tex_Panner", Float) = 0
		_Sub_Tex_Panner("Sub_Tex_Panner", Float) = 0
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_Sub_Tex_Ins("Sub_Tex_Ins", Range( 0 , 20)) = 4
		_Sub_Tex_Pow("Sub_Tex_Pow", Range( 1 , 10)) = 4
		_Desaturate("Desaturate", Range( 0 , 1)) = 0.64
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Front
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Sub_Texture;
		uniform float _Sub_Tex_Panner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Desaturate;
		uniform float _Sub_Tex_Pow;
		uniform float _Sub_Tex_Ins;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_Tex_Panner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_Tex_Panner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texture_ST;
		uniform float _Mask_Pow;
		uniform float _Main_Pow;
		uniform float _Main_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult39 = (float2(0.0 , _Sub_Tex_Panner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner40 = ( 1.0 * _Time.y * appendResult39 + uv0_Sub_Texture);
			float3 desaturateInitialColor49 = tex2D( _Sub_Texture, panner40 ).rgb;
			float desaturateDot49 = dot( desaturateInitialColor49, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar49 = lerp( desaturateInitialColor49, desaturateDot49.xxx, _Desaturate );
			float3 temp_cast_1 = (_Sub_Tex_Pow).xxx;
			float2 appendResult11 = (float2(0.0 , _Main_Tex_Panner));
			float2 appendResult32 = (float2(0.0 , _Noise_Tex_Panner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner29 = ( 1.0 * _Time.y * appendResult32 + uv0_Noise_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * appendResult11 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner29 ) )).xy * _Noise_Val ) + uv0_Main_Texture )*float2( 1,1 ) + 0.0));
			float temp_output_18_0 = saturate( pow( ( 1.0 - i.uv_texcoord.y ) , _Mask_Pow ) );
			float4 temp_output_33_0 = ( _Main_Color * ( pow( ( ( tex2D( _Main_Texture, panner8 ).r + temp_output_18_0 ) * temp_output_18_0 ) , _Main_Pow ) * _Main_Ins ) );
			o.Emission = ( ( float4( ( pow( desaturateVar49 , temp_cast_1 ) * _Sub_Tex_Ins ) , 0.0 ) + temp_output_33_0 ) * temp_output_33_0 ).rgb;
			o.Alpha = saturate( 1.0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;-563.4672;677.3113;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;31;-2269.579,-94.22778;Float;False;Property;_Noise_Tex_Panner;Noise_Tex_Panner;7;0;Create;True;0;0;False;0;0;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2251.579,-189.2278;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-2109.579,-190.2278;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2331.579,-404.2278;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;29;-2048.579,-370.2278;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;23;-1868.579,-425.2278;Float;True;Property;_Noise_Texture;Noise_Texture;5;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-1593.579,-229.2278;Float;False;Property;_Noise_Val;Noise_Val;6;0;Create;True;0;0;False;0;0;0.063;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;24;-1569.579,-462.2278;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1326.579,-455.2278;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1538,-0.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-1162.579,-267.2278;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1062.579,310.7722;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1057.579,73.77222;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;9;-1307,-0.5;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;13;-1126.579,193.7722;Float;False;Property;_Main_Tex_Panner;Main_Tex_Panner;1;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;7;-1029.8,-186.3;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;20;-906.579,319.7722;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-853.579,145.7722;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-860.579,593.7722;Float;False;Property;_Mask_Pow;Mask_Pow;4;0;Create;True;0;0;False;0;4;1.73;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1142.767,-546.8153;Float;False;Property;_Sub_Tex_Panner;Sub_Tex_Panner;8;0;Create;True;0;0;False;0;0;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1079.767,-637.8154;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-673.579,358.7722;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;8;-791.3001,-157;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;18;-328.1765,273.6661;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-530.6677,-181.7039;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;710f0ecf3a70db046b1d6dc37fef65ac;710f0ecf3a70db046b1d6dc37fef65ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-1159.767,-852.8153;Float;False;0;35;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;39;-937.7673,-638.8154;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;40;-876.7673,-818.8153;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-134.4734,6.483488;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-712.5356,-952.1368;Float;True;Property;_Sub_Texture;Sub_Texture;10;0;Create;True;0;0;False;0;dd20e223d5d16ed459475ca491481cab;dd20e223d5d16ed459475ca491481cab;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-608.6512,-729.6797;Float;False;Property;_Desaturate;Desaturate;13;0;Create;True;0;0;False;0;0.64;0.7223529;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-196.3374,557.6603;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;2;1.28;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;203.2236,242.2753;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;393.6262,221.0452;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;49;-404.2657,-956.1595;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-648.1149,-441.7911;Float;False;Property;_Sub_Tex_Pow;Sub_Tex_Pow;12;0;Create;True;0;0;False;0;4;7.21;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;278.9686,480.0279;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;4;1.37;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;41;-237.1149,-677.7911;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;34;535.8524,-50.00108;Float;False;Property;_Main_Color;Main_Color;9;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.122875,0.7451339,1.055606,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;676.5862,241.8392;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-354.1149,-426.7911;Float;False;Property;_Sub_Tex_Ins;Sub_Tex_Ins;11;0;Create;True;0;0;False;0;4;2.99;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;960.7489,128.145;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-4.11487,-677.7911;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;52;1342.467,28.68866;Float;False;Constant;_Float3;Float 3;14;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;956.4804,-427.9647;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1324.851,-387.9986;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;51;1529.467,-35.31134;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1883.913,-379.9257;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Portal01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;29;0;28;0
WireConnection;29;2;32;0
WireConnection;23;1;29;0
WireConnection;24;0;23;0
WireConnection;26;0;24;0
WireConnection;26;1;27;0
WireConnection;22;0;26;0
WireConnection;22;1;6;0
WireConnection;7;0;22;0
WireConnection;7;1;9;0
WireConnection;20;0;14;2
WireConnection;11;0;12;0
WireConnection;11;1;13;0
WireConnection;16;0;20;0
WireConnection;16;1;17;0
WireConnection;8;0;7;0
WireConnection;8;2;11;0
WireConnection;18;0;16;0
WireConnection;1;1;8;0
WireConnection;39;0;36;0
WireConnection;39;1;37;0
WireConnection;40;0;38;0
WireConnection;40;2;39;0
WireConnection;21;0;1;1
WireConnection;21;1;18;0
WireConnection;35;1;40;0
WireConnection;19;0;21;0
WireConnection;19;1;18;0
WireConnection;2;0;19;0
WireConnection;2;1;3;0
WireConnection;49;0;35;0
WireConnection;49;1;50;0
WireConnection;41;0;49;0
WireConnection;41;1;42;0
WireConnection;4;0;2;0
WireConnection;4;1;5;0
WireConnection;33;0;34;0
WireConnection;33;1;4;0
WireConnection;43;0;41;0
WireConnection;43;1;44;0
WireConnection;47;0;43;0
WireConnection;47;1;33;0
WireConnection;48;0;47;0
WireConnection;48;1;33;0
WireConnection;51;0;52;0
WireConnection;0;2;48;0
WireConnection;0;9;51;0
ASEEND*/
//CHKSM=6B820E965A804FED6CE49D0699657AD6D6523D9B