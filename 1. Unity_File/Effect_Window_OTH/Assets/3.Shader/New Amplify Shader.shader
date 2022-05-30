// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Addtive_Shine"
{
	Properties
	{
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		[HDR]_TintColor("Tint Color ", Color) = (0,0,0,0)
		_Mask_Range_Up("Mask_Range_Up", Float) = 0
		_Mask_Range_Down("Mask_Range_Down", Float) = 1.71
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		ZWrite Off
		Blend SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _Cull_Mode;
		uniform float4 _TintColor;
		uniform float _Mask_Range_Down;
		uniform float _Mask_Range_Up;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float temp_output_27_0 = ( pow( ( 1.0 - abs( ( i.uv_texcoord.y - 0.5 ) ) ) , 8.0 ) * 1.74 );
			float2 appendResult28 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 panner33 = ( 1.0 * _Time.y * appendResult28 + i.uv_texcoord);
			o.Emission = ( i.vertexColor * ( ( _TintColor * ( saturate( ( pow( i.uv_texcoord.x , _Mask_Range_Down ) * 45.0 ) ) * ( pow( saturate( ( 1.0 - i.uv_texcoord.x ) ) , _Mask_Range_Up ) * temp_output_27_0 ) ) ) * tex2D( _Noise_Texture, panner33 ).r ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;3006.77;663.2225;1.714199;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-2609.504,423.1552;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2776.772,26.51248;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-2387.14,169.6588;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;12;-2165.235,166.9581;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1967.852,-218.6227;Float;False;Property;_Mask_Range_Down;Mask_Range_Down;5;0;Create;True;0;0;False;0;1.71;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;14;-1942.35,172.4623;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1851.441,429.7607;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;-2124.919,-106.7226;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;-1863.999,-116.8338;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1875.104,69.07719;Float;False;Property;_Mask_Range_Up;Mask_Range_Up;4;0;Create;True;0;0;False;0;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1604.852,-221.6227;Float;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;False;0;45;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1587.441,418.7608;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;1.74;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;21;-1684.243,187.5636;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;22;-1725.852,-445.6226;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1460.441,174.7609;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1458.852,-418.6224;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;25;-1701.004,-121.5228;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1378.45,792.2886;Float;False;Property;_Noise_VPanner;Noise_VPanner;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1379.45,710.2886;Float;False;Property;_Noise_UPanner;Noise_UPanner;1;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1213.45,716.2886;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;29;-1180.831,-291.3864;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1028.596,44.54226;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-1445.45,538.2886;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;32;-771.6885,-351.4196;Float;False;Property;_TintColor;Tint Color ;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;5.59088,4.068756,2.722261,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;33;-1214.45,544.2886;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-968.3933,-201.7058;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-708.6885,148.5803;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;36;-860.4504,423.289;Float;True;Property;_Noise_Texture;Noise_Texture;0;0;Create;True;0;0;False;0;None;cbc6cf68c6cb60d4a96f969da02fb810;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-463.9103,231.5657;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;38;-566.5915,-25.27865;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;220,6;Float;False;Property;_Cull_Mode;Cull_Mode;6;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;-1249.896,181.5156;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-255.3795,-111.3065;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Addtive_Shine;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;7;-1;-1;-1;0;False;0;0;True;3;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;10;2
WireConnection;11;1;9;0
WireConnection;12;0;11;0
WireConnection;14;0;12;0
WireConnection;13;0;10;1
WireConnection;17;0;13;0
WireConnection;21;0;14;0
WireConnection;21;1;16;0
WireConnection;22;0;10;1
WireConnection;22;1;15;0
WireConnection;27;0;21;0
WireConnection;27;1;20;0
WireConnection;26;0;22;0
WireConnection;26;1;19;0
WireConnection;25;0;17;0
WireConnection;25;1;18;0
WireConnection;28;0;23;0
WireConnection;28;1;24;0
WireConnection;29;0;26;0
WireConnection;30;0;25;0
WireConnection;30;1;27;0
WireConnection;33;0;31;0
WireConnection;33;2;28;0
WireConnection;34;0;29;0
WireConnection;34;1;30;0
WireConnection;35;0;32;0
WireConnection;35;1;34;0
WireConnection;36;1;33;0
WireConnection;37;0;35;0
WireConnection;37;1;36;1
WireConnection;40;0;27;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;2;2;39;0
WireConnection;2;9;38;4
ASEEND*/
//CHKSM=03F15A03772977FB9DC6CF9B995B7190ADBEE3BE