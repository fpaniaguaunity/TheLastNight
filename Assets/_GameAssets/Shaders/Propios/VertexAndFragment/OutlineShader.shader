Shader "Unlit/OutlineShader" {
	Properties{
		_Color("Main Color", Color) = (.5,.5,.5,1)
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_Outline("Outline width", Range(0, 1)) = .1
		_MainTex("Base (RGB)", 2D) = "white" { }
	}

		CGINCLUDE
#include "UnityCG.cginc"
		struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : POSITION;
		float4 color : COLOR;
	};

	//uniform indica que no cambian
	uniform float _Outline;
	uniform float4 _OutlineColor;

	v2f vert(appdata v) {
		v2f o;
		v.vertex *= (1 + _Outline);
		/*
		v.vertex.x *= (1 + _Outline);
		v.vertex.y *= (1 + _Outline);
		*/
		o.pos = UnityObjectToClipPos(v.vertex);
		o.color = _OutlineColor;
		return o;
	}
	ENDCG

		SubShader{
			CGPROGRAM
			#pragma surface surf Lambert
			sampler2D _MainTex;
			fixed4 _Color;
			struct Input {
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}
			ENDCG

				//Pass-->Renderizado
				Pass {
					Name "OUTLINE"
					Tags { "LightMode" = "Always" }
					Cull Front //Culling mode (Front, Back, Off)
					ZWrite On //Modo de escritura del buffer de produndidad
					ColorMask RGB //Máscara de color, combinacines de R, G, B, A, 0
					Blend SrcAlpha OneMinusSrcAlpha //Alpha blending

					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					half4 frag(v2f i) :COLOR { return i.color; }
					ENDCG
				}
	}
		Fallback "Diffuse"
}