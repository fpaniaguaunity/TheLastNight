Shader "Custom/Slice" {
    Properties{
      _MainTex("Texture", 2D) = "white" {}
      _BumpMap("Bumpmap", 2D) = "bump" {}
    }
        SubShader{
          Tags { "RenderType" = "Opaque" }
          CGPROGRAM
          #pragma surface surf Lambert
          struct Input {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 worldPos;
          };

          sampler2D _MainTex;
          sampler2D _BumpMap;

          void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            clip(frac((IN.worldPos.y * 0.01 + IN.worldPos.z) * 10) - 0.2);
            //clip(fmod(IN.worldPos.z, 2));
          }
          ENDCG
    }
        Fallback "Diffuse"
}
