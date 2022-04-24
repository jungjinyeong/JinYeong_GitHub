// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:Legacy Shaders/Diffuse,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:0,x:35652,y:33101,varname:node_0,prsc:2|custl-7908-OUT,olwid-5886-OUT,olcol-4533-OUT;n:type:ShaderForge.SFN_Dot,id:40,x:33494,y:33097,varname:node_40,prsc:2,dt:1|A-42-OUT,B-41-OUT;n:type:ShaderForge.SFN_NormalVector,id:41,x:33203,y:33135,prsc:2,pt:True;n:type:ShaderForge.SFN_LightVector,id:42,x:33203,y:33016,varname:node_42,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:9233,x:33203,y:33549,varname:_node_9643_copy,prsc:2,ntxv:0,isnm:False|TEX-9167-TEX;n:type:ShaderForge.SFN_Tex2d,id:9120,x:33203,y:33322,varname:_node_9643_copy_copy,prsc:2,ntxv:0,isnm:False|TEX-9167-TEX;n:type:ShaderForge.SFN_Vector1,id:7888,x:33203,y:33274,varname:node_7888,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Subtract,id:9664,x:33493,y:33308,varname:node_9664,prsc:2|A-7888-OUT,B-9120-G;n:type:ShaderForge.SFN_Subtract,id:2990,x:33709,y:33107,varname:node_2990,prsc:2|A-40-OUT,B-9664-OUT;n:type:ShaderForge.SFN_If,id:3046,x:33922,y:33199,varname:node_3046,prsc:2|A-2990-OUT,B-2817-OUT,GT-6943-OUT,EQ-1346-OUT,LT-1346-OUT;n:type:ShaderForge.SFN_Slider,id:2817,x:33415,y:33251,ptovrint:False,ptlb:ShadowRange,ptin:_ShadowRange,varname:node_2817,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Vector1,id:6943,x:33625,y:33360,varname:node_6943,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:1346,x:33625,y:33405,varname:node_1346,prsc:2,v1:0;n:type:ShaderForge.SFN_ViewVector,id:5884,x:33203,y:33438,varname:node_5884,prsc:2;n:type:ShaderForge.SFN_Dot,id:8748,x:33387,y:33405,varname:node_8748,prsc:2,dt:1|A-5884-OUT,B-41-OUT;n:type:ShaderForge.SFN_Power,id:8417,x:33560,y:33489,varname:node_8417,prsc:2|VAL-8748-OUT,EXP-9233-R;n:type:ShaderForge.SFN_Clamp01,id:3305,x:33738,y:33489,varname:node_3305,prsc:2|IN-8417-OUT;n:type:ShaderForge.SFN_Slider,id:6765,x:33581,y:33619,ptovrint:False,ptlb:SpecularRange,ptin:_SpecularRange,varname:node_6765,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.9,cur:0.9820514,max:1;n:type:ShaderForge.SFN_If,id:526,x:33926,y:33488,varname:node_526,prsc:2|A-3305-OUT,B-6765-OUT,GT-8750-OUT,EQ-4786-OUT,LT-4786-OUT;n:type:ShaderForge.SFN_Vector1,id:8750,x:33738,y:33681,varname:node_8750,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:4786,x:33738,y:33723,varname:node_4786,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:6065,x:34095,y:33488,varname:node_6065,prsc:2|A-526-OUT,B-9233-B;n:type:ShaderForge.SFN_If,id:8645,x:34300,y:33542,varname:node_8645,prsc:2|A-6065-OUT,B-5365-OUT,GT-3087-OUT,EQ-10-OUT,LT-10-OUT;n:type:ShaderForge.SFN_Vector1,id:5365,x:34094,y:33608,varname:node_5365,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:3087,x:34094,y:33658,varname:node_3087,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:10,x:34094,y:33704,varname:node_10,prsc:2,v1:0;n:type:ShaderForge.SFN_Blend,id:1398,x:33895,y:32823,varname:node_1398,prsc:2,blmd:10,clmp:True|SRC-7076-G,DST-6629-RGB;n:type:ShaderForge.SFN_Tex2d,id:7076,x:33239,y:32753,varname:_node_9643_copy_copy_copy,prsc:2,ntxv:0,isnm:False|TEX-9167-TEX;n:type:ShaderForge.SFN_Tex2d,id:6629,x:33690,y:32869,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_Diffuse_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6970,x:34113,y:33174,ptovrint:False,ptlb:ShadowIntensity,ptin:_ShadowIntensity,varname:_DiffuseLightness_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7956449,max:1;n:type:ShaderForge.SFN_Multiply,id:8078,x:34502,y:32824,cmnt:Diffuse,varname:node_8078,prsc:2|A-1398-OUT,B-9458-OUT;n:type:ShaderForge.SFN_OneMinus,id:4552,x:34660,y:33149,varname:node_4552,prsc:2|IN-9597-OUT;n:type:ShaderForge.SFN_Multiply,id:7944,x:34857,y:33128,cmnt:Shadow,varname:node_7944,prsc:2|A-2807-OUT,B-4552-OUT;n:type:ShaderForge.SFN_Add,id:2201,x:35061,y:33097,varname:node_2201,prsc:2|A-9930-OUT,B-7944-OUT;n:type:ShaderForge.SFN_Slider,id:2573,x:34105,y:33423,ptovrint:False,ptlb:SpecularMult,ptin:_SpecularMult,varname:node_2573,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:8854,x:34437,y:33396,varname:node_8854,prsc:2|A-2344-OUT,B-2573-OUT;n:type:ShaderForge.SFN_Multiply,id:3419,x:34623,y:33496,varname:node_3419,prsc:2|A-8854-OUT,B-8645-OUT;n:type:ShaderForge.SFN_Multiply,id:6858,x:34817,y:33460,cmnt:Specular,varname:node_6858,prsc:2|A-1762-OUT,B-3419-OUT;n:type:ShaderForge.SFN_Add,id:3357,x:35290,y:33157,varname:node_3357,prsc:2|A-2201-OUT,B-6858-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:9167,x:32870,y:33120,ptovrint:False,ptlb:SpeShaTex,ptin:_SpeShaTex,varname:node_9167,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9989,x:35079,y:33354,ptovrint:False,ptlb:ShadowColorTex,ptin:_ShadowColorTex,varname:_MainTex_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4533,x:35290,y:33400,varname:node_4533,prsc:2|A-9989-RGB,B-8823-OUT;n:type:ShaderForge.SFN_Slider,id:8823,x:34922,y:33519,ptovrint:False,ptlb:OutlineLightness,ptin:_OutlineLightness,varname:node_8823,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:5886,x:34922,y:33604,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_5886,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.01581197,max:0.05;n:type:ShaderForge.SFN_Color,id:3561,x:34228,y:33027,ptovrint:False,ptlb:ShadowColor,ptin:_ShadowColor,varname:node_3561,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6663285,c2:0.6544118,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:2807,x:34486,y:33017,varname:node_2807,prsc:2|A-1398-OUT,B-3561-RGB,C-6970-OUT;n:type:ShaderForge.SFN_Set,id:780,x:34667,y:32824,varname:Diffuse,prsc:2|IN-8078-OUT;n:type:ShaderForge.SFN_Get,id:2344,x:34241,y:33364,varname:node_2344,prsc:2|IN-780-OUT;n:type:ShaderForge.SFN_Get,id:9930,x:34836,y:33052,varname:node_9930,prsc:2|IN-780-OUT;n:type:ShaderForge.SFN_Get,id:9597,x:34465,y:33149,varname:node_9597,prsc:2|IN-2937-OUT;n:type:ShaderForge.SFN_Set,id:2937,x:34105,y:33263,varname:DiffuseIf,prsc:2|IN-3046-OUT;n:type:ShaderForge.SFN_Get,id:9458,x:34275,y:32860,varname:node_9458,prsc:2|IN-2937-OUT;n:type:ShaderForge.SFN_Get,id:1762,x:34602,y:33453,varname:node_1762,prsc:2|IN-2937-OUT;n:type:ShaderForge.SFN_Multiply,id:7908,x:35432,y:32993,varname:node_7908,prsc:2|A-4235-RGB,B-3357-OUT;n:type:ShaderForge.SFN_Color,id:4235,x:35108,y:32885,ptovrint:False,ptlb:tex_color,ptin:_tex_color,varname:node_4235,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;proporder:4235-6629-9167-9989-3561-2817-6970-6765-2573-5886-8823;pass:END;sub:END;*/

Shader "Quadratic/Quadratic element" {
    Properties {
        [HDR]_tex_color ("tex_color", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _SpeShaTex ("SpeShaTex", 2D) = "white" {}
        _ShadowColorTex ("ShadowColorTex", 2D) = "white" {}
        [HDR]_ShadowColor ("ShadowColor", Color) = (0.6663285,0.6544118,1,1)
        _ShadowRange ("ShadowRange", Range(0, 1)) = 0
        _ShadowIntensity ("ShadowIntensity", Range(0, 1)) = 0.7956449
        _SpecularRange ("SpecularRange", Range(0.9, 1)) = 0.9820514
        _SpecularMult ("SpecularMult", Range(0, 1)) = 1
        _OutlineWidth ("OutlineWidth", Range(0, 0.05)) = 0.01581197
        _OutlineLightness ("OutlineLightness", Range(0, 1)) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            uniform sampler2D _ShadowColorTex; uniform float4 _ShadowColorTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _OutlineLightness)
                UNITY_DEFINE_INSTANCED_PROP( float, _OutlineWidth)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                float _OutlineWidth_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineWidth );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineWidth_var,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _ShadowColorTex_var = tex2D(_ShadowColorTex,TRANSFORM_TEX(i.uv0, _ShadowColorTex));
                float _OutlineLightness_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineLightness );
                return fixed4((_ShadowColorTex_var.rgb*_OutlineLightness_var),0);
            }
            ENDCG
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
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _SpeShaTex; uniform float4 _SpeShaTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _ShadowRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _ShadowIntensity)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularMult)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ShadowColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _tex_color)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float4 _tex_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _tex_color );
                float4 _node_9643_copy_copy_copy = tex2D(_SpeShaTex,TRANSFORM_TEX(i.uv0, _SpeShaTex));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 node_1398 = saturate(( _MainTex_var.rgb > 0.5 ? (1.0-(1.0-2.0*(_MainTex_var.rgb-0.5))*(1.0-_node_9643_copy_copy_copy.g)) : (2.0*_MainTex_var.rgb*_node_9643_copy_copy_copy.g) ));
                float4 _node_9643_copy_copy = tex2D(_SpeShaTex,TRANSFORM_TEX(i.uv0, _SpeShaTex));
                float _ShadowRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ShadowRange );
                float node_3046_if_leA = step((max(0,dot(lightDirection,normalDirection))-(0.5-_node_9643_copy_copy.g)),_ShadowRange_var);
                float node_3046_if_leB = step(_ShadowRange_var,(max(0,dot(lightDirection,normalDirection))-(0.5-_node_9643_copy_copy.g)));
                float node_1346 = 0.0;
                float DiffuseIf = lerp((node_3046_if_leA*node_1346)+(node_3046_if_leB*1.0),node_1346,node_3046_if_leA*node_3046_if_leB);
                float3 Diffuse = (node_1398*DiffuseIf);
                float4 _ShadowColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ShadowColor );
                float _ShadowIntensity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ShadowIntensity );
                float _SpecularMult_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularMult );
                float4 _node_9643_copy = tex2D(_SpeShaTex,TRANSFORM_TEX(i.uv0, _SpeShaTex));
                float _SpecularRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularRange );
                float node_526_if_leA = step(saturate(pow(max(0,dot(viewDirection,normalDirection)),_node_9643_copy.r)),_SpecularRange_var);
                float node_526_if_leB = step(_SpecularRange_var,saturate(pow(max(0,dot(viewDirection,normalDirection)),_node_9643_copy.r)));
                float node_4786 = 0.0;
                float node_8645_if_leA = step((lerp((node_526_if_leA*node_4786)+(node_526_if_leB*1.0),node_4786,node_526_if_leA*node_526_if_leB)*_node_9643_copy.b),0.1);
                float node_8645_if_leB = step(0.1,(lerp((node_526_if_leA*node_4786)+(node_526_if_leB*1.0),node_4786,node_526_if_leA*node_526_if_leB)*_node_9643_copy.b));
                float node_10 = 0.0;
                float3 finalColor = (_tex_color_var.rgb*((Diffuse+((node_1398*_ShadowColor_var.rgb*_ShadowIntensity_var)*(1.0 - DiffuseIf)))+(DiffuseIf*((Diffuse*_SpecularMult_var)*lerp((node_8645_if_leA*node_10)+(node_8645_if_leB*1.0),node_10,node_8645_if_leA*node_8645_if_leB)))));
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Legacy Shaders/Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
