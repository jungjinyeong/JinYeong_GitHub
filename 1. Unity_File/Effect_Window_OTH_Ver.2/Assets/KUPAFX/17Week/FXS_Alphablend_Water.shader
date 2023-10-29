// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Water"
{
	Properties
	{
		_FXT_Water01("FXT_Water01", 2D) = "white" {}
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 5)) = 0.1
		_Dissolve_Texure("Dissolve_Texure", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_FXT_Water01_Normal("FXT_Water01_Normal", 2D) = "bump" {}
		_Highlingt("Highlingt", Float) = 12
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform sampler2D _FXT_Water01_Normal;
		uniform sampler2D _Noise_Texture;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _Highlingt;
		uniform sampler2D _FXT_Water01;
		uniform float4 _Color0;
		uniform sampler2D _Dissolve_Texure;
		uniform float4 _Dissolve_Texure_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + uv0_Noise_Texture);
			float3 temp_output_4_0 = ( (UnpackNormal( tex2D( _Noise_Texture, panner8 ) )).xyz * _Noise_Str );
			float2 temp_cast_2 = (0.24).xx;
			float4 tex2DNode1 = tex2D( _FXT_Water01, ( float3( i.uv_texcoord ,  0.0 ) + temp_output_4_0 ).xy );
			o.Emission = ( i.vertexColor * ( ( saturate( ( pow( length( abs( ( (UnpackNormal( tex2D( _FXT_Water01_Normal, ( float3( i.uv_texcoord ,  0.0 ) + temp_output_4_0 ).xy ) )).xy - temp_cast_2 ) ) ) , 8.0 ) * _Highlingt ) ) + tex2DNode1.r ) * _Color0 ) ).rgb;
			float2 uv0_Dissolve_Texure = i.uv_texcoord * _Dissolve_Texure_ST.xy + _Dissolve_Texure_ST.zw;
			float2 temp_cast_6 = (0.5).xx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch30 = i.uv_tex4coord.w;
			#else
				float staticSwitch30 = 0.0;
			#endif
			float cos28 = cos( staticSwitch30 );
			float sin28 = sin( staticSwitch30 );
			float2 rotator28 = mul( uv0_Dissolve_Texure - temp_cast_6 , float2x2( cos28 , -sin28 , sin28 , cos28 )) + temp_cast_6;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch26 = i.uv_tex4coord.z;
			#else
				float staticSwitch26 = _Dissolve;
			#endif
			o.Alpha = ( ( tex2DNode1.r * saturate( ( saturate( ( pow( tex2D( _Dissolve_Texure, rotator28 ).r , 3.0 ) * 4.0 ) ) + staticSwitch26 ) ) ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-108;294;1920;685;467.8149;560.9297;1.188903;True;False
Node;AmplifyShaderEditor.Vector2Node;10;-1270,-135.5;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1340,-282.5;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;8;-1108,-243.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-910,-249.5;Float;True;Property;_Noise_Texture;Noise_Texture;1;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;3;-620.2891,-251.3368;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-684,-38.5;Float;False;Property;_Noise_Str;Noise_Str;2;0;Create;True;0;0;False;0;0.1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-373,-149.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-1190.804,-885.0524;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-891.4009,-824.4373;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1519.476,877.4797;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-1649.176,1070.979;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-742.4327,-864.1911;Float;True;Property;_FXT_Water01_Normal;FXT_Water01_Normal;7;0;Create;True;0;0;False;0;635035644f4199548a8fe4a830af641c;635035644f4199548a8fe4a830af641c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-393.9268,-661.9382;Float;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;False;0;0.24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;35;-442.9268,-863.9382;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1674.076,533.2797;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;30;-1382.776,878.5796;Float;False;Property;_Use_Custom;Use_Custom;6;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1471.276,705.9796;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1218.348,441.7429;Float;False;1425.293;410.9526;Dissolve;9;16;15;18;17;19;22;21;23;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;28;-1328.276,534.9796;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-187.9268,-853.9382;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-1168.348,491.7429;Float;True;Property;_Dissolve_Texure;Dissolve_Texure;3;0;Create;True;0;0;False;0;None;d2610227d915935429fe8720ba0f7a3c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-1065.348,675.0429;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;38;16.07324,-854.9382;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;41;251.0732,-597.9382;Float;False;Constant;_Float5;Float 5;8;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;39;184.0732,-850.9382;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-881.3479,492.0429;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-752.0548,717.6955;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-642.0549,499.6955;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-527.2552,727.5956;Float;False;Property;_Dissolve;Dissolve;5;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-425,-423.5;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;483.0732,-587.9382;Float;False;Property;_Highlingt;Highlingt;8;0;Create;True;0;0;False;0;12;12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;382.0732,-844.9382;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;587.0732,-819.9382;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-180.1632,-388.563;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;26;-177.276,920.9796;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-435.0549,498.6955;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-205.0552,511.6955;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;530.9985,-448.1046;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-82,-273.5;Float;True;Property;_FXT_Water01;FXT_Water01;0;0;Create;True;0;0;False;0;d85340c4113ea0b4293caa0dfa851044;d85340c4113ea0b4293caa0dfa851044;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;711.1411,-168.931;Float;False;Property;_Color0;Color 0;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1.454925,1.921915,2.319128,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;19;8.944719,506.6955;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;744.8696,-444.6617;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;243.0447,-94.00464;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;32;274.0389,124.222;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;975.3804,-305.7601;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;1229.938,-383.7832;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;576.9064,91.37318;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1475.63,-368.8917;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Water;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;9;0
WireConnection;8;2;10;0
WireConnection;2;1;8;0
WireConnection;3;0;2;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;45;0;44;0
WireConnection;45;1;4;0
WireConnection;34;1;45;0
WireConnection;35;0;34;0
WireConnection;30;1;31;0
WireConnection;30;0;25;4
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;28;2;30;0
WireConnection;36;0;35;0
WireConnection;36;1;37;0
WireConnection;14;1;28;0
WireConnection;38;0;36;0
WireConnection;39;0;38;0
WireConnection;15;0;14;1
WireConnection;15;1;16;0
WireConnection;21;0;15;0
WireConnection;21;1;22;0
WireConnection;40;0;39;0
WireConnection;40;1;41;0
WireConnection;42;0;40;0
WireConnection;42;1;43;0
WireConnection;7;0;6;0
WireConnection;7;1;4;0
WireConnection;26;1;18;0
WireConnection;26;0;25;3
WireConnection;23;0;21;0
WireConnection;17;0;23;0
WireConnection;17;1;26;0
WireConnection;48;0;42;0
WireConnection;1;1;7;0
WireConnection;19;0;17;0
WireConnection;49;0;48;0
WireConnection;49;1;1;1
WireConnection;20;0;1;1
WireConnection;20;1;19;0
WireConnection;47;0;49;0
WireConnection;47;1;13;0
WireConnection;50;0;32;0
WireConnection;50;1;47;0
WireConnection;33;0;20;0
WireConnection;33;1;32;4
WireConnection;0;2;50;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=D4FE788AD8F9F38ECBC601ED25838A9A83AB0077