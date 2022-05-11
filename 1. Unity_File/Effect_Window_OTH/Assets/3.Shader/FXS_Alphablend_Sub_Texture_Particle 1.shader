// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Sub_Texture_Particle"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Power("Main_Power", Range( 0 , 10)) = 1.936796
		_Main_UOffset("Main_UOffset", Float) = 0
		_Main_VOffset("Main_VOffset", Float) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 0.5294118
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_Sub_Pow("Sub_Pow", Float) = 1
		_Sub_Ins("Sub_Ins", Float) = 1
		_Sub_Texture_VPanner("Sub_Texture_VPanner", Float) = 0
		_Sub_Texture_UPanner("Sub_Texture_UPanner", Float) = 0
		[HDR]_Sub_Color("Sub_Color", Color) = (1,1,1,0)
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cull_Mode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float _Cull_Mode;
		uniform float4 _Tint_Color;
		uniform sampler2D _Sub_Texture;
		uniform float _Sub_Texture_UPanner;
		uniform float _Sub_Texture_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Sub_Pow;
		uniform float _Sub_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_UOffset;
		uniform float _Main_VOffset;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult29 = (float2(_Sub_Texture_UPanner , _Sub_Texture_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult29 + uv0_Sub_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch38 = i.uv_tex4coord.w;
			#else
				float staticSwitch38 = _Main_VOffset;
			#endif
			float2 appendResult36 = (float2(_Main_UOffset , staticSwitch38));
			float4 tex2DNode7 = tex2D( _Main_Texture, (uv0_Main_Texture*1.0 + appendResult36) );
			float4 temp_cast_0 = (_Main_Power).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch8 = i.uv_tex4coord.z;
			#else
				float staticSwitch8 = _Main_Ins;
			#endif
			o.Emission = ( ( _Tint_Color * ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner25 ).r , _Sub_Pow ) * _Sub_Ins ) * _Sub_Color ) + tex2DNode7.r ) * tex2DNode7.r ) , temp_cast_0 ) * staticSwitch8 ) ) * i.vertexColor ).rgb;
			o.Alpha = ( saturate( ( tex2DNode7.r * _Opacity ) ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;14;1920;1001;3509.394;738.2557;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-3457.483,-478.8932;Float;False;Property;_Sub_Texture_UPanner;Sub_Texture_UPanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3457.484,-346.2572;Float;False;Property;_Sub_Texture_VPanner;Sub_Texture_VPanner;10;0;Create;True;0;0;False;0;0;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-3178.813,-434.6812;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-3403.57,-685.6154;Float;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;25;-3050.196,-682.5363;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2643.127,41.45398;Float;False;Property;_Main_VOffset;Main_VOffset;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;-2660.19,252.4788;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2658.591,-466.7079;Float;False;Property;_Sub_Pow;Sub_Pow;8;0;Create;True;0;0;False;0;1;0.77;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-2757.5,-685.9395;Float;True;Property;_Sub_Texture;Sub_Texture;7;0;Create;True;0;0;False;0;None;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-2392.546,-64.5073;Float;False;Property;_Main_UOffset;Main_UOffset;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;38;-2424.258,47.61576;Float;False;Property;_Use_Custom;Use_Custom;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-2213.529,-39.44486;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2368.795,-297.4807;Float;False;0;7;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-2386.946,-462.0151;Float;False;Property;_Sub_Ins;Sub_Ins;9;0;Create;True;0;0;False;0;1;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;-2432.043,-688.8416;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;-2169.748,-929.4641;Float;False;Property;_Sub_Color;Sub_Color;12;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2.240674,2.116163,1.765059,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-2194.535,-682.0103;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;37;-2032.721,-230.9935;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1778.353,-257.0653;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;b32ac9c7987c0714b9a0509bf57063c1;c2413ef1a54da374ab4fc98b50b8ef17;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1920.873,-678.1618;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1400.014,-489.6224;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1164.566,-338.4151;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1248.083,-6.917818;Float;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;False;0;1.936796;1.52;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1254.872,188.3336;Float;False;Property;_Main_Ins;Main_Ins;2;0;Create;True;0;0;False;0;1;1.9;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-334.0629,156.8065;Float;False;Property;_Opacity;Opacity;6;0;Create;True;0;0;False;0;0.5294118;0.32;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-838.0419,-214.6086;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;8;-860.7935,199.0087;Float;False;Property;_Use_Custom;Use_Custom;15;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-29.06287,49.80652;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-523.6876,-214.7852;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;4;-512.4003,-463.7466;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.2103062,0.2666024,0.3207547,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-273.0405,-216.6085;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;12;22.10785,382.7875;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;16;260.465,53.45831;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;243.4998,-189.6615;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;500.4655,74.45831;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;1013.967,-160.4639;Float;False;Property;_Cull_Mode;Cull_Mode;13;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;778,-181;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Sub_Texture_Particle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;32;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;26;0
WireConnection;29;1;27;0
WireConnection;25;0;18;0
WireConnection;25;2;29;0
WireConnection;17;1;25;0
WireConnection;38;1;35;0
WireConnection;38;0;1;4
WireConnection;36;0;34;0
WireConnection;36;1;38;0
WireConnection;19;0;17;1
WireConnection;19;1;21;0
WireConnection;20;0;19;0
WireConnection;20;1;22;0
WireConnection;37;0;3;0
WireConnection;37;2;36;0
WireConnection;7;1;37;0
WireConnection;30;0;20;0
WireConnection;30;1;31;0
WireConnection;23;0;30;0
WireConnection;23;1;7;1
WireConnection;24;0;23;0
WireConnection;24;1;7;1
WireConnection;9;0;24;0
WireConnection;9;1;6;0
WireConnection;8;1;5;0
WireConnection;8;0;1;3
WireConnection;13;0;7;1
WireConnection;13;1;14;0
WireConnection;10;0;9;0
WireConnection;10;1;8;0
WireConnection;11;0;4;0
WireConnection;11;1;10;0
WireConnection;16;0;13;0
WireConnection;2;0;11;0
WireConnection;2;1;12;0
WireConnection;15;0;16;0
WireConnection;15;1;12;4
WireConnection;0;2;2;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=311D819FD25F83DD3F72D17090A2517F32182D11