// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/14Week_Circle_Mask"
{
	Properties
	{
		_FXT_Circle_Dummy("FXT_Circle_Dummy", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_Mask_Range("Mask_Range", Range( 0 , 0.5)) = 0.5
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Color0;
		uniform sampler2D _FXT_Circle_Dummy;
		uniform float4 _FXT_Circle_Dummy_ST;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = ( _Color0 * i.vertexColor ).rgb;
			float2 uv_FXT_Circle_Dummy = i.uv_texcoord * _FXT_Circle_Dummy_ST.xy + _FXT_Circle_Dummy_ST.zw;
			float2 temp_cast_1 = (0.5).xx;
			float2 break17 = ( ( i.uv_texcoord - temp_cast_1 ) * 2.0 );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch40 = i.uv_tex4coord.z;
			#else
				float staticSwitch40 = _Mask_Range;
			#endif
			float2 appendResult36 = (float2(i.uv_texcoord.x , saturate( ( 1.0 - i.uv_texcoord.y ) )));
			float2 temp_cast_2 = (0.5).xx;
			float2 break23 = ( ( appendResult36 - temp_cast_2 ) * 2.0 );
			o.Alpha = ( i.vertexColor * ( tex2D( _FXT_Circle_Dummy, uv_FXT_Circle_Dummy ).r * ( step( frac( ( atan2( break17.x , break17.y ) / 6.28318548202515 ) ) , staticSwitch40 ) + step( ( 1.0 - frac( ( atan2( break23.x , break23.y ) / 6.28318548202515 ) ) ) , staticSwitch40 ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;54;1920;965;743.4226;668.9695;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2714.934,233.3203;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;37;-2497.419,413.9358;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;-2360.419,451.9358;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-2219.419,308.9358;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2190.934,199.3203;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-2037.977,311.7465;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1886.934,249.3203;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1808.977,304.7465;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-2055.934,44.32028;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;23;-1584.056,299.0865;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1818.934,43.32028;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ATan2OpNode;31;-1324.58,351.7502;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;17;-1591.013,35.66031;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TauNode;11;-1307.839,226.667;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;6;-1259.537,8.323946;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-1085.949,332.9278;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-801.4749,177.0722;Float;False;Property;_Mask_Range;Mask_Range;2;0;Create;True;0;0;False;0;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;39;-721.6946,261.1876;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;32;-841.1191,361.7717;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-1040.906,2.501618;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;5;-837.0757,0.3455511;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;-637.4189,436.9358;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;40;-513.4226,230.0305;Float;False;Property;_Use_Custom;Use_Custom;3;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;20;-257.1882,88.21274;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;33;-210.4189,398.9358;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-413.1883,-212.0766;Float;True;Property;_FXT_Circle_Dummy;FXT_Circle_Dummy;0;0;Create;True;0;0;False;0;b4445b837243ccb46b6e431b4bb42098;b4445b837243ccb46b6e431b4bb42098;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-36.4189,277.9358;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;41;-21.42261,-267.9695;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-45.78271,-81.64679;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-125,-479.5;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;267.5774,-120.9695;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;262.5774,-432.9695;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;492,-367;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/14Week_Circle_Mask;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;12;2
WireConnection;38;0;37;0
WireConnection;36;0;12;1
WireConnection;36;1;38;0
WireConnection;25;0;36;0
WireConnection;25;1;14;0
WireConnection;28;0;25;0
WireConnection;28;1;16;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;23;0;28;0
WireConnection;15;0;13;0
WireConnection;15;1;16;0
WireConnection;31;0;23;0
WireConnection;31;1;23;1
WireConnection;17;0;15;0
WireConnection;6;0;17;0
WireConnection;6;1;17;1
WireConnection;29;0;31;0
WireConnection;29;1;11;0
WireConnection;32;0;29;0
WireConnection;10;0;6;0
WireConnection;10;1;11;0
WireConnection;5;0;10;0
WireConnection;35;0;32;0
WireConnection;40;1;21;0
WireConnection;40;0;39;3
WireConnection;20;0;5;0
WireConnection;20;1;40;0
WireConnection;33;0;35;0
WireConnection;33;1;40;0
WireConnection;34;0;20;0
WireConnection;34;1;33;0
WireConnection;22;0;1;1
WireConnection;22;1;34;0
WireConnection;42;0;41;0
WireConnection;42;1;22;0
WireConnection;43;0;2;0
WireConnection;43;1;41;0
WireConnection;0;2;43;0
WireConnection;0;9;42;0
ASEEND*/
//CHKSM=721B395D54EF4C2FA06FD12E449D6162F9ADBD38