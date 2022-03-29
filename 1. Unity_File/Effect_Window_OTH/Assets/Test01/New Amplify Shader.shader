// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Test"
{
	Properties
	{
		_FXT_Sword_Slash("FXT_Sword_Slash", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_Glow("Glow", Float) = 1
		_Main_POW("Main_POW", Float) = 15
		_T_lesson05_sphere01("T_lesson05_sphere01", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _FXT_Sword_Slash;
		uniform sampler2D _T_lesson05_sphere01;
		uniform float _Main_POW;
		uniform float4 _Color0;
		uniform float _Glow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner17 = ( 1.0 * _Time.y * float2( 0.2,0.1 ) + i.uv_texcoord);
			float4 tex2DNode12 = tex2D( _T_lesson05_sphere01, panner17 );
			float4 tex2DNode1 = tex2D( _FXT_Sword_Slash, ( ( tex2DNode12.r + i.uv_texcoord ) * 1.0 ) );
			o.Emission = ( pow( tex2DNode1.r , _Main_POW ) + ( tex2DNode12.r * ( tex2DNode1 * i.vertexColor * _Color0 * _Glow ) ) ).rgb;
			o.Alpha = ( tex2DNode1.r * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;2273.696;426.3413;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1771.043,-375.188;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;19;-1720.343,-217.8881;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0.2,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;17;-1512.343,-319.2882;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1935.718,155.2939;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1316.042,-351.7881;Float;True;Property;_T_lesson05_sphere01;T_lesson05_sphere01;4;0;Create;True;0;0;False;0;d21f7822dd2995745901043658333ecc;d21f7822dd2995745901043658333ecc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1680.918,94.19388;Float;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1392.318,335.9938;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1309.318,110.0939;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-740,618.5;Float;False;Property;_Glow;Glow;2;0;Create;True;0;0;False;0;1;3.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1067,36.09999;Float;True;Property;_FXT_Sword_Slash;FXT_Sword_Slash;0;0;Create;True;0;0;False;0;be992bbc6d79694478a1115b34900de4;be992bbc6d79694478a1115b34900de4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-784,427.5;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2,2,2,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;3;-748,252.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-852.8417,-182.988;Float;False;Property;_Main_POW;Main_POW;3;0;Create;True;0;0;False;0;15;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-697.7999,68.49998;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;8;-574.6417,-409.188;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-479.2223,55.0387;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-354,319.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-315.9417,-199.888;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-8,3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Test;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;18;0
WireConnection;17;2;19;0
WireConnection;12;1;17;0
WireConnection;27;0;12;1
WireConnection;27;1;22;0
WireConnection;25;0;27;0
WireConnection;25;1;26;0
WireConnection;1;1;25;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;2;2;4;0
WireConnection;2;3;5;0
WireConnection;8;0;1;1
WireConnection;8;1;9;0
WireConnection;21;0;12;1
WireConnection;21;1;2;0
WireConnection;6;0;1;1
WireConnection;6;1;3;4
WireConnection;10;0;8;0
WireConnection;10;1;21;0
WireConnection;0;2;10;0
WireConnection;0;9;6;0
ASEEND*/
//CHKSM=E948DF7DCA8322C83CB4BB0F23565F179E00A40B