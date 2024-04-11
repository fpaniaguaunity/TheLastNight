Shader "Unlit/SeaShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed ("Speed", Range(0,5)) = 1
        _Frecuency("Frecuency", Range(0,5)) = 1
        _Amplitude("Amplitude", Range(0,5)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Speed;
            float _Frecuency;
            float _Amplitude;

            float4 flag(float4 vertexPosition, float2 uv) {
                const float pi = 3.14159;
                float y = sin((uv.x - (_Time.y * _Speed)) * _Frecuency) * sin(uv.x*pi) * sin(uv.y*pi) *  _Amplitude;
                vertexPosition.y += y;
                float4 vertex = UnityObjectToClipPos(vertexPosition);
                return vertex;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = flag(v.vertex, v.uv);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
