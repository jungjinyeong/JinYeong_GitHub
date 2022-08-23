// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/Spider_Vertex"
{
	Properties
	{
		_FXT_Spider_Tex("FXT_Spider_Tex", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_VertexNormal_Str("VertexNormal_Str", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _VertexNormal_Str;
		uniform sampler2D _FXT_Spider_Tex;
		uniform float4 _FXT_Spider_Tex_ST;
		uniform float _Opacity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 temp_cast_0 = (0.5).xx;
			v.vertex.xyz += ( ( ase_vertexNormal * pow( ( 1.0 - length( ( ( v.texcoord.xy - temp_cast_0 ) * 2.0 ) ) ) , 4.0 ) ) * _VertexNormal_Str );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color3 = IsGammaSpace() ? float4(0.2776789,0.8172126,0.9056604,0) : float4(0.06266929,0.6334141,0.7986599,0);
			o.Emission = color3.rgb;
			float2 uv_FXT_Spider_Tex = i.uv_texcoord * _FXT_Spider_Tex_ST.xy + _FXT_Spider_Tex_ST.zw;
			o.Alpha = ( tex2D( _FXT_Spider_Tex, uv_FXT_Spider_Tex ).r * _Opacity );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;1160.942;400.812;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1210.764,244.7836;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1168.764,514.7836;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-983.7637,525.7836;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-982.7637,298.7836;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-776.7637,295.7836;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;11;-579.7637,299.7836;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;-418.7636,291.7836;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-448.7636,500.7836;Float;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;15;-253.6659,101.297;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;13;-258.7637,289.7836;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1.679668,128.3464;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-440,-419.5;Float;True;Property;_FXT_Spider_Tex;FXT_Spider_Tex;0;0;Create;True;0;0;False;0;e61b6d1f3b5a38449b7e7e950f773f0a;e61b6d1f3b5a38449b7e7e950f773f0a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-434,-125.5;Float;False;Property;_Opacity;Opacity;1;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-61.47269,457.2097;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;2;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;28,-358.5;Float;False;Constant;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;0.2776789,0.8172126,0.9056604,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-137,-142.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;227.5283,128.3464;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;385,-318;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/Spider_Vertex;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;16;0;15;0
WireConnection;16;1;13;0
WireConnection;4;0;1;1
WireConnection;4;1;5;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;0;2;3;0
WireConnection;0;9;4;0
WireConnection;0;11;17;0
ASEEND*/
//CHKSM=D378A2AC46C9BD7872C218F6D310EF0F293A3783