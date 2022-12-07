// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Shokewave_Pola"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Src("Src", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst("Dst", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_UTiling("Main_UTiling", Float) = 1
		_Main_VTiling("Main_VTiling", Float) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Hole_Radius("Hole_Radius", Range( 1 , 10)) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 1
		_Diss_Texture("Diss_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_DissTex_UTiling("DissTex_UTiling", Float) = 1
		_DissTex_VTiling("DissTex_VTiling", Float) = 1
		_DissTex_UPanner("DissTex_UPanner", Float) = 0
		_DissTex_VPanner("DissTex_VPanner", Float) = 0
		[Toggle(_USE_MASKTEX_ON)] _Use_MaskTex("Use_MaskTex", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_Src] [_Dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_MASKTEX_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _Src;
		uniform float _CullMode;
		uniform float _Dst;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		sampler2D _Sampler606;
		uniform float _Main_UTiling;
		uniform float _Main_VTiling;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float _Hole_Radius;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Pow;
		uniform sampler2D _Diss_Texture;
		sampler2D _Sampler6050;
		uniform float _DissTex_UTiling;
		uniform float _DissTex_VTiling;
		uniform float _DissTex_UPanner;
		uniform float _DissTex_VPanner;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_output_1_0_g4 = float2( 1,1 );
			float2 appendResult10_g4 = (float2(( (temp_output_1_0_g4).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g4).y )));
			float2 temp_output_11_0_g4 = float2( 0,0 );
			float2 panner18_g4 = ( ( (temp_output_11_0_g4).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g4 = ( ( _Time.y * (temp_output_11_0_g4).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g4 = (float2((panner18_g4).x , (panner19_g4).y));
			float2 appendResult13 = (float2(_Main_UTiling , _Main_VTiling));
			float2 appendResult10 = (float2(_Main_UPanner , _Main_VPanner));
			float2 temp_output_47_0_g4 = appendResult10;
			float2 uv_TexCoord78_g4 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g4 = ( uv_TexCoord78_g4 - float2( 1,1 ) );
			float2 appendResult39_g4 = (float2(frac( ( atan2( (temp_output_31_0_g4).x , (temp_output_31_0_g4).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g4 )));
			float2 panner54_g4 = ( ( (temp_output_47_0_g4).x * _Time.y ) * float2( 1,0 ) + appendResult39_g4);
			float2 panner55_g4 = ( ( _Time.y * (temp_output_47_0_g4).y ) * float2( 0,1 ) + appendResult39_g4);
			float2 appendResult58_g4 = (float2((panner54_g4).x , (panner55_g4).y));
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_18_0 = ( ( i.uv_texcoord - temp_cast_0 ) * 2.0 );
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_20_0 = ( temp_output_18_0 * temp_output_18_0 );
			float2 temp_cast_2 = (0.5).xx;
			float2 temp_cast_3 = (0.5).xx;
			float temp_output_23_0 = ( (temp_output_20_0).x + (temp_output_20_0).y );
			#ifdef _USE_MASKTEX_ON
				float staticSwitch38 = 1.0;
			#else
				float staticSwitch38 = pow( temp_output_23_0 , _Hole_Radius );
			#endif
			o.Emission = ( i.vertexColor * ( _Main_Color * ( tex2D( _Main_Texture, ( ( (tex2D( _Sampler606, ( appendResult10_g4 + appendResult24_g4 ) )).rg * 1.0 ) + ( appendResult13 * appendResult58_g4 ) ) ) * staticSwitch38 ) ) ).rgb;
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			#ifdef _USE_MASKTEX_ON
				float staticSwitch35 = pow( tex2D( _Mask_Texture, uv_Mask_Texture ).r , _Mask_Pow );
			#else
				float staticSwitch35 = step( temp_output_23_0 , 0.5 );
			#endif
			float2 temp_output_1_0_g3 = float2( 1,1 );
			float2 appendResult10_g3 = (float2(( (temp_output_1_0_g3).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g3).y )));
			float2 temp_output_11_0_g3 = float2( 0,0 );
			float2 panner18_g3 = ( ( (temp_output_11_0_g3).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g3 = ( ( _Time.y * (temp_output_11_0_g3).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g3 = (float2((panner18_g3).x , (panner19_g3).y));
			float2 appendResult49 = (float2(_DissTex_UTiling , _DissTex_VTiling));
			float2 appendResult48 = (float2(_DissTex_UPanner , _DissTex_VPanner));
			float2 temp_output_47_0_g3 = appendResult48;
			float2 uv_TexCoord78_g3 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g3 = ( uv_TexCoord78_g3 - float2( 1,1 ) );
			float2 appendResult39_g3 = (float2(frac( ( atan2( (temp_output_31_0_g3).x , (temp_output_31_0_g3).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g3 )));
			float2 panner54_g3 = ( ( (temp_output_47_0_g3).x * _Time.y ) * float2( 1,0 ) + appendResult39_g3);
			float2 panner55_g3 = ( ( _Time.y * (temp_output_47_0_g3).y ) * float2( 0,1 ) + appendResult39_g3);
			float2 appendResult58_g3 = (float2((panner54_g3).x , (panner55_g3).y));
			o.Alpha = ( i.vertexColor.a * ( staticSwitch35 * saturate( ( tex2D( _Diss_Texture, ( ( (tex2D( _Sampler6050, ( appendResult10_g3 + appendResult24_g3 ) )).rg * 1.0 ) + ( appendResult49 * appendResult58_g3 ) ) ).r + _Dissolve ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;0;1920;1019;5998.421;617.3863;3.422773;True;False
Node;AmplifyShaderEditor.CommentaryNode;54;-3305.531,508.8594;Inherit;False;2138.045;782.0521;Mask;16;15;17;16;19;18;29;23;28;20;22;21;26;25;24;39;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-3243.531,1118.412;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-3255.531,859.4109;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-2987.531,1162.412;Inherit;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;16;-3012.531,915.4109;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;52;-1648.66,1350.2;Inherit;False;1619.379;429.941;Dissolve;11;40;42;41;43;50;48;49;47;45;46;51;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-2798.531,917.4109;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;55;-2502.382,-267.3317;Inherit;False;1743.825;731.5791;Main;12;12;8;10;9;11;13;6;7;5;27;31;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1579.319,1400.2;Inherit;False;Property;_DissTex_UTiling;DissTex_UTiling;15;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1577.313,1473.206;Inherit;False;Property;_DissTex_VTiling;DissTex_VTiling;16;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1598.66,1664.141;Inherit;False;Property;_DissTex_VPanner;DissTex_VPanner;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-2589.531,913.4109;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1593.57,1580.45;Inherit;False;Property;_DissTex_UPanner;DissTex_UPanner;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-2412.929,133.171;Inherit;False;Property;_Main_VTiling;Main_VTiling;7;0;Create;True;0;0;0;False;0;False;1;0.22;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;49;-1384.313,1420.206;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;48;-1355.313,1614.538;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2413.929,61.17103;Inherit;False;Property;_Main_UTiling;Main_UTiling;6;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2452.382,348.2474;Inherit;False;Property;_Main_VPanner;Main_VPanner;9;0;Create;True;0;0;0;False;0;False;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;22;-2349.531,1021.411;Inherit;True;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;21;-2349.531,831.4109;Inherit;True;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2384.929,255.5043;Inherit;False;Property;_Main_UPanner;Main_UPanner;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-2190.929,274.5043;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;50;-1190.307,1404.101;Inherit;False;RadialUVDistortion;-1;;3;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6050;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;53;-2574.096,1413.963;Inherit;False;658.2743;386.4822;MaskTex;3;37;36;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-2090.331,638.7425;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-2219.929,80.171;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2118.899,859.4172;Inherit;False;Property;_Hole_Radius;Hole_Radius;10;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1681.322,786.4506;Inherit;False;Constant;_Float5;Float 5;15;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-734.1172,1401.638;Inherit;True;Property;_Diss_Texture;Diss_Texture;13;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;6;-2026.93,-32.49571;Inherit;False;RadialUVDistortion;-1;;4;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler606;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1982.333,1174.912;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-2524.096,1463.963;Inherit;True;Property;_Mask_Texture;Mask_Texture;11;0;Create;True;0;0;0;False;0;False;-1;8813ac6b4a65824479c76a296ad80607;8813ac6b4a65824479c76a296ad80607;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;28;-1702.222,558.8594;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-728.2797,1613.51;Inherit;False;Property;_Dissolve;Dissolve;14;0;Create;True;0;0;0;False;0;False;0;-0.1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2507.322,1684.445;Inherit;False;Property;_Mask_Pow;Mask_Pow;12;0;Create;True;0;0;0;False;0;False;1;3.8;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1586.975,-44.01493;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;36;-2175.822,1485.545;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-420.2805,1417.51;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;25;-1650.612,934.7917;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;38;-1430.486,587.4504;Inherit;True;Property;_Use_MaskTex;Use_MaskTex;19;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;43;-227.2803,1414.51;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;35;-714.5067,517.8839;Inherit;False;Property;_Use_MaskTex;Use_MaskTex;12;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1234.64,-27.83653;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;31;-1314.311,-217.3316;Inherit;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;5.59088,2.839348,4.888361,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1;196,-15.74997;Inherit;False;241;282;Enum;3;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-920.5571,-79.33167;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;32;-649.3092,89.7943;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-489.3168,487.1041;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;232,165.25;Inherit;False;Property;_Dst;Dst;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-375.1465,-89.20193;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;24;-1914.396,902.4109;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;231,91.25;Inherit;False;Property;_Src;Src;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-251.4474,397.3341;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;7;-1850.688,-196.4501;Inherit;False;Polar Coordinates;-1;;5;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;225,17.25;Inherit;False;Property;_CullMode;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-34,-22;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX/Shokewave_Pola;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;2;10;True;3;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;4;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;18;0;16;0
WireConnection;18;1;19;0
WireConnection;20;0;18;0
WireConnection;20;1;18;0
WireConnection;49;0;47;0
WireConnection;49;1;45;0
WireConnection;48;0;46;0
WireConnection;48;1;51;0
WireConnection;22;0;20;0
WireConnection;21;0;20;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;50;68;49;0
WireConnection;50;47;48;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;40;1;50;0
WireConnection;6;68;13;0
WireConnection;6;47;10;0
WireConnection;28;0;23;0
WireConnection;28;1;29;0
WireConnection;5;1;6;0
WireConnection;36;0;14;1
WireConnection;36;1;37;0
WireConnection;41;0;40;1
WireConnection;41;1;42;0
WireConnection;25;0;23;0
WireConnection;25;1;26;0
WireConnection;38;1;28;0
WireConnection;38;0;39;0
WireConnection;43;0;41;0
WireConnection;35;1;25;0
WireConnection;35;0;36;0
WireConnection;27;0;5;0
WireConnection;27;1;38;0
WireConnection;30;0;31;0
WireConnection;30;1;27;0
WireConnection;44;0;35;0
WireConnection;44;1;43;0
WireConnection;33;0;32;0
WireConnection;33;1;30;0
WireConnection;24;0;23;0
WireConnection;34;0;32;4
WireConnection;34;1;44;0
WireConnection;0;2;33;0
WireConnection;0;9;34;0
ASEEND*/
//CHKSM=00D32BC48DCABBE8A66FD586AE886F2238800FC7