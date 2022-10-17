// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Portar_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
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
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_Sub_Pow("Sub_Pow", Float) = 1
		_Sub_Ins("Sub_Ins", Float) = 1
		[HDR]_Sub_Color("Sub_Color", Color) = (1,1,1,0)
		_Sub_UPanner("Sub_UPanner", Float) = 0
		_Sub_VPanner("Sub_VPanner", Float) = 0
		_Mask_In_Val("Mask_In_Val", Float) = 4
		_Desaturate_Val("Desaturate_Val", Range( 0 , 1)) = 0
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
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_UScail;
		uniform float _Main_VScail;
		uniform float _Mask_In_Val;
		uniform float _Main_Pow;
		uniform float _Main_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult45 = (float2(_Sub_UPanner , _Sub_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner46 = ( 1.0 * _Time.y * appendResult45 + uv0_Sub_Texture);
			float3 desaturateInitialColor60 = tex2D( _Sub_Texture, panner46 ).rgb;
			float desaturateDot60 = dot( desaturateInitialColor60, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar60 = lerp( desaturateInitialColor60, desaturateDot60.xxx, _Desaturate_Val );
			float3 temp_cast_1 = (_Sub_Pow).xxx;
			float2 appendResult15 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner34 = ( 1.0 * _Time.y * appendResult38 + uv0_Noise_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult26 = (float2(_Main_UScail , _Main_VScail));
			float2 panner9 = ( 1.0 * _Time.y * appendResult15 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner34 ) )).xy * _Noise_Val ) + uv0_Main_Texture )*appendResult26 + 0.0));
			float temp_output_19_0 = saturate( pow( ( 1.0 - i.uv_texcoord.y ) , _Mask_In_Val ) );
			float4 temp_output_39_0 = ( _Main_Color * ( pow( ( ( tex2D( _Main_Texture, panner9 ).r + temp_output_19_0 ) * temp_output_19_0 ) , _Main_Pow ) * _Main_Ins ) );
			o.Emission = ( ( ( _Sub_Color * float4( ( pow( desaturateVar60 , temp_cast_1 ) * _Sub_Ins ) , 0.0 ) ) + temp_output_39_0 ) * temp_output_39_0 * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;73;1043;620;3981.49;1535.326;2.661038;True;False
Node;AmplifyShaderEditor.RangedFloatNode;36;-3271.279,-328.3893;Float;False;Property;_Noise_VPanner;Noise_VPanner;11;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3269.279,-491.3893;Float;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-3247.279,-665.3893;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;38;-3064.279,-427.3893;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-2925.279,-661.3893;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;28;-2675.279,-641.3893;Float;True;Property;_Noise_Texture;Noise_Texture;7;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;29;-2329.279,-627.3893;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2243.279,-388.3893;Float;False;Property;_Noise_Val;Noise_Val;8;0;Create;True;0;0;False;0;0.47;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2214.771,-223.4308;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1981.559,82.2027;Float;False;Property;_Main_VScail;Main_VScail;4;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2035.279,-634.3893;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1979.871,-51.1716;Float;False;Property;_Main_UScail;Main_UScail;6;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1665.788,287.2086;Float;False;Property;_Main_VPanner;Main_VPanner;3;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1664.1,153.8343;Float;False;Property;_Main_UPanner;Main_UPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1690.545,452.1832;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1787.407,24.80109;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1882.279,-237.3893;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2487.659,-755.2084;Float;False;Property;_Sub_VPanner;Sub_VPanner;17;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2495.194,-891.0815;Float;False;Property;_Sub_UPanner;Sub_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1409.168,735.5135;Float;False;Property;_Mask_In_Val;Mask_In_Val;18;0;Create;True;0;0;False;0;4;2.64;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;8;-1635.229,-216.0319;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1471.636,229.807;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;21;-1431.287,471.7366;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;17;-1123.85,483.0486;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;9;-1409.169,-189.7301;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2476.531,-1088.097;Float;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;45;-2301.48,-815.1088;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1181.251,-230.2488;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;7942e01aa6202744db9bc724f6356fc4;cbc6cf68c6cb60d4a96f969da02fb810;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;46;-2164.274,-1042.748;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;19;-850.3494,486.425;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-1887.557,-1070.627;Float;True;Property;_Sub_Texture;Sub_Texture;12;0;Create;True;0;0;False;0;None;cbc6cf68c6cb60d4a96f969da02fb810;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-687.5698,-194.1586;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1724.557,-840.0818;Float;False;Property;_Desaturate_Val;Desaturate_Val;19;0;Create;True;0;0;False;0;0;0.59;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-337.3612,69.85313;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;0;0.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1044.742,-702.5078;Float;False;Property;_Sub_Pow;Sub_Pow;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-376.8668,-181.4189;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;60;-1484.558,-1046.299;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-54.4318,52.61678;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;0;0.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-106.9682,-181.3866;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;48;-788.7417,-894.5078;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-685.05,-654.2821;Float;False;Property;_Sub_Ins;Sub_Ins;14;0;Create;True;0;0;False;0;1;3.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;41;178.0635,-370.3665;Float;False;Property;_Main_Color;Main_Color;9;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.528931,1.443802,1.218817,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;56;-503.596,-1144.921;Float;False;Property;_Sub_Color;Sub_Color;15;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.785992,1.748651,1.440588,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;185.6972,-183.9359;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-487.0051,-887.0051;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;426.9467,-181.9184;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-257.2298,-884.6121;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;62;1077.636,-211.0456;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;59;930.1653,-554.2389;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;1283.505,-551.8838;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1672.796,-530.703;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Portar_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;21;0;16;2
WireConnection;17;0;21;0
WireConnection;17;1;18;0
WireConnection;9;0;8;0
WireConnection;9;2;15;0
WireConnection;45;0;44;0
WireConnection;45;1;43;0
WireConnection;1;1;9;0
WireConnection;46;0;47;0
WireConnection;46;2;45;0
WireConnection;19;0;17;0
WireConnection;42;1;46;0
WireConnection;22;0;1;1
WireConnection;22;1;19;0
WireConnection;23;0;22;0
WireConnection;23;1;19;0
WireConnection;60;0;42;0
WireConnection;60;1;61;0
WireConnection;2;0;23;0
WireConnection;2;1;4;0
WireConnection;48;0;60;0
WireConnection;48;1;51;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;50;0;48;0
WireConnection;50;1;52;0
WireConnection;39;0;41;0
WireConnection;39;1;3;0
WireConnection;55;0;56;0
WireConnection;55;1;50;0
WireConnection;59;0;55;0
WireConnection;59;1;39;0
WireConnection;58;0;59;0
WireConnection;58;1;39;0
WireConnection;58;2;62;0
WireConnection;0;2;58;0
WireConnection;0;9;62;4
ASEEND*/
//CHKSM=B201D64BC28E6A3FBDAF2A595E32AD7D5F21E297