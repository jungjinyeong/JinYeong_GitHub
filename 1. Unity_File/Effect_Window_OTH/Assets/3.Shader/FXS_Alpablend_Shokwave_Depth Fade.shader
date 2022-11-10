// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alpablend_Shokwave_Depth Fade"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_Mani_Ins("Mani_Ins", Range( 0 , 20)) = 0
		_Main_Pow("Main_Pow", Range( 0 , 10)) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 1
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 1
		_Opacity("Opacity", Range( 0 , 10)) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Rang("Mask_Rang", Range( 0 , 20)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 1
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Main_UVPow("Main_UVPow", Range( -10 , 10)) = 2.5
		[Toggle(_USE_COSTUM_ON)] _Use_Costum("Use_Costum", Float) = 0
		_DepthFade("Depth Fade", Float) = 1.46
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_COSTUM_ON
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

		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_UVPow;
		uniform float _Main_Pow;
		uniform float _Mani_Ins;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;
		uniform float _Mask_Rang;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthFade;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult4 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult37 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner38 = ( 1.0 * _Time.y * appendResult37 + uv0_Noise_Texture);
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			#ifdef _USE_COSTUM_ON
				float staticSwitch69 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch69 = _Main_UVPow;
			#endif
			float2 appendResult59 = (float2(uv0_Main_Texture.x , pow( uv0_Main_Texture.y , staticSwitch69 )));
			float2 panner3 = ( 1.0 * _Time.y * appendResult4 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner38 ) )).xy * _Noise_Val ) + appendResult59 ));
			float4 tex2DNode1 = tex2D( _Main_Texture, panner3 );
			#ifdef _USE_COSTUM_ON
				float staticSwitch68 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch68 = _Mani_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( _Tint_Color * saturate( ( pow( tex2DNode1.r , _Main_Pow ) * staticSwitch68 ) ) ) ).rgb;
			float2 appendResult54 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv0_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner51 = ( 1.0 * _Time.y * appendResult54 + uv0_Dissolve_Texture);
			#ifdef _USE_COSTUM_ON
				float staticSwitch70 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch70 = _Dissolve;
			#endif
			float2 uv0_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			float4 temp_cast_1 = (_Mask_Rang).xxxx;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth76 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth76 = abs( ( screenDepth76 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade ) );
			o.Alpha = ( i.vertexColor.a * ( ( ( ( tex2DNode1.r * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, panner51 ).r + staticSwitch70 ) ) ) * pow( tex2D( _Mask_Texture, uv0_Mask_Texture ) , temp_cast_1 ) ) * saturate( distanceDepth76 ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;224;1920;1011;3390.355;641.5273;1.807679;True;False
Node;AmplifyShaderEditor.CommentaryNode;65;-3631.336,-775.689;Float;False;1755.008;479.5198;Noise;9;31;32;33;35;36;29;37;38;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-3581.336,-412.1692;Float;False;Property;_Noise_VPanner;Noise_VPanner;15;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3579.774,-527.814;Float;False;Property;_Noise_UPanner;Noise_UPanner;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-3372.337,-472.1279;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-3577.945,-725.689;Float;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;66;-2960.292,-263.7592;Float;False;1122.97;460.9331;UV_Pow;5;57;69;59;56;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;38;-3103.154,-681.6486;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2904.292,-67.87184;Float;False;Property;_Main_UVPow;Main_UVPow;17;0;Create;True;0;0;False;0;2.5;1;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;67;-2839.746,328.7803;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-2830.606,-626.2556;Float;True;Property;_Noise_Texture;Noise_Texture;13;0;Create;True;0;0;False;0;None;291b26790b4e30e43b6347b381849af8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2629.219,-220.7592;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;69;-2603.151,-23.9259;Float;False;Property;_Use_Costum;Use_Costum;18;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;-1807.209,407.8734;Float;False;1581.082;516.6813;Dissolve;10;52;53;54;50;51;44;46;45;48;70;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;32;-2424.586,-623.2144;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;56;-2305.374,-89.82613;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2440.611,-417.2419;Float;False;Property;_Noise_Val;Noise_Val;16;0;Create;True;0;0;False;0;0;0.03;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1754.209,808.5547;Float;False;Property;_Diss_VPanner;Diss_VPanner;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-1757.209,703.5547;Float;False;Property;_Diss_UPanner;Diss_UPanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1696.686,-322.853;Float;False;Property;_Main_UPanner;Main_UPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-2111.328,-629.2971;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-1998.322,-203.646;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1680.686,-210.8533;Float;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;54;-1545.209,745.5547;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;50;-1678.025,481.9291;Float;False;0;44;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;51;-1342.75,516.509;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1303.625,736.3364;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1712.686,-578.853;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1472.686,-274.8531;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;70;-957.1476,765.6197;Float;False;Property;_Use_Costum;Use_Costum;18;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;64;-1034.148,18.47377;Float;False;1341.239;357.3011;Opacity;4;10;11;23;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;44;-1094.677,457.8734;Float;True;Property;_Dissolve_Texture;Dissolve_Texture;6;0;Create;True;0;0;False;0;None;03344d3d32e85af4faf109e635145a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-1264.686,-482.8531;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1044.412,-507.9814;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-984.1482,85.27376;Float;False;Property;_Opacity;Opacity;10;0;Create;True;0;0;False;0;1;0.61;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-644.9334,-253.0573;Float;False;Property;_Mani_Ins;Mani_Ins;2;0;Create;True;0;0;False;0;0;2.3;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-1285.681,1050.052;Float;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-679.5822,-358.1393;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;1;0.22;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-705.2769,460.8803;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-377.3201,-610.6446;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;68;-349.3812,-195.9921;Float;False;Property;_Use_Costum;Use_Costum;18;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;-424.1269,463.8873;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-661.1483,71.47379;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-878.7266,1053.607;Float;True;Property;_Mask_Texture;Mask_Texture;11;0;Create;True;0;0;False;0;None;c2413ef1a54da374ab4fc98b50b8ef17;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;77;20.36487,494.791;Float;False;Property;_DepthFade;Depth Fade;19;0;Create;True;0;0;False;0;1.46;4.22;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-858.8285,1327.516;Float;False;Property;_Mask_Rang;Mask_Rang;12;0;Create;True;0;0;False;0;0;1.33;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-263.9999,78.47038;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;76;195.7228,427.319;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;42;-476.3682,1067.568;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-67.28686,-361.1256;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;156.2759,-601.8932;Float;False;Property;_Tint_Color;Tint_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;5.691391,2.811057,6.548836,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;75;175.8539,-358.7784;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;78.49021,126.5748;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;79;473.8008,386.0589;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;28;-1900.94,1561.55;Float;False;1742.445;642.7472;Mask;8;12;15;14;16;21;17;19;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;415.923,91.70938;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;398.6624,-405.6607;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;60;487.7538,-602.1336;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1154.262,1860.168;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1480.744,1611.55;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-909.3303,2084.744;Float;False;Constant;_Mask_Rang2;Mask_Rang2;7;0;Create;True;0;0;False;0;0;13.55;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-356.4954,1860.168;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;750.9168,-548.0728;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;19;-591.4542,1857.436;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1850.94,1742.689;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;15;-1430.202,1909.346;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-875.5905,1858.802;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;639.3729,8.226037;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1147.342,-211.992;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Alpablend_Shokwave_Depth Fade;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;35;0
WireConnection;37;1;36;0
WireConnection;38;0;29;0
WireConnection;38;2;37;0
WireConnection;31;1;38;0
WireConnection;69;1;57;0
WireConnection;69;0;67;3
WireConnection;32;0;31;0
WireConnection;56;0;2;2
WireConnection;56;1;69;0
WireConnection;33;0;32;0
WireConnection;33;1;34;0
WireConnection;59;0;2;1
WireConnection;59;1;56;0
WireConnection;54;0;52;0
WireConnection;54;1;53;0
WireConnection;51;0;50;0
WireConnection;51;2;54;0
WireConnection;30;0;33;0
WireConnection;30;1;59;0
WireConnection;4;0;5;0
WireConnection;4;1;7;0
WireConnection;70;1;46;0
WireConnection;70;0;67;2
WireConnection;44;1;51;0
WireConnection;3;0;30;0
WireConnection;3;2;4;0
WireConnection;1;1;3;0
WireConnection;45;0;44;1
WireConnection;45;1;70;0
WireConnection;8;0;1;1
WireConnection;8;1;9;0
WireConnection;68;1;25;0
WireConnection;68;0;67;1
WireConnection;48;0;45;0
WireConnection;10;0;1;1
WireConnection;10;1;11;0
WireConnection;40;1;39;0
WireConnection;49;0;10;0
WireConnection;49;1;48;0
WireConnection;76;0;77;0
WireConnection;42;0;40;0
WireConnection;42;1;43;0
WireConnection;24;0;8;0
WireConnection;24;1;68;0
WireConnection;75;0;24;0
WireConnection;23;0;49;0
WireConnection;23;1;42;0
WireConnection;79;0;76;0
WireConnection;78;0;23;0
WireConnection;78;1;79;0
WireConnection;26;0;27;0
WireConnection;26;1;75;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;14;0;12;2
WireConnection;22;0;19;0
WireConnection;61;0;60;0
WireConnection;61;1;26;0
WireConnection;19;0;17;0
WireConnection;19;1;21;0
WireConnection;15;0;12;2
WireConnection;17;0;16;0
WireConnection;62;0;60;4
WireConnection;62;1;78;0
WireConnection;0;2;61;0
WireConnection;0;9;62;0
ASEEND*/
//CHKSM=EC54A12814CA19C5FDE8767C796E79497CC33646