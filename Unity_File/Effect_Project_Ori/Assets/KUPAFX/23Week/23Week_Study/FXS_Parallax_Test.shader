// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Stduy/Parallax_Test"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Tiling("Tiling", Float) = 1
		_Ins("Ins", Float) = 0
		_Pow("Pow", Float) = 0
		_Hight("Hight", Float) = 1
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Sub_Tex_Height("Sub_Tex_Height", Float) = 1
		_SubTex_Tilng("SubTex_Tilng", Float) = 1
		_SubTex_Offset("SubTex_Offset", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample1;
		uniform float _Sub_Tex_Height;
		uniform float _SubTex_Tilng;
		uniform float _SubTex_Offset;
		uniform sampler2D _TextureSample0;
		uniform float _Hight;
		uniform float _Tiling;
		uniform float _Pow;
		uniform float _Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 paralaxOffset26 = ParallaxOffset( 0 , _Sub_Tex_Height , i.viewDir );
			float2 paralaxOffset12 = ParallaxOffset( 0 , _Hight , i.viewDir );
			float4 temp_cast_0 = (_Pow).xxxx;
			o.Emission = ( tex2D( _TextureSample1, (paralaxOffset26*_SubTex_Tilng + _SubTex_Offset) ).r + ( pow( tex2D( _TextureSample0, (paralaxOffset12*_Tiling + 0.0) ) , temp_cast_0 ) * _Ins ) ).rgb;
			float2 temp_cast_2 = (0.5).xx;
			o.Alpha = step( length( ( ( i.uv_texcoord - temp_cast_2 ) * 2.0 ) ) , 0.7529412 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
2101;-3;1920;978;1068;922.5;1;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;17;-607,-268.5;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-590,-355.5;Float;False;Property;_Hight;Hight;4;0;Create;True;0;0;False;0;1;7.97;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-284,-51.5;Float;False;Property;_Tiling;Tiling;1;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;12;-415,-342.5;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-658,41.5;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;25;-496.8,-585.9;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-120,-297.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-624,330.5;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-475.8,-717.9;Float;False;Property;_Sub_Tex_Height;Sub_Tex_Height;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-433,280.5;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-228.8,-518.9;Float;False;Property;_SubTex_Tilng;SubTex_Tilng;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-436,69.5;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;140,-192.5;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;02898dfb4fcd1e249b2c981ed0c5c828;02898dfb4fcd1e249b2c981ed0c5c828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;26;-239.8,-665.9;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-233,-416.5;Float;False;Property;_SubTex_Offset;SubTex_Offset;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;289,8.5;Float;False;Property;_Pow;Pow;3;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;455,-142.5;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;729,-14.5;Float;False;Property;_Ins;Ins;2;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-238,64.5;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;27;40.20001,-627.9;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;842,-99.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-175,299.5;Float;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;False;0;0.7529412;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;7;-18,55.5;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;260,-630.5;Float;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;False;0;None;5383fe6908d8ffc4f9336151bbc09f0a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;8;167,81.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;913,-385.5;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1275,-154;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Stduy/Parallax_Test;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;1;16;0
WireConnection;12;2;17;0
WireConnection;14;0;12;0
WireConnection;14;1;15;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;10;1;14;0
WireConnection;26;1;24;0
WireConnection;26;2;25;0
WireConnection;19;0;10;0
WireConnection;19;1;20;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;27;0;26;0
WireConnection;27;1;23;0
WireConnection;27;2;29;0
WireConnection;21;0;19;0
WireConnection;21;1;22;0
WireConnection;7;0;5;0
WireConnection;18;1;27;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;28;0;18;1
WireConnection;28;1;21;0
WireConnection;0;2;28;0
WireConnection;0;9;8;0
ASEEND*/
//CHKSM=576A0CAF8180342FE73ACAFFA5F465F3368A2045