// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Particle_Chromatic"
{
	Properties
	{
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		_Main_Power("Main_Power", Range( 1 , 10)) = 1
		[Toggle(_USE_COSTOM_ON)] _Use_Costom("Use_Costom", Float) = 0
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Texture_Obj("Texture_Obj", 2D) = "white" {}
		_Chromatic_Val("Chromatic_Val", Range( 0 , 1)) = 0.04
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _USE_COSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Texture_Obj;
		uniform float _Chromatic_Val;
		uniform float4 _Tint_Color;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 tex2DNode7 = tex2D( _Texture_Obj, i.uv_texcoord );
			float2 temp_cast_0 = (_Chromatic_Val).xx;
			float3 appendResult24 = (float3(tex2D( _Texture_Obj, ( _Chromatic_Val + i.uv_texcoord ) ).r , tex2DNode7.g , tex2D( _Texture_Obj, ( i.uv_texcoord - temp_cast_0 ) ).b));
			#ifdef _USE_COSTOM_ON
				float staticSwitch8 = i.uv_tex4coord.z;
			#else
				float staticSwitch8 = _Main_Ins;
			#endif
			o.Emission = ( float4( appendResult24 , 0.0 ) * ( _Tint_Color * ( pow( tex2DNode7.r , _Main_Power ) * staticSwitch8 ) ) * i.vertexColor ).rgb;
			o.Alpha = ( saturate( ( tex2DNode7.r * _Opacity ) ) * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2299.169;1150.171;1.736748;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2087.057,-548.6991;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;17;-1557.547,-572.0424;Float;True;Property;_Texture_Obj;Texture_Obj;5;0;Create;True;0;0;False;0;da1dd60bd611927448df56afcc0b9f08;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;-917.2021,291.5803;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1267.414,-575.9916;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;1195516317f46f34b9c06a0dee51c9a5;8e5149c69938b4f4ba79eead733e3157;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1845.976,-539.2642;Float;False;Property;_Chromatic_Val;Chromatic_Val;6;0;Create;True;0;0;False;0;0.04;0.04;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1013.609,25.96217;Float;False;Property;_Main_Power;Main_Power;2;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-993.1172,175.7056;Float;False;Property;_Main_Ins;Main_Ins;1;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-334.0629,156.8065;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;1;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;8;-582.6369,226.4742;Float;False;Property;_Use_Costom;Use_Costom;3;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-607.056,-192.0384;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-1548.226,-800.5186;Float;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;21;-1542.866,-312.6671;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-29.06287,49.80652;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-292.7027,-192.2151;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1266.651,-326.8264;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;1195516317f46f34b9c06a0dee51c9a5;8e5149c69938b4f4ba79eead733e3157;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-1262.014,-819.0778;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;1195516317f46f34b9c06a0dee51c9a5;8e5149c69938b4f4ba79eead733e3157;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-308.7519,-441.1765;Float;False;Property;_Tint_Color;Tint_Color;0;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.568627,0.454902,0.2509804,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-42.05602,-194.0384;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;16;260.465,53.45831;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;12;22.10785,382.7875;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;24;-30.17432,-802.7269;Float;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;326.8637,-233.0803;Float;True;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;500.4655,74.45831;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;778,-181;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alphablend_Particle_Chromatic;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;17;0
WireConnection;7;1;3;0
WireConnection;8;1;5;0
WireConnection;8;0;1;3
WireConnection;9;0;7;1
WireConnection;9;1;6;0
WireConnection;20;0;23;0
WireConnection;20;1;3;0
WireConnection;21;0;3;0
WireConnection;21;1;23;0
WireConnection;13;0;7;1
WireConnection;13;1;14;0
WireConnection;10;0;9;0
WireConnection;10;1;8;0
WireConnection;18;0;17;0
WireConnection;18;1;21;0
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;11;0;4;0
WireConnection;11;1;10;0
WireConnection;16;0;13;0
WireConnection;24;0;19;1
WireConnection;24;1;7;2
WireConnection;24;2;18;3
WireConnection;2;0;24;0
WireConnection;2;1;11;0
WireConnection;2;2;12;0
WireConnection;15;0;16;0
WireConnection;15;1;12;4
WireConnection;0;2;2;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=DF4ECFD414445E149A685DA5B23531FB1EB9BA6F