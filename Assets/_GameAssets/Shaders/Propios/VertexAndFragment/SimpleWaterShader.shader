Shader "Unlit/SimpleWater"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _DisValue("Distortion Value", Range(2, 10)) = 3
        _Transparency("Transparency", Range(0,1)) = 1
    }
        SubShader
        {
            Tags { "Queue" = "Transparent" }
            Blend SrcAlpha OneMinusSrcAlpha

            Pass //TexturePass -----------
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
                float _DisValue;
                float _Transparency;

                float4 _MainTex_ST;

                v2f vert(appdata v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    fixed distortion = tex2D(_MainTex, i.uv + _Time).r;
                    i.uv += distortion / _DisValue;
                    fixed4 col = tex2D(_MainTex, i.uv);
                    col.a = _Transparency;
                    return col;
                }
                ENDCG
            }
        }
}
