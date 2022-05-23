// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Projectile_Tail_01"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		_Trail_Texture("Trail_Texture", 2D) = "white" {}
		_Trail_UPanner("Trail_UPanner", Float) = 1
		_Trail_VPanner("Trail_VPanner", Float) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Mask_Pow("Mask_Pow", Float) = 0
		_Opacity("Opacity", Float) = 0
		_Trail_Ins("Trail_Ins", Float) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_Str("Noise_Str", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _Cull_Mode;
		uniform float4 _Tint_Color;
		uniform float _Trail_Ins;
		uniform float _Opacity;
		uniform sampler2D _Trail_Texture;
		uniform float _Trail_UPanner;
		uniform float _Trail_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Trail_Texture_ST;
		uniform float _Mask_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = ( ( _Tint_Color * _Trail_Ins ) * i.vertexColor ).rgb;
			float2 appendResult8 = (float2(_Trail_UPanner , _Trail_VPanner));
			float2 appendResult30 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner27 = ( 1.0 * _Time.y * appendResult30 + uv0_Noise_Texture);
			float2 uv0_Trail_Texture = i.uv_texcoord * _Trail_Texture_ST.xy + _Trail_Texture_ST.zw;
			float2 panner5 = ( 1.0 * _Time.y * appendResult8 + (( ( (UnpackNormal( tex2D( _Noise_Texture, panner27 ) )).xy * _Noise_Str ) + uv0_Trail_Texture )*1.0 + 0.0));
			o.Alpha = ( i.vertexColor.a * saturate( ( _Opacity * ( tex2D( _Trail_Texture, panner5 ) * pow( i.uv_texcoord.x , _Mask_Pow ) ) ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;2;1920;1014;3592.475;498.5567;1.802147;True;False
Node;AmplifyShaderEditor.RangedFloatNode;29;-3834.86,96.80466;Float;False;Property;_Noise_VPanner;Noise_VPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-3840.961,5.595529;Float;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;30;-3591.937,15.49647;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-3822.36,-214.9265;Float;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;27;-3427.121,-197.3248;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;25;-3063.884,-214.9265;Float;True;Property;_Noise_Texture;Noise_Texture;8;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;31;-2723.347,-218.8299;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2615.038,-13.61278;Float;False;Property;_Noise_Str;Noise_Str;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-2430.723,-216.9298;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2394.728,61.34353;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-2075.394,83.29541;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1859.264,248.3004;Float;False;Property;_Trail_UPanner;Trail_UPanner;2;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1861.723,324.5576;Float;False;Property;_Trail_VPanner;Trail_VPanner;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;24;-1877.681,67.00256;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1608.351,283.9691;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1430.023,632.1666;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1311.947,874.4675;Float;False;Property;_Mask_Pow;Mask_Pow;5;0;Create;True;0;0;False;0;0;2.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;5;-1569.008,63.92643;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;14;-1052.426,718.2631;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1292.267,71.30617;Float;True;Property;_Trail_Texture;Trail_Texture;1;0;Create;True;0;0;False;0;76664483ba366ec4bba8c9e209074406;76664483ba366ec4bba8c9e209074406;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-647.7704,463.6619;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-518.6249,252.1098;Float;False;Property;_Opacity;Opacity;6;0;Create;True;0;0;False;0;0;1.23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-699.9628,22.19804;Float;False;Property;_Trail_Ins;Trail_Ins;7;0;Create;True;0;0;False;0;0;1.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-316.912,443.9829;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;-668.4773,-253.558;Float;False;Property;_Tint_Color;Tint_Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-373.5303,-192.2234;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;20;-311.123,110.2069;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;18;-110.2794,441.5229;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1;720.0774,14.37018;Float;False;Property;_Cull_Mode;Cull_Mode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;143.3225,425.4385;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-43.89648,-25.80669;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;3;510.568,3.331842;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Projectile_Tail_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;27;0;26;0
WireConnection;27;2;30;0
WireConnection;25;1;27;0
WireConnection;31;0;25;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;34;0;32;0
WireConnection;34;1;10;0
WireConnection;24;0;34;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;5;0;24;0
WireConnection;5;2;8;0
WireConnection;14;0;12;1
WireConnection;14;1;15;0
WireConnection;4;1;5;0
WireConnection;13;0;4;0
WireConnection;13;1;14;0
WireConnection;16;0;17;0
WireConnection;16;1;13;0
WireConnection;23;0;11;0
WireConnection;23;1;22;0
WireConnection;18;0;16;0
WireConnection;21;0;20;4
WireConnection;21;1;18;0
WireConnection;19;0;23;0
WireConnection;19;1;20;0
WireConnection;3;2;19;0
WireConnection;3;9;21;0
ASEEND*/
//CHKSM=1614836C9F54288BC5F940BDFD9260F03FA7DEFB