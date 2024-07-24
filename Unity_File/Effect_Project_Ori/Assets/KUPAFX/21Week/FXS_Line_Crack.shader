// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KUPAFX/Line_Crak"
{
	Properties
	{
		[HDR]_Albedo_Color("Albedo_Color", Color) = (0,0,0,0)
		_RGB_Texture("RGB_Texture", 2D) = "white" {}
		_Parallax_Scale("Parallax_Scale", Range( 0 , 1)) = 0
		_Emi_Pow("Emi_Pow", Range( 1 , 10)) = 0
		[HDR]_Emi_Color("Emi_Color", Color) = (0,0,0,0)
		_Normal_Texture("Normal_Texture", 2D) = "bump" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform float _Normal_Scale;
		uniform sampler2D _Normal_Texture;
		uniform float _Parallax_Scale;
		uniform sampler2D _RGB_Texture;
		uniform float4 _Albedo_Color;
		uniform float _Emi_Pow;
		uniform float4 _Emi_Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 Offset3 = ( ( 0.0 - 1 ) * i.viewDir.xy * _Parallax_Scale ) + i.uv_texcoord;
			float2 Offset9 = ( ( tex2D( _RGB_Texture, Offset3 ).g - 1 ) * i.viewDir.xy * _Parallax_Scale ) + Offset3;
			float2 Offset11 = ( ( tex2D( _RGB_Texture, Offset9 ).g - 1 ) * i.viewDir.xy * _Parallax_Scale ) + Offset9;
			float2 Offset13 = ( ( tex2D( _RGB_Texture, Offset11 ).g - 1 ) * i.viewDir.xy * _Parallax_Scale ) + Offset11;
			float2 Offset15 = ( ( tex2D( _RGB_Texture, Offset13 ).g - 1 ) * i.viewDir.xy * _Parallax_Scale ) + Offset13;
			float2 Offset16 = ( ( tex2D( _RGB_Texture, Offset15 ).g - 1 ) * i.viewDir.xy * _Parallax_Scale ) + Offset15;
			o.Normal = UnpackScaleNormal( tex2D( _Normal_Texture, Offset16 ), _Normal_Scale );
			float4 tex2DNode1 = tex2D( _RGB_Texture, Offset16 );
			o.Albedo = ( tex2DNode1.r * _Albedo_Color ).rgb;
			o.Emission = ( ( pow( ( 1.0 - tex2DNode1.g ) , _Emi_Pow ) * _Emi_Color ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * tex2DNode1.b );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
0;0;1920;1019;4606.922;652.3298;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;18;-4050.588,-481.2096;Float;False;3737.329;1280.676;Parallax_Stack;15;4;2;6;7;3;8;9;10;11;12;13;14;15;17;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-3945.24,-431.2096;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-4000.588,-228.3657;Float;False;Property;_Parallax_Scale;Parallax_Scale;2;0;Create;True;0;0;False;0;0;0.028;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;4;-3951.002,-152.4197;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ParallaxMappingNode;3;-3647.471,-426.3586;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;2;-3984.678,0.6040993;Float;True;Property;_RGB_Texture;RGB_Texture;1;0;Create;True;0;0;False;0;None;9a0b9a7b51741254a8ee5cc7c7ad8998;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;8;-3341.674,-321.4096;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;9;-3038.687,-192.0349;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;-2733.887,-44.58498;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;11;-2421.3,75.29596;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;12;-2108.18,195.9688;Float;True;Property;_TextureSample3;Texture Sample 3;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;13;-1807.432,270.9633;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-1516.177,357.8188;Float;True;Property;_TextureSample4;Texture Sample 4;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;15;-1227.267,416.8697;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-942.4873,476.454;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;16;-630.2598,540.4664;Float;True;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-232.6058,-64.50383;Float;True;Property;_FXT_Line_Crak;FXT_Line_Crak;0;0;Create;True;0;0;False;0;None;9a0b9a7b51741254a8ee5cc7c7ad8998;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;23;26.39813,-610.6541;Float;False;588.1961;484;Emi;5;19;20;22;30;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;19;76.39813,-559.4637;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;214.5942,-411.6541;Float;False;Property;_Emi_Pow;Emi_Pow;3;0;Create;True;0;0;False;0;0;6.18;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;256.5942,-541.6541;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;22;80.59424,-338.6541;Float;False;Property;_Emi_Color;Emi_Color;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.039143,2.122193,3.000341,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;27;586.5942,-27.6541;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;478.5942,-511.6541;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;26;-157.528,148.3324;Float;False;Property;_Albedo_Color;Albedo_Color;0;1;[HDR];Create;True;0;0;False;0;0,0,0,0;12.99604,12.99604,12.99604,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;101.4176,567.3921;Float;False;Property;_Normal_Scale;Normal_Scale;6;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;929.5942,-72.6541;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;286.5942,-100.6541;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;813.5942,89.3459;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;32;455.5584,544.2873;Float;True;Property;_Normal_Texture;Normal_Texture;5;0;Create;True;0;0;False;0;dca85ccf2e5ee3b4ab9831032eeecaf0;dca85ccf2e5ee3b4ab9831032eeecaf0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1142.926,-125.5013;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;KUPAFX/Line_Crak;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;7;0
WireConnection;3;2;6;0
WireConnection;3;3;4;0
WireConnection;8;0;2;0
WireConnection;8;1;3;0
WireConnection;9;0;3;0
WireConnection;9;1;8;2
WireConnection;9;2;6;0
WireConnection;9;3;4;0
WireConnection;10;0;2;0
WireConnection;10;1;9;0
WireConnection;11;0;9;0
WireConnection;11;1;10;2
WireConnection;11;2;6;0
WireConnection;11;3;4;0
WireConnection;12;0;2;0
WireConnection;12;1;11;0
WireConnection;13;0;11;0
WireConnection;13;1;12;2
WireConnection;13;2;6;0
WireConnection;13;3;4;0
WireConnection;14;0;2;0
WireConnection;14;1;13;0
WireConnection;15;0;13;0
WireConnection;15;1;14;2
WireConnection;15;2;6;0
WireConnection;15;3;4;0
WireConnection;17;0;2;0
WireConnection;17;1;15;0
WireConnection;16;0;15;0
WireConnection;16;1;17;2
WireConnection;16;2;6;0
WireConnection;16;3;4;0
WireConnection;1;0;2;0
WireConnection;1;1;16;0
WireConnection;19;0;1;2
WireConnection;30;0;19;0
WireConnection;30;1;31;0
WireConnection;20;0;30;0
WireConnection;20;1;22;0
WireConnection;28;0;20;0
WireConnection;28;1;27;0
WireConnection;25;0;1;1
WireConnection;25;1;26;0
WireConnection;29;0;27;4
WireConnection;29;1;1;3
WireConnection;32;1;16;0
WireConnection;32;5;33;0
WireConnection;0;0;25;0
WireConnection;0;1;32;0
WireConnection;0;2;28;0
WireConnection;0;9;29;0
ASEEND*/
//CHKSM=D0D8360282FFE6A9360FAF524FC143B653A01868