// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LJU/Sword_Trail_Shader"
{
	Properties
	{
		_Trail_Tex("Trail_Tex", 2D) = "white" {}
		_Trail_UV("Trail_UV", Vector) = (1,1,0,0)
		_Tile_Tex("Tile_Tex", 2D) = "white" {}
		_Tile_UV("Tile_UV", Vector) = (1,1,0,0)
		_Tile_Str("Tile_Str", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Tile_Tex;
		uniform float4 _Tile_UV;
		uniform float _Tile_Str;
		uniform sampler2D _Trail_Tex;
		uniform float4 _Trail_UV;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult13 = (float2(_Tile_UV.z , _Tile_UV.w));
			float2 appendResult11 = (float2(_Tile_UV.x , _Tile_UV.y));
			float2 uv_TexCoord10 = i.uv_texcoord * appendResult11;
			float2 panner14 = ( 1.0 * _Time.y * appendResult13 + uv_TexCoord10);
			float2 appendResult4 = (float2(_Trail_UV.x , _Trail_UV.y));
			float2 appendResult5 = (float2(_Trail_UV.z , _Trail_UV.w));
			float2 uv_TexCoord2 = i.uv_texcoord * appendResult4 + appendResult5;
			float4 tex2DNode1 = tex2D( _Trail_Tex, saturate( uv_TexCoord2 ) );
			o.Emission = ( ( ( ( tex2D( _Tile_Tex, panner14 ).r * _Tile_Str ) * tex2DNode1.r ) + tex2DNode1.r ) * i.vertexColor * i.vertexColor.a ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1965;174;1450;855;1546.004;193.4816;1;True;False
Node;AmplifyShaderEditor.Vector4Node;12;-2045.32,-313.4258;Inherit;False;Property;_Tile_UV;Tile_UV;3;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;11;-1872.32,-285.4258;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;7;-1889.714,135.6782;Inherit;False;Property;_Trail_UV;Trail_UV;1;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1740.779,-308.6922;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1708.714,134.6782;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1658.32,-187.4258;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;5;-1708.714,227.6782;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-1466.435,-306.9924;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1536.174,138.4118;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;8;-1331.714,138.6783;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-928.5476,-61.70486;Inherit;False;Property;_Tile_Str;Tile_Str;4;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1233.446,-195.2037;Inherit;True;Property;_Tile_Tex;Tile_Tex;2;0;Create;True;0;0;0;False;0;False;-1;cb3db7b0a3d7e1e4cb96977896ea78b7;cb3db7b0a3d7e1e4cb96977896ea78b7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-925.5476,-165.7049;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1205.174,108.4118;Inherit;True;Property;_Trail_Tex;Trail_Tex;0;0;Create;True;0;0;0;False;0;False;-1;65b8adf8e89ff634cb54a682508d76f1;65b8adf8e89ff634cb54a682508d76f1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-786.2102,-168.1895;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-807.6343,114.7221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;19;-849.8137,229.3374;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-680.0682,114.156;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-419.0499,66.30878;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;LJU/Sword_Trail_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Transparent;;Overlay;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;5;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;12;1
WireConnection;11;1;12;2
WireConnection;10;0;11;0
WireConnection;4;0;7;1
WireConnection;4;1;7;2
WireConnection;13;0;12;3
WireConnection;13;1;12;4
WireConnection;5;0;7;3
WireConnection;5;1;7;4
WireConnection;14;0;10;0
WireConnection;14;2;13;0
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;8;0;2;0
WireConnection;9;1;14;0
WireConnection;22;0;9;1
WireConnection;22;1;23;0
WireConnection;1;1;8;0
WireConnection;18;0;22;0
WireConnection;18;1;1;1
WireConnection;29;0;18;0
WireConnection;29;1;1;1
WireConnection;30;0;29;0
WireConnection;30;1;19;0
WireConnection;30;2;19;4
WireConnection;0;2;30;0
ASEEND*/
//CHKSM=25CD6868F5E90E2BB3D7DDB3FCB9239159E1498D