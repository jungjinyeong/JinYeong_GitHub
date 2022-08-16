// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Alphablend_Shiled"
{
	Properties
	{
		_Fade_Distance("Fade_Distance", Range( 0 , 1)) = 0
		_Line_Texture("Line_Texture", 2D) = "white" {}
		[HDR]_Fade_Color_A("Fade_Color_A", Color) = (0,0,0,0)
		_Opacity("Opacity", Range( -1 , 1)) = 1
		[HDR]_Line_Color("Line_Color", Color) = (1,1,1,0)
		[HDR]_InColor("InColor", Color) = (0.02830189,0.02830189,0.02830189,0)
		[HDR]_OutColor("OutColor", Color) = (1,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 2.270588
		_Noise_Texutre("Noise_Texutre", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 3)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0.1
		_Noise_Sub_Texture("Noise_Sub_Texture", 2D) = "white" {}
		[Toggle(_USE_VERTEXNORMAL_OFFSET_ON)] _Use_VertexNormal_Offset("Use_VertexNormal_Offset", Float) = 0
		_Vertex_Normal_Str("Vertex_Normal_Str", Range( 0 , 5)) = 0
		_Wave_Count("Wave_Count", Float) = 4.64
		_Time_Scale("Time_Scale", Float) = 0
		[HDR]_VertexNormal_Color("VertexNormal_Color", Color) = (0,0,0,0)
		_Vertexnormal_Offset("Vertexnormal_Offset", Float) = 0
		[Toggle(_VERTEXNORMAL_TEXTURE_ON)] _VertexNormal_Texture("VertexNormal_Texture", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Cullmode("Cullmode", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_Cullmode]
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _VERTEXNORMAL_TEXTURE_ON
		#pragma shader_feature _USE_VERTEXNORMAL_OFFSET_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 screenPos;
			float2 uv2_texcoord2;
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform float _Cullmode;
		uniform float _Time_Scale;
		uniform float _Vertexnormal_Offset;
		uniform float _Wave_Count;
		uniform sampler2D _Noise_Sub_Texture;
		uniform float4 _Noise_Sub_Texture_ST;
		uniform float _Vertex_Normal_Str;
		uniform float4 _Fade_Color_A;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;
		uniform sampler2D _GrabTexture;
		uniform float _Normal_Scale;
		uniform sampler2D _Noise_Texutre;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texutre_ST;
		uniform float4 _InColor;
		uniform float4 _OutColor;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Line_Texture;
		uniform float4 _Line_Color;
		uniform float4 _VertexNormal_Color;
		uniform float _Opacity;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime44 = _Time.y * _Time_Scale;
			#ifdef _USE_VERTEXNORMAL_OFFSET_ON
				float staticSwitch59 = _Vertexnormal_Offset;
			#else
				float staticSwitch59 = mulTime44;
			#endif
			float temp_output_51_0 = saturate( sin( ( ( v.texcoord1.xy.y + staticSwitch59 ) * _Wave_Count ) ) );
			float2 appendResult66 = (float2(0.0 , 0.15));
			float2 uv1_Noise_Sub_Texture = v.texcoord1.xy * _Noise_Sub_Texture_ST.xy + _Noise_Sub_Texture_ST.zw;
			float2 panner62 = ( 1.0 * _Time.y * appendResult66 + uv1_Noise_Sub_Texture);
			#ifdef _VERTEXNORMAL_TEXTURE_ON
				float staticSwitch67 = tex2Dlod( _Noise_Sub_Texture, float4( panner62, 0, 0.0) ).r;
			#else
				float staticSwitch67 = temp_output_51_0;
			#endif
			v.vertex.xyz += ( ( ase_vertexNormal * staticSwitch67 ) * _Vertex_Normal_Str );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_cast_0 = (0.0).xxxx;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth76 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth76 = abs( ( screenDepth76 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			float4 lerpResult79 = lerp( _Fade_Color_A , temp_cast_0 , saturate( distanceDepth76 ));
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 appendResult33 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv1_Noise_Texutre = i.uv2_texcoord2 * _Noise_Texutre_ST.xy + _Noise_Texutre_ST.zw;
			float2 panner31 = ( 1.0 * _Time.y * appendResult33 + uv1_Noise_Texutre);
			float4 screenColor24 = tex2D( _GrabTexture, ( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _Noise_Texutre, panner31 ), _Normal_Scale ) , 0.0 ) ).xy );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV8 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode8 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV8, _Fresnel_Pow ) );
			float4 lerpResult19 = lerp( _InColor , _OutColor , saturate( fresnelNode8 ));
			float mulTime44 = _Time.y * _Time_Scale;
			#ifdef _USE_VERTEXNORMAL_OFFSET_ON
				float staticSwitch59 = _Vertexnormal_Offset;
			#else
				float staticSwitch59 = mulTime44;
			#endif
			float temp_output_51_0 = saturate( sin( ( ( i.uv2_texcoord2.y + staticSwitch59 ) * _Wave_Count ) ) );
			o.Emission = ( lerpResult79 + ( ( screenColor24 + ( lerpResult19 + ( tex2D( _Line_Texture, i.uv_texcoord ).r * _Line_Color ) ) ) + ( temp_output_51_0 * _VertexNormal_Color ) ) ).rgb;
			o.Alpha = saturate( ( i.uv2_texcoord2.y + _Opacity ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;18;1920;1001;2792.173;244.2203;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;56;-2630.487,-126.7015;Float;False;2447.252;666.0556;VertexNormal;14;42;44;48;59;43;46;58;41;52;50;53;51;49;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2451.486,190.9388;Float;False;Property;_Time_Scale;Time_Scale;18;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-2647.769,-1790.353;Float;False;1557.566;513;Grab;10;28;25;27;26;24;30;31;33;34;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-2284.401,316.7636;Float;False;Property;_Vertexnormal_Offset;Vertexnormal_Offset;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;44;-2259.375,197.2279;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2549.769,-1467.353;Float;False;Property;_Noise_UPanner;Noise_UPanner;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;22;-2576.361,-1243.761;Float;False;1290.639;1060.31;Comment;8;21;20;19;17;9;16;8;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;59;-2006.927,254.7542;Float;False;Property;_Use_VertexNormal_Offset;Use_VertexNormal_Offset;15;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2556.769,-1393.353;Float;False;Property;_Noise_VPanner;Noise_VPanner;13;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-2202.375,-75.77198;Float;True;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1720.375,-2.771958;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-2375.769,-1481.353;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-2597.769,-1740.353;Float;True;1;27;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-2508.361,-754.5331;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;9;0;Create;True;0;0;False;0;2.270588;2.270588;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;68;-1687.209,427.868;Float;False;1072.307;440.3066;Comment;7;61;60;67;62;64;65;66;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1416.375,219.2279;Float;False;Property;_Wave_Count;Wave_Count;17;0;Create;True;0;0;False;0;4.64;6.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2495.716,-835.5954;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;8;-2086.715,-863.5954;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2145.218,-1407.437;Float;False;Property;_Normal_Scale;Normal_Scale;11;0;Create;True;0;0;False;0;0;0.45;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1294.073,-767.1202;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;-1623.355,673.1746;Float;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1524.375,13.22806;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;31;-2218.769,-1613.353;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1614.355,752.1746;Float;False;Constant;_Float1;Float 1;18;0;Create;True;0;0;False;0;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-685.845,-1930.115;Float;False;1181.644;709;DepthFade_Color;6;75;76;77;79;80;84;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;61;-1637.209,515.3519;Float;False;1;60;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GrabScreenPosition;25;-1799.248,-1727.231;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-1849.218,-1529.437;Float;True;Property;_Noise_Texutre;Noise_Texutre;10;0;Create;True;0;0;False;0;f99cd2cad01a9ec4c9f1d25eebf10402;f99cd2cad01a9ec4c9f1d25eebf10402;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;17;-1781.632,-864.8105;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1025.755,-765.3922;Float;True;Property;_Line_Texture;Line_Texture;2;0;Create;True;0;0;False;0;8e986a13ebb04cc4fbd8ca991fb97fdd;f6f245eb1afedf243965e586e867b780;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-938.8465,-574.9844;Float;False;Property;_Line_Color;Line_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2.996078,1.882353,0.7843137,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-1840.55,-1017.761;Float;False;Property;_OutColor;OutColor;7;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0.1248237,0.3477232,0.5676507,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;-1837.55,-1193.761;Float;False;Property;_InColor;InColor;6;1;[HDR];Create;True;0;0;False;0;0.02830189,0.02830189,0.02830189,0;0.07691573,0.03163938,0.08490568,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;49;-1318.376,7.228042;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1468.355,716.1746;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-710.1346,-758.7705;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;19;-1538.946,-1016.153;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;51;-1126.606,78.98079;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-632.845,-1550.926;Float;False;Property;_Fade_Distance;Fade_Distance;1;0;Create;True;0;0;False;0;0;0.49;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1498.932,-1537.688;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;62;-1373.355,531.1746;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;55;-868.1699,-374.0352;Float;False;Property;_VertexNormal_Color;VertexNormal_Color;19;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,0.6988453,0.2122642,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;24;-1286.204,-1536.826;Float;False;Global;_GrabScreen0;Grab Screen 0;6;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;76;-325.2011,-1476.115;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1204.707,515.3473;Float;True;Property;_Noise_Sub_Texture;Noise_Sub_Texture;14;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-447.7962,-1033.188;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;74;688.9422,106.306;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-193.6064,-543.6201;Float;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-212.9449,-1041.932;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;41;-909.7278,-87.75988;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-84.24628,-705.9751;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-379.9097,-410.1425;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;67;-906.9021,477.868;Float;False;Property;_VertexNormal_Texture;VertexNormal_Texture;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;77;-67.20111,-1475.115;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-47.04565,-1689.463;Float;False;Constant;_Float2;Float 2;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;80;-99.20111,-1880.115;Float;False;Property;_Fade_Color_A;Fade_Color_A;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;38;106.3938,-638.6201;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;137.7827,-1003.504;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-747.9525,226.5054;Float;False;Property;_Vertex_Normal_Str;Vertex_Normal_Str;16;0;Create;True;0;0;False;0;0;0.65;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-600.1713,-23.53118;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;73;-23.66355,-58.51443;Float;False;740.0391;430;이미션에다가 넣으세요;4;69;71;70;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2526.361,-633.5331;Float;False;940.0002;415;예시;5;11;12;13;14;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;79;230.7989,-1831.115;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;15;-1846.361,-562.5331;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;69;27.33645,-8.514435;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;71;26.33645,183.4856;Float;False;Property;_Vertex_Dir;Vertex_Dir;22;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;70;304.3672,92.97832;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;85;-2282.534,386.2543;Float;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;40;306.394,-636.6201;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;844.8859,-807.2023;Float;False;Property;_Cullmode;Cullmode;23;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;12;-2476.361,-443.5331;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;82;337.8752,-1112.517;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;13;-2245.361,-537.5331;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-407.2305,103.549;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;14;-2041.361,-538.5331;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;72;551.3755,80.59329;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;11;-2426.361,-583.5331;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;545.778,-907.6604;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Alphablend_Shiled;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;86;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;44;0;48;0
WireConnection;59;1;44;0
WireConnection;59;0;58;0
WireConnection;43;0;42;2
WireConnection;43;1;59;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;8;2;9;0
WireConnection;8;3;16;0
WireConnection;45;0;43;0
WireConnection;45;1;46;0
WireConnection;31;0;30;0
WireConnection;31;2;33;0
WireConnection;27;1;31;0
WireConnection;27;5;28;0
WireConnection;17;0;8;0
WireConnection;4;1;7;0
WireConnection;49;0;45;0
WireConnection;66;0;64;0
WireConnection;66;1;65;0
WireConnection;5;0;4;1
WireConnection;5;1;6;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;19;2;17;0
WireConnection;51;0;49;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;62;0;61;0
WireConnection;62;2;66;0
WireConnection;24;0;26;0
WireConnection;76;0;75;0
WireConnection;60;1;62;0
WireConnection;23;0;19;0
WireConnection;23;1;5;0
WireConnection;74;0;51;0
WireConnection;29;0;24;0
WireConnection;29;1;23;0
WireConnection;54;0;74;0
WireConnection;54;1;55;0
WireConnection;67;1;51;0
WireConnection;67;0;60;1
WireConnection;77;0;76;0
WireConnection;38;0;37;2
WireConnection;38;1;39;0
WireConnection;57;0;29;0
WireConnection;57;1;54;0
WireConnection;50;0;41;0
WireConnection;50;1;67;0
WireConnection;79;0;80;0
WireConnection;79;1;84;0
WireConnection;79;2;77;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;70;0;69;0
WireConnection;70;1;71;0
WireConnection;40;0;38;0
WireConnection;82;0;79;0
WireConnection;82;1;57;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;52;0;50;0
WireConnection;52;1;53;0
WireConnection;14;0;13;0
WireConnection;72;0;70;0
WireConnection;0;2;82;0
WireConnection;0;9;40;0
WireConnection;0;11;52;0
ASEEND*/
//CHKSM=53018762DBB9D52EE847DD67B7B247628A43608F