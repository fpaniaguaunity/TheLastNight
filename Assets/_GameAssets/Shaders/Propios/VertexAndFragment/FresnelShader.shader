Shader "Unlit/FresnelShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Back Color", Color) = (1,1,1,1)
        _FresnelColor("Fresnel Color", Color) = (1,1,1,1)
        _Power ("Fresnel Power", Range(0,5)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Blend SrcAlpha OneMinusSrcAlpha

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
                float4 normal: NORMAL;//NORMAL
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal: COLOR;//COLOR 
                float3 viewDir: COLOR1;//COLOR1, PORQUE COLOR ESTÁ USADO
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _FresnelColor;
            float _Power;
            float4 _Color;

            void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
            {
                Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //Normales
                o.normal = v.normal;
                //ObjSpaceViewDir proporciona la dirección de un vértice hacia la cámara
                //No está normalizada.
                o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //Variable de fresnel
                fixed fresnel = 0;
                //https://docs.unity3d.com/Packages/com.unity.shadergraph@6.9/manual/Fresnel-Effect-Node.html
                Unity_FresnelEffect_float(i.normal, i.viewDir, _Power, fresnel);
                //A partir del frescel, aplica el color
                fixed4 fresnelColor = fresnel * _FresnelColor;
                //Aplicando textura
                //fixed4 col = tex2D(_MainTex, i.uv);
                //Aplicando color
                fixed4 col = _Color;
                col+= fresnelColor;//Agrega el fresnel
                return col;
            }
            ENDCG
        }
    }
}
