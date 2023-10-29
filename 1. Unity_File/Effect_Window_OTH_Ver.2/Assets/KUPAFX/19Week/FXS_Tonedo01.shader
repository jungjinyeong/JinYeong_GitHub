// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Tondeo01"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Tonde_Speed("Tonde_Speed", Range( 0 , 10)) = 1
		_Wave_Count("Wave_Count", Range( 0 , 20)) = 6.048598
		_Wave_Str("Wave_Str", Range( 0 , 5)) = 1.235294
		_Wave_Thnkiness("Wave_Thnkiness", Range( 0 , 10)) = 5.411765
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		[HDR]_Color_A("Color_A", Color) = (1,0,0,0)
		[HDR]_Color_B("Color_B", Color) = (0.1414957,0,1,0)
		_Noise_UTiling("Noise_UTiling", Float) = 0.5
		_Noise_VTlling("Noise_VTlling", Float) = 2
		_Noise_Rotor("Noise_Rotor", Float) = 0.96
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Main_Pow("Main_Pow", Range( 0 , 10)) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Rotor;
		uniform float _Noise_UTiling;
		uniform float _Noise_VTlling;
		uniform float _Wave_Thnkiness;
		uniform float _Tonde_Speed;
		uniform float _Wave_Count;
		uniform float _Wave_Str;
		uniform float _Main_Pow;
		uniform float _Opacity;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult38 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner36 = ( 1.0 * _Time.y * appendResult38 + uv0_Noise_Texture);
			float2 temp_cast_0 = (0.5).xx;
			float cos27 = cos( _Noise_Rotor );
			float sin27 = sin( _Noise_Rotor );
			float2 rotator27 = mul( panner36 - temp_cast_0 , float2x2( cos27 , -sin27 , sin27 , cos27 )) + temp_cast_0;
			float4 appendResult49 = (float4(_Noise_UTiling , _Noise_VTlling , 0.0 , 0.0));
			float mulTime2 = _Time.y * _Tonde_Speed;
			float temp_output_35_0 = saturate( ( 1.0 - ( ( 1.0 - i.uv_texcoord.y ) + abs( ( ( ( i.uv_texcoord.x - 0.5 ) * _Wave_Thnkiness ) + ( sin( ( ( i.uv_texcoord.y + mulTime2 ) * _Wave_Count ) ) * _Wave_Str ) ) ) ) ) );
			float temp_output_33_0 = ( ( tex2D( _Noise_Texture, (rotator27*appendResult49.xy + 0.0) ).r + temp_output_35_0 ) * temp_output_35_0 );
			float4 lerpResult43 = lerp( _Color_A , _Color_B , pow( temp_output_33_0 , _Main_Pow ));
			o.Emission = ( lerpResult43 * i.vertexColor ).rgb;
			o.Alpha = 1;
			clip( ( temp_output_33_0 * _Opacity ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;975.4141;302.8468;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-3183.27,1170.962;Float;False;Property;_Tonde_Speed;Tonde_Speed;2;0;Create;True;0;0;False;0;1;1.25;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-3093.472,885.7941;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;2;-2891.472,1162.794;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-2778.27,931.9617;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2682.27,1160.962;Float;False;Property;_Wave_Count;Wave_Count;3;0;Create;True;0;0;False;0;6.048598;7.8;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2755.563,698.7695;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2532.27,944.9617;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2387.27,1159.962;Float;False;Property;_Wave_Str;Wave_Str;4;0;Create;True;0;0;False;0;1.235294;0.42;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;14;-2627.563,632.7694;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-2338.27,935.9617;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2843.564,846.7696;Float;False;Property;_Wave_Thnkiness;Wave_Thnkiness;5;0;Create;True;0;0;False;0;5.411765;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2899.026,272.9464;Float;False;Property;_Noise_UPanner;Noise_UPanner;12;0;Create;True;0;0;False;0;0;0.71;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2904.026,345.9464;Float;False;Property;_Noise_VPanner;Noise_VPanner;13;0;Create;True;0;0;False;0;0;-2.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-2445.563,647.7694;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2167.27,931.9617;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-2672.025,288.9464;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-2945.026,103.9464;Float;False;0;26;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-2394.025,264.9464;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1992.563,795.7695;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2441.025,385.9464;Float;False;Property;_Noise_Rotor;Noise_Rotor;11;0;Create;True;0;0;False;0;0.96;4.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2269.414,566.1532;Float;False;Property;_Noise_VTlling;Noise_VTlling;10;0;Create;True;0;0;False;0;2;1.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;36;-2577.025,192.9464;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-2273.414,482.1532;Float;False;Property;_Noise_UTiling;Noise_UTiling;9;0;Create;True;0;0;False;0;0.5;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;16;-1780.563,789.7695;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-1909.563,538.7696;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;49;-2028.414,388.1532;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotatorNode;27;-2208.025,202.9464;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-1956.025,216.9464;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1650.379,529.568;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-1452.35,540.591;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;48;-1811.414,247.1532;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;35;-1269.025,473.9464;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-1703.609,170.6094;Float;True;Property;_Noise_Texture;Noise_Texture;6;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1280.025,213.9464;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1011.025,389.9464;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-961.8406,237.481;Float;False;Property;_Main_Pow;Main_Pow;14;0;Create;True;0;0;False;0;0;2.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-804.8478,-75.5025;Float;False;Property;_Color_B;Color_B;8;1;[HDR];Create;True;0;0;False;0;0.1414957,0,1,0;1.189632,0.4627169,4.265042,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-817.8478,-387.5025;Float;False;Property;_Color_A;Color_A;7;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;46;-580.9406,210.1811;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1206.061,714.5775;Float;False;Property;_Opacity;Opacity;15;0;Create;True;0;0;False;0;0;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;43;-513.1746,-59.29289;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;54;-244.4141,166.1532;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;1088.616,179.3041;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;6904366d56281b64b949da6521ac47d2;6904366d56281b64b949da6521ac47d2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;6;733.6158,283.304;Float;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;0,1.74;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;682.6159,150.3041;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-481.1879,490.4067;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;909.6159,171.3041;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-28.41406,-50.8468;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;423,-4;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Tondeo01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;8;0
WireConnection;7;0;1;2
WireConnection;7;1;2;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;14;0;1;1
WireConnection;14;1;15;0
WireConnection;11;0;9;0
WireConnection;20;0;14;0
WireConnection;20;1;21;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;38;0;39;0
WireConnection;38;1;40;0
WireConnection;19;0;20;0
WireConnection;19;1;12;0
WireConnection;36;0;28;0
WireConnection;36;2;38;0
WireConnection;16;0;19;0
WireConnection;24;0;1;2
WireConnection;49;0;50;0
WireConnection;49;1;51;0
WireConnection;27;0;36;0
WireConnection;27;1;29;0
WireConnection;27;2;30;0
WireConnection;31;0;27;0
WireConnection;31;1;49;0
WireConnection;23;0;24;0
WireConnection;23;1;16;0
WireConnection;22;0;23;0
WireConnection;48;0;31;0
WireConnection;35;0;22;0
WireConnection;26;1;48;0
WireConnection;34;0;26;1
WireConnection;34;1;35;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;46;0;33;0
WireConnection;46;1;47;0
WireConnection;43;0;44;0
WireConnection;43;1;45;0
WireConnection;43;2;46;0
WireConnection;3;1;4;0
WireConnection;41;0;33;0
WireConnection;41;1;42;0
WireConnection;4;0;5;0
WireConnection;4;2;6;0
WireConnection;55;0;43;0
WireConnection;55;1;54;0
WireConnection;0;2;55;0
WireConnection;0;10;41;0
ASEEND*/
//CHKSM=5D603C48F1A789890880478ACD2629F78A03B681