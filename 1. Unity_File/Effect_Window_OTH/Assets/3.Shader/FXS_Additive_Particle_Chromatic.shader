// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Particle_Chromatic"
{
	Properties
	{
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Chromatic_Texture_Obj("Chromatic_Texture_Obj", 2D) = "white" {}
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Texture_Offset("Main_Texture_Offset", Vector) = (1,1,0,0)
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Chromatic_Val("Chromatic_Val", Range( 0 , 1)) = 0.02
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
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Cull_Mode;
		uniform sampler2D _Chromatic_Texture_Obj;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Chromatic_Texture_Obj_ST;
		uniform float2 _Main_Texture_Offset;
		uniform float _Chromatic_Val;
		uniform float _Main_Ins;
		uniform float4 _Tint_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult25 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_Chromatic_Texture_Obj = i.uv_texcoord * _Chromatic_Texture_Obj_ST.xy + _Chromatic_Texture_Obj_ST.zw;
			float2 panner26 = ( 1.0 * _Time.y * appendResult25 + uv0_Chromatic_Texture_Obj);
			float2 temp_output_29_0 = (panner26*_Main_Texture_Offset + 0.0);
			float2 temp_cast_0 = (_Chromatic_Val).xx;
			float3 appendResult36 = (float3(tex2D( _Chromatic_Texture_Obj, ( temp_output_29_0 + _Chromatic_Val ) ).r , tex2D( _Chromatic_Texture_Obj, temp_output_29_0 ).g , tex2D( _Chromatic_Texture_Obj, ( temp_output_29_0 - temp_cast_0 ) ).b));
			o.Emission = ( float4( appendResult36 , 0.0 ) * i.vertexColor * _Main_Ins * _Tint_Color ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;-0.5141602;462.6177;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-1905.923,-519.3991;Float;False;Property;_Main_UPanner;Main_UPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1907.457,-389.3821;Float;False;Property;_Main_VPanner;Main_VPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-1698.665,-570.3827;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1765.545,-875.4813;Float;True;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;27;-1522.451,-374.6739;Float;False;Property;_Main_Texture_Offset;Main_Texture_Offset;3;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;26;-1523.363,-852.2892;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;29;-1317.211,-568.2388;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1066.271,-551.8417;Float;False;Property;_Chromatic_Val;Chromatic_Val;6;0;Create;True;0;0;False;0;0.02;0.01;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-771.1555,-895.4573;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-747.9101,-314.1079;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;30;-765.1924,-582.0875;Float;True;Property;_Chromatic_Texture_Obj;Chromatic_Texture_Obj;1;0;Create;True;0;0;False;0;aaee582b48c170e428b733f8951dc6f0;d6519871a572e074d8db45063bd7881a;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;3;-431.768,-592.691;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;1195516317f46f34b9c06a0dee51c9a5;d647617c1ff6b1a4291f900bcd04800d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;33;-446.5529,-881.3577;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;7942e01aa6202744db9bc724f6356fc4;7942e01aa6202744db9bc724f6356fc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-436.8436,-332.39;Float;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;7942e01aa6202744db9bc724f6356fc4;7942e01aa6202744db9bc724f6356fc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;629.3389,-43.15602;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;2.1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;12;789.1639,151.3258;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;694.3041,-499.6382;Float;False;Property;_Tint_Color;Tint_Color;0;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.6658945,1.072857,1.425956,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;36;-47.65262,-569.3661;Float;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;993.5559,-286.1231;Float;True;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;37;1510.779,-256.8474;Float;False;Property;_Cull_Mode;Cull_Mode;7;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;1286.768,-262.8878;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Particle_Chromatic;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;8;-1;-1;-1;0;False;0;0;True;37;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;22;0
WireConnection;25;1;23;0
WireConnection;26;0;24;0
WireConnection;26;2;25;0
WireConnection;29;0;26;0
WireConnection;29;1;27;0
WireConnection;31;0;29;0
WireConnection;31;1;28;0
WireConnection;32;0;29;0
WireConnection;32;1;28;0
WireConnection;3;0;30;0
WireConnection;3;1;29;0
WireConnection;33;0;30;0
WireConnection;33;1;31;0
WireConnection;34;0;30;0
WireConnection;34;1;32;0
WireConnection;36;0;33;1
WireConnection;36;1;3;2
WireConnection;36;2;34;3
WireConnection;21;0;36;0
WireConnection;21;1;12;0
WireConnection;21;2;7;0
WireConnection;21;3;10;0
WireConnection;2;2;21;0
WireConnection;2;9;12;4
ASEEND*/
//CHKSM=7AB13E36E5FC8B937ED54F45AC2ABD9E31B02A3C