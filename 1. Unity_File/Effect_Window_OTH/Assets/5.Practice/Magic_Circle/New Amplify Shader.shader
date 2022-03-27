// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_T_lesson05_sphere01("T_lesson05_sphere01", 2D) = "white" {}
		_magiccircle("magic circle", 2D) = "white" {}
		_magiccircle1("magic circle", 2D) = "white" {}
		_Flow_int("Flow_int", Float) = 1
		_UV_Speed("UV_Speed", Vector) = (0,0,0,0)
		_pOWINT("pOWINT", Float) = 20
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IsEmissive" = "true"  }
		Cull Back
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

		uniform sampler2D _magiccircle;
		uniform sampler2D _T_lesson05_sphere01;
		uniform float2 _UV_Speed;
		uniform float _Flow_int;
		uniform sampler2D _magiccircle1;
		uniform float _pOWINT;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner3 = ( 1.0 * _Time.y * _UV_Speed + i.uv_texcoord);
			float4 tex2DNode2 = tex2D( _magiccircle, ( i.uv_texcoord + ( tex2D( _T_lesson05_sphere01, panner3 ).r * _Flow_int ) ) );
			float cos13 = cos( _Time.y );
			float sin13 = sin( _Time.y );
			float2 rotator13 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos13 , -sin13 , sin13 , cos13 )) + float2( 0.5,0.5 );
			o.Emission = ( pow( ( ( tex2DNode2 + ( tex2DNode2 * tex2D( _magiccircle1, rotator13 ) ) ) * i.vertexColor * i.vertexColor.a ) , 2.0 ) * _pOWINT ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
2672;197;1515;735;3919.638;449.1473;1.9;True;False
Node;AmplifyShaderEditor.CommentaryNode;22;-3174.419,-86.55154;Inherit;False;1350.916;823.2543;UV_FLow;8;4;9;3;6;5;1;8;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;9;-3036.504,429.7028;Inherit;False;Property;_UV_Speed;UV_Speed;5;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-3124.419,262.0952;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-2892.419,261.0952;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.2,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-2656.077,229.144;Inherit;True;Property;_T_lesson05_sphere01;T_lesson05_sphere01;1;0;Create;True;0;0;0;False;0;False;-1;072ada3897c891647b0b293bbe11aedc;072ada3897c891647b0b293bbe11aedc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-2550.504,455.7028;Inherit;False;Property;_Flow_int;Flow_int;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2235.504,530.7027;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;14;-2138.504,837.7027;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-2364.447,242.0469;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2293.712,-36.55154;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-2058.504,234.7027;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;13;-1856.504,529.7027;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;-1642.522,704.1629;Inherit;True;Property;_magiccircle1;magic circle;3;0;Create;True;0;0;0;False;0;False;-1;7c4c35f982d197941bf5d8f37fa3ae58;7c4c35f982d197941bf5d8f37fa3ae58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1680.468,61.1669;Inherit;True;Property;_magiccircle;magic circle;2;0;Create;True;0;0;0;False;0;False;-1;7c4c35f982d197941bf5d8f37fa3ae58;7c4c35f982d197941bf5d8f37fa3ae58;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1496.504,361.7028;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1052.344,169.3704;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;17;-1072.09,461.1898;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-593.0896,227.1898;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;19;-383.0172,225.8662;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-295.0172,496.8662;Inherit;False;Property;_pOWINT;pOWINT;6;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-126.0172,244.8662;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;232.7,83.19999;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;4;0
WireConnection;3;2;9;0
WireConnection;1;1;3;0
WireConnection;5;0;1;1
WireConnection;5;1;6;0
WireConnection;7;0;8;0
WireConnection;7;1;5;0
WireConnection;13;0;12;0
WireConnection;13;2;14;0
WireConnection;10;1;13;0
WireConnection;2;1;7;0
WireConnection;15;0;2;0
WireConnection;15;1;10;0
WireConnection;16;0;2;0
WireConnection;16;1;15;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;18;2;17;4
WireConnection;19;0;18;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;0;2;20;0
ASEEND*/
//CHKSM=5EE6F2C796D3D311E0CC2CBAB4C8CAC9E6E9663B