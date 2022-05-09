// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Portal_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 0
		_Main_Ins("Main_Ins", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Sub_VPanner("Sub_VPanner", Float) = 0
		_Main_VScail("Main_VScail", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Sub_UPanner("Sub_UPanner", Float) = 0
		_Main_UScail("Main_UScail", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Float) = 0.47
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_Sub_Pow("Sub_Pow", Float) = 1
		_Sub_Ins("Sub_Ins", Float) = 1
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
		uniform float _Sub_UPanner;
		uniform float _Sub_VPanner;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float _Main_UScail;
		uniform float _Main_VScail;
		uniform float _Main_Pow;
		uniform float _Main_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color41 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float2 appendResult45 = (float2(_Sub_UPanner , _Sub_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner46 = ( 1.0 * _Time.y * appendResult45 + uv0_Main_Texture);
			float4 temp_cast_0 = (_Sub_Pow).xxxx;
			float2 appendResult15 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner34 = ( 1.0 * _Time.y * appendResult38 + uv0_Noise_Texture);
			float2 appendResult26 = (float2(_Main_UScail , _Main_VScail));
			float2 panner9 = ( 1.0 * _Time.y * appendResult15 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner34 ) )).xy * _Noise_Val ) + uv0_Main_Texture )*appendResult26 + 0.0));
			float4 tex2DNode1 = tex2D( _Main_Texture, panner9 );
			float temp_output_19_0 = saturate( pow( ( 1.0 - i.uv_texcoord.y ) , 4.0 ) );
			float4 temp_cast_1 = (_Main_Pow).xxxx;
			o.Emission = ( color41 * ( pow( ( ( ( ( ( pow( tex2D( _Sub_Texture, panner46 ) , temp_cast_0 ) * _Sub_Ins ) + tex2DNode1.r ) * tex2DNode1.r ) + temp_output_19_0 ) * temp_output_19_0 ) , temp_cast_1 ) * _Main_Ins ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;8;1920;1008;2975.854;1545.333;2.593443;True;False
Node;AmplifyShaderEditor.RangedFloatNode;36;-3271.279,-328.3893;Float;False;Property;_Noise_VPanner;Noise_VPanner;12;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3269.279,-491.3893;Float;False;Property;_Noise_UPanner;Noise_UPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-3247.279,-665.3893;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-3064.279,-427.3893;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-2925.279,-661.3893;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;28;-2675.279,-641.3893;Float;True;Property;_Noise_Texture;Noise_Texture;9;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-2243.279,-388.3893;Float;False;Property;_Noise_Val;Noise_Val;10;0;Create;True;0;0;False;0;0.47;0.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;29;-2329.279,-627.3893;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2487.659,-757.7073;Float;False;Property;_Sub_VPanner;Sub_VPanner;4;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2493.944,-891.0815;Float;False;Property;_Sub_UPanner;Sub_UPanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2214.771,-223.4308;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2474.982,-1086.548;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;45;-2301.48,-815.1088;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1981.559,82.2027;Float;False;Property;_Main_VScail;Main_VScail;5;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1979.871,-51.1716;Float;False;Property;_Main_UScail;Main_UScail;8;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2035.279,-634.3893;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1882.279,-237.3893;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1665.788,287.2086;Float;False;Property;_Main_VPanner;Main_VPanner;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;46;-2164.274,-1042.748;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1787.407,24.80109;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1664.1,153.8343;Float;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-1886.007,-1065.979;Float;True;Property;_Sub_Texture;Sub_Texture;13;0;Create;True;0;0;False;0;None;587e91d7209e32340a11a711df6c875f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1471.636,229.807;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;8;-1635.229,-216.0319;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1733.871,-839.2288;Float;False;Property;_Sub_Pow;Sub_Pow;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-1409.169,-189.7301;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1696.174,422.2708;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;48;-1519.967,-1066.266;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1436.105,-831.255;Float;False;Property;_Sub_Ins;Sub_Ins;15;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1261.302,-1053.132;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1409.168,732.9135;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;-1392.287,484.7366;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1181.251,-230.2488;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;7942e01aa6202744db9bc724f6356fc4;7942e01aa6202744db9bc724f6356fc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;17;-1123.85,483.0486;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-888.304,-538.2624;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;19;-850.3494,486.425;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-625.7291,-369.1045;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-417.9097,-117.4092;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;4;15.97853,79.27553;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-43.11208,-171.434;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;2;279.3499,-179.031;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;5;390.7763,57.32797;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;0;0.87;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;41;678.6193,-424.5451;Float;False;Constant;_Main_Color;Main_Color;11;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;647.3943,-136.824;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;938.1111,-167.7848;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1252.871,-179.227;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Portal_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;35;0
WireConnection;38;1;36;0
WireConnection;34;0;33;0
WireConnection;34;2;38;0
WireConnection;28;1;34;0
WireConnection;29;0;28;0
WireConnection;45;0;44;0
WireConnection;45;1;43;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;27;0;30;0
WireConnection;27;1;7;0
WireConnection;46;0;47;0
WireConnection;46;2;45;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;42;1;46;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;8;0;27;0
WireConnection;8;1;26;0
WireConnection;9;0;8;0
WireConnection;9;2;15;0
WireConnection;48;0;42;0
WireConnection;48;1;51;0
WireConnection;50;0;48;0
WireConnection;50;1;52;0
WireConnection;21;0;16;2
WireConnection;1;1;9;0
WireConnection;17;0;21;0
WireConnection;17;1;18;0
WireConnection;53;0;50;0
WireConnection;53;1;1;1
WireConnection;19;0;17;0
WireConnection;54;0;53;0
WireConnection;54;1;1;1
WireConnection;22;0;54;0
WireConnection;22;1;19;0
WireConnection;23;0;22;0
WireConnection;23;1;19;0
WireConnection;2;0;23;0
WireConnection;2;1;4;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;39;0;41;0
WireConnection;39;1;3;0
WireConnection;0;2;39;0
ASEEND*/
//CHKSM=E435FC26913947A8B55D5DCE8C991F4FAE7EC4E0