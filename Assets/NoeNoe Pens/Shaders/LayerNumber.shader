// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-2521-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32198,y:32876,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2460,x:32198,y:32687,ptovrint:False,ptlb:SpriteSheet,ptin:_SpriteSheet,varname:node_2460,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6537-OUT;n:type:ShaderForge.SFN_TexCoord,id:7314,x:31526,y:32667,varname:node_7314,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Append,id:6537,x:31944,y:32687,varname:node_6537,prsc:2|A-7314-U,B-4781-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:4781,x:31957,y:32537,varname:node_4781,prsc:2|IN-7314-V,IMIN-8680-R,IMAX-8680-G,OMIN-7029-OUT,OMAX-6225-OUT;n:type:ShaderForge.SFN_Vector2,id:2580,x:31957,y:32311,varname:node_2580,prsc:2,v1:0,v2:1;n:type:ShaderForge.SFN_ComponentMask,id:8680,x:31957,y:32394,varname:node_8680,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2580-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5827,x:31291,y:32410,ptovrint:False,ptlb:Layer,ptin:_Layer,varname:node_5827,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Divide,id:6225,x:31641,y:32466,varname:node_6225,prsc:2|A-8518-OUT,B-8132-OUT;n:type:ShaderForge.SFN_Vector1,id:8132,x:31478,y:32600,varname:node_8132,prsc:2,v1:5;n:type:ShaderForge.SFN_Subtract,id:7029,x:31641,y:32327,varname:node_7029,prsc:2|A-6225-OUT,B-9255-OUT;n:type:ShaderForge.SFN_Vector1,id:9255,x:31641,y:32278,varname:node_9255,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Multiply,id:2521,x:32459,y:32807,varname:node_2521,prsc:2|A-2460-RGB,B-7241-RGB;n:type:ShaderForge.SFN_Subtract,id:8518,x:31478,y:32466,varname:node_8518,prsc:2|A-4295-OUT,B-5827-OUT;n:type:ShaderForge.SFN_Vector1,id:4295,x:31291,y:32466,varname:node_4295,prsc:2,v1:6;proporder:7241-2460-5827;pass:END;sub:END;*/

Shader "NoeNoe/LayerNumber" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _SpriteSheet ("SpriteSheet", 2D) = "white" {}
        _Layer ("Layer", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _SpriteSheet; uniform float4 _SpriteSheet_ST;
            uniform float _Layer;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float2 node_8680 = float2(0,1).rg;
                float node_6225 = ((6.0-_Layer)/5.0);
                float node_7029 = (node_6225-0.2);
                float2 node_6537 = float2(i.uv0.r,(node_7029 + ( (i.uv0.g - node_8680.r) * (node_6225 - node_7029) ) / (node_8680.g - node_8680.r)));
                float4 _SpriteSheet_var = tex2D(_SpriteSheet,TRANSFORM_TEX(node_6537, _SpriteSheet));
                float3 emissive = (_SpriteSheet_var.rgb*_Color.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
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
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
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
