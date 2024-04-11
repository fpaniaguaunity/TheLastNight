Shader "Unlit/SimpleNormalShader"
{
    //No tiene propiedades
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert //Directiva, declara la función vert de tipo vertex
            #pragma fragment frag //", frag, de tipo fragment
            #include "UnityCG.cginc"

            struct v2f
            {
                //flotante, half precision, 3 decimales ->direcciones
                half3 worldNormal : TEXCOORD0;
                //flotante, la más alta precisión, posiciones 3d, texturas, operaciones trigonométricas
                float4 pos : SV_POSITION;
            };

            v2f vert (float4 vertex : POSITION, float3 normal : NORMAL)
            {
                v2f o;
                //Transforma un punto del espacio del objeto al espacio de la cámara
                o.pos = UnityObjectToClipPos(vertex);
                //Transforma las normales del espacio del objeto al espacio de la cámara
                o.worldNormal = UnityObjectToWorldNormal(normal);
                //o.pos += o.worldNormal.x + _SinTime;//Locura
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = 0;
                col.rgb = i.worldNormal;//Asignación del valor de la normal al rgb
                //col.rgb = i.worldNormal * -1;//Inversión del color
                //col.r = i.worldNormal;//Asignación al rojo
                /*
                //Condiciona el color a la normal
                if (i.worldNormal.z > 0) {
                    col.r = i.worldNormal.z;
                }
                else {
                    col.rgb = 1;
                }
                */
                return col;
            }
            ENDCG
        }
    }
}
