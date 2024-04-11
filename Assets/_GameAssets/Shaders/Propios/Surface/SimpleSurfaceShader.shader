Shader "Custom/SimpleSurfaceShader"
{
    SubShader{
        Tags { "RenderType" = "Opaque" }
        CGPROGRAM
        //#pragma surface surf BlinnPhong
        #pragma surface surf Lambert
        struct Input {
            float4 color : COLOR;
        };
        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = 1;
            //o.Albedo = fixed3(0,0.7,0);
        }
        ENDCG
    }
    Fallback "Diffuse"
}
