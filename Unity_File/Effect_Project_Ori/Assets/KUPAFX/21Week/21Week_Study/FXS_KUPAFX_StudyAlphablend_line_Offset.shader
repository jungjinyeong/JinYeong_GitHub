// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/Alphablend_line_Offset"
{
	Properties
	{
		_Gra_Texutre("Gra_Texutre", 2D) = "white" {}
		_Noise_Texture("Noise_Texture", 2D) = "white" {}
		_Noise_Str("Noise_Str", Range( 0 , 10)) = 0
		_Offset("Offset", Float) = 0.94
		[HDR]_Tint_Color("Tint_Color ", Color) = (1,1,1,0)
		_Gra_Pow("Gra_Pow", Range( 1 , 50)) = 45
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint_Color;
		uniform sampler2D _Gra_Texutre;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Gra_Texutre_ST;
		uniform float _Offset;
		uniform float _Gra_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 appendResult13 = (float2(1.0 , 1.0));
			float2 panner29 = ( 1.0 * _Time.y * float2( 0,0.15 ) + (uv0_Noise_Texture*appendResult13 + 0.0));
			float2 uv0_Gra_Texutre = i.uv_texcoord * _Gra_Texutre_ST.xy + _Gra_Texutre_ST.zw;
			float2 appendResult17 = (float2(0.0 , _Offset));
			float4 tex2DNode1 = tex2D( _Gra_Texutre, ( ( (tex2D( _Noise_Texture, panner29 )).rga * _Noise_Str ) + float3( (uv0_Gra_Texutre*1.0 + appendResult17) ,  0.0 ) ).xy );
			o.Emission = ( _Tint_Color * pow( tex2DNode1.r , _Gra_Pow ) ).rgb;
			o.Alpha = saturate( ( pow( tex2DNode1.r , 2.0 ) * saturate( pow( ( ( i.uv_texcoord.y * ( 1.0 - i.uv_texcoord.y ) ) * 4.0 ) , 4.0 ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
113;33;1920;1012;492.4224;496.1361;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;12;-2022,-298.5;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2027,-375.5;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1845,-332.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2105,-547.5;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;30;-1640.604,-327.089;Float;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0,0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;9;-1840,-532.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;29;-1491.604,-445.089;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1001.29,153.9319;Float;False;Property;_Offset;Offset;3;0;Create;True;0;0;False;0;0.94;0.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1296,-514.5;Float;True;Property;_Noise_Texture;Noise_Texture;1;0;Create;True;0;0;False;0;None;fdb7f2284c843954baf647c1c33d72fe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1329.509,419.6235;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-996.2903,56.93188;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-1001.509,568.6236;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1027,-135.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1103,-256.5;Float;False;Property;_Noise_Str;Noise_Str;2;0;Create;True;0;0;False;0;0;0.46;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-800.2903,137.9319;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;6;-1009,-509.5;Float;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-748,-504.5;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-702.2903,-36.06812;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-811.5089,467.6235;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-589.5089,472.6235;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-612,-157.5;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-575.5089,750.6236;Float;False;Constant;_Float4;Float 4;4;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-472,-141.5;Float;True;Property;_Gra_Texutre;Gra_Texutre;0;0;Create;True;0;0;False;0;3f5b46fe17ed58946937189037ccfc8c;3f5b46fe17ed58946937189037ccfc8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;25;-373.5088,475.6235;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-337.2903,207.9319;Float;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;27;-137.5088,478.6235;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;18;-196.2903,47.93188;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-45.42242,-26.13614;Float;False;Property;_Gra_Pow;Gra_Pow;5;0;Create;True;0;0;False;0;45;40.74118;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;131.4936,278.8092;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;241.5776,-114.1361;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;241.5776,-327.1361;Float;False;Property;_Tint_Color;Tint_Color ;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;511.5776,-170.1361;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;19;541.3896,138.663;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;778.3799,-184.7411;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/Alphablend_line_Offset;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;9;0;10;0
WireConnection;9;1;13;0
WireConnection;29;0;9;0
WireConnection;29;2;30;0
WireConnection;5;1;29;0
WireConnection;22;0;21;2
WireConnection;17;0;15;0
WireConnection;17;1;16;0
WireConnection;6;0;5;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;14;0;3;0
WireConnection;14;2;17;0
WireConnection;23;0;21;2
WireConnection;23;1;22;0
WireConnection;24;0;23;0
WireConnection;4;0;7;0
WireConnection;4;1;14;0
WireConnection;1;1;4;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;27;0;25;0
WireConnection;18;0;1;1
WireConnection;18;1;20;0
WireConnection;28;0;18;0
WireConnection;28;1;27;0
WireConnection;31;0;1;1
WireConnection;31;1;32;0
WireConnection;33;0;35;0
WireConnection;33;1;31;0
WireConnection;19;0;28;0
WireConnection;0;2;33;0
WireConnection;0;9;19;0
ASEEND*/
//CHKSM=B39A15A7A5063F31AEF7117441942F27A3FE8886