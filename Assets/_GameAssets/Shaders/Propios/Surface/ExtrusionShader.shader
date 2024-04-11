Shader "Custom/Extrusion" {
    Properties{
      _MainTex("Texture", 2D) = "white" {}
      _BumpMap("Bumpmap", 2D) = "bump" {}
    }
        SubShader{
          Tags { "RenderType" = "Opaque" }
          CGPROGRAM
          #pragma surface surf Lambert vertex:vert
          struct Input {
            float2 uv_MainTex;
            float2 uv_BumpMap;
          };
          
          sampler2D _MainTex;
          sampler2D _BumpMap;
          
          void vert(inout appdata_full v) {
              v.vertex.xyz += v.normal * 0.05f;
              //v.vertex.xyz -= v.normal * 0.05f;
              //v.vertex.xyz += v.normal * abs(_SinTime * 2) * 0.01;
          }

          void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
          }
          ENDCG
    }
        Fallback "Diffuse"
}
