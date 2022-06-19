// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Crack01"
{
	Properties
	{
		_FXT_Crack_Base("FXT_Crack_Base", 2D) = "white" {}
		_Mask_Pow("Mask_Pow", Range( 1 , 10)) = 0
		_Opacity("Opacity", Range( 0 , 5)) = 0
		_Base_Color("Base_Color", Color) = (0,0,0,0)
		_Brightness("Brightness", Range( 1 , 50)) = 0
		_FXT_Crack_Emi("FXT_Crack_Emi", 2D) = "white" {}
		[HDR]_Emi_Color("Emi_Color", Color) = (0,0,0,0)
		_Emi_Pow("Emi_Pow", Range( 1 , 20)) = 2
		_Glow_Range("Glow_Range", Float) = 5.12
		_Glow_Ins("Glow_Ins", Range( 0 , 2)) = 0.75
		_Emi_Noise("Emi_Noise", 2D) = "white" {}
		_Emi_Noise_UPanner("Emi_Noise_UPanner", Float) = 0
		_Emi_Noise_VPanner("Emi_Noise_VPanner", Float) = 0
		_FXT_Crack_Normal("FXT_Crack_Normal", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 5)) = 0
		_FXT_Crack_Height("FXT_Crack_Height", 2D) = "white" {}
		_Height_Scale("Height_Scale", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow nometa 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform float _Normal_Scale;
		uniform sampler2D _FXT_Crack_Normal;
		uniform sampler2D _FXT_Crack_Height;
		uniform float4 _FXT_Crack_Height_ST;
		uniform float _Height_Scale;
		uniform sampler2D _FXT_Crack_Base;
		uniform float4 _Base_Color;
		uniform float _Brightness;
		uniform sampler2D _FXT_Crack_Emi;
		uniform sampler2D _Emi_Noise;
		uniform sampler2D _Sampler6057;
		uniform float _Emi_Noise_UPanner;
		uniform float _Emi_Noise_VPanner;
		uniform float _Glow_Range;
		uniform float _Glow_Ins;
		uniform float _Emi_Pow;
		uniform float4 _Emi_Color;
		uniform float _Mask_Pow;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FXT_Crack_Height = i.uv_texcoord * _FXT_Crack_Height_ST.xy + _FXT_Crack_Height_ST.zw;
			float2 Offset34 = ( ( tex2D( _FXT_Crack_Height, uv_FXT_Crack_Height ).r - 1 ) * i.viewDir.xy * _Height_Scale ) + i.uv_texcoord;
			float2 ParallaxMapping55 = Offset34;
			o.Normal = UnpackScaleNormal( tex2D( _FXT_Crack_Normal, ParallaxMapping55 ), _Normal_Scale );
			float4 tex2DNode1 = tex2D( _FXT_Crack_Base, ParallaxMapping55 );
			o.Albedo = ( ( tex2DNode1 * _Base_Color ) * _Brightness ).rgb;
			float4 tex2DNode2 = tex2D( _FXT_Crack_Emi, ParallaxMapping55 );
			float2 temp_output_1_0_g1 = float2( 1,1 );
			float2 appendResult10_g1 = (float2(( (temp_output_1_0_g1).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g1).y )));
			float2 temp_output_11_0_g1 = float2( 0,0 );
			float2 panner18_g1 = ( ( (temp_output_11_0_g1).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g1 = ( ( _Time.y * (temp_output_11_0_g1).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g1 = (float2((panner18_g1).x , (panner19_g1).y));
			float2 appendResult59 = (float2(_Emi_Noise_UPanner , _Emi_Noise_VPanner));
			float2 temp_output_47_0_g1 = appendResult59;
			float2 temp_output_31_0_g1 = ( ( ParallaxMapping55 * 2.0 ) - float2( 1,1 ) );
			float2 appendResult39_g1 = (float2(frac( ( atan2( (temp_output_31_0_g1).x , (temp_output_31_0_g1).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g1 )));
			float2 panner54_g1 = ( ( (temp_output_47_0_g1).x * _Time.y ) * float2( 1,0 ) + appendResult39_g1);
			float2 panner55_g1 = ( ( _Time.y * (temp_output_47_0_g1).y ) * float2( 0,1 ) + appendResult39_g1);
			float2 appendResult58_g1 = (float2((panner54_g1).x , (panner55_g1).y));
			float2 temp_cast_1 = (0.5).xx;
			float temp_output_23_0 = length( ( ( ParallaxMapping55 - temp_cast_1 ) * 2.0 ) );
			o.Emission = ( ( pow( ( ( tex2DNode2.r * ( tex2DNode2.r + saturate( pow( tex2D( _Emi_Noise, ( ( (tex2D( _Sampler6057, ( appendResult10_g1 + appendResult24_g1 ) )).rg * 1.0 ) + ( float2( 1,1 ) * appendResult58_g1 ) ) ).r , 8.0 ) ) ) ) + ( pow( saturate( ( ( 1.0 - temp_output_23_0 ) - 0.18 ) ) , _Glow_Range ) * _Glow_Ins ) ) , _Emi_Pow ) * _Emi_Color ) * i.vertexColor ).rgb;
			o.Alpha = ( saturate( ( pow( saturate( ( 1.0 - temp_output_23_0 ) ) , _Mask_Pow ) * _Opacity ) ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;255;1920;980;3027.82;1144.024;3.104772;True;False
Node;AmplifyShaderEditor.CommentaryNode;39;-2835.084,-1210.393;Float;False;1383.513;582.8331;Parallax;6;55;34;37;35;36;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-2357.929,-1160.393;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;37;-2320.414,-894.065;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;3;-2694.084,-1099.298;Float;True;Property;_FXT_Crack_Height;FXT_Crack_Height;15;0;Create;True;0;0;False;0;None;bde8fbc25f37f954d8e511165edab3fc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-2372.015,-999.0839;Float;False;Property;_Height_Scale;Height_Scale;16;0;Create;True;0;0;False;0;0;0.12;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;34;-2040.696,-1089.787;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-1717.175,-1090.724;Float;False;ParallaxMapping;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;33;-652.3705,695.7061;Float;False;1853.944;698.7924;Comment;15;20;19;22;21;23;24;25;26;28;29;27;31;32;17;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-910.0797,744.319;Float;False;55;ParallaxMapping;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-560.3704,1005.707;Float;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;69;-1830.895,13.78209;Float;False;1664.24;544.1709;Emi_Noise;10;77;64;62;56;63;57;59;76;60;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-1763.302,278.6046;Float;False;Constant;_Float4;Float 4;18;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1586.716,323.5156;Float;False;Property;_Emi_Noise_UPanner;Emi_Noise_UPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-342.3699,1004.707;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-391.3698,748.7061;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1589.716,406.5155;Float;False;Property;_Emi_Noise_VPanner;Emi_Noise_VPanner;12;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-1370.716,362.5155;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-190.37,756.7064;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1571.243,86.73032;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;57;-1326.363,110.1273;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6057;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;52;89.16803,205.0146;Float;False;1125.785;463.1121;Comment;8;50;49;48;51;44;46;47;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LengthOpNode;23;20.63013,756.7064;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;45;252.0406,298.0756;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-740.5521,437.1647;Float;False;Constant;_Float6;Float 6;16;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;260.3645,434.6444;Float;False;Constant;_Float3;Float 3;13;0;Create;True;0;0;False;0;0.18;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;56;-902.8574,248.1927;Float;True;Property;_Emi_Noise;Emi_Noise;10;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;16;-134.6437,-323.784;Float;False;1355.071;506.5123;Emission;7;12;15;13;53;66;65;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;418.7495,324.3117;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;62;-612.6034,269.5303;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-134.53,-274.9771;Float;True;Property;_FXT_Crack_Emi;FXT_Crack_Emi;5;0;Create;True;0;0;False;0;ccd47012bab324f468dec368548f3049;ccd47012bab324f468dec368548f3049;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;607.3453,532.0334;Float;False;Property;_Glow_Range;Glow_Range;8;0;Create;True;0;0;False;0;5.12;3.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;617.4479,327.0444;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;64;-364.6553,265.8837;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;44;785.4774,311.1568;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;81.86883,-64.37152;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;186.8926,753.2144;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;809.0389,540.4651;Float;False;Property;_Glow_Ins;Glow_Ins;9;0;Create;True;0;0;False;0;0.75;0.59;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;1026.318,313.4428;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;198.6299,1008.707;Float;False;Property;_Mask_Pow;Mask_Pow;1;0;Create;True;0;0;False;0;0;1.9;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;283.4688,-229.8715;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;352.7144,759.7401;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;329.7194,12.97226;Float;False;Property;_Emi_Pow;Emi_Pow;7;0;Create;True;0;0;False;0;2;2;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;506.6302,1006.707;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;0;3.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;531.6606,-231.7445;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;26;512.6302,769.7064;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-568.6602,-1278.29;Float;False;891.3051;478.7673;Comment;5;6;7;1;9;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;754.6303,768.7064;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;38;-107.7842,-706.0529;Float;False;766.1894;346.0629;Normal;2;11;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-518.6603,-1228.29;Float;True;Property;_FXT_Crack_Base;FXT_Crack_Base;0;0;Create;True;0;0;False;0;f719773caaa49fe40ac0521d134f36b8;f719773caaa49fe40ac0521d134f36b8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;845.4993,-13.13911;Float;False;Property;_Emi_Color;Emi_Color;6;1;[HDR];Create;True;0;0;False;0;0,0,0,0;35.58215,12.70357,3.860328,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;12;836.7979,-253.7559;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-442.4237,-1011.523;Float;False;Property;_Base_Color;Base_Color;3;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;70;1374.399,-200.1402;Float;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;1086.03,-258.3712;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-44.65524,-671.2466;Float;False;Property;_Normal_Scale;Normal_Scale;14;0;Create;True;0;0;False;0;0;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-199.8015,-1219.806;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;30;953.5302,768.1064;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;127.3545,-1692.322;Float;False;473.8199;378.5891;Emi 대신 쓰기 가능;3;40;41;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-209.2738,-985.8745;Float;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;False;0;0;3;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;210.6607,-1429.733;Float;False;Constant;_Float2;Float 2;13;0;Create;True;0;0;False;0;54.87;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;87.64491,-1073.711;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;17;393.1754,1138.701;Float;True;Property;_TextureSample0;Texture Sample 0;17;0;Create;True;0;0;False;0;None;ada7d7b9960604d429f82277e242d1ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;936.6143,983.7882;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;1650.631,-333.1938;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;31;735.5738,1133.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;41;341.1743,-1642.322;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;40;177.3545,-1639.829;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;224.8595,-656.053;Float;True;Property;_FXT_Crack_Normal;FXT_Crack_Normal;13;0;Create;True;0;0;False;0;3557bae52f9f5b544b5a4224a7c67086;3557bae52f9f5b544b5a4224a7c67086;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;1686.417,-46.93468;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1960.529,-423.8447;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/Crack01;False;False;False;False;False;False;False;False;False;False;True;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;34;0;35;0
WireConnection;34;1;3;1
WireConnection;34;2;36;0
WireConnection;34;3;37;0
WireConnection;55;0;34;0
WireConnection;19;0;54;0
WireConnection;19;1;20;0
WireConnection;59;0;60;0
WireConnection;59;1;61;0
WireConnection;21;0;19;0
WireConnection;21;1;22;0
WireConnection;76;0;54;0
WireConnection;76;1;77;0
WireConnection;57;47;59;0
WireConnection;57;29;76;0
WireConnection;23;0;21;0
WireConnection;45;0;23;0
WireConnection;56;1;57;0
WireConnection;46;0;45;0
WireConnection;46;1;47;0
WireConnection;62;0;56;1
WireConnection;62;1;63;0
WireConnection;2;1;54;0
WireConnection;48;0;46;0
WireConnection;64;0;62;0
WireConnection;44;0;48;0
WireConnection;44;1;49;0
WireConnection;65;0;2;1
WireConnection;65;1;64;0
WireConnection;24;0;23;0
WireConnection;50;0;44;0
WireConnection;50;1;51;0
WireConnection;66;0;2;1
WireConnection;66;1;65;0
WireConnection;25;0;24;0
WireConnection;53;0;66;0
WireConnection;53;1;50;0
WireConnection;26;0;25;0
WireConnection;26;1;28;0
WireConnection;27;0;26;0
WireConnection;27;1;29;0
WireConnection;1;1;54;0
WireConnection;12;0;53;0
WireConnection;12;1;13;0
WireConnection;14;0;12;0
WireConnection;14;1;15;0
WireConnection;6;0;1;0
WireConnection;6;1;7;0
WireConnection;30;0;27;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;32;0;31;0
WireConnection;32;1;29;0
WireConnection;72;0;14;0
WireConnection;72;1;70;0
WireConnection;31;0;17;1
WireConnection;31;1;28;0
WireConnection;41;0;40;0
WireConnection;41;1;42;0
WireConnection;40;0;1;1
WireConnection;5;1;54;0
WireConnection;5;5;11;0
WireConnection;71;0;30;0
WireConnection;71;1;70;4
WireConnection;0;0;8;0
WireConnection;0;1;5;0
WireConnection;0;2;72;0
WireConnection;0;9;71;0
ASEEND*/
//CHKSM=AB8CFE6FCBE994DC625D673EEFC2022FC7685426