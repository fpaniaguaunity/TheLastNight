Shader "Unlit/RefractionShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_HorizontalDist("Horizontal Distorsion", Range(0,1)) = 0
		_VerticalDist("Vertical Distorsion", Range(0,1)) = 0
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
		LOD 100
		GrabPass{
			//Captura el contenido de la pantalla y lo almacena en una textura (por defecto _GrabTexture)
			"_ScreenTexture"
		}
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
			  float2 uv : TEXCOORD0;
			  float4 vertex : SV_POSITION;
			  float4 screenUV : TEXCOORD1;//tex2Dproj() utiliza float4
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _VerticalDist;
			float _HorizontalDist;
			float4 _Color;

			sampler2D _ScreenTexture;//Textura

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.screenUV = ComputeGrabScreenPos(o.vertex);//Obtiene las coordenadas de la pantalla para aplicarlo en text2Dproj
				return o;
			}

			
			fixed4 frag(v2f i) : SV_Target{
				float4 newUV = i.screenUV;
				newUV.x += _HorizontalDist*i.uv.y;
				newUV.y += _VerticalDist;
				//fixed4 grab = tex2D(_ScreenTexture, i.uv);Proyecta toda la pantalla sobre el objeto
				//fixed4 grab = tex2Dproj(_ScreenTexture, i.screenUV);//Proyecta la parte de la pantalla correspondiente al objeto
				fixed4 grab = tex2Dproj(_ScreenTexture,i.screenUV + newUV);//Desplaza la proyección
				grab.rgb *= _Color;
				return grab;
			}
		ENDCG
		}
	}
}
