Shader "Unlit/NormalAnimatorShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed("Speed",Range(1,10)) = 5 //VELOCIDAD
        _Amplitud("Amplitud", Range(0,1))=1 //AMPLITUD
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float4 normal : NORMAL;//DECLARACIÓN DE NORMALES
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Speed;
            float _Amplitud;

            //Funcion de calculo de direccion
            float4 direccion(float4 vertexPos, float4 normalPos) {
                vertexPos += ((cos(_Time.y * _Speed) + 1) * _Amplitud) * normalPos;
                //vertexPos += ((cos(_Time.y * _Speed) + 1) * _Amplitud) * vertexPos;
                float4 vertex = UnityObjectToClipPos(vertexPos);
                return vertex;
            }

            v2f vert (appdata v)
            {
                v2f o;
                //o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertex = direccion(v.vertex, v.normal);//Sustituye a la línea anterior
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
