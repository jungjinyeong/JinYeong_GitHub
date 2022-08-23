// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|emission-9495-OUT;n:type:ShaderForge.SFN_Tex2d,id:8847,x:32699,y:32750,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_8847,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8067-OUT;n:type:ShaderForge.SFN_Color,id:5177,x:32699,y:32576,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_5177,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_VertexColor,id:7888,x:32528,y:33041,varname:node_7888,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9495,x:33051,y:32752,varname:node_9495,prsc:2|A-5177-RGB,B-8847-RGB,C-7888-RGB,D-4386-RGB,E-6278-OUT;n:type:ShaderForge.SFN_Tex2d,id:6509,x:31788,y:33354,ptovrint:False,ptlb:Erosion_Texture,ptin:_Erosion_Texture,varname:node_6509,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7737-OUT;n:type:ShaderForge.SFN_Vector1,id:5983,x:31792,y:33893,varname:node_5983,prsc:2,v1:-1.5;n:type:ShaderForge.SFN_ValueProperty,id:3578,x:31788,y:33571,ptovrint:False,ptlb:Soft_Value,ptin:_Soft_Value,varname:node_3578,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_TexCoord,id:9046,x:31763,y:33689,varname:node_9046,prsc:2,uv:1,uaff:True;n:type:ShaderForge.SFN_Multiply,id:125,x:32056,y:33298,varname:node_125,prsc:2|A-6509-R,B-3578-OUT;n:type:ShaderForge.SFN_Lerp,id:466,x:32069,y:33499,varname:node_466,prsc:2|A-3578-OUT,B-5983-OUT,T-9046-U;n:type:ShaderForge.SFN_Subtract,id:8492,x:32274,y:33462,varname:node_8492,prsc:2|A-125-OUT,B-466-OUT;n:type:ShaderForge.SFN_Clamp01,id:3775,x:32619,y:33472,varname:node_3775,prsc:2|IN-8492-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7771,x:31657,y:32350,ptovrint:False,ptlb:U,ptin:_U,varname:node_7771,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:6668,x:31667,y:32579,ptovrint:False,ptlb:V,ptin:_V,varname:_U_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:8888,x:31640,y:32417,varname:node_8888,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6072,x:31934,y:32354,varname:node_6072,prsc:2|A-7771-OUT,B-8888-T;n:type:ShaderForge.SFN_Multiply,id:2948,x:31934,y:32512,varname:node_2948,prsc:2|A-8888-T,B-6668-OUT;n:type:ShaderForge.SFN_Append,id:4905,x:32209,y:32351,varname:node_4905,prsc:2|A-6072-OUT,B-2948-OUT;n:type:ShaderForge.SFN_TexCoord,id:4825,x:32209,y:32488,varname:node_4825,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:747,x:32442,y:32421,varname:node_747,prsc:2|A-4905-OUT,B-4825-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:4386,x:32868,y:32417,ptovrint:False,ptlb:MASK,ptin:_MASK,varname:node_4386,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-747-OUT;n:type:ShaderForge.SFN_Time,id:1593,x:31618,y:32783,varname:node_1593,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1725,x:31912,y:32720,varname:node_1725,prsc:2|A-5767-OUT,B-1593-T;n:type:ShaderForge.SFN_Multiply,id:8472,x:31912,y:32878,varname:node_8472,prsc:2|A-1593-T,B-7532-OUT;n:type:ShaderForge.SFN_Append,id:9420,x:32187,y:32717,varname:node_9420,prsc:2|A-1725-OUT,B-8472-OUT;n:type:ShaderForge.SFN_TexCoord,id:2090,x:32187,y:32854,varname:node_2090,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:8067,x:32420,y:32787,varname:node_8067,prsc:2|A-9420-OUT,B-2090-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:5767,x:31645,y:32713,ptovrint:False,ptlb:T_U,ptin:_T_U,varname:node_5767,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7532,x:31618,y:32958,ptovrint:False,ptlb:T_V,ptin:_T_V,varname:_U_T_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:6278,x:32971,y:33092,varname:node_6278,prsc:2|A-5177-A,B-8847-A,C-3775-OUT,D-7888-A;n:type:ShaderForge.SFN_Time,id:5480,x:30784,y:33322,varname:node_5480,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1338,x:31078,y:33259,varname:node_1338,prsc:2|A-8755-OUT,B-5480-T;n:type:ShaderForge.SFN_Multiply,id:1539,x:31078,y:33417,varname:node_1539,prsc:2|A-5480-T,B-8747-OUT;n:type:ShaderForge.SFN_Append,id:3034,x:31353,y:33256,varname:node_3034,prsc:2|A-1338-OUT,B-1539-OUT;n:type:ShaderForge.SFN_TexCoord,id:1588,x:31353,y:33393,varname:node_1588,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:7737,x:31586,y:33326,varname:node_7737,prsc:2|A-3034-OUT,B-1588-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:8755,x:30811,y:33252,ptovrint:False,ptlb:E_U,ptin:_E_U,varname:_T_U_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8747,x:30784,y:33497,ptovrint:False,ptlb:E_V,ptin:_E_V,varname:_T_V_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;proporder:5177-8847-5767-7532-6509-8755-8747-3578-4386-7771-6668;pass:END;sub:END;*/

Shader "Custom_VFX/UV_Dissolve_Add_Mask_uv2" {
    Properties {
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Texture ("Texture", 2D) = "white" {}
        _T_U ("T_U", Float ) = 0
        _T_V ("T_V", Float ) = 0
        _Erosion_Texture ("Erosion_Texture", 2D) = "white" {}
        _E_U ("E_U", Float ) = 0
        _E_V ("E_V", Float ) = 0
        _Soft_Value ("Soft_Value", Float ) = 0
        _MASK ("MASK", 2D) = "white" {}
        _U ("U", Float ) = 0
        _V ("V", Float ) = 0
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
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _Erosion_Texture; uniform float4 _Erosion_Texture_ST;
            uniform sampler2D _MASK; uniform float4 _MASK_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _Soft_Value)
                UNITY_DEFINE_INSTANCED_PROP( float, _U)
                UNITY_DEFINE_INSTANCED_PROP( float, _V)
                UNITY_DEFINE_INSTANCED_PROP( float, _T_U)
                UNITY_DEFINE_INSTANCED_PROP( float, _T_V)
                UNITY_DEFINE_INSTANCED_PROP( float, _E_U)
                UNITY_DEFINE_INSTANCED_PROP( float, _E_V)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
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
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float _T_U_var = UNITY_ACCESS_INSTANCED_PROP( Props, _T_U );
                float4 node_1593 = _Time;
                float _T_V_var = UNITY_ACCESS_INSTANCED_PROP( Props, _T_V );
                float2 node_8067 = (float2((_T_U_var*node_1593.g),(node_1593.g*_T_V_var))+i.uv0);
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_8067, _Texture));
                float _U_var = UNITY_ACCESS_INSTANCED_PROP( Props, _U );
                float4 node_8888 = _Time;
                float _V_var = UNITY_ACCESS_INSTANCED_PROP( Props, _V );
                float2 node_747 = (float2((_U_var*node_8888.g),(node_8888.g*_V_var))+i.uv0);
                float4 _MASK_var = tex2D(_MASK,TRANSFORM_TEX(node_747, _MASK));
                float _E_U_var = UNITY_ACCESS_INSTANCED_PROP( Props, _E_U );
                float4 node_5480 = _Time;
                float _E_V_var = UNITY_ACCESS_INSTANCED_PROP( Props, _E_V );
                float2 node_7737 = (float2((_E_U_var*node_5480.g),(node_5480.g*_E_V_var))+i.uv0);
                float4 _Erosion_Texture_var = tex2D(_Erosion_Texture,TRANSFORM_TEX(node_7737, _Erosion_Texture));
                float _Soft_Value_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Soft_Value );
                float3 emissive = (_Color_var.rgb*_Texture_var.rgb*i.vertexColor.rgb*_MASK_var.rgb*(_Color_var.a*_Texture_var.a*saturate(((_Erosion_Texture_var.r*_Soft_Value_var)-lerp(_Soft_Value_var,(-1.5),i.uv1.r)))*i.vertexColor.a));
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
