// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additve_Sword_Edge_2"
{
	Properties
	{
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Sword_UOffset("Sword_UOffset", Range( -1 , 1)) = 0
		_Sword_VOffset("Sword_VOffset", Range( -1 , 1)) = 0
		_Edge_Range("Edge_Range", Range( -1 , 1)) = -0.9176471
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_Edge_Ins("Edge_Ins", Range( 1 , 10)) = 1
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
		_Mask_Ins("Mask_Ins", Float) = 1
		_Mask_Pow("Mask_Pow", Float) = 1
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_UPanner("Noise_UPanner", Float) = 1
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_Val("Noise_Val", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_texcoord2;
		};

		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float _Edge_Range;
		uniform sampler2D _Sword_Texture;
		uniform float4 _Sword_Texture_ST;
		uniform float _Sword_UOffset;
		uniform float _Sword_VOffset;
		uniform float _Edge_Ins;
		uniform float4 _Edge_Color;
		uniform sampler2D _Dissolve_Texture;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float _Mask_Pow;
		uniform float _Mask_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult52 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner49 = ( 1.0 * _Time.y * appendResult52 + uv_Noise_Texture);
			float temp_output_4_0 = ( ( ( (UnpackNormal( tex2D( _Noise_Texture, panner49 ) )).x * _Noise_Val ) + i.uv_texcoord.y ) + _Edge_Range );
			float2 uv_Sword_Texture = i.uv_texcoord * _Sword_Texture_ST.xy + _Sword_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch44 = i.uv2_texcoord2.x;
			#else
				float staticSwitch44 = _Sword_UOffset;
			#endif
			#ifdef _USE_CUSTOM_ON
				float staticSwitch45 = i.uv2_texcoord2.y;
			#else
				float staticSwitch45 = _Sword_VOffset;
			#endif
			float2 appendResult43 = (float2(staticSwitch44 , staticSwitch45));
			#ifdef _USE_CUSTOM_ON
				float staticSwitch27 = i.uv2_texcoord2.z;
			#else
				float staticSwitch27 = _Edge_Ins;
			#endif
			float2 appendResult22 = (float2(1.0 , 0.0));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner18 = ( 1.0 * _Time.y * appendResult22 + uv_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch28 = i.uv2_texcoord2.w;
			#else
				float staticSwitch28 = _Dissolve;
			#endif
			o.Emission = ( i.vertexColor * ( ( ( ( ( saturate( temp_output_4_0 ) * tex2D( _Sword_Texture, (uv_Sword_Texture*1.0 + appendResult43) ) ) * staticSwitch27 ) * _Edge_Color ) * saturate( ( tex2D( _Dissolve_Texture, panner18 ) + staticSwitch28 ) ) ) * ( pow( ( saturate( ( ( i.uv_texcoord.x * 1.0 ) * ( 1.0 - i.uv_texcoord.x ) ) ) * 4.0 ) , _Mask_Pow ) * _Mask_Ins ) ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;73;1085;711;471.6786;-683.9091;1.360589;True;False
Node;AmplifyShaderEditor.RangedFloatNode;51;-2488.127,-697.8506;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-2490.127,-766.8506;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2394.619,-972.0806;Inherit;False;0;48;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;52;-2232.127,-758.8506;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;49;-2077.127,-955.8506;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;48;-1835.522,-984.9187;Inherit;True;Property;_Noise_Texture;Noise_Texture;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;26;-1752.259,839.756;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;-1954.94,332.1903;Inherit;False;Property;_Sword_VOffset;Sword_VOffset;2;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1414.414,-726.3106;Inherit;False;Property;_Noise_Val;Noise_Val;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1927.424,175.0557;Inherit;False;Property;_Sword_UOffset;Sword_UOffset;1;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;55;-1513.6,-975.5637;Inherit;True;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-1257.753,-969.453;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1324.101,-598.678;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;45;-1540.631,311.815;Float;False;Property;_Use_Custom;Use_Custom;9;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;44;-1517.372,199.871;Float;False;Property;_Use_Custom;Use_Custom;14;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1400.505,-110.327;Inherit;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-843.7255,-209.0397;Float;False;Property;_Edge_Range;Edge_Range;3;0;Create;True;0;0;0;False;0;False;-0.9176471;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1046.365,710.558;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1067.165,580.5581;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-801.5281,-658.6195;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-1345.157,260.1592;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-335.8656,1246.531;Inherit;False;Constant;_Float2;Float 2;9;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-543.4005,1155.46;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-194.7606,1128.491;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;40;-1031.921,-11.09523;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;30;-173.0522,1372.712;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-461.7513,-381.0396;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-837.0645,576.6583;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-1074.964,406.3583;Inherit;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;38.2621,1222.075;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;18;-674.5645,386.8581;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-525.8667,642.9915;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;0;False;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;46;-180.4455,-375.9402;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-458,25.5;Inherit;True;Property;_Sword_Texture;Sword_Texture;0;0;Create;True;0;0;0;False;0;False;-1;7b081e079f7aa9c43b1de5daf2815f96;7b081e079f7aa9c43b1de5daf2815f96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-64.83519,50.47409;Float;False;Property;_Edge_Ins;Edge_Ins;5;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-469.1646,375.1581;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;6;0;Create;True;0;0;0;False;0;False;-1;8d21b35fab1359d4aa689ddf302e1b01;d66bfe10b05fc6e46b051b9afca6d29b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;62;271.203,1236.309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;27;194.5198,165.6967;Float;False;Property;_Use_Custom;Use_Custom;12;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;89.24861,-373.0396;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;28;-119.6097,668.4446;Float;False;Property;_Use_Custom;Use_Custom;7;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;471,121.5;Float;False;Property;_Edge_Color;Edge_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0.9559475,0.3814134,0.275197,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;436.1408,1237.033;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;436,-230.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;247.0785,406.9989;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;36;498.4651,1451.102;Inherit;False;Property;_Mask_Pow;Mask_Pow;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;780.4005,1460.096;Inherit;False;Property;_Mask_Ins;Mask_Ins;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;35;688.4169,1240.356;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;703,-207.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;16;460.2794,412.1986;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;965.5459,1231.358;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1003.735,336.1582;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;25;1007.89,-27.48312;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1305.15,318.4683;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;7;-224.7514,-607.0397;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;1575.706,-16.62298;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1849.598,-32.11003;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;OTH/Additve_Sword_Edge_2;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;15;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;49;0;47;0
WireConnection;49;2;52;0
WireConnection;48;1;49;0
WireConnection;55;0;48;0
WireConnection;58;0;55;0
WireConnection;58;1;59;0
WireConnection;45;1;42;0
WireConnection;45;0;26;2
WireConnection;44;1;41;0
WireConnection;44;0;26;1
WireConnection;56;0;58;0
WireConnection;56;1;3;2
WireConnection;43;0;44;0
WireConnection;43;1;45;0
WireConnection;31;0;29;1
WireConnection;31;1;32;0
WireConnection;40;0;12;0
WireConnection;40;2;43;0
WireConnection;30;0;29;1
WireConnection;4;0;56;0
WireConnection;4;1;5;0
WireConnection;22;0;19;0
WireConnection;22;1;20;0
WireConnection;33;0;31;0
WireConnection;33;1;30;0
WireConnection;18;0;17;0
WireConnection;18;2;22;0
WireConnection;46;0;4;0
WireConnection;1;1;40;0
WireConnection;13;1;18;0
WireConnection;62;0;33;0
WireConnection;27;1;9;0
WireConnection;27;0;26;3
WireConnection;6;0;46;0
WireConnection;6;1;1;0
WireConnection;28;1;15;0
WireConnection;28;0;26;4
WireConnection;34;0;62;0
WireConnection;8;0;6;0
WireConnection;8;1;27;0
WireConnection;14;0;13;0
WireConnection;14;1;28;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;10;0;8;0
WireConnection;10;1;11;0
WireConnection;16;0;14;0
WireConnection;37;0;35;0
WireConnection;37;1;38;0
WireConnection;23;0;10;0
WireConnection;23;1;16;0
WireConnection;39;0;23;0
WireConnection;39;1;37;0
WireConnection;7;1;4;0
WireConnection;24;0;25;0
WireConnection;24;1;39;0
WireConnection;0;2;24;0
WireConnection;0;9;25;4
ASEEND*/
//CHKSM=4B440EA6933213C1AA9CA13FDADF853F186E6B26