/*
 Original file :
 Storage for distribution - phi16
 https://github.com/phi16/VRC_storage
 rounded_trail.unitypackage
 LICENSE : CC0
*/

// 2019-09-26 customized for QvPen v2.
// 2019-09-09 customized for QvPen.

Shader "Unlit/rounded_trail_for_qv_pen"
{
	Properties
	{
		_Color ("Solid Color", Color) = (1,1,1,1)
		_Width ("Width", Float) = 0.03
	}
	SubShader
	{
		Tags { "Queue"="Transparent+1" "RenderType"="Transparent" }
		LOD 100
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2g
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct g2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float d : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _Color;
			float _Width;
			float _Invisible;
			
			v2g vert (appdata v)
			{
				v2g o;
				o.vertex = v.vertex;
				o.uv = v.uv;
				return o;
			}

			[maxvertexcount(10)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> stream) {
				g2f o;
				if(IN[0].uv.x + IN[2].uv.x > IN[1].uv.x * 2) return;
				float3 p = IN[0].vertex.xyz, v = IN[1].vertex.xyz;
				v -= p;
				
				float4 vp1 = UnityObjectToClipPos(p);
				float4 vp2 = UnityObjectToClipPos(p + v);
				float2 vd = vp1.xy / vp1.w - vp2.xy / vp2.w;
				float aspectRatio = - _ScreenParams.y / _ScreenParams.x;
				vd.x /= aspectRatio;
				o.d = length(vd);
				if(length(vd) < 0.0001) vd = float2(1,0);
				else vd = normalize(vd);
				float2 vn = vd.yx * float2(-1,1);
				
				float2 sz = _Width;
				sz.x *= aspectRatio;
				sz *= unity_CameraProjection._m11 / sqrt(3);
				vn *= sz;
				
				if(length(v) < 1) {
					o.d = 0;
					o.uv = float2(-1,-1);
					o.vertex = vp1+float4(+vn,0,0);
					stream.Append(o);
					o.uv = float2(-1,1);
					o.vertex = vp1+float4(-vn,0,0);
					stream.Append(o);
					o.uv = float2(1,-1);
					o.vertex = vp2+float4(+vn,0,0);
					stream.Append(o);
					o.uv = float2(1,1);
					o.vertex = vp2+float4(-vn,0,0);
					stream.Append(o);
					stream.RestartStrip();
				}
				
				o.d = 1;
				sz *= 2.0;
				if(IN[1].uv.x >= 1) {
					o.uv = float2(0,1);
					o.vertex = vp2+float4(o.uv*sz,0,0);
					stream.Append(o);
					o.uv = float2(-0.9,-0.5);
					o.vertex = vp2+float4(o.uv*sz,0,0);
					stream.Append(o);
					o.uv = float2(0.9,-0.5);
					o.vertex = vp2+float4(o.uv*sz,0,0);
					stream.Append(o);
					stream.RestartStrip();
				}
				
				o.uv = float2(0,1);
				o.vertex = vp1+float4(o.uv*sz,0,0);
				stream.Append(o);
				o.uv = float2(-0.9,-0.5);
				o.vertex = vp1+float4(o.uv*sz,0,0);
				stream.Append(o);
				o.uv = float2(0.9,-0.5);
				o.vertex = vp1+float4(o.uv*sz,0,0);
				stream.Append(o);
				stream.RestartStrip();
			}
			
			fixed4 frag (g2f i) : SV_Target
			{
				float l = length(i.uv);
				clip(- min(i.d - 0.5, l - 0.5));
				return float4(_Color.xyz,1);
			}
			ENDCG
		}
	}
}
