// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Post/LerpColor"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Min("Min", Float) = 0
		_Max("Max", Float) = 1
		_ColorA("ColorA", Color) = (0,0,0,0)
		[HDR]_ColorB("ColorB", Color) = (1,1,1,0)
		[Toggle(_ONEMINUS_ON)] _OneMinus("OneMinus", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 2.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature_local _ONEMINUS_ON


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float4 _ColorA;
			uniform float4 _ColorB;
			uniform float _Min;
			uniform float _Max;
			uniform sampler2D _TextureSample1;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float3 temp_cast_0 = (_Min).xxx;
				float3 temp_cast_1 = (( _Min + _Max )).xxx;
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float3 desaturateInitialColor16 = (tex2D( _MainTex, uv_MainTex )).rgb;
				float desaturateDot16 = dot( desaturateInitialColor16, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar16 = lerp( desaturateInitialColor16, desaturateDot16.xxx, 1.0 );
				float2 CenteredUV15_g4 = ( i.uv.xy - float2( 0.5,0.5 ) );
				float2 break17_g4 = CenteredUV15_g4;
				float2 appendResult23_g4 = (float2(( length( CenteredUV15_g4 ) * 0.0 * 2.0 ) , ( atan2( break17_g4.x , break17_g4.y ) * ( 1.0 / 6.28318548202515 ) * 24.0 )));
				float2 panner41 = ( 1.0 * _Time.y * float2( 1.09,0 ) + appendResult23_g4);
				float2 texCoord47 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_cast_2 = (0.5).xx;
				float2 temp_output_50_0 = ( ( texCoord47 - temp_cast_2 ) * 2.0 );
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_52_0 = ( temp_output_50_0 * temp_output_50_0 );
				float2 temp_cast_4 = (0.5).xx;
				float2 temp_cast_5 = (0.5).xx;
				float temp_output_56_0 = ( tex2D( _TextureSample1, panner41 ).r * pow( ( (temp_output_52_0).x + (temp_output_52_0).y ) , 2.0 ) );
				float3 smoothstepResult18 = smoothstep( temp_cast_0 , temp_cast_1 , ( desaturateVar16 * ( 1.0 - temp_output_56_0 ) ));
				#ifdef _ONEMINUS_ON
				float3 staticSwitch35 = ( 1.0 - smoothstepResult18 );
				#else
				float3 staticSwitch35 = smoothstepResult18;
				#endif
				float4 lerpResult22 = lerp( _ColorA , _ColorB , float4( saturate( staticSwitch35 ) , 0.0 ));
				

				finalColor = lerpResult22;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18712
2022;42;1920;873;1865.076;1207.057;2.68981;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-1245.537,849.9599;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-1188.337,1120.36;Inherit;False;Constant;_Float5;Float 5;6;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-985.537,1113.86;Inherit;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;48;-1047.937,887.6599;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-869.837,886.3598;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1448.079,593.2082;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1452.918,678.6136;Inherit;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-646.237,878.5599;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;39;-1245.879,533.5082;Inherit;False;Polar Coordinates;-1;;4;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;43;-1551.879,492.5083;Inherit;False;Constant;_Vector2;Vector 2;6;0;Create;True;0;0;0;False;0;False;1.09,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ComponentMaskNode;54;-421.3371,942.2599;Inherit;False;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;53;-433.037,835.6599;Inherit;False;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-192.7436,814.4006;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-275.9376,1034.103;Inherit;False;Constant;_Float7;Float 7;6;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;11;-1083.5,-338.2;Inherit;True;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;41;-1025.88,367.5081;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;61;124.0624,807.103;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-850.5001,-262.2;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;1;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-773.1603,427.9675;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-334.3146,422.3506;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;29;-563.3483,-259.7921;Inherit;True;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-457.6179,-53.78296;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;16;-323.3174,-167.4218;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;19;68,213.5;Inherit;False;Property;_Min;Min;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;72.59875,306.8852;Inherit;False;Property;_Max;Max;1;0;Create;True;0;0;0;False;0;False;1;0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;63;-118.1967,409.3444;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;320.2452,208.2548;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;34.9634,-307.2764;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;18;339,-10.5;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;34;534.7769,111.8849;Inherit;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;35;725.1013,-9.505739;Inherit;True;Property;_OneMinus;OneMinus;4;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;36;996.9995,-8.973694;Inherit;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;24;633.9352,-488.8906;Inherit;False;Property;_ColorA;ColorA;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;669.9352,-302.8906;Inherit;False;Property;_ColorB;ColorB;3;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1091.962,-109.8155;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;22;1296.8,-373.8999;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;38;-1606.234,775.9379;Inherit;False;RadialUVDistortion;-1;;5;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;0.0;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;33.20623,-96.59461;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;32;1574.121,-361.6057;Float;False;True;-1;2;ASEMaterialInspector;0;2;Post/LerpColor;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;50;0;48;0
WireConnection;50;1;51;0
WireConnection;52;0;50;0
WireConnection;52;1;50;0
WireConnection;39;3;40;0
WireConnection;39;4;45;0
WireConnection;54;0;52;0
WireConnection;53;0;52;0
WireConnection;55;0;53;0
WireConnection;55;1;54;0
WireConnection;41;0;39;0
WireConnection;41;2;43;0
WireConnection;61;0;55;0
WireConnection;61;1;62;0
WireConnection;1;0;11;0
WireConnection;37;1;41;0
WireConnection;56;0;37;1
WireConnection;56;1;61;0
WireConnection;29;0;1;0
WireConnection;16;0;29;0
WireConnection;16;1;17;0
WireConnection;63;0;56;0
WireConnection;21;0;19;0
WireConnection;21;1;20;0
WireConnection;64;0;16;0
WireConnection;64;1;63;0
WireConnection;18;0;64;0
WireConnection;18;1;19;0
WireConnection;18;2;21;0
WireConnection;34;0;18;0
WireConnection;35;1;18;0
WireConnection;35;0;34;0
WireConnection;36;0;35;0
WireConnection;22;0;24;0
WireConnection;22;1;25;0
WireConnection;22;2;36;0
WireConnection;58;0;16;0
WireConnection;58;1;56;0
WireConnection;32;0;22;0
ASEEND*/
//CHKSM=8F134AF61A828D359DED081F5E69FCF808F59FF6