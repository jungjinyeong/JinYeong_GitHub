// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FXS_Shine"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode2("CullMode", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Src2("Src", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_Dst2("Dst", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 0.5)) = 0.1705882
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode2]
		ZWrite Off
		Blend [_Src2] [_Dst2]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _Src2;
		uniform float _Dst2;
		uniform float _CullMode2;
		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult30 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult41 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner42 = ( 1.0 * _Time.y * appendResult41 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner26 = ( 1.0 * _Time.y * appendResult30 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner42 ) )).xy * _Noise_Str ) + uv_Main_Texture ));
			float temp_output_22_0 = ( ( pow( saturate( ( 1.0 - i.uv_texcoord.y ) ) , 1.7 ) * pow( ( 1.0 - abs( ( i.uv_texcoord.x - 0.5 ) ) ) , 12.0 ) ) * saturate( ( i.uv_texcoord.y * 6.0 ) ) );
			float temp_output_24_0 = ( ( tex2D( _Main_Texture, panner26 ).r + temp_output_22_0 ) * temp_output_22_0 );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_24_0 ) ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_24_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;90;1920;929;935.485;536.6706;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;43;-2738.254,-1050.492;Inherit;False;1216.25;383.25;Noise;9;34;36;35;33;38;42;39;40;41;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2684.254,-859.2423;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2688.254,-783.2423;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-2641.254,-999.2423;Inherit;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;41;-2522.254,-814.2423;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;42;-2423.004,-985.4923;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-2355.674,-28.42677;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-2271.674,299.5732;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-2250.004,-1000.492;Inherit;True;Property;_Noise_Texture;Noise_Texture;8;0;Create;True;0;0;0;False;0;False;-1;1dbf1177420b46f47b20959a7c02ae71;82d7a1f26ef85f048b76b9dcc08c906b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;-2114.674,34.57326;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;34;-1962.004,-1000.492;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;8;-1907.674,34.57326;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-2080.674,-236.4268;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2045.004,-794.4923;Inherit;False;Property;_Noise_Str;Noise_Str;9;0;Create;True;0;0;0;False;0;False;0.1705882;0.023;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1569.723,-359.2789;Inherit;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;0;False;0;False;0;-0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;10;-1735.674,34.57326;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1565.723,-435.2789;Inherit;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1684.004,-991.4923;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1714.674,412.5732;Inherit;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1674.723,-621.2789;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;16;-1921.674,-239.4268;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1755.674,-141.4268;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;1.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1736.674,280.5732;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;13;-1560.674,-235.4268;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1563.674,375.5732;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-1403.723,-390.2789;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;11;-1555.674,34.57326;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-1470.004,-651.4923;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1277.674,-46.42676;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-1362.674,370.5732;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;26;-1239.723,-547.2789;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-990.1383,-44.65219;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-1011.723,-408.2789;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;44;-636.4854,-357.6706;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;32;-224.6242,-649.91;Inherit;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;4.094159,2.452633,1.139412,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-349.3472,-57.26779;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1;480,-155.75;Inherit;False;241;282;Enum;3;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;45;-56.48499,-362.6706;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-87.4614,-139.2342;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2;515,-48.75;Inherit;False;Property;_Src2;Src;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;516,25.25;Inherit;False;Property;_Dst2;Dst;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;509,-122.75;Inherit;False;Property;_CullMode2;CullMode;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;177.515,-394.6706;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;92.51501,123.3294;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;254,-160;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;FXS_Shine;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;2;10;True;4;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;3;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;41;0;39;0
WireConnection;41;1;40;0
WireConnection;42;0;38;0
WireConnection;42;2;41;0
WireConnection;33;1;42;0
WireConnection;6;0;5;1
WireConnection;6;1;7;0
WireConnection;34;0;33;0
WireConnection;8;0;6;0
WireConnection;15;0;5;2
WireConnection;10;0;8;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;16;0;15;0
WireConnection;13;0;16;0
WireConnection;13;1;14;0
WireConnection;18;0;5;2
WireConnection;18;1;19;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;37;0;35;0
WireConnection;37;1;25;0
WireConnection;17;0;13;0
WireConnection;17;1;11;0
WireConnection;20;0;18;0
WireConnection;26;0;37;0
WireConnection;26;2;30;0
WireConnection;22;0;17;0
WireConnection;22;1;20;0
WireConnection;23;1;26;0
WireConnection;44;0;23;1
WireConnection;44;1;22;0
WireConnection;24;0;44;0
WireConnection;24;1;22;0
WireConnection;31;0;32;0
WireConnection;31;1;24;0
WireConnection;46;0;45;0
WireConnection;46;1;31;0
WireConnection;47;0;45;4
WireConnection;47;1;24;0
WireConnection;0;2;46;0
WireConnection;0;9;47;0
ASEEND*/
//CHKSM=5CC0A003B25D85D573CE7EA385689D121F9E2CE1