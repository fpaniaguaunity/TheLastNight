Shader "Unlit/MathHologramShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        _Alpha("Alpha", Range(0,1)) = 0.5
        _Frecuencia("Frecuencia", Range(2,100)) = 5
        _Velocidad("Velocidad", Range(-10,10)) = 1
    }
        SubShader
        {
            Tags {
                "RenderType" = "Opaque"
                "Queue" = "Transparent"
            }
            ZWrite Off
            Blend SrcAlpha One
            BlendOp Add //Mezcla por defecto

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
                float _Alpha;
                float4 _Color;
                float _Frecuencia;
                float _Velocidad;

                v2f vert(appdata v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    o.uv.y += _Time * _Velocidad;
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
                    col.a = abs(sin(i.uv.y * _Frecuencia));
                    col.a = clamp(col.a, 0, _Alpha);
                    return col;
                }
                ENDCG
            }
        }
}
