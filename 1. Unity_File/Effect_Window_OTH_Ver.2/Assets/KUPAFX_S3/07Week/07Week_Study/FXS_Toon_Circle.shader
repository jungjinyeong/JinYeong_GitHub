// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX_Study/Toon_CircleDissolve"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Rot("Rot", Float) = 1
		_Main_VPanner("Main_VPanner", Float) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_SmoothMin("SmoothMin", Range( 0 , 1)) = 0
		_SmoothMax("SmoothMax", Range( 0 , 1)) = 0
		_Main_Tex_Val("Main_Tex_Val", Range( 0 , 1)) = 0
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Rot;
		uniform float _Main_Tex_Val;
		uniform float _SmoothMin;
		uniform float _SmoothMax;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult34 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 appendResult30 = (float2(( uv_Main_Texture.x + ( uv_Main_Texture.y * _Rot ) ) , uv_Main_Texture.y));
			float2 panner31 = ( 1.0 * _Time.y * appendResult34 + appendResult30);
			float4 tex2DNode1 = tex2D( _Main_Texture, panner31 );
			o.Emission = ( i.vertexColor * ( _Main_Color * saturate( ( tex2DNode1.r + ( 1.0 - _Main_Tex_Val ) ) ) ) ).rgb;
			float smoothstepResult35 = smoothstep( _SmoothMin , _SmoothMax , ( tex2DNode1.r + _Dissolve ));
			o.Alpha = ( i.vertexColor.a * smoothstepResult35 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
7;66;1920;953;1810.88;527.666;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;28;-1348.684,186.6664;Inherit;False;Property;_Rot;Rot;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1400.984,-67.63358;Inherit;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1166.684,62.66643;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-1120.684,-119.3336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-923.9214,141.0458;Inherit;False;Property;_Main_UPanner;Main_UPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-932.9214,217.0457;Inherit;False;Property;_Main_VPanner;Main_VPanner;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-979.5837,-90.43356;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-736.9214,159.0458;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;31;-722.9214,-14.95426;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-436.8805,-109.666;Inherit;False;Property;_Main_Tex_Val;Main_Tex_Val;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;43;-99.88049,-172.666;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-501.8127,-422.7176;Inherit;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;39;7.119511,-346.666;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-530.8127,161.2824;Inherit;False;Property;_Dissolve;Dissolve;1;0;Create;True;0;0;0;False;0;False;0;0.097;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;41;248.1195,-285.666;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-150.6974,278.0122;Inherit;False;Property;_SmoothMax;SmoothMax;7;0;Create;True;0;0;0;False;0;False;0;0.512;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-212.8127,-18.71754;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;126.894,-539.2122;Inherit;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.1981132,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-149.6974,197.0122;Inherit;False;Property;_SmoothMin;SmoothMin;6;0;Create;True;0;0;0;False;0;False;0;0.419;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;35;110.1636,-11.53707;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;433.1195,-305.666;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;44;457.12,-494.666;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;680.12,-484.666;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;789.12,-72.66602;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1018,-256;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;KUPAFX_Study/Toon_CircleDissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;26;2
WireConnection;27;1;28;0
WireConnection;29;0;26;1
WireConnection;29;1;27;0
WireConnection;30;0;29;0
WireConnection;30;1;26;2
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;31;0;30;0
WireConnection;31;2;34;0
WireConnection;43;0;40;0
WireConnection;1;1;31;0
WireConnection;39;0;1;1
WireConnection;39;1;43;0
WireConnection;41;0;39;0
WireConnection;2;0;1;1
WireConnection;2;1;3;0
WireConnection;35;0;2;0
WireConnection;35;1;36;0
WireConnection;35;2;37;0
WireConnection;38;0;19;0
WireConnection;38;1;41;0
WireConnection;45;0;44;0
WireConnection;45;1;38;0
WireConnection;46;0;44;4
WireConnection;46;1;35;0
WireConnection;0;2;45;0
WireConnection;0;9;46;0
ASEEND*/
//CHKSM=D9306318F2102C24AF0529A8FD17324DB02FD9AF