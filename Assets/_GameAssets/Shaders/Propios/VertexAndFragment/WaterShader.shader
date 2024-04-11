Shader "Unlit/Water"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DisText("Distortion Texture", 2D) = "white" {}
        [Space(10)]
        _DisSpeed("Distortion Speed", Range(-0.4, 0.4)) = 0.1
        _DisValue("Distortion Value", Range(2, 10)) = 3
        [Space(10)]
        _Transparency("Transparency", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
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
            sampler2D _DisText;
            float _DisSpeed;
            float _DisValue;
            float _Transparency;

            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed distortion = tex2D(_DisText, i.uv + (_Time * _DisSpeed)).r;
                i.uv += distortion / _DisValue;
                fixed4 col = tex2D(_MainTex, i.uv);
                col.a = _Transparency;
                return col;
            }
            ENDCG
        }
    }
}