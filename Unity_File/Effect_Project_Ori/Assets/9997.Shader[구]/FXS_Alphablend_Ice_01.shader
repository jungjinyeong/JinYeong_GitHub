// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Ice_01"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_Cull_Mode("Cull_Mode", Float) = 0
		_Ice_Texure("Ice_Texure", 2D) = "white" {}
		_Ice_Tex_Normal("Ice_Tex_Normal", 2D) = "bump" {}
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 0 , 10)) = 1.836505
		_Normal_Scale("Normal_Scale", Range( 0 , 3)) = 1
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (2.55,1,0,0)
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Parallax_Tex("Parallax_Tex", 2D) = "white" {}
		_Parallax_Scale("Parallax_Scale", Range( -10 , 10)) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve_Val("Dissolve_Val", Range( -0.2 , 1)) = 1
		_Dissolve_UPanner("Dissolve_UPanner", Float) = 0
		_Dissolve_VPanner("Dissolve_VPanner", Float) = 0
		_Ice_Tex_VPanner("Ice_Tex_VPanner", Float) = 0
		_Ice_Tex_UPanner("Ice_Tex_UPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float _Cull_Mode;
		uniform float4 _Fresnel_Color;
		uniform float _Normal_Scale;
		uniform sampler2D _Ice_Tex_Normal;
		uniform float4 _Ice_Tex_Normal_ST;
		uniform float2 _Vector0;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Ice_Texure;
		uniform float _Ice_Tex_UPanner;
		uniform float _Ice_Tex_VPanner;
		uniform float4 _Ice_Texure_ST;
		uniform sampler2D _Parallax_Tex;
		uniform float4 _Parallax_Tex_ST;
		uniform float _Parallax_Scale;
		uniform float4 _Tint_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve_Val;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv0_Ice_Tex_Normal = i.uv_texcoord * _Ice_Tex_Normal_ST.xy + _Ice_Tex_Normal_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch53 = i.uv_tex4coord.x;
			#else
				float staticSwitch53 = _Fresnel_Pow;
			#endif
			float fresnelNdotV4 = dot( UnpackScaleNormal( tex2D( _Ice_Tex_Normal, (uv0_Ice_Tex_Normal*_Vector0 + 0.0) ), _Normal_Scale ), i.viewDir );
			float fresnelNode4 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV4, staticSwitch53 ) );
			float2 appendResult44 = (float2(_Ice_Tex_UPanner , _Ice_Tex_VPanner));
			float2 uv0_Ice_Texure = i.uv_texcoord * _Ice_Texure_ST.xy + _Ice_Texure_ST.zw;
			float2 uv0_Parallax_Tex = i.uv_texcoord * _Parallax_Tex_ST.xy + _Parallax_Tex_ST.zw;
			float2 Offset21 = ( ( tex2D( _Parallax_Tex, uv0_Parallax_Tex ).r - 1 ) * i.viewDir.xy * _Parallax_Scale ) + uv0_Ice_Texure;
			float2 panner43 = ( 1.0 * _Time.y * appendResult44 + (Offset21*1.0 + float2( 2,2 )));
			o.Emission = ( i.vertexColor * ( ( _Fresnel_Color * saturate( fresnelNode4 ) ) + ( tex2D( _Ice_Texure, panner43 ) * _Tint_Color ) ) ).rgb;
			float2 appendResult40 = (float2(_Dissolve_UPanner , _Dissolve_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner38 = ( 1.0 * _Time.y * appendResult40 + uv0_Dissolve_Texture);
			float2 temp_cast_1 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch52 = i.uv_tex4coord.w;
			#else
				float staticSwitch52 = 0.0;
			#endif
			float cos49 = cos( staticSwitch52 );
			float sin49 = sin( staticSwitch52 );
			float2 rotator49 = mul( panner38 - temp_cast_1 , float2x2( cos49 , -sin49 , sin49 , cos49 )) + temp_cast_1;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch47 = i.uv_tex4coord.z;
			#else
				float staticSwitch47 = _Dissolve_Val;
			#endif
			float4 temp_cast_2 = (staticSwitch47).xxxx;
			o.Alpha = ( i.vertexColor.a * step( tex2D( _Dissolve_Texture, rotator49 ) , temp_cast_2 ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;2560;1011;2327.171;350.4566;2.266621;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-1605.201,560;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1084.373,-602.9885;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1317.2,336;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;22;-1221.2,896;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;23;-1349.201,544;Float;True;Property;_Parallax_Tex;Parallax_Tex;9;0;Create;True;0;0;False;0;4f599298d22bf8047b38f3bd26dad4c7;4f599298d22bf8047b38f3bd26dad4c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1301.2,768;Float;False;Property;_Parallax_Scale;Parallax_Scale;10;0;Create;True;0;0;False;0;0;0.9;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;15;-1066.172,-394.9887;Float;False;Property;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;2.55,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;48;-325.4561,930.8701;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-442.5744,747.2579;Float;False;Property;_Ice_Tex_VPanner;Ice_Tex_VPanner;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-440.9746,608.0573;Float;False;Property;_Ice_Tex_UPanner;Ice_Tex_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;21;-885.2004,544;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;42;99.2,870.3999;Float;False;Property;_Dissolve_VPanner;Dissolve_VPanner;14;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-806.1716,-491.1886;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-464.333,212.2083;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;4;0;Create;True;0;0;False;0;1.836505;0.35;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;67.2,774.3999;Float;False;Property;_Dissolve_UPanner;Dissolve_UPanner;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;29;-789.2003,752;Float;False;Constant;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;2,2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;11;-759.8439,-227.1845;Float;False;Property;_Normal_Scale;Normal_Scale;5;0;Create;True;0;0;False;0;1;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-465.6332,96.50828;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;3;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;10;-351.2339,-127.0918;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;51;562.02,853.4965;Float;False;Constant;_Float1;Float 1;18;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;26;-629.2004,544;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;355.2,790.3999;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;138.7156,553.2944;Float;False;0;33;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;53;-155.3197,137.6876;Float;False;Property;_Use_Custom;Use_Custom;17;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;44;-200.9738,520.0573;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;3;-469.248,-398.9739;Float;True;Property;_Ice_Tex_Normal;Ice_Tex_Normal;2;0;Create;True;0;0;False;0;1612e87ed21a8af4080fd48ab7954cae;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;52;742.7197,775.4966;Float;False;Property;_Use_Custom;Use_Custom;17;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;4;-24.69543,-140.0594;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;43;-125.7739,278.4575;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;545.12,750.7966;Float;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;38;467.2,614.3999;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;101.7277,120.1881;Float;True;Property;_Ice_Texure;Ice_Texure;1;0;Create;True;0;0;False;0;1fd0a24bca365a343912d72c2c55ea4f;3a67505ded26145ecbbafc32f569f643;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;7;265.5321,-138.3195;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;200.7323,360.8511;Float;False;Property;_Tint_Color;Tint_Color;8;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;18;268.38,-411.1338;Float;False;Property;_Fresnel_Color;Fresnel_Color;6;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.8584906,0.4452738,0.2146226,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;1099.671,683.9312;Float;False;Property;_Dissolve_Val;Dissolve_Val;12;0;Create;True;0;0;False;0;1;1;-0.2;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;49;836.2236,527.5995;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;47;1372.194,850.3196;Float;False;Property;_Use_Custom;Use_Custom;17;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;463.2514,-165.0556;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;448.8543,115.7542;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;33;1079.676,439.0399;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;11;0;Create;True;0;0;False;0;c3ec6f776be501a4db757961359756df;c3ec6f776be501a4db757961359756df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;31;721.9543,-377.5014;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;685.1487,-159.366;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;34;1466.281,436.1984;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1473.163,-79.06261;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1;2143.948,-260.6324;Float;True;Property;_Cull_Mode;Cull_Mode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;961.6444,-179.3326;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1796.453,-292.5687;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Ice_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;1;30;0
WireConnection;21;0;24;0
WireConnection;21;1;23;1
WireConnection;21;2;25;0
WireConnection;21;3;22;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;26;0;21;0
WireConnection;26;2;29;0
WireConnection;40;0;41;0
WireConnection;40;1;42;0
WireConnection;53;1;9;0
WireConnection;53;0;48;1
WireConnection;44;0;46;0
WireConnection;44;1;45;0
WireConnection;3;1;14;0
WireConnection;3;5;11;0
WireConnection;52;1;51;0
WireConnection;52;0;48;4
WireConnection;4;0;3;0
WireConnection;4;4;10;0
WireConnection;4;2;8;0
WireConnection;4;3;53;0
WireConnection;43;0;26;0
WireConnection;43;2;44;0
WireConnection;38;0;37;0
WireConnection;38;2;40;0
WireConnection;2;1;43;0
WireConnection;7;0;4;0
WireConnection;49;0;38;0
WireConnection;49;1;50;0
WireConnection;49;2;52;0
WireConnection;47;1;35;0
WireConnection;47;0;48;3
WireConnection;17;0;18;0
WireConnection;17;1;7;0
WireConnection;19;0;2;0
WireConnection;19;1;20;0
WireConnection;33;1;49;0
WireConnection;16;0;17;0
WireConnection;16;1;19;0
WireConnection;34;0;33;0
WireConnection;34;1;47;0
WireConnection;36;0;31;4
WireConnection;36;1;34;0
WireConnection;32;0;31;0
WireConnection;32;1;16;0
WireConnection;0;2;32;0
WireConnection;0;9;36;0
ASEEND*/
//CHKSM=7024DA7F902C8B01EAF97738E5D07A2DBA46F1A9