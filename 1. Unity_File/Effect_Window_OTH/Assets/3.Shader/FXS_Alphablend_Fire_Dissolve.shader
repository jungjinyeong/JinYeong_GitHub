// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OTH/Alphablend_Fire_Dissolve"
{
	Properties
	{
		[Toggle]_ZWrite("ZWrite", Float) = 0
		_Main_step("Main_step", Range( 0 , 2)) = 0
		[HDR]_Out_Color("Out_Color", Color) = (0,0,0,1)
		[HDR]_In_Color("In_Color", Color) = (1,0,0,1)
		[HDR]_Main_Color("Main_Color", Color) = (1,0.3057163,0,1)
		_Lerp_Color_Size("Lerp_Color_Size", Float) = 0
		_Lerp_Color_Size_02("Lerp_Color_Size_02", Float) = 0
		_Voronoi_Scale_01("Voronoi_Scale_01", Float) = 5
		_Voronoi_Scale_02("Voronoi_Scale_02", Float) = 3
		_Time_Scale_01("Time_Scale_01", Float) = 2
		_Time_Scale_02("Time_Scale_02", Float) = 0.6
		_Voronoi_TilingSpeed_01("Voronoi_Tiling&Speed_01", Vector) = (2,1,0,-1)
		_Voronoi_TilingSpeed_02("Voronoi_Tiling&Speed_02", Vector) = (2,1,0,-0.7)
		_Sphere_Size("Sphere_Size", Range( 0 , 1.5)) = 0.7
		_Sphere_UV("Sphere_UV", Vector) = (0,0,0,0)
		_Sphere_Str("Sphere_Str", Float) = 0.3
		[KeywordEnum(up,down,left,right,off)] _SW_Mask("SW_Mask", Float) = 0
		[Toggle]_Use_Custom("Use_Custom", Float) = 0
		_Mask("Mask", 2D) = "white" {}
		_Main_Str("Main_Str", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "Queue"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite [_ZWrite]
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature_local _SW_MASK_UP _SW_MASK_DOWN _SW_MASK_LEFT _SW_MASK_RIGHT _SW_MASK_OFF


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _ZWrite;
			uniform float _Main_Str;
			uniform float4 _Out_Color;
			uniform float4 _In_Color;
			uniform float4 _Main_Color;
			uniform float _Lerp_Color_Size_02;
			uniform float _Lerp_Color_Size;
			uniform float _Main_step;
			uniform float _Use_Custom;
			uniform float _Voronoi_Scale_01;
			uniform float _Time_Scale_01;
			uniform float4 _Voronoi_TilingSpeed_01;
			uniform float _Voronoi_Scale_02;
			uniform float _Time_Scale_02;
			uniform float4 _Voronoi_TilingSpeed_02;
			uniform float2 _Sphere_UV;
			uniform float _Sphere_Size;
			uniform float _Sphere_Str;
			uniform sampler2D _Mask;
			uniform float4 _Mask_ST;
					float2 voronoihash17( float2 p )
					{
						
						p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
						return frac( sin( p ) *43758.5453);
					}
			
					float voronoi17( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
					{
						float2 n = floor( v );
						float2 f = frac( v );
						float F1 = 8.0;
						float F2 = 8.0; float2 mg = 0;
						for ( int j = -1; j <= 1; j++ )
						{
							for ( int i = -1; i <= 1; i++ )
						 	{
						 		float2 g = float2( i, j );
						 		float2 o = voronoihash17( n + g );
								o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
								float d = 0.5 * dot( r, r );
						 		if( d<F1 ) {
						 			F2 = F1;
						 			F1 = d; mg = g; mr = r; id = o;
						 		} else if( d<F2 ) {
						 			F2 = d;
						
						 		}
						 	}
						}
						return F1;
					}
			
					float2 voronoihash33( float2 p )
					{
						
						p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
						return frac( sin( p ) *43758.5453);
					}
			
					float voronoi33( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
					{
						float2 n = floor( v );
						float2 f = frac( v );
						float F1 = 8.0;
						float F2 = 8.0; float2 mg = 0;
						for ( int j = -1; j <= 1; j++ )
						{
							for ( int i = -1; i <= 1; i++ )
						 	{
						 		float2 g = float2( i, j );
						 		float2 o = voronoihash33( n + g );
								o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
								float d = 0.5 * dot( r, r );
						 		if( d<F1 ) {
						 			F2 = F1;
						 			F1 = d; mg = g; mr = r; id = o;
						 		} else if( d<F2 ) {
						 			F2 = d;
						
						 		}
						 	}
						}
						return F1;
					}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float4 texCoord72 = i.ase_texcoord1;
				texCoord72.xy = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult71 = lerp( _Main_step , texCoord72.z , _Use_Custom);
				float temp_output_7_0 = ( _Lerp_Color_Size + lerpResult71 );
				float time17 = ( _Time.y * _Time_Scale_01 );
				float2 voronoiSmoothId17 = 0;
				float2 appendResult27 = (float2(_Voronoi_TilingSpeed_01.z , _Voronoi_TilingSpeed_01.w));
				float2 appendResult25 = (float2(_Voronoi_TilingSpeed_01.x , _Voronoi_TilingSpeed_01.y));
				float2 texCoord24 = i.ase_texcoord2.xy * appendResult25 + float2( 0,0 );
				float2 panner23 = ( 1.0 * _Time.y * appendResult27 + texCoord24);
				float2 coords17 = panner23 * _Voronoi_Scale_01;
				float2 id17 = 0;
				float2 uv17 = 0;
				float voroi17 = voronoi17( coords17, time17, id17, uv17, 0, voronoiSmoothId17 );
				float time33 = ( _Time.y * _Time_Scale_02 );
				float2 voronoiSmoothId33 = 0;
				float2 appendResult36 = (float2(_Voronoi_TilingSpeed_02.z , _Voronoi_TilingSpeed_02.w));
				float2 appendResult35 = (float2(_Voronoi_TilingSpeed_02.x , _Voronoi_TilingSpeed_02.y));
				float2 texCoord34 = i.ase_texcoord2.xy * appendResult35 + float2( 0,0 );
				float2 panner28 = ( 1.0 * _Time.y * appendResult36 + texCoord34);
				float2 coords33 = panner28 * _Voronoi_Scale_02;
				float2 id33 = 0;
				float2 uv33 = 0;
				float voroi33 = voronoi33( coords33, time33, id33, uv33, 0, voronoiSmoothId33 );
				float blendOpSrc38 = voroi17;
				float blendOpDest38 = voroi33;
				float2 _Vector0 = float2(0.5,0.5);
				float4 texCoord74 = i.ase_texcoord1;
				texCoord74.xy = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult52 = (float2(( _Vector0.x + _Sphere_UV.x + texCoord74.x ) , ( _Vector0.y + _Sphere_UV.y + texCoord74.y )));
				float2 texCoord45 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_46_0 = (1.0 + (distance( appendResult52 , texCoord45 ) - 0.0) * (0.0 - 1.0) / (_Sphere_Size - 0.0));
				float2 texCoord60 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord63 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord65 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord64 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_SW_MASK_UP)
				float staticSwitch59 = ( 1.0 - saturate( texCoord60.y ) );
				#elif defined(_SW_MASK_DOWN)
				float staticSwitch59 = saturate( texCoord63.y );
				#elif defined(_SW_MASK_LEFT)
				float staticSwitch59 = saturate( texCoord65.x );
				#elif defined(_SW_MASK_RIGHT)
				float staticSwitch59 = ( 1.0 - saturate( texCoord64.x ) );
				#elif defined(_SW_MASK_OFF)
				float staticSwitch59 = 1.0;
				#else
				float staticSwitch59 = ( 1.0 - saturate( texCoord60.y ) );
				#endif
				float temp_output_39_0 = saturate( ( ( ( saturate( (( blendOpDest38 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest38 ) * ( 1.0 - blendOpSrc38 ) ) : ( 2.0 * blendOpDest38 * blendOpSrc38 ) ) )) * temp_output_46_0 ) + ( temp_output_46_0 * 0.1 * _Sphere_Str * staticSwitch59 ) ) );
				float4 lerpResult15 = lerp( _In_Color , _Main_Color , step( ( ( _Lerp_Color_Size_02 + temp_output_7_0 ) * 0.1 ) , temp_output_39_0 ));
				float4 lerpResult11 = lerp( _Out_Color , lerpResult15 , step( ( temp_output_7_0 * 0.1 ) , temp_output_39_0 ));
				float2 uv_Mask = i.ase_texcoord2.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 appendResult79 = (float2(texCoord74.z , texCoord74.w));
				float4 appendResult6 = (float4(lerpResult11.rgb , ( step( ( lerpResult71 * 0.1 ) , temp_output_39_0 ) * tex2D( _Mask, ( uv_Mask - appendResult79 ) ).r )));
				
				
				finalColor = ( _Main_Str * appendResult6 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18935
1920;0;1920;1019;1992.631;-31.255;1;True;False
Node;AmplifyShaderEditor.Vector4Node;37;-2989.496,837.8855;Inherit;False;Property;_Voronoi_TilingSpeed_02;Voronoi_Tiling&Speed_02;12;0;Create;True;0;0;0;False;0;False;2,1,0,-0.7;2,1,0,-0.7;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;26;-3021.496,165.8855;Inherit;False;Property;_Voronoi_TilingSpeed_01;Voronoi_Tiling&Speed_01;11;0;Create;True;0;0;0;False;0;False;2,1,0,-1;2,1,0,-1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;51;-3053.496,1637.885;Inherit;False;Property;_Sphere_UV;Sphere_UV;14;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;43;-3069.496,1477.885;Inherit;False;Constant;_Vector0;Vector 0;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;35;-2733.496,837.8855;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2749.496,149.8855;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;74;-3691.305,1865.564;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;20;-2637.496,389.8853;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2605.496,1157.885;Inherit;False;Property;_Time_Scale_02;Time_Scale_02;10;0;Create;True;0;0;0;False;0;False;0.6;0.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-2829.496,21.88547;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;36;-2733.496,933.8856;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-2600.105,1928.707;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-2813.496,693.8856;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-2621.496,485.8853;Inherit;False;Property;_Time_Scale_01;Time_Scale_01;9;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;64;-2552.774,2660.559;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-2749.496,261.8855;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;-2621.496,1077.886;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-2813.496,1621.885;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-2813.496,1493.885;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2461.496,1237.885;Inherit;False;Property;_Voronoi_Scale_02;Voronoi_Scale_02;8;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2461.496,421.8853;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;28;-2525.496,901.8856;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-2477.496,565.8853;Inherit;False;Property;_Voronoi_Scale_01;Voronoi_Scale_01;7;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2429.496,1093.886;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;23;-2541.496,213.8855;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;65;-2441.716,2414.688;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-2439.095,2221.399;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;45;-2557.496,1637.885;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;61;-2305.741,1974.568;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;68;-2297.003,2681.3;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-2637.496,1493.885;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1421.28,357.2973;Inherit;False;Property;_Main_step;Main_step;1;0;Create;True;0;0;0;False;0;False;0;0.14;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1262.3,658.6412;Inherit;False;Property;_Use_Custom;Use_Custom;17;1;[Toggle];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;62;-2103.1,1971.368;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;44;-2301.496,1493.885;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;67;-2117.04,2438.969;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;17;-2253.496,245.8855;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;70;-1759.026,2198.715;Inherit;False;Constant;_Float1;Float 1;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;69;-2105.931,2678.553;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;-1485.3,453.6412;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;33;-2237.496,917.8856;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;47;-2093.496,1749.885;Inherit;False;Property;_Sphere_Size;Sphere_Size;13;0;Create;True;0;0;0;False;0;False;0.7;1.5;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;66;-2110.144,2210.448;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;71;-1099.3,362.6412;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1214.898,139.575;Inherit;False;Property;_Lerp_Color_Size;Lerp_Color_Size;5;0;Create;True;0;0;0;False;0;False;0;0.23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-1694.617,1940.439;Inherit;False;Property;_SW_Mask;SW_Mask;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;5;up;down;left;right;off;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;38;-2013.497,597.8854;Inherit;True;Overlay;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1711.785,1703.955;Inherit;False;Property;_Sphere_Str;Sphere_Str;15;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1713.666,1561.118;Inherit;False;Constant;_Float0;Float 0;16;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;46;-2045.497,1493.885;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-1706.292,1094.168;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-1547.785,1493.955;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1280.175,-17.96342;Inherit;False;Property;_Lerp_Color_Size_02;Lerp_Color_Size_02;6;0;Create;True;0;0;0;False;0;False;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-904.3985,148.975;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-1435.67,1092.893;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-916.6749,5.436584;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;79;-3361.938,2005.589;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;39;-1239.521,1084.284;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;78;-3450.613,1871.418;Inherit;False;0;76;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-735.6167,15.93164;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-738.6167,144.9316;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-575.6128,-173.8588;Inherit;False;Property;_Main_Color;Main_Color;4;1;[HDR];Create;True;0;0;0;False;0;False;1,0.3057163,0,1;4,1.223529,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-831.6167,346.9316;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;12;-513.225,22.03662;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;81;-2976.995,1977.52;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;10;-573.7987,-361.9249;Inherit;False;Property;_In_Color;In_Color;3;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,1;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-572.28,-553.3026;Inherit;False;Property;_Out_Color;Out_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;3;-504.3793,352.3973;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;15;-322.1394,-96.55954;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;9;-511.1986,158.275;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;76;-402.5121,669.1168;Inherit;True;Property;_Mask;Mask;18;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;11;-169.6792,-425.0856;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-79.51003,505.8233;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;113.035,-56.20268;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;83;131.7763,-179.0043;Inherit;False;Property;_Main_Str;Main_Str;19;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;295.5717,-67.22501;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1;518.42,-187.8027;Inherit;False;Property;_ZWrite;ZWrite;0;1;[Toggle];Create;True;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;473,-51;Float;False;True;-1;2;ASEMaterialInspector;100;1;OTH/Alphablend_Fire_Dissolve;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;1;True;1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;Queue=Transparent=Queue=0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;35;0;37;1
WireConnection;35;1;37;2
WireConnection;25;0;26;1
WireConnection;25;1;26;2
WireConnection;24;0;25;0
WireConnection;36;0;37;3
WireConnection;36;1;37;4
WireConnection;34;0;35;0
WireConnection;27;0;26;3
WireConnection;27;1;26;4
WireConnection;50;0;43;2
WireConnection;50;1;51;2
WireConnection;50;2;74;2
WireConnection;49;0;43;1
WireConnection;49;1;51;1
WireConnection;49;2;74;1
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;28;0;34;0
WireConnection;28;2;36;0
WireConnection;30;0;32;0
WireConnection;30;1;31;0
WireConnection;23;0;24;0
WireConnection;23;2;27;0
WireConnection;61;0;60;2
WireConnection;68;0;64;1
WireConnection;52;0;49;0
WireConnection;52;1;50;0
WireConnection;62;0;61;0
WireConnection;44;0;52;0
WireConnection;44;1;45;0
WireConnection;67;0;65;1
WireConnection;17;0;23;0
WireConnection;17;1;21;0
WireConnection;17;2;18;0
WireConnection;69;0;68;0
WireConnection;33;0;28;0
WireConnection;33;1;30;0
WireConnection;33;2;29;0
WireConnection;66;0;63;2
WireConnection;71;0;4;0
WireConnection;71;1;72;3
WireConnection;71;2;73;0
WireConnection;59;1;62;0
WireConnection;59;0;66;0
WireConnection;59;2;67;0
WireConnection;59;3;69;0
WireConnection;59;4;70;0
WireConnection;38;0;17;0
WireConnection;38;1;33;0
WireConnection;46;0;44;0
WireConnection;46;2;47;0
WireConnection;48;0;38;0
WireConnection;48;1;46;0
WireConnection;55;0;46;0
WireConnection;55;1;58;0
WireConnection;55;2;56;0
WireConnection;55;3;59;0
WireConnection;7;0;8;0
WireConnection;7;1;71;0
WireConnection;57;0;48;0
WireConnection;57;1;55;0
WireConnection;14;0;13;0
WireConnection;14;1;7;0
WireConnection;79;0;74;3
WireConnection;79;1;74;4
WireConnection;39;0;57;0
WireConnection;42;0;14;0
WireConnection;41;0;7;0
WireConnection;40;0;71;0
WireConnection;12;0;42;0
WireConnection;12;1;39;0
WireConnection;81;0;78;0
WireConnection;81;1;79;0
WireConnection;3;0;40;0
WireConnection;3;1;39;0
WireConnection;15;0;10;0
WireConnection;15;1;16;0
WireConnection;15;2;12;0
WireConnection;9;0;41;0
WireConnection;9;1;39;0
WireConnection;76;1;81;0
WireConnection;11;0;5;0
WireConnection;11;1;15;0
WireConnection;11;2;9;0
WireConnection;80;0;3;0
WireConnection;80;1;76;1
WireConnection;6;0;11;0
WireConnection;6;3;80;0
WireConnection;82;0;83;0
WireConnection;82;1;6;0
WireConnection;0;0;82;0
ASEEND*/
//CHKSM=346546820B4079CE5620DFF76E00C626BF319FE6