// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MagicCircle"
{
	Properties
	{
		_5_1("5_1", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_5_2("5_2", 2D) = "white" {}
		_5_3("5_3", 2D) = "white" {}
		_Start_Power("Start_Power", Float) = 2
		_TimePower_1("TimePower_1", Float) = -1
		_C_Power_1("C_Power_1", Float) = 2
		_Color_1("Color_1", Color) = (0,0,0,0)
		_TimePower_2_1("TimePower_2_1", Float) = 0
		_C_Power_2_1("C_Power_2_1", Float) = 2
		_Color_2_1("Color_2_1", Color) = (0,0,0,0)
		_TimePower_2_2("TimePower_2_2", Float) = -1
		_C_Power_2_2("C_Power_2_2", Float) = 2
		_Color_2_2("Color_2_2", Color) = (0,0,0,0)
		_TimePower_3("TimePower_3", Float) = -1
		_C_Power_3("C_Power_3", Float) = 2
		_Color_3("Color_3", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _5_1;
		uniform float _TimePower_1;
		uniform float4 _Color_1;
		uniform float _C_Power_1;
		uniform sampler2D _5_2;
		uniform float _TimePower_2_1;
		uniform float4 _Color_2_1;
		uniform float _C_Power_2_1;
		uniform sampler2D _TextureSample0;
		uniform float _TimePower_2_2;
		uniform float4 _Color_2_2;
		uniform float _C_Power_2_2;
		uniform sampler2D _5_3;
		uniform float _TimePower_3;
		uniform float4 _Color_3;
		uniform float _C_Power_3;
		uniform float _Start_Power;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float mulTime18 = _Time.y * _TimePower_1;
			float cos7 = cos( mulTime18 );
			float sin7 = sin( mulTime18 );
			float2 rotator7 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos7 , -sin7 , sin7 , cos7 )) + float2( 0.5,0.5 );
			float mulTime20 = _Time.y * _TimePower_2_1;
			float cos12 = cos( mulTime20 );
			float sin12 = sin( mulTime20 );
			float2 rotator12 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos12 , -sin12 , sin12 , cos12 )) + float2( 0.5,0.5 );
			float mulTime39 = _Time.y * _TimePower_2_2;
			float cos42 = cos( mulTime39 );
			float sin42 = sin( mulTime39 );
			float2 rotator42 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos42 , -sin42 , sin42 , cos42 )) + float2( 0.5,0.5 );
			float mulTime22 = _Time.y * _TimePower_3;
			float cos13 = cos( mulTime22 );
			float sin13 = sin( mulTime22 );
			float2 rotator13 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos13 , -sin13 , sin13 , cos13 )) + float2( 0.5,0.5 );
			o.Emission = ( ( ( tex2D( _5_1, saturate( rotator7 ) ) * _Color_1 * _C_Power_1 ) + ( ( tex2D( _5_2, rotator12 ) * _Color_2_1 * _C_Power_2_1 ) * ( tex2D( _TextureSample0, saturate( rotator42 ) ) * _Color_2_2 * _C_Power_2_2 ) ) + ( tex2D( _5_3, saturate( rotator13 ) ) * _Color_3 * _C_Power_3 ) ) * i.vertexColor * _Start_Power ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
2560;10;1913;997;1255.401;791.3591;1.6;True;False
Node;AmplifyShaderEditor.CommentaryNode;51;-1668.541,543.1253;Inherit;False;1594.667;471.5001;Comment;10;38;39;40;41;42;43;44;45;46;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;49;-1456.424,-424.2415;Inherit;False;1576.558;439.6137;Comment;10;19;4;18;9;7;14;1;32;28;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1618.541,879.6967;Inherit;False;Property;_TimePower_2_2;TimePower_2_2;12;0;Create;True;0;0;0;False;0;False;-1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;-1680.278,64.07642;Inherit;False;1594.667;471.5002;Comment;9;21;20;5;10;12;33;36;29;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;50;-1452.188,1029.631;Inherit;False;1602.889;551.9053;Comment;10;23;11;22;6;13;16;37;34;3;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1406.424,-109.5587;Inherit;False;Property;_TimePower_1;TimePower_1;6;0;Create;True;0;0;0;False;0;False;-1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-1558.415,617.8665;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;39;-1416.821,878.0156;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1402.188,1465.536;Inherit;False;Property;_TimePower_3;TimePower_3;15;0;Create;True;0;0;0;False;0;False;-1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-1548.298,738.6191;Inherit;False;Constant;_Ahchor_2_2;Ahchor_2_2;4;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;21;-1630.278,400.6478;Inherit;False;Property;_TimePower_2_1;TimePower_2_1;9;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;18;-1204.703,-111.2397;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1333.349,-358.3962;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;11;-1322.299,1313.036;Inherit;False;Constant;_Ahchor_3;Ahchor_3;4;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;42;-1257.486,614.5602;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;9;-1331.278,-239.7941;Inherit;False;Constant;_Ahchor_1;Ahchor_1;4;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1319.564,1192.482;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;10;-1565.747,257.6665;Inherit;False;Constant;_Ahchor_2_1;Ahchor_2_1;4;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;20;-1428.558,398.9668;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1570.152,138.8175;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;22;-1200.468,1463.855;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;13;-1027.249,1192.76;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;7;-1047.129,-358.3961;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;12;-1269.224,135.5113;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;43;-1035.913,612.7404;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-432.948,898.6254;Inherit;False;Property;_C_Power_2_2;C_Power_2_2;13;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;14;-831.0179,-358.1886;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;16;-822.0441,1194.658;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;33;-518.7855,236.2766;Inherit;False;Property;_Color_2_1;Color_2_1;11;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-507.0478,715.3253;Inherit;False;Property;_Color_2_2;Color_2_2;14;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-444.6858,419.5766;Inherit;False;Property;_C_Power_2_1;C_Power_2_1;10;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;47;-823.4115,608.4753;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;a13eac31afb36b943986de0c2a328bf6;a13eac31afb36b943986de0c2a328bf6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-835.149,129.4263;Inherit;True;Property;_5_2;5_2;3;0;Create;True;0;0;0;False;0;False;-1;a13eac31afb36b943986de0c2a328bf6;a13eac31afb36b943986de0c2a328bf6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-242.6067,-100.628;Inherit;False;Property;_C_Power_1;C_Power_1;7;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-247.6119,114.0764;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;32;-312.9064,-291.528;Inherit;False;Property;_Color_1;Color_1;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-598.987,1181.137;Inherit;True;Property;_5_3;5_3;4;0;Create;True;0;0;0;False;0;False;-1;d96c198b6bd31c04ab92eeccfabb35ed;d96c198b6bd31c04ab92eeccfabb35ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;-286.2061,1271.663;Inherit;False;Property;_Color_3;Color_3;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-215.7705,1458.711;Inherit;False;Property;_C_Power_3;C_Power_3;16;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-606.9521,-374.2415;Inherit;True;Property;_5_1;5_1;0;0;Create;True;0;0;0;False;0;False;-1;dbb6806bd2c773149831885171a48fcf;dbb6806bd2c773149831885171a48fcf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-235.8744,593.1254;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;127.4372,266.9723;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-11.29898,1079.631;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-41.8653,-363.8278;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;637.8271,483.2188;Inherit;False;Property;_Start_Power;Start_Power;5;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;26;588.0646,271.3192;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;54;514.6861,120.5937;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;784.2646,50.01871;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1087.346,-11.2315;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;MagicCircle;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;38;0
WireConnection;18;0;19;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;42;2;39;0
WireConnection;20;0;21;0
WireConnection;22;0;23;0
WireConnection;13;0;6;0
WireConnection;13;1;11;0
WireConnection;13;2;22;0
WireConnection;7;0;4;0
WireConnection;7;1;9;0
WireConnection;7;2;18;0
WireConnection;12;0;5;0
WireConnection;12;1;10;0
WireConnection;12;2;20;0
WireConnection;43;0;42;0
WireConnection;14;0;7;0
WireConnection;16;0;13;0
WireConnection;47;1;43;0
WireConnection;2;1;12;0
WireConnection;29;0;2;0
WireConnection;29;1;33;0
WireConnection;29;2;36;0
WireConnection;3;1;16;0
WireConnection;1;1;14;0
WireConnection;46;0;47;0
WireConnection;46;1;44;0
WireConnection;46;2;45;0
WireConnection;53;0;29;0
WireConnection;53;1;46;0
WireConnection;30;0;3;0
WireConnection;30;1;34;0
WireConnection;30;2;37;0
WireConnection;28;0;1;0
WireConnection;28;1;32;0
WireConnection;28;2;35;0
WireConnection;54;0;28;0
WireConnection;54;1;53;0
WireConnection;54;2;30;0
WireConnection;25;0;54;0
WireConnection;25;1;26;0
WireConnection;25;2;27;0
WireConnection;0;2;25;0
WireConnection;0;9;26;4
ASEEND*/
//CHKSM=12562D21E4C0704E4E94F4919FCA6F1BD6E2A863