// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Additive_Beam"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_Tex_UPanner("Main_Tex_UPanner", Float) = 0
		_Main_Tex_VPanner("Main_Tex_VPanner", Float) = 0
		[HDR]_Tint_Color("Tint_Color", Color) = (1,1,1,0)
		_VertexMomal_Texture("VertexMomal_Texture", 2D) = "white" {}
		_VertexMomal_UPanner("VertexMomal_UPanner", Float) = 0
		_VertexMomal_VPanner("VertexMomal_VPanner", Float) = 0
		_VertexMomal_Str("VertexMomal_Str", Float) = 0
		_Chromatic("Chromatic", Range( 0 , 0.1)) = 0
		_Mask_Val("Mask_Val", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _VertexMomal_Texture;
		uniform float _VertexMomal_UPanner;
		uniform float _VertexMomal_VPanner;
		uniform float4 _VertexMomal_Texture_ST;
		uniform float _VertexMomal_Str;
		uniform float4 _Tint_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_Tex_UPanner;
		uniform float _Main_Tex_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Chromatic;
		uniform float _Mask_Val;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult26 = (float2(_VertexMomal_UPanner , _VertexMomal_VPanner));
			float2 uv0_VertexMomal_Texture = v.texcoord.xy * _VertexMomal_Texture_ST.xy + _VertexMomal_Texture_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult26 + uv0_VertexMomal_Texture);
			v.vertex.xyz += ( ( float4( ase_vertexNormal , 0.0 ) * tex2Dlod( _VertexMomal_Texture, float4( panner23, 0, 0.0) ) ) * _VertexMomal_Str ).rgb;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult17 = (float2(_Main_Tex_UPanner , _Main_Tex_VPanner));
			float2 uv0_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner14 = ( 1.0 * _Time.y * appendResult17 + uv0_Main_Texture);
			float2 temp_cast_0 = (_Chromatic).xx;
			float3 appendResult11 = (float3(tex2D( _Main_Texture, ( panner14 + _Chromatic ) ).r , tex2D( _Main_Texture, panner14 ).g , tex2D( _Main_Texture, ( panner14 - temp_cast_0 ) ).b));
			o.Emission = ( i.vertexColor * ( _Tint_Color * float4( appendResult11 , 0.0 ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * pow( ( saturate( ( saturate( ( 1.0 - i.uv_texcoord.y ) ) * i.uv_texcoord.y ) ) * 4.0 ) , _Mask_Val ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1920;229;1920;1005;3158.963;850.5571;3.388167;True;False
Node;AmplifyShaderEditor.CommentaryNode;40;-2066.38,-315.3702;Float;False;1962.071;801.3235;채널 분리하기;15;2;9;5;4;3;15;16;7;17;14;8;10;11;12;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-445.1832,1097.404;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2016.38,27.78625;Float;False;Property;_Main_Tex_UPanner;Main_Tex_UPanner;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2007.514,164.3234;Float;False;Property;_Main_Tex_VPanner;Main_Tex_VPanner;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;-168.2459,1098.664;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1862.112,-197.4113;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1718.482,40.19875;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;32;7.127097,1102.395;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-662.3686,896.1357;Float;False;Property;_VertexMomal_VPanner;VertexMomal_VPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-651.2081,802.2521;Float;False;Property;_VertexMomal_UPanner;VertexMomal_UPanner;5;0;Create;True;0;0;False;0;0;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1519.89,55.66017;Float;False;Property;_Chromatic;Chromatic;8;0;Create;True;0;0;False;0;0;0.0026;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;14;-1480.872,-238.195;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1117.96,-235.2255;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-636.001,606.519;Float;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;182.5008,1104.26;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-364.4453,817.587;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-1101.414,341.0671;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-1122.692,28.98257;Float;True;Property;_Main_Texture;Main_Texture;0;0;Create;True;0;0;False;0;c7d564bbc661feb448e7dcb86e2aa438;587e91d7209e32340a11a711df6c875f;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;3;-674.0701,-265.3701;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;39;441.8421,1110.275;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-693.5753,255.9534;Float;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-679.3896,-33.07971;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;23;-217.4858,643.1951;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-339.3095,-3.48991;Float;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;21;127.3789,615.7627;Float;True;Property;_VertexMomal_Texture;VertexMomal_Texture;4;0;Create;True;0;0;False;0;03344d3d32e85af4faf109e635145a9b;a3c943a6914a9f84a8f678a08b3f2e14;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;20;-464.815,306.455;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;729.2853,1339.395;Float;False;Property;_Mask_Val;Mask_Val;9;0;Create;True;0;0;False;0;0;1.61;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;661.5369,1116.46;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;79.51343,-309.4242;Float;False;Property;_Tint_Color;Tint_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;660.2344,843.4186;Float;False;Property;_VertexMomal_Str;VertexMomal_Str;7;0;Create;True;0;0;False;0;0;-0.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;626.6522,539.3143;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;37;914.2041,1114.243;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;19;401.7038,-283.6292;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-472.6363,-95.40558;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;608.3995,-52.87212;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;889.7119,526.2546;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;1238.93,534.2199;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1703.94,-71.51421;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;OTH/Additive_Beam;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;10;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;30;2
WireConnection;17;0;15;0
WireConnection;17;1;16;0
WireConnection;32;0;31;0
WireConnection;14;0;7;0
WireConnection;14;2;17;0
WireConnection;8;0;14;0
WireConnection;8;1;10;0
WireConnection;33;0;32;0
WireConnection;33;1;30;2
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;9;0;14;0
WireConnection;9;1;10;0
WireConnection;3;0;2;0
WireConnection;3;1;8;0
WireConnection;39;0;33;0
WireConnection;5;0;2;0
WireConnection;5;1;9;0
WireConnection;4;0;2;0
WireConnection;4;1;14;0
WireConnection;23;0;22;0
WireConnection;23;2;26;0
WireConnection;11;0;3;1
WireConnection;11;1;4;2
WireConnection;11;2;5;3
WireConnection;21;1;23;0
WireConnection;34;0;39;0
WireConnection;27;0;20;0
WireConnection;27;1;21;0
WireConnection;37;0;34;0
WireConnection;37;1;36;0
WireConnection;12;0;13;0
WireConnection;12;1;11;0
WireConnection;18;0;19;0
WireConnection;18;1;12;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;38;0;19;4
WireConnection;38;1;37;0
WireConnection;0;2;18;0
WireConnection;0;9;38;0
WireConnection;0;11;28;0
ASEEND*/
//CHKSM=3E86428963FA762B336A9A8326B1F982734FB233