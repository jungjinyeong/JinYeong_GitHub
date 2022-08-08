// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additve_Particle"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 1
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,1)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Fade_Distance("Fade_Distance", Range( 0 , 10)) = 0
		_Float0("Float 0", Float) = 4
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform float _Float0;
		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Fade_Distance;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (0.5).xx;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( pow( ( 1.0 - length( ( v.texcoord.xy - temp_cast_0 ) ) ) , 9.67 ) * ( ase_vertexNormal * _Float0 ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float3 temp_cast_0 = (_Main_Pow).xxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch12 = i.uv_tex4coord.z;
			#else
				float staticSwitch12 = _Main_Ins;
			#endif
			o.Emission = ( ( _Tint_Color * float4( ( pow( (tex2D( _Main_Texture, uv0_Main_Texture )).rgb , temp_cast_0 ) * staticSwitch12 ) , 0.0 ) ) * i.vertexColor ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth14 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth14 = abs( ( screenDepth14 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Fade_Distance ) );
			o.Alpha = ( i.vertexColor.a * saturate( distanceDepth14 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1886;-11;1920;927;195.787;763.6956;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1155.697,-673.7924;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;1151.013,16.30444;Float;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;896.0737,-141.4288;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-892,-671.5;Float;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;False;0;b32ac9c7987c0714b9a0509bf57063c1;eecf53c160cb9e84cb84617588f73625;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;18;-583.101,-682.7089;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;13;-581.9496,-155.4652;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-601,-232.5;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;1;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;1239.413,-142.2956;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-701,-376.5;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-64.94995,-36.46521;Float;False;Property;_Fade_Distance;Fade_Distance;6;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;12;-309.9496,-181.4652;Float;False;Property;_Use_Custom;Use_Custom;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-365,-545.5;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;24;1353.812,-139.6956;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;1538.413,-159.1956;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;19;588.9739,149.8712;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;817.9739,288.8712;Float;False;Property;_Float0;Float 0;7;0;Create;True;0;0;False;0;4;-0.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-120.6969,-722.7924;Float;False;Property;_Tint_Color;Tint_Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-47,-509.5;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;29;1460.413,249.0045;Float;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;False;0;9.67;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;14;179.05,-134.4652;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;10;306.3031,-413.7924;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;1187.974,181.8712;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;134.3031,-568.7924;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;17;413.05,-132.4652;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;28;1637.212,43.60446;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;575.05,-222.4652;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;470.3031,-611.7924;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1968.674,150.5712;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1549.999,-641.29;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additve_Particle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;1;9;0
WireConnection;18;0;1;0
WireConnection;25;0;22;0
WireConnection;25;1;26;0
WireConnection;12;1;4;0
WireConnection;12;0;13;3
WireConnection;2;0;18;0
WireConnection;2;1;6;0
WireConnection;24;0;25;0
WireConnection;27;0;24;0
WireConnection;3;0;2;0
WireConnection;3;1;12;0
WireConnection;14;0;16;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;7;0;8;0
WireConnection;7;1;3;0
WireConnection;17;0;14;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;15;0;10;4
WireConnection;15;1;17;0
WireConnection;11;0;7;0
WireConnection;11;1;10;0
WireConnection;23;0;28;0
WireConnection;23;1;20;0
WireConnection;0;2;11;0
WireConnection;0;9;15;0
WireConnection;0;11;23;0
ASEEND*/
//CHKSM=B088286CC5196E0EF6A1F575D495FDF367A7B5A4