// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Beam_01"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Opacity("Opacity", Float) = 1.02
		[HDR]_Tint_Color("Tint_Color", Color) = (0,0,0,0)
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _Tint_Color.rgb;
			float2 appendResult7 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner3 = ( 1.0 * _Time.y * appendResult7 + uv0_Main_Texture);
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_output_11_0 = ( ( i.uv_texcoord - temp_cast_1 ) * 2.0 );
			float2 temp_cast_2 = (0.5).xx;
			float2 break14 = ( temp_output_11_0 * temp_output_11_0 );
			float temp_output_18_0 = pow( saturate( ( 1.0 - ( break14.x + break14.y ) ) ) , 7.26 );
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( tex2D( _Main_Texture, panner3 ) + temp_output_18_0 ) * temp_output_18_0 ) * _Opacity ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;848.4344;216.5698;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-2436.658,826.2816;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2515.564,547.1715;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-2115.153,813.3273;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-2191.701,557.7708;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1944.389,556.5931;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1719.182,560.1968;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;14;-1486.182,564.1968;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1246.182,568.1968;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1649.751,248.4494;Float;False;Property;_Main_UPanner;Main_UPanner;2;0;Create;True;0;0;False;0;0;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1655.751,344.4494;Float;False;Property;_Main_VPanner;Main_VPanner;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1401.751,50.4494;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;16;-1005.182,556.1968;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1381.751,285.4494;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-786.0204,785.4952;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;7.26;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;3;-1058.751,141.4494;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;17;-809.1818,558.1968;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;18;-606.7203,552.6954;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-731.751,167.4494;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;7942e01aa6202744db9bc724f6356fc4;c3ec6f776be501a4db757961359756df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-371.8296,343.4592;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-150.8296,685.4592;Float;False;Property;_Opacity;Opacity;3;0;Create;True;0;0;False;0;1.02;1.44;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-196.8296,421.4592;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;29.17041,419.4592;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;26;45.56555,169.4302;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;25;230.5512,420.1416;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;24;-86.74841,-34.93826;Float;False;Property;_Tint_Color;Tint_Color;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.662745,0.5490196,0.5490196,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;432.5656,427.4302;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;746,63.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Beam_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;11;0;9;0
WireConnection;11;1;12;0
WireConnection;13;0;11;0
WireConnection;13;1;11;0
WireConnection;14;0;13;0
WireConnection;15;0;14;0
WireConnection;15;1;14;1
WireConnection;16;0;15;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;3;0;2;0
WireConnection;3;2;7;0
WireConnection;17;0;16;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;1;1;3;0
WireConnection;20;0;1;0
WireConnection;20;1;18;0
WireConnection;21;0;20;0
WireConnection;21;1;18;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;25;0;22;0
WireConnection;27;0;26;4
WireConnection;27;1;25;0
WireConnection;0;2;24;0
WireConnection;0;9;27;0
ASEEND*/
//CHKSM=66952E7AC6A03E7ABB8CAA6A03D5217777EF3DCE