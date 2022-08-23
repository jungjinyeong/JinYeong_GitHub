// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Smoke_Real"
{
	Properties
	{
		_Smoke_Texture("Smoke_Texture", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Emi_Offset("Emi_Offset", Range( -1 , 1)) = 0
		_Texture0("Texture 0", 2D) = "bump" {}
		[HDR]_Emi_UPColor("Emi_UPColor", Color) = (0.2814426,0,1,0)
		_Emi_DownColor("Emi_DownColor", Color) = (1,0,0,0)
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_TextureSample4("Texture Sample 4", 2D) = "bump" {}
		_Fade_Distance("Fade_Distance", Range( 0 , 5)) = 0
		_Emi_Brigthness("Emi_Brigthness", Range( 1 , 10)) = 0
		_Rot("Rot", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 screenPos;
		};

		uniform float4 _Emi_DownColor;
		uniform sampler2D _Main_Texture;
		uniform sampler2D _TextureSample4;
		uniform float4 _Emi_UPColor;
		uniform float _Emi_Brigthness;
		uniform sampler2D _Texture0;
		uniform float _Emi_Offset;
		uniform sampler2D _Smoke_Texture;
		uniform float _Rot;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Dissolve;
		uniform float _Opacity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner80 = ( 1.0 * _Time.y * float2( 0,-0.05 ) + i.uv_texcoord);
			float2 temp_output_79_0 = ( ( (UnpackNormal( tex2D( _TextureSample4, panner80 ) )).xy * 0.05 ) + i.uv_texcoord );
			float2 panner64 = ( 1.0 * _Time.y * float2( 0,-0.1 ) + temp_output_79_0);
			float2 panner65 = ( 1.0 * _Time.y * float2( 0,-0.05 ) + temp_output_79_0);
			float temp_output_68_0 = ( tex2D( _Main_Texture, panner64 ).r * tex2D( _Main_Texture, panner65 ).r );
			float VertexTexcord_Y103 = i.uv2_tex4coord2.y;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch97 = VertexTexcord_Y103;
			#else
				float staticSwitch97 = _Emi_Brigthness;
			#endif
			float2 panner54 = ( 1.0 * _Time.y * float2( 0,-0.1 ) + (i.uv_texcoord*float2( 2,1 ) + 0.0));
			float2 break47 = ( ( (UnpackNormal( tex2D( _Texture0, panner54 ) )).xy * 0.05 ) + i.uv_texcoord );
			float VertexTexcord_X102 = i.uv2_tex4coord2.x;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch96 = VertexTexcord_X102;
			#else
				float staticSwitch96 = _Emi_Offset;
			#endif
			float4 appendResult43 = (float4(break47.x , saturate( ( break47.y + staticSwitch96 ) ) , 0.0 , 0.0));
			float4 temp_cast_0 = (0.5).xxxx;
			float3 appendResult37 = (float3(( ( appendResult43 - temp_cast_0 ) * 2.0 ).xy , 1.0));
			float3 viewToObjDir39 = mul( UNITY_MATRIX_T_MV, float4( appendResult37, 0 ) ).xyz;
			float4 lerpResult28 = lerp( ( _Emi_DownColor * temp_output_68_0 ) , ( ( temp_output_68_0 * _Emi_UPColor ) * staticSwitch97 ) , saturate( viewToObjDir39.y ));
			o.Emission = ( i.vertexColor * lerpResult28 ).rgb;
			float2 panner20 = ( 1.0 * _Time.y * float2( 0,-0.05 ) + (i.uv_texcoord*float2( 1,0.5 ) + 0.0));
			float2 temp_cast_3 = (0.5).xx;
			float VertexTexcord_T105 = i.uv2_tex4coord2.w;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch99 = VertexTexcord_T105;
			#else
				float staticSwitch99 = _Rot;
			#endif
			float cos92 = cos( staticSwitch99 );
			float sin92 = sin( staticSwitch99 );
			float2 rotator92 = mul( ( i.uv_texcoord + ( (UnpackNormal( tex2D( _Texture0, panner20 ) )).xy * 0.05 ) ) - temp_cast_3 , float2x2( cos92 , -sin92 , sin92 , cos92 )) + temp_cast_3;
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 temp_cast_4 = (0.5).xx;
			float cos110 = cos( staticSwitch99 );
			float sin110 = sin( staticSwitch99 );
			float2 rotator110 = mul( uv0_Dissolve_Tex - temp_cast_4 , float2x2( cos110 , -sin110 , sin110 , cos110 )) + temp_cast_4;
			float VertexTexcord_W104 = i.uv2_tex4coord2.z;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch98 = VertexTexcord_W104;
			#else
				float staticSwitch98 = _Dissolve;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth83 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth83 = abs( ( screenDepth83 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			o.Alpha = ( i.vertexColor.a * ( saturate( ( ( tex2D( _Smoke_Texture, rotator92 ).r * ( tex2D( _Dissolve_Tex, rotator110 ).r + staticSwitch98 ) ) * _Opacity ) ) * saturate( distanceDepth83 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;3957.77;540.2621;2.523166;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-3896.956,-486.1314;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;58;-3831.603,-199.2758;Float;False;Constant;_Vector3;Vector 3;8;0;Create;True;0;0;False;0;2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;56;-3620.956,-120.1314;Float;False;Constant;_Vector2;Vector 2;8;0;Create;True;0;0;False;0;0,-0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;57;-3619.603,-347.2756;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;54;-3414.003,-252.8899;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;59;-3563.823,320.0581;Float;True;Property;_Texture0;Texture 0;5;0;Create;True;0;0;False;0;None;51fe2c9d5b236124d9f9e7ea528b0bea;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;109;-3628.969,627.866;Float;False;632.1785;969.5164;Comment;5;100;102;103;104;105;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;48;-3357.97,-535.4053;Float;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;True;0;0;False;0;None;19891385e026bce4894bf60164334a4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;100;-3621.366,990.8278;Float;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-2509.147,319.4856;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;24;-2393.147,468.4856;Float;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;1,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ComponentMaskNode;49;-3060.956,-532.1315;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-3047.956,-327.1312;Float;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;82;-3093.918,-1081.489;Float;False;Constant;_Vector7;Vector 7;10;0;Create;True;0;0;False;0;0,-0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;22;-2264.147,546.4856;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0,-0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;-2287.147,322.4856;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-2804.956,-515.1315;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;-3222.918,-1213.489;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-2701.381,-202.1515;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;102;-3240.183,677.866;Float;True;VertexTexcord_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-2544.461,25.5312;Float;False;Property;_Emi_Offset;Emi_Offset;4;0;Create;True;0;0;False;0;0;0.21;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;20;-2083.147,364.4856;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;-2502.856,132.5933;Float;True;102;VertexTexcord_X;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-2520.956,-290.1312;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;80;-2967.918,-1189.489;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;96;-2260.059,148.3729;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-1920.026,296.8774;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-2428.701,-195.1879;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;75;-2777.419,-1214.604;Float;True;Property;_TextureSample4;Texture Sample 4;9;0;Create;True;0;0;False;0;None;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-3235.791,1338.382;Float;True;VertexTexcord_T;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-1407.596,642.1052;Float;False;105;VertexTexcord_T;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;-2163.397,-48.92385;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1604.147,527.4856;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;76;-2493.419,-1204.604;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-2407.419,-1011.604;Float;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;15;-1636.147,308.4856;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1167.393,518.663;Float;False;Property;_Rot;Rot;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-2666.464,-930.775;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1806.13,942.8109;Float;False;0;9;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;93;-1157.639,447.1429;Float;False;Constant;_Float6;Float 6;12;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1379.147,154.4856;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2229.419,-1191.604;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1379.147,354.4856;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;104;-3236.791,1110.382;Float;True;VertexTexcord_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;45;-2122.55,67.19036;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;99;-1121.311,603.1971;Float;False;Property;_Use_Custom;Use_Custom;16;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-1426.868,1325.516;Float;True;104;VertexTexcord_W;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;110;-1549.617,948.8992;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;66;-1834.775,-824.8392;Float;False;Constant;_Vector4;Vector 4;8;0;Create;True;0;0;False;0;0,-0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;67;-1872.775,-522.8392;Float;False;Constant;_Vector5;Vector 5;8;0;Create;True;0;0;False;0;0,-0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;34;-1954.543,73.23823;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-2060.419,-966.6038;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-1992.966,-191.0933;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1182.083,248.8173;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1471.305,1221.717;Float;False;Property;_Dissolve;Dissolve;3;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;62;-1614.775,-828.8392;Float;True;Property;_Main_Texture;Main_Texture;8;0;Create;True;0;0;False;0;None;92ef54e4d8bc5d04389a5d64ce40dff3;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.StaticSwitch;98;-1184.398,1217.166;Float;False;Property;_Use_Custom;Use_Custom;13;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;64;-1683.775,-1039.839;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;92;-944.6365,423.016;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;65;-1630.775,-568.8392;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-1725.544,-194.7618;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1650.544,52.23823;Float;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1355.391,925.1501;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;2;0;Create;True;0;0;False;0;None;92ef54e4d8bc5d04389a5d64ce40dff3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-996.4513,949.2599;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1451.544,50.23823;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;-3239.791,897.3821;Float;True;VertexTexcord_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1307.371,-968.1286;Float;True;Property;_TextureSample2;Texture Sample 2;7;0;Create;True;0;0;False;0;None;92ef54e4d8bc5d04389a5d64ce40dff3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-787.4479,226.1997;Float;True;Property;_Smoke_Texture;Smoke_Texture;0;0;Create;True;0;0;False;0;a466d9e2abfe11c439ffdeb4cdcb4573;a466d9e2abfe11c439ffdeb4cdcb4573;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;61;-1287.775,-757.8392;Float;True;Property;_TextureSample3;Texture Sample 3;7;0;Create;True;0;0;False;0;None;92ef54e4d8bc5d04389a5d64ce40dff3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1506.544,-194.7618;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-937.7754,-890.8392;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1292.144,-195.1617;Float;True;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;31;-953.2081,-473.7602;Float;False;Property;_Emi_UPColor;Emi_UPColor;6;1;[HDR];Create;True;0;0;False;0;0.2814426,0,1,0;3.095047,2.859814,6.968742,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;101;-648.7278,0.9181519;Float;True;103;VertexTexcord_Y;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-471.3318,345.2394;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-562.7146,489.0195;Float;False;Property;_Opacity;Opacity;1;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-725.5323,-255.9996;Float;False;Property;_Emi_Brigthness;Emi_Brigthness;11;0;Create;True;0;0;False;0;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-448.629,725.256;Float;False;Property;_Fade_Distance;Fade_Distance;10;0;Create;True;0;0;False;0;0;0.52;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-314.1495,338.8807;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;39;-1071.143,-203.2618;Float;True;View;Object;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DepthFade;83;-202.629,603.256;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;-567.1081,-937.86;Float;False;Property;_Emi_DownColor;Emi_DownColor;7;0;Create;True;0;0;False;0;1,0,0,0;0.3113208,0.3113208,0.3113208,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;97;-435.0571,-87.44183;Float;False;Property;_Use_Custom;Use_Custom;15;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-670.1227,-500.9394;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;71;-819.8226,-152.6393;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-399.0226,-747.2393;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;84;27.37097,605.256;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-357.5112,-352.2041;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;7;-170.6816,334.1532;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;130.371,334.256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;89;-48.11117,-349.6041;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;28;-83.24712,-183.9716;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;69;-1971.775,-650.8392;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;159.8888,-350.9042;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;70;-2271.775,-528.8392;Float;False;Constant;_Vector6;Vector 6;8;0;Create;True;0;0;False;0;0.2,-0.35;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;324.9888,-22.00416;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;530.4,-199.2;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Smoke_Real;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;57;0;53;0
WireConnection;57;1;58;0
WireConnection;54;0;57;0
WireConnection;54;2;56;0
WireConnection;48;0;59;0
WireConnection;48;1;54;0
WireConnection;49;0;48;0
WireConnection;23;0;21;0
WireConnection;23;1;24;0
WireConnection;50;0;49;0
WireConnection;50;1;51;0
WireConnection;102;0;100;1
WireConnection;20;0;23;0
WireConnection;20;2;22;0
WireConnection;52;0;50;0
WireConnection;52;1;32;0
WireConnection;80;0;81;0
WireConnection;80;2;82;0
WireConnection;96;1;46;0
WireConnection;96;0;108;0
WireConnection;14;0;59;0
WireConnection;14;1;20;0
WireConnection;47;0;52;0
WireConnection;75;1;80;0
WireConnection;105;0;100;4
WireConnection;44;0;47;1
WireConnection;44;1;96;0
WireConnection;76;0;75;0
WireConnection;15;0;14;0
WireConnection;77;0;76;0
WireConnection;77;1;78;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;104;0;100;3
WireConnection;45;0;44;0
WireConnection;99;1;94;0
WireConnection;99;0;107;0
WireConnection;110;0;13;0
WireConnection;110;1;93;0
WireConnection;110;2;99;0
WireConnection;79;0;77;0
WireConnection;79;1;63;0
WireConnection;43;0;47;0
WireConnection;43;1;45;0
WireConnection;18;0;19;0
WireConnection;18;1;16;0
WireConnection;98;1;11;0
WireConnection;98;0;106;0
WireConnection;64;0;79;0
WireConnection;64;2;66;0
WireConnection;92;0;18;0
WireConnection;92;1;93;0
WireConnection;92;2;99;0
WireConnection;65;0;79;0
WireConnection;65;2;67;0
WireConnection;33;0;43;0
WireConnection;33;1;34;0
WireConnection;9;1;110;0
WireConnection;10;0;9;1
WireConnection;10;1;98;0
WireConnection;103;0;100;2
WireConnection;60;0;62;0
WireConnection;60;1;64;0
WireConnection;3;1;92;0
WireConnection;61;0;62;0
WireConnection;61;1;65;0
WireConnection;35;0;33;0
WireConnection;35;1;36;0
WireConnection;68;0;60;1
WireConnection;68;1;61;1
WireConnection;37;0;35;0
WireConnection;37;2;38;0
WireConnection;12;0;3;1
WireConnection;12;1;10;0
WireConnection;5;0;12;0
WireConnection;5;1;6;0
WireConnection;39;0;37;0
WireConnection;83;0;85;0
WireConnection;97;1;88;0
WireConnection;97;0;101;0
WireConnection;72;0;68;0
WireConnection;72;1;31;0
WireConnection;71;0;39;2
WireConnection;73;0;30;0
WireConnection;73;1;68;0
WireConnection;84;0;83;0
WireConnection;87;0;72;0
WireConnection;87;1;97;0
WireConnection;7;0;5;0
WireConnection;86;0;7;0
WireConnection;86;1;84;0
WireConnection;28;0;73;0
WireConnection;28;1;87;0
WireConnection;28;2;71;0
WireConnection;69;2;70;0
WireConnection;90;0;89;0
WireConnection;90;1;28;0
WireConnection;91;0;89;4
WireConnection;91;1;86;0
WireConnection;2;2;90;0
WireConnection;2;9;91;0
ASEEND*/
//CHKSM=B27FD27DDCCFD4F62BFA1895A8F05B9E89269EB3