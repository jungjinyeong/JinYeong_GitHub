// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additve_Shine"
{
	Properties
	{
		[HDR]_TintColor("Tint Color ", Color) = (0,0,0,0)
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Mask_Range_Up("Mask_Range_Up", Float) = 0
		_Mask_Range_Down("Mask_Range_Down", Float) = 1.71
		[Enum(UnityEngine.Rendering.StencilOp)]_Depth("Depth", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest Always
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Depth;
		uniform float4 _TintColor;
		uniform float _Mask_Range_Down;
		uniform float _Mask_Range_Up;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float temp_output_9_0 = ( pow( ( 1.0 - abs( ( i.uv_texcoord.y - 0.5 ) ) ) , 8.0 ) * 1.74 );
			float2 appendResult29 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult29 + uv0_Noise_Texture);
			o.Emission = ( ( ( _TintColor * ( saturate( ( pow( i.uv_texcoord.x , _Mask_Range_Down ) * 45.0 ) ) * ( pow( saturate( ( 1.0 - i.uv_texcoord.x ) ) , _Mask_Range_Up ) * temp_output_9_0 ) ) ) * tex2D( _Noise_Texture, panner25 ).r ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;266.061;609.3937;1.48431;True;True
Node;AmplifyShaderEditor.RangedFloatNode;3;-1301.062,196.8945;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1468.33,-199.7483;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2;-1078.698,-56.60207;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;4;-856.7932,-59.30276;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;-816.4777,-332.9834;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;6;-633.9089,-53.79861;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-692.4114,-504.8835;Float;False;Property;_Mask_Range_Down;Mask_Range_Down;6;0;Create;True;0;0;False;0;1.71;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-543,203.5;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;35;-555.5578,-343.0946;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-566.663,-157.1836;Float;False;Property;_Mask_Range_Up;Mask_Range_Up;5;0;Create;True;0;0;False;0;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-296.4114,-447.8835;Float;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;False;0;45;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-279,192.5;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;1.74;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;-375.8028,-38.69724;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;13;-417.4115,-671.8834;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-71.00952,484.0282;Float;False;Property;_Noise_UPanner;Noise_UPanner;3;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-70.00952,566.0282;Float;False;Property;_Noise_VPanner;Noise_VPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;-392.5629,-347.7836;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-150.4114,-644.8833;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-152,-51.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;94.99048,490.0282;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;17;127.6094,-517.6472;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;279.8446,-181.7185;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-137.0095,312.0282;Float;False;0;24;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;536.7524,-577.6805;Float;False;Property;_TintColor;Tint Color ;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;5.59088,4.068756,2.722261,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;25;93.99048,318.0282;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;340.0475,-427.9666;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;599.7524,-77.68054;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;24;447.9905,197.0282;Float;True;Property;_Noise_Texture;Noise_Texture;2;0;Create;True;0;0;False;0;None;cbc6cf68c6cb60d4a96f969da02fb810;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;844.5303,5.30475;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;22;867.3709,-206.8826;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1034.957,-388.2588;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;58.54424,-44.74525;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1723.268,-131.5081;Float;False;Property;_Depth;Depth;7;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1439,-273;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additve_Shine;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;7;False;36;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;2
WireConnection;2;1;3;0
WireConnection;4;0;2;0
WireConnection;12;0;1;1
WireConnection;6;0;4;0
WireConnection;35;0;12;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;13;0;1;1
WireConnection;13;1;14;0
WireConnection;31;0;35;0
WireConnection;31;1;33;0
WireConnection;15;0;13;0
WireConnection;15;1;16;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;17;0;15;0
WireConnection;11;0;31;0
WireConnection;11;1;9;0
WireConnection;25;0;26;0
WireConnection;25;2;29;0
WireConnection;19;0;17;0
WireConnection;19;1;11;0
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;24;1;25;0
WireConnection;30;0;20;0
WireConnection;30;1;24;1
WireConnection;23;0;30;0
WireConnection;23;1;22;0
WireConnection;34;0;9;0
WireConnection;0;2;23;0
WireConnection;0;9;22;4
ASEEND*/
//CHKSM=D0F03A86EE1FC207CFA16F71DD0CE8E7B298D1D5