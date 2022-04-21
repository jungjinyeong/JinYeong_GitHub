// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:32825,y:32277,varname:node_9361,prsc:2|emission-9225-OUT,alpha-2200-OUT;n:type:ShaderForge.SFN_Tex2d,id:3957,x:32158,y:32519,ptovrint:False,ptlb:tietu,ptin:_tietu,varname:node_3957,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-5360-OUT;n:type:ShaderForge.SFN_Color,id:4029,x:32158,y:32317,ptovrint:False,ptlb:color,ptin:_color,varname:node_4029,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6935,x:32266,y:32173,ptovrint:False,ptlb:mask,ptin:_mask,varname:_tietu_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9225,x:32557,y:32344,varname:node_9225,prsc:2|A-3957-RGB,B-4029-RGB,C-6935-RGB,D-3977-RGB;n:type:ShaderForge.SFN_VertexColor,id:3977,x:32265,y:32690,varname:node_3977,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2200,x:32508,y:32558,varname:node_2200,prsc:2|A-3957-A,B-3977-A,C-4029-A,D-6935-A;n:type:ShaderForge.SFN_TexCoord,id:7369,x:31784,y:32503,varname:node_7369,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:5058,x:31360,y:32485,varname:node_5058,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:3243,x:31387,y:32322,ptovrint:False,ptlb:U_yidong,ptin:_U_yidong,varname:node_3243,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:274,x:31360,y:32712,ptovrint:False,ptlb:V_yidong,ptin:_V_yidong,varname:_U_yidong_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:1075,x:31562,y:32548,varname:node_1075,prsc:2|A-5058-T,B-274-OUT;n:type:ShaderForge.SFN_Multiply,id:3528,x:31562,y:32343,varname:node_3528,prsc:2|A-3243-OUT,B-5058-T;n:type:ShaderForge.SFN_Append,id:7472,x:31784,y:32318,varname:node_7472,prsc:2|A-3528-OUT,B-1075-OUT;n:type:ShaderForge.SFN_Add,id:5360,x:31964,y:32402,varname:node_5360,prsc:2|A-7472-OUT,B-7369-UVOUT;proporder:3957-3243-274-4029-6935;pass:END;sub:END;*/

Shader "Custom_VFX/UV_move_Alpha Blend" {
    Properties {
        _tietu ("tietu", 2D) = "white" {}
        _U_yidong ("U_yidong", Float ) = 0
        _V_yidong ("V_yidong", Float ) = 0
        [HDR]_color ("color", Color) = (0.5,0.5,0.5,1)
        _mask ("mask", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            Blend SrcAlpha OneMinusSrcAlpha
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
            uniform sampler2D _tietu; uniform float4 _tietu_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _color)
                UNITY_DEFINE_INSTANCED_PROP( float, _U_yidong)
                UNITY_DEFINE_INSTANCED_PROP( float, _V_yidong)
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
                float _U_yidong_var = UNITY_ACCESS_INSTANCED_PROP( Props, _U_yidong );
                float4 node_5058 = _Time;
                float _V_yidong_var = UNITY_ACCESS_INSTANCED_PROP( Props, _V_yidong );
                float2 node_5360 = (float2((_U_yidong_var*node_5058.g),(node_5058.g*_V_yidong_var))+i.uv0);
                float4 _tietu_var = tex2D(_tietu,TRANSFORM_TEX(node_5360, _tietu));
                float4 _color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _color );
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float3 emissive = (_tietu_var.rgb*_color_var.rgb*_mask_var.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,(_tietu_var.a*i.vertexColor.a*_color_var.a*_mask_var.a));
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
