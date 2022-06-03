// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Plan_BackGround"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_U_Tiling("U_Tiling", Float) = 1
		_V_Tililng("V_Tililng", Float) = 1
		_Mask_Pow("Mask_Pow", Range( 0 , 20)) = 0
		_Mask_Ins("Mask_Ins", Range( 0 , 10)) = 1
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _TextureSample0;
		uniform float _U_Tiling;
		uniform float _V_Tililng;
		uniform float _Mask_Ins;
		uniform float _Mask_Pow;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult16 = (float4(( ( 0.0 + i.uv_texcoord.x ) * _U_Tiling ) , ( ( i.uv_texcoord.y + 0.0 ) * _V_Tililng ) , 0.0 , 0.0));
			o.Albedo = ( ( _Tint_Color * tex2D( _TextureSample0, appendResult16.xy ) ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( pow( ( ( saturate( ( ( 1.0 - i.uv_texcoord.x ) * ( i.uv_texcoord.x * _Mask_Ins ) ) ) * 4.0 ) * ( saturate( ( ( 1.0 - i.uv_texcoord.y ) * ( i.uv_texcoord.y * _Mask_Ins ) ) ) * 4.0 ) ) , _Mask_Pow ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;2353.18;686.8954;2.204653;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1505.554,588.1193;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1413.574,785.7214;Float;False;Property;_Mask_Ins;Mask_Ins;4;0;Create;True;0;0;False;0;1;0.8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;-1054.522,927.5088;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;26;-1058.165,384.0045;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1087.884,631.6446;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1084.241,1175.149;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-799.1467,1069.1;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-792.301,519.6021;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1520.544,277.4318;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1505.227,-180.0084;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1548.114,19.10071;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1244.856,156.9454;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;37;-572.7321,519.6063;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-963.8755,-9.126155;Float;False;Property;_U_Tiling;U_Tiling;1;0;Create;True;0;0;False;0;1;32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-965.0812,301.6376;Float;False;Property;_V_Tililng;V_Tililng;2;0;Create;True;0;0;False;0;1;32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-1253.024,-168.7766;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;-575.7288,1062.046;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-797.6254,147.7557;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-795.5833,-142.2287;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-380.1143,524.9548;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-383.9636,1062.466;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-465.3021,-13.98403;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-130.9125,706.6386;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-61.45032,1032.241;Float;False;Property;_Mask_Pow;Mask_Pow;3;0;Create;True;0;0;False;0;0;1.4;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;35;101.7998,703.0764;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-238.3609,-40.73346;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;40;-88.55017,-367.4031;Float;False;Property;_Tint_Color;Tint_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;156.8235,-73.38775;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;355.3827,700.4657;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;31;-73.03419,221.5128;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;405.4996,121.7627;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;564.9302,475.5779;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;800.8476,110.5554;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;OTH/Plan_BackGround;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;18;2
WireConnection;26;0;18;1
WireConnection;27;0;18;1
WireConnection;27;1;22;0
WireConnection;20;0;18;2
WireConnection;20;1;22;0
WireConnection;23;0;21;0
WireConnection;23;1;20;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;6;0;3;2
WireConnection;6;1;7;0
WireConnection;37;0;28;0
WireConnection;4;0;5;0
WireConnection;4;1;3;1
WireConnection;38;0;23;0
WireConnection;8;0;6;0
WireConnection;8;1;12;0
WireConnection;9;0;4;0
WireConnection;9;1;11;0
WireConnection;29;0;37;0
WireConnection;24;0;38;0
WireConnection;16;0;9;0
WireConnection;16;1;8;0
WireConnection;30;0;29;0
WireConnection;30;1;24;0
WireConnection;35;0;30;0
WireConnection;35;1;36;0
WireConnection;1;1;16;0
WireConnection;39;0;40;0
WireConnection;39;1;1;0
WireConnection;34;0;35;0
WireConnection;32;0;39;0
WireConnection;32;1;31;0
WireConnection;33;0;31;4
WireConnection;33;1;34;0
WireConnection;0;0;32;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=D1AE85A892B7D6D3EABEC02F17A9E86C9A574C65