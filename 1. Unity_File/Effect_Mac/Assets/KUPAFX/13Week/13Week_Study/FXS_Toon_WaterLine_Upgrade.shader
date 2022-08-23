// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_WaterLine"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_u("u", 2D) = "white" {}
		_Color0("Color 0", Color) = (0.04841581,0.1083998,0.6037736,0)
		_Vertexnormal("Vertex normal", Float) = 0.1
		_Color1("Color 1", Color) = (1,1,1,1)
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Dissove("Dissove", Range( -2 , 1)) = 1
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", CUBE) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Float) = 0
		_TextureSample4("Texture Sample 4", 2D) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 2.0
		#pragma surface surf Standard keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 worldRefl;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _Vertexnormal;
		uniform float _Normal_Scale;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform samplerCUBE _TextureSample2;
		uniform sampler2D _TextureSample4;
		uniform float4 _TextureSample4_ST;
		uniform float4 _Color1;
		uniform float4 _Color0;
		uniform sampler2D _u;
		uniform sampler2D _TextureSample0;
		uniform float4 _u_ST;
		uniform float _Dissove;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv0_TextureSample1 = v.texcoord.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * float2( 0,0.15 ) + uv0_TextureSample1);
			float4 tex2DNode30 = tex2Dlod( _TextureSample1, float4( panner32, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2DNode30 * float4( ase_vertexNormal , 0.0 ) ) * _Vertexnormal ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float3 tex2DNode39 = UnpackScaleNormal( tex2D( _TextureSample3, uv_TextureSample3 ), _Normal_Scale );
			o.Normal = tex2DNode39;
			o.Albedo = texCUBE( _TextureSample2, WorldReflectionVector( i , tex2DNode39 ) ).rgb;
			float2 uv0_TextureSample4 = i.uv_texcoord * _TextureSample4_ST.xy + _TextureSample4_ST.zw;
			float2 panner49 = ( 1.0 * _Time.y * float2( 0,0.05 ) + uv0_TextureSample4);
			float2 panner21 = ( 1.0 * _Time.y * float2( 0.01,-0.01 ) + i.uv_texcoord);
			float2 uv0_u = i.uv_texcoord * _u_ST.xy + _u_ST.zw;
			float2 panner13 = ( 1.0 * _Time.y * float2( 0,0.5 ) + ( ( (UnpackNormal( tex2D( _TextureSample0, panner21 ) )).xy * 0.05 ) + uv0_u ));
			float4 lerpResult9 = lerp( _Color1 , _Color0 , saturate( step( 0.1 , pow( tex2D( _u, (panner13*float2( 3,1 ) + 0.0) ).r , 3.0 ) ) ));
			o.Emission = ( i.vertexColor * ( saturate( pow( tex2D( _TextureSample4, panner49 ).r , 4.0 ) ) + ( lerpResult9 * 1.0 ) ) ).rgb;
			o.Metallic = 0.2;
			o.Smoothness = 1.0;
			o.Alpha = i.vertexColor.a;
			float2 uv0_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 panner32 = ( 1.0 * _Time.y * float2( 0,0.15 ) + uv0_TextureSample1);
			float4 tex2DNode30 = tex2D( _TextureSample1, panner32 );
			float2 temp_output_58_0 = ( (tex2DNode39).xy + i.uv_texcoord );
			clip( saturate( ( ( step( 0.0 , ( tex2DNode30.r + _Dissove ) ) * step( 0.1 , saturate( ( saturate( (temp_output_58_0).y ) + i.uv_tex4coord.z ) ) ) ) * step( 0.1 , saturate( ( (( 1.0 - temp_output_58_0 )).y + i.uv_tex4coord.w ) ) ) ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;-1973.079;32.58948;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1416.238,-984.6166;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;22;-1346.238,-778.6165;Float;False;Constant;_Vector2;Vector 2;2;0;Create;True;0;0;False;0;0.01,-0.01;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;21;-1168.238,-851.6165;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;15;-969.2379,-993.6166;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-637.2375,-889.6165;Float;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;16;-658.2375,-989.6166;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-519.2377,-241.6165;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;1272.465,-191.7156;Float;False;Property;_Normal_Scale;Normal_Scale;10;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-480.2378,-983.6166;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-265.2376,-733.6165;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;14;-269.2376,-531.6165;Float;False;Constant;_Vector1;Vector 1;1;0;Create;True;0;0;False;0;0,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;39;1576.721,-189.8093;Float;True;Property;_TextureSample3;Texture Sample 3;9;0;Create;True;0;0;False;0;None;4f96d4ef7222cda4fbc29abb96dc4423;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;1586.973,269.1782;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;59;1743.886,94.80676;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;13;-15.2376,-698.6165;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;6;-265.2376,-474.6165;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;3,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;58;1782.302,248.9014;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;5;169.7624,-511.6164;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-33,68.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-197,-204.5;Float;True;Property;_u;u;1;0;Create;True;0;0;False;0;c7d564bbc661feb448e7dcb86e2aa438;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;187.8253,109.9387;Float;False;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;34;250.6426,229.3945;Float;False;Constant;_Vector3;Vector 3;8;0;Create;True;0;0;False;0;0,0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ComponentMaskNode;60;2051.886,245.8068;Float;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;2269.079,293.4105;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;72;1876.079,427.4105;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;64;2272.998,769.9335;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;578.0213,-944.9591;Float;False;0;45;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;2;96,-206.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;50;684.1097,-806.9415;Float;False;Constant;_Vector4;Vector 4;12;0;Create;True;0;0;False;0;0,0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;8;160,-324.5;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;32;412.3197,111.9983;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;30;543.4506,243.5486;Float;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;True;0;0;False;0;None;7ead229491461f64fb8abd86dfcd7d4b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;309.2292,-29.83036;Float;False;Property;_Dissove;Dissove;6;0;Create;True;0;0;False;0;1;0.11;-2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;49;883.9263,-850.2009;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;74;2055.079,490.4105;Float;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;7;359.7999,-296.2;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;2464.302,274.9014;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;715.0215,-647.1939;Float;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;0.04841581,0.1083998,0.6037736,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;27;807.759,-82.4537;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;2540.079,655.4105;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;608.2234,-293.6446;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;1082.563,-526.9366;Float;False;Constant;_Float6;Float 6;12;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;1067.263,-802.8219;Float;True;Property;_TextureSample4;Texture Sample 4;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;61;2652.886,276.8068;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;706.2213,-472.0937;Float;False;Property;_Color1;Color 1;4;0;Create;True;0;0;False;0;1,1,1,1;0.1650943,0.3574182,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;2575.886,186.8068;Float;False;Constant;_Float8;Float 8;12;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;57;2857.302,271.9014;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;9;990.9896,-453.4808;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;73;2687.079,563.4105;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;1231.254,-327.3008;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;46;1344.329,-684.3741;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;35;1078.234,-92.01824;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1339.02,-415.3788;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;75;2910.079,532.4105;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;2940.405,124.7876;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;23;925.5162,315.599;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;52;1591.31,-533.3884;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;1729.113,-510.5165;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;1086.98,173.6585;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;65;2314.213,-609.3893;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldReflectionVector;38;1618.552,-761.8642;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;3354.079,157.4105;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;1192.635,397.7946;Float;False;Property;_Vertexnormal;Vertex normal;3;0;Create;True;0;0;False;0;0.1;0.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;29;2756.389,-136.4115;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;1844.552,-813.8642;Float;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;False;0;None;56a68e301a0ff55469ae441c0112d256;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;1290.682,173.7181;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1849.728,-296.1464;Float;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;1940.502,-362.4921;Float;False;Constant;_Float4;Float 4;11;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;2518.53,-509.0649;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;56;2183.066,678.9014;Float;False;Property;_Mask;Mask;12;0;Create;True;0;0;False;0;-0.5117362;-0.4814397;-5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2998.111,-436.3578;Float;False;True;0;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/Alphablend_WaterLine;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;20;0
WireConnection;21;2;22;0
WireConnection;15;1;21;0
WireConnection;16;0;15;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;19;0;17;0
WireConnection;19;1;4;0
WireConnection;39;5;41;0
WireConnection;59;0;39;0
WireConnection;13;0;19;0
WireConnection;13;2;14;0
WireConnection;58;0;59;0
WireConnection;58;1;54;0
WireConnection;5;0;13;0
WireConnection;5;1;6;0
WireConnection;1;1;5;0
WireConnection;60;0;58;0
WireConnection;71;0;60;0
WireConnection;72;0;58;0
WireConnection;2;0;1;1
WireConnection;2;1;3;0
WireConnection;32;0;31;0
WireConnection;32;2;34;0
WireConnection;30;1;32;0
WireConnection;49;0;48;0
WireConnection;49;2;50;0
WireConnection;74;0;72;0
WireConnection;7;0;8;0
WireConnection;7;1;2;0
WireConnection;55;0;71;0
WireConnection;55;1;64;3
WireConnection;27;0;30;1
WireConnection;27;1;28;0
WireConnection;76;0;74;0
WireConnection;76;1;64;4
WireConnection;10;0;7;0
WireConnection;45;1;49;0
WireConnection;61;0;55;0
WireConnection;57;0;62;0
WireConnection;57;1;61;0
WireConnection;9;0;12;0
WireConnection;9;1;11;0
WireConnection;9;2;10;0
WireConnection;73;0;76;0
WireConnection;46;0;45;1
WireConnection;46;1;47;0
WireConnection;35;1;27;0
WireConnection;43;0;9;0
WireConnection;43;1;44;0
WireConnection;75;0;62;0
WireConnection;75;1;73;0
WireConnection;63;0;35;0
WireConnection;63;1;57;0
WireConnection;52;0;46;0
WireConnection;51;0;52;0
WireConnection;51;1;43;0
WireConnection;24;0;30;0
WireConnection;24;1;23;0
WireConnection;38;0;39;0
WireConnection;77;0;63;0
WireConnection;77;1;75;0
WireConnection;29;0;77;0
WireConnection;37;1;38;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;66;0;65;0
WireConnection;66;1;51;0
WireConnection;0;0;37;0
WireConnection;0;1;39;0
WireConnection;0;2;66;0
WireConnection;0;3;42;0
WireConnection;0;4;36;0
WireConnection;0;9;65;4
WireConnection;0;10;29;0
WireConnection;0;11;25;0
ASEEND*/
//CHKSM=13C2A933EE661CAB46218A8726693DE15CE7DFE6