// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33946,y:32683,varname:node_4013,prsc:2|diff-8755-OUT,diffpow-4334-OUT,spec-157-OUT,normal-9150-OUT,clip-909-OUT;n:type:ShaderForge.SFN_Tex2d,id:1386,x:33068,y:32611,ptovrint:False,ptlb:node_1386,ptin:_node_1386,varname:node_1386,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ed5f7a91044df7c41a7f72e09e44ef53,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4343,x:32810,y:33048,ptovrint:False,ptlb:node_4343,ptin:_node_4343,varname:node_4343,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbab0a6f7bae9cf42bf057d8ee2755f6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Multiply,id:9150,x:33021,y:32943,varname:node_9150,prsc:2|A-8362-OUT,B-4343-RGB;n:type:ShaderForge.SFN_ValueProperty,id:8362,x:32779,y:32943,ptovrint:False,ptlb:faqiang,ptin:_faqiang,varname:node_8362,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:4334,x:33245,y:32692,ptovrint:False,ptlb:Diffuse Power,ptin:_DiffusePower,varname:node_4334,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:157,x:33258,y:32768,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_157,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:6134,x:33068,y:32433,ptovrint:False,ptlb:node_6134,ptin:_node_6134,varname:node_6134,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:74184199860ddd2478461f67c0338c49,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:8755,x:33219,y:32489,varname:node_8755,prsc:2|A-6134-R,B-1386-RGB;n:type:ShaderForge.SFN_Tex2d,id:3994,x:33538,y:32933,ptovrint:False,ptlb:wenli,ptin:_wenli,varname:node_3994,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6411,x:33400,y:33152,ptovrint:False,ptlb:rongjiekongzhi,ptin:_rongjiekongzhi,varname:node_6411,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:2;n:type:ShaderForge.SFN_Multiply,id:909,x:33749,y:33008,varname:node_909,prsc:2|A-3994-R,B-6411-OUT;proporder:1386-4343-8362-4334-157-6134-3994-6411;pass:END;sub:END;*/

Shader "Shader Forge/Background" {
    Properties {
        _node_1386 ("node_1386", 2D) = "white" {}
        _node_4343 ("node_4343", 2D) = "bump" {}
        _faqiang ("faqiang", Float ) = 1
        _DiffusePower ("Diffuse Power", Float ) = 1
        _Specular ("Specular", Float ) = 1
        _node_6134 ("node_6134", 2D) = "white" {}
        _wenli ("wenli", 2D) = "white" {}
        _rongjiekongzhi ("rongjiekongzhi", Range(0, 2)) = 2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _node_1386; uniform float4 _node_1386_ST;
            uniform sampler2D _node_4343; uniform float4 _node_4343_ST;
            uniform sampler2D _node_6134; uniform float4 _node_6134_ST;
            uniform sampler2D _wenli; uniform float4 _wenli_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _faqiang)
                UNITY_DEFINE_INSTANCED_PROP( float, _DiffusePower)
                UNITY_DEFINE_INSTANCED_PROP( float, _Specular)
                UNITY_DEFINE_INSTANCED_PROP( float, _rongjiekongzhi)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float _faqiang_var = UNITY_ACCESS_INSTANCED_PROP( Props, _faqiang );
                float3 _node_4343_var = UnpackNormal(tex2D(_node_4343,TRANSFORM_TEX(i.uv0, _node_4343)));
                float3 normalLocal = (_faqiang_var*_node_4343_var.rgb);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 _wenli_var = tex2D(_wenli,TRANSFORM_TEX(i.uv0, _wenli));
                float _rongjiekongzhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _rongjiekongzhi );
                clip((_wenli_var.r*_rongjiekongzhi_var) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float _Specular_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Specular );
                float3 specularColor = float3(_Specular_var,_Specular_var,_Specular_var);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float _DiffusePower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffusePower );
                float3 directDiffuse = pow(max( 0.0, NdotL), _DiffusePower_var) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _node_6134_var = tex2D(_node_6134,TRANSFORM_TEX(i.uv0, _node_6134));
                float4 _node_1386_var = tex2D(_node_1386,TRANSFORM_TEX(i.uv0, _node_1386));
                float3 diffuseColor = (_node_6134_var.r*_node_1386_var.rgb);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _node_1386; uniform float4 _node_1386_ST;
            uniform sampler2D _node_4343; uniform float4 _node_4343_ST;
            uniform sampler2D _node_6134; uniform float4 _node_6134_ST;
            uniform sampler2D _wenli; uniform float4 _wenli_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _faqiang)
                UNITY_DEFINE_INSTANCED_PROP( float, _DiffusePower)
                UNITY_DEFINE_INSTANCED_PROP( float, _Specular)
                UNITY_DEFINE_INSTANCED_PROP( float, _rongjiekongzhi)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float _faqiang_var = UNITY_ACCESS_INSTANCED_PROP( Props, _faqiang );
                float3 _node_4343_var = UnpackNormal(tex2D(_node_4343,TRANSFORM_TEX(i.uv0, _node_4343)));
                float3 normalLocal = (_faqiang_var*_node_4343_var.rgb);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 _wenli_var = tex2D(_wenli,TRANSFORM_TEX(i.uv0, _wenli));
                float _rongjiekongzhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _rongjiekongzhi );
                clip((_wenli_var.r*_rongjiekongzhi_var) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float _Specular_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Specular );
                float3 specularColor = float3(_Specular_var,_Specular_var,_Specular_var);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float _DiffusePower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffusePower );
                float3 directDiffuse = pow(max( 0.0, NdotL), _DiffusePower_var) * attenColor;
                float4 _node_6134_var = tex2D(_node_6134,TRANSFORM_TEX(i.uv0, _node_6134));
                float4 _node_1386_var = tex2D(_node_1386,TRANSFORM_TEX(i.uv0, _node_1386));
                float3 diffuseColor = (_node_6134_var.r*_node_1386_var.rgb);
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
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
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _wenli; uniform float4 _wenli_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _rongjiekongzhi)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _wenli_var = tex2D(_wenli,TRANSFORM_TEX(i.uv0, _wenli));
                float _rongjiekongzhi_var = UNITY_ACCESS_INSTANCED_PROP( Props, _rongjiekongzhi );
                clip((_wenli_var.r*_rongjiekongzhi_var) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
