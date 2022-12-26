// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_SubWave"
{
	Properties
	{
		_Main_Pow("Main_Pow", Float) = 0
		_Main_Ins("Main_Ins", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_VScail("Main_VScail", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_UScail("Main_UScail", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Float) = 0.47
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Sub_Pow("Sub_Pow", Float) = 1
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_Sub_Ins("Sub_Ins", Float) = 1
		[HDR]_Sub_Color("Sub_Color", Color) = (1,1,1,0)
		_Sub_UPanner("Sub_UPanner", Float) = 0
		_Sub_VPanner("Sub_VPanner", Float) = 0
		_Mask_In_Val("Mask_In_Val", Float) = 4
		_Desaturate_Val("Desaturate_Val", Range( 0 , 1)) = 0
		_Mask_Out_Pow("Mask_Out_Pow", Float) = 0
		_Mask_Out_Ins("Mask_Out_Ins", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Sub_Chromatic_Val("Sub_Chromatic_Val", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
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
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Sub_Color;
		uniform sampler2D _Sub_Texture;
		uniform float _Sub_UPanner;
		uniform float _Sub_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Desaturate_Val;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float4 _Main_Color;
		uniform sampler2D _Texture0;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float _Main_UScail;
		uniform float _Main_VScail;
		uniform float _Sub_Chromatic_Val;
		uniform float _Mask_In_Val;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Mask_Out_Pow;
		uniform float _Mask_Out_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult45 = (float2(_Sub_UPanner , _Sub_VPanner));
			float2 uv_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner46 = ( 1.0 * _Time.y * appendResult45 + uv_Sub_Texture);
			float3 desaturateInitialColor60 = tex2D( _Sub_Texture, panner46 ).rgb;
			float desaturateDot60 = dot( desaturateInitialColor60, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar60 = lerp( desaturateInitialColor60, desaturateDot60.xxx, _Desaturate_Val );
			float3 temp_cast_1 = (_Sub_Pow).xxx;
			float2 appendResult15 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner34 = ( 1.0 * _Time.y * appendResult38 + uv_Noise_Texture);
			float2 appendResult26 = (float2(_Main_UScail , _Main_VScail));
			float2 panner9 = ( 1.0 * _Time.y * appendResult15 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner34 ) )).xy * _Noise_Val ) + i.uv_texcoord )*appendResult26 + 0.0));
			float2 temp_cast_3 = (_Sub_Chromatic_Val).xx;
			float3 appendResult97 = (float3(tex2D( _Texture0, ( panner9 + _Sub_Chromatic_Val ) ).r , tex2D( _Texture0, panner9 ).g , tex2D( _Texture0, ( panner9 - temp_cast_3 ) ).b));
			float temp_output_19_0 = saturate( pow( ( 1.0 - i.uv_texcoord.y ) , _Mask_In_Val ) );
			float3 temp_cast_4 = (_Main_Pow).xxx;
			float4 temp_output_39_0 = ( _Main_Color * float4( ( pow( ( ( appendResult97 + temp_output_19_0 ) * temp_output_19_0 ) , temp_cast_4 ) * _Main_Ins ) , 0.0 ) );
			o.Emission = ( ( ( _Sub_Color * float4( ( pow( desaturateVar60 , temp_cast_1 ) * _Sub_Ins ) , 0.0 ) ) + temp_output_39_0 ) * temp_output_39_0 * i.vertexColor ).rgb;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 temp_cast_8 = (_Mask_Out_Pow).xxxx;
			o.Alpha = ( i.vertexColor.a * saturate( ( pow( tex2D( _TextureSample0, uv_TextureSample0 ) , temp_cast_8 ) * _Mask_Out_Ins ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1146;605;2999.781;1371.345;1.36982;True;False
Node;AmplifyShaderEditor.RangedFloatNode;36;-4055.64,-313.834;Float;False;Property;_Noise_VPanner;Noise_VPanner;10;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-4055.64,-473.834;Float;False;Property;_Noise_UPanner;Noise_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-4039.64,-649.834;Inherit;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-3863.64,-409.834;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-3719.64,-649.834;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;28;-3463.64,-617.834;Inherit;True;Property;_Noise_Texture;Noise_Texture;6;0;Create;True;0;0;0;False;0;False;-1;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;29;-3127.64,-601.834;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-3031.64,-361.834;Float;False;Property;_Noise_Val;Noise_Val;7;0;Create;True;0;0;0;False;0;False;0.47;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2775.64,-25.83405;Float;False;Property;_Main_UScail;Main_UScail;5;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2823.64,-617.834;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2999.64,-201.834;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-2775.64,102.1659;Float;False;Property;_Main_VScail;Main_VScail;3;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2470.094,274.5423;Float;False;Property;_Main_VPanner;Main_VPanner;2;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2468.406,141.168;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-2583.64,38.16594;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-2679.64,-217.834;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;8;-2423.64,-201.834;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-2275.942,217.1407;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;9;-2213.475,-202.3964;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1690.545,452.1832;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;90;-2241.556,-2.712105;Inherit;False;Property;_Sub_Chromatic_Val;Sub_Chromatic_Val;22;0;Create;True;0;0;0;False;0;False;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2285.795,-1001.126;Float;False;Property;_Sub_UPanner;Sub_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1409.168,735.5135;Float;False;Property;_Mask_In_Val;Mask_In_Val;17;0;Create;True;0;0;0;False;0;False;4;1.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1936.912,-229.5293;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;92;-1990.314,-63.53447;Inherit;True;Property;_Texture0;Texture 0;23;0;Create;True;0;0;0;False;0;False;None;03344d3d32e85af4faf109e635145a9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleSubtractOpNode;91;-1851.46,215.8475;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;21;-1431.287,471.7366;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2278.26,-865.2531;Float;False;Property;_Sub_VPanner;Sub_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-2092.081,-925.1532;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2267.132,-1198.142;Inherit;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;17;-1123.85,483.0486;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1553.025,-55.40449;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;7942e01aa6202744db9bc724f6356fc4;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;94;-1548.805,-259.2683;Inherit;True;Property;_TextureSample1;Texture Sample 1;23;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;95;-1554.428,173.746;Inherit;True;Property;_TextureSample2;Texture Sample 2;24;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;19;-850.3494,486.425;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;97;-1151.329,-6.468551;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;46;-1954.875,-1152.793;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-687.5698,-194.1586;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;42;-1676.285,-1038.399;Inherit;True;Property;_Sub_Texture;Sub_Texture;12;0;Create;True;0;0;0;False;0;False;-1;None;3b2d12b1ac7d63f4d80f853f4abac466;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-1567.098,-606.7047;Float;False;Property;_Desaturate_Val;Desaturate_Val;18;0;Create;True;0;0;0;False;0;False;0;0.95;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-337.3612,69.85313;Float;False;Property;_Main_Pow;Main_Pow;0;0;Create;True;0;0;0;False;0;False;0;0.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1044.742,-702.5078;Float;False;Property;_Sub_Pow;Sub_Pow;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-376.8668,-181.4189;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DesaturateOpNode;60;-1237.122,-1032.24;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-54.4318,52.61678;Float;False;Property;_Main_Ins;Main_Ins;1;0;Create;True;0;0;0;False;0;False;0;0.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;48;-788.7417,-894.5078;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;78;245.9859,426.9381;Inherit;True;Property;_TextureSample0;Texture Sample 0;21;0;Create;True;0;0;0;False;0;False;-1;None;90c7e899747425248a6d16f412e7cf3d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;2;-106.9682,-181.3866;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-685.05,-654.2821;Float;False;Property;_Sub_Ins;Sub_Ins;13;0;Create;True;0;0;0;False;0;False;1;3.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;504.8491,706.184;Float;False;Property;_Mask_Out_Pow;Mask_Out_Pow;19;0;Create;True;0;0;0;False;0;False;0;2.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;71;701.6239,421.1822;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;41;178.0635,-370.3665;Float;False;Property;_Main_Color;Main_Color;8;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.015103,0.7213027,1.100116,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-487.0051,-887.0051;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;80;769.6881,711.0151;Float;False;Property;_Mask_Out_Ins;Mask_Out_Ins;20;0;Create;True;0;0;0;False;0;False;0;7.58;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;185.6972,-183.9359;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;56;-503.596,-1144.921;Float;False;Property;_Sub_Color;Sub_Color;14;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1.785992,1.748651,1.440588,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;426.9467,-181.9184;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;985.7047,423.4798;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-257.2298,-884.6121;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;930.1653,-554.2389;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;62;1077.636,-211.0456;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;77;1226.965,425.0101;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;1595.913,-12.8015;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;1283.505,-551.8838;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1978.696,-582.003;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_SubWave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;35;0
WireConnection;38;1;36;0
WireConnection;34;0;33;0
WireConnection;34;2;38;0
WireConnection;28;1;34;0
WireConnection;29;0;28;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;27;0;30;0
WireConnection;27;1;7;0
WireConnection;8;0;27;0
WireConnection;8;1;26;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;9;0;8;0
WireConnection;9;2;15;0
WireConnection;93;0;9;0
WireConnection;93;1;90;0
WireConnection;91;0;9;0
WireConnection;91;1;90;0
WireConnection;21;0;16;2
WireConnection;45;0;44;0
WireConnection;45;1;43;0
WireConnection;17;0;21;0
WireConnection;17;1;18;0
WireConnection;1;0;92;0
WireConnection;1;1;9;0
WireConnection;94;0;92;0
WireConnection;94;1;93;0
WireConnection;95;0;92;0
WireConnection;95;1;91;0
WireConnection;19;0;17;0
WireConnection;97;0;94;1
WireConnection;97;1;1;2
WireConnection;97;2;95;3
WireConnection;46;0;47;0
WireConnection;46;2;45;0
WireConnection;22;0;97;0
WireConnection;22;1;19;0
WireConnection;42;1;46;0
WireConnection;23;0;22;0
WireConnection;23;1;19;0
WireConnection;60;0;42;0
WireConnection;60;1;61;0
WireConnection;48;0;60;0
WireConnection;48;1;51;0
WireConnection;2;0;23;0
WireConnection;2;1;4;0
WireConnection;71;0;78;0
WireConnection;71;1;73;0
WireConnection;50;0;48;0
WireConnection;50;1;52;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;39;0;41;0
WireConnection;39;1;3;0
WireConnection;79;0;71;0
WireConnection;79;1;80;0
WireConnection;55;0;56;0
WireConnection;55;1;50;0
WireConnection;59;0;55;0
WireConnection;59;1;39;0
WireConnection;77;0;79;0
WireConnection;70;0;62;4
WireConnection;70;1;77;0
WireConnection;58;0;59;0
WireConnection;58;1;39;0
WireConnection;58;2;62;0
WireConnection;0;2;58;0
WireConnection;0;9;70;0
ASEEND*/
//CHKSM=AA35FBEF1390D21CE8CCEAEC96A8BB4E67C86FE3