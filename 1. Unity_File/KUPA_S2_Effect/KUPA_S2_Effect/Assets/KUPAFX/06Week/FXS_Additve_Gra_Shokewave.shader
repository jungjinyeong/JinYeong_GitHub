// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Additive_Gra_Shokewave"
{
	Properties
	{
		_FXT_GraTex01("FXT_GraTex01", 2D) = "white" {}
		_Gra_Offset("Gra_Offset", Range( -1 , 1)) = 0
		_Gra_Pow("Gra_Pow", Range( 1 , 20)) = 1
		[HDR]_Gra_Color("Gra_Color ", Color) = (0,0,0,0)
		_Gra_Ins("Gra_Ins", Range( 1 , 10)) = 0
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Mask_Range("Mask_Range", Range( 1 , 20)) = 8
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		[HDR]_Sub_Color("Sub_Color", Color) = (0,0,0,0)
		_Sub_Tex_Pow("Sub_Tex_Pow", Range( 1 , 10)) = 2
		_Sub_Tex_Ins("Sub_Tex_Ins", Range( 0 , 20)) = 2
		_Sub_Tex_VPanner("Sub_Tex_VPanner", Float) = 0
		_Sub_Tex_UPanner("Sub_Tex_UPanner", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float _CullMode;
		uniform sampler2D _Sub_Texture;
		uniform float _Sub_Tex_UPanner;
		uniform float _Sub_Tex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _Sub_Tex_Pow;
		uniform float _Sub_Tex_Ins;
		uniform float4 _Sub_Color;
		uniform sampler2D _FXT_GraTex01;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Val;
		uniform float4 _FXT_GraTex01_ST;
		uniform float _Gra_Offset;
		uniform float _Gra_Pow;
		uniform float _Gra_Ins;
		uniform float4 _Gra_Color;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult56 = (float2(_Sub_Tex_UPanner , _Sub_Tex_VPanner));
			float2 uv0_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner52 = ( 1.0 * _Time.y * appendResult56 + uv0_Sub_Texture);
			float2 appendResult25 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv0_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner21 = ( 1.0 * _Time.y * appendResult25 + uv0_Noise_Texture);
			float2 uv0_FXT_GraTex01 = i.uv_texcoord * _FXT_GraTex01_ST.xy + _FXT_GraTex01_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch61 = i.uv_tex4coord.z;
			#else
				float staticSwitch61 = _Gra_Offset;
			#endif
			float2 appendResult6 = (float2(0.0 , staticSwitch61));
			float4 tex2DNode1 = tex2D( _FXT_GraTex01, (( ( (UnpackNormal( tex2D( _Noise_Texture, panner21 ) )).xy * _Noise_Val ) + uv0_FXT_GraTex01 )*1.0 + appendResult6) );
			float4 temp_cast_0 = (_Gra_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( ( pow( ( ( ( ( pow( tex2D( _Sub_Texture, panner52 ).r , _Sub_Tex_Pow ) * _Sub_Tex_Ins ) * _Sub_Color ) + tex2DNode1.r ) * tex2DNode1.r ) , temp_cast_0 ) * _Gra_Ins ) * _Gra_Color ) ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( pow( ( 1.0 - abs( ( i.uv_texcoord.y - 0.5 ) ) ) , _Mask_Range ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;6;1920;1013;1971.815;651.9111;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;23;-2236,-324.5;Float;False;Property;_Noise_UPanner;Noise_UPanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2241,-246.5;Float;False;Property;_Noise_VPanner;Noise_VPanner;9;0;Create;True;0;0;False;0;0;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-2151.66,-1238.228;Float;False;1699;596.0478;Sub;13;43;45;47;50;48;44;46;42;52;56;54;55;53;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2034,-296.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2197,-529.5;Float;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;21;-1944,-463.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2101.66,-1010.18;Float;False;Property;_Sub_Tex_UPanner;Sub_Tex_UPanner;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2098.66,-945.1799;Float;False;Property;_Sub_Tex_VPanner;Sub_Tex_VPanner;15;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-1933.66,-1002.18;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-2099.969,-1188.228;Float;False;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-1741,-494.5;Float;True;Property;_Noise_Texture;Noise_Texture;6;0;Create;True;0;0;False;0;None;291b26790b4e30e43b6347b381849af8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1359,164.5;Float;False;Property;_Gra_Offset;Gra_Offset;2;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;18;-1446,-497.5;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;52;-1825.66,-1135.18;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1512,-297.5;Float;False;Property;_Noise_Val;Noise_Val;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;60;-1336.748,252.9742;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-973,58.5;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-1208,-431.5;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1267,-96.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;61;-1048.748,174.9742;Float;False;Property;_Use_Custom;Use_Custom;18;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1712.66,-889.1799;Float;False;Property;_Sub_Tex_Pow;Sub_Tex_Pow;13;0;Create;True;0;0;False;0;2;1.61;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-1675.66,-1113.18;Float;True;Property;_Sub_Texture;Sub_Texture;11;0;Create;True;0;0;False;0;68e5980af78d21e4f8e879df5d2164b5;68e5980af78d21e4f8e879df5d2164b5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;43;-1359.66,-1068.18;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-831,65.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1002,-309.5;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1429.66,-846.1799;Float;False;Property;_Sub_Tex_Ins;Sub_Tex_Ins;14;0;Create;True;0;0;False;0;2;2;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1128.66,-1065.18;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;3;-776,-103.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;41;-517.8425,479.5587;Float;False;1532.36;1072.357;Mask;15;28;32;34;35;36;37;38;26;27;29;30;31;33;40;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;48;-1090.66,-854.1799;Float;False;Property;_Sub_Color;Sub_Color;12;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-524,-282.5;Float;True;Property;_FXT_GraTex01;FXT_GraTex01;1;0;Create;True;0;0;False;0;3f5b46fe17ed58946937189037ccfc8c;61fa5133046a58942b52ff7b6d40b215;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-653.8426,838.9155;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-916.6598,-1054.18;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-413.5742,992.9556;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;-249.0565,841.2682;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-687.6598,-1000.18;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-173.6598,-462.1799;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-514,24.5;Float;False;Property;_Gra_Pow;Gra_Pow;3;0;Create;True;0;0;False;0;1;2;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;29;-14.78452,818.3217;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-207,-0.5;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-254,227.5;Float;False;Property;_Gra_Ins;Gra_Ins;5;0;Create;True;0;0;False;0;0;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;84.03239,1068.269;Float;False;Property;_Mask_Range;Mask_Range;10;0;Create;True;0;0;False;0;8;6.5;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;141.5681,818.4422;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;89,256.5;Float;False;Property;_Gra_Color;Gra_Color ;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.659126,1.143819,1.820579,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;37,-0.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;31;325.394,831.0895;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;588.046,832.7369;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;14;261,-172.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;230,-5.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-265.0882,1242.921;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;513.4091,-122.8243;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;1385.123,-117.8984;Float;False;Property;_CullMode;CullMode;17;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;419.1574,1206.916;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-432.8426,1270.916;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;102.7331,1244.438;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;809.1698,511.4378;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;-64.12228,1243.575;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;786.1574,1205.916;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1153.025,-160.4302;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;KUPAFX/Additive_Gra_Shokewave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;58;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;21;0;22;0
WireConnection;21;2;25;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;17;1;21;0
WireConnection;18;0;17;0
WireConnection;52;0;53;0
WireConnection;52;2;56;0
WireConnection;19;0;18;0
WireConnection;19;1;20;0
WireConnection;61;1;5;0
WireConnection;61;0;60;3
WireConnection;42;1;52;0
WireConnection;43;0;42;1
WireConnection;43;1;44;0
WireConnection;6;0;7;0
WireConnection;6;1;61;0
WireConnection;16;0;19;0
WireConnection;16;1;2;0
WireConnection;45;0;43;0
WireConnection;45;1;46;0
WireConnection;3;0;16;0
WireConnection;3;2;6;0
WireConnection;1;1;3;0
WireConnection;47;0;45;0
WireConnection;47;1;48;0
WireConnection;27;0;26;2
WireConnection;27;1;28;0
WireConnection;50;0;47;0
WireConnection;50;1;1;1
WireConnection;51;0;50;0
WireConnection;51;1;1;1
WireConnection;29;0;27;0
WireConnection;8;0;51;0
WireConnection;8;1;12;0
WireConnection;30;0;29;0
WireConnection;9;0;8;0
WireConnection;9;1;13;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;33;0;31;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;35;0;26;2
WireConnection;35;1;34;0
WireConnection;15;0;14;0
WireConnection;15;1;10;0
WireConnection;37;0;36;0
WireConnection;37;1;32;0
WireConnection;34;0;26;2
WireConnection;36;0;59;0
WireConnection;40;0;14;4
WireConnection;40;1;33;0
WireConnection;59;0;35;0
WireConnection;38;0;37;0
WireConnection;0;2;15;0
WireConnection;0;9;40;0
ASEEND*/
//CHKSM=68284B71A99699470294BB2020582A897991D290