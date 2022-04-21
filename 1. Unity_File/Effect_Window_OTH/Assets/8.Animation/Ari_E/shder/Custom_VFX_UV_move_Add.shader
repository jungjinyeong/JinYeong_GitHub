// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:32726,y:32455,varname:node_9361,prsc:2|emission-966-OUT;n:type:ShaderForge.SFN_Tex2d,id:8843,x:32279,y:32345,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_8843,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8700-OUT;n:type:ShaderForge.SFN_Tex2d,id:2295,x:31910,y:32574,ptovrint:False,ptlb:Tietu,ptin:_Tietu,varname:node_2295,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3176-OUT;n:type:ShaderForge.SFN_Multiply,id:957,x:32355,y:32543,varname:node_957,prsc:2|A-2295-RGB,B-1885-RGB,C-8843-RGB,D-7381-RGB;n:type:ShaderForge.SFN_Color,id:1885,x:32015,y:32373,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1885,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_VertexColor,id:7381,x:31910,y:32763,varname:node_7381,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:5110,x:31589,y:32660,varname:node_5110,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:4377,x:31139,y:32589,varname:node_4377,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:1927,x:31126,y:32411,ptovrint:False,ptlb:U_liudong,ptin:_U_liudong,varname:node_1927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6470,x:31139,y:32781,ptovrint:False,ptlb:V_liudong,ptin:_V_liudong,varname:_U_yidong_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:3187,x:31348,y:32481,varname:node_3187,prsc:2|A-1927-OUT,B-4377-T;n:type:ShaderForge.SFN_Multiply,id:429,x:31321,y:32695,varname:node_429,prsc:2|A-4377-T,B-6470-OUT;n:type:ShaderForge.SFN_Append,id:5904,x:31566,y:32386,varname:node_5904,prsc:2|A-3187-OUT,B-429-OUT;n:type:ShaderForge.SFN_Add,id:3176,x:31753,y:32505,varname:node_3176,prsc:2|A-5904-OUT,B-5110-UVOUT;n:type:ShaderForge.SFN_Multiply,id:9473,x:32264,y:32831,varname:node_9473,prsc:2|A-2295-A,B-7381-A,C-1885-A,D-8843-A;n:type:ShaderForge.SFN_Multiply,id:966,x:32527,y:32606,varname:node_966,prsc:2|A-957-OUT,B-9473-OUT;n:type:ShaderForge.SFN_TexCoord,id:7105,x:31855,y:32186,varname:node_7105,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:2704,x:31405,y:32115,varname:node_2704,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3103,x:31415,y:32009,ptovrint:False,ptlb:U_liudong_copy,ptin:_U_liudong_copy,varname:_U_liudong_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:197,x:31405,y:32307,ptovrint:False,ptlb:V_liudong_copy,ptin:_V_liudong_copy,varname:_V_liudong_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:343,x:31602,y:32075,varname:node_343,prsc:2|A-3103-OUT,B-2704-T;n:type:ShaderForge.SFN_Multiply,id:6040,x:31637,y:32196,varname:node_6040,prsc:2|A-2704-T,B-197-OUT;n:type:ShaderForge.SFN_Append,id:7502,x:31855,y:32008,varname:node_7502,prsc:2|A-343-OUT,B-6040-OUT;n:type:ShaderForge.SFN_Add,id:8700,x:32019,y:32031,varname:node_8700,prsc:2|A-7502-OUT,B-7105-UVOUT;proporder:2295-1927-6470-1885-8843-3103-197;pass:END;sub:END;*/

Shader "Custom_VFX/UV_move_Add" {
    Properties {
        _Tietu ("Tietu", 2D) = "white" {}
        _U_liudong ("U_liudong", Float ) = 0
        _V_liudong ("V_liudong", Float ) = 0
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Mask ("Mask", 2D) = "white" {}
        _U_liudong_copy ("U_liudong_copy", Float ) = 0
        _V_liudong_copy ("V_liudong_copy", Float ) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform sampler2D _Tietu; uniform float4 _Tietu_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _U_liudong)
                UNITY_DEFINE_INSTANCED_PROP( float, _V_liudong)
                UNITY_DEFINE_INSTANCED_PROP( float, _U_liudong_copy)
                UNITY_DEFINE_INSTANCED_PROP( float, _V_liudong_copy)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float _U_liudong_var = UNITY_ACCESS_INSTANCED_PROP( Props, _U_liudong );
                float4 node_4377 = _Time;
                float _V_liudong_var = UNITY_ACCESS_INSTANCED_PROP( Props, _V_liudong );
                float2 node_3176 = (float2((_U_liudong_var*node_4377.g),(node_4377.g*_V_liudong_var))+i.uv0);
                float4 _Tietu_var = tex2D(_Tietu,TRANSFORM_TEX(node_3176, _Tietu));
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float _U_liudong_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _U_liudong_copy );
                float4 node_2704 = _Time;
                float _V_liudong_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _V_liudong_copy );
                float2 node_8700 = (float2((_U_liudong_copy_var*node_2704.g),(node_2704.g*_V_liudong_copy_var))+i.uv0);
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(node_8700, _Mask));
                float3 emissive = ((_Tietu_var.rgb*_Color_var.rgb*_Mask_var.rgb*i.vertexColor.rgb)*(_Tietu_var.a*i.vertexColor.a*_Color_var.a*_Mask_var.a));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
