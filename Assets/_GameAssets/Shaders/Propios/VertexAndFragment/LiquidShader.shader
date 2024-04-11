Shader "Unlit/LiquidShader"
{
    Properties
    {
        _TopColor("Top Color", Color) = (0,1,1,1)
        _MidColor("Middle Color", Color) = (1,0,1,1)
        _BaseColor("Base Color", Color) = (1,1,0,1)
        _LiquidAmount("Liquid Amount", Range(-2,2)) = 0
        _MidAmount("Middle Amount", Range(0, 0.2)) = 0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "DisableBatching" = "True"}
        ZWrite On
        Cull Off
        AlphaToMask On

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
                float liquidEdge : TEXCOORD1;
            };

            float4 _TopColor;
            float4 _MidColor;
            float4 _BaseColor;
            float _LiquidAmount;
            float _MidAmount;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                //mul --> Multiplica una matriz por otra
                float3 worldPosition = mul(unity_ObjectToWorld, v.vertex.xyz);
                //La y determina la orientación. liquidEdge es el umbral del líquido
                o.liquidEdge = worldPosition.y + _LiquidAmount;
                return o;
            }

            fixed4 frag(v2f i, fixed facing : VFACE) : SV_Target
            {
                //step (0 ó 1) - smoothstep (interpolación)
                fixed4 midEdge = step(i.liquidEdge, 0.5) - smoothstep(i.liquidEdge, 0.5, (0.5 - _MidAmount));
                fixed4 midEdgeColor = midEdge * _MidColor;

                fixed4 base = step(i.liquidEdge, 0.5) - midEdge;
                fixed4 baseColor = base * _BaseColor;

                fixed4 renderBase = baseColor + midEdgeColor;
                fixed4 renderTop = _TopColor * (midEdge + base);

                return facing > 0 ? renderBase : renderTop;
            }
            ENDCG
        }
    }
}
