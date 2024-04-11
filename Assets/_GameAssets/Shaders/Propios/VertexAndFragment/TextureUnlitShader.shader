Shader "Unlit/TextureShader"
{
    Properties
    {
        //white=> color por defecto
        _MainText("Texture", 2D) = "white"{} 
        _Color("Tint", Color) = (1,1,1,1)
    }
        Subshader
        {
            Pass
            {
                CGPROGRAM
                #pragma vertex vertexShaderx
                #pragma fragment fragmentShader
                #include "UnityCG.cginc"

                //Se conecta con la propiedades
                uniform sampler2D _MainText;
                //Se conecta posteriormente con el offset y el tiling. 
                //Tiene que llamarse igual que la anterior con _ST
                uniform float4 _MainText_ST;
                uniform float4 _Color;

                struct vertexInput
                {
                    //Almacena los vértices del mesh
                    float4 vertex : POSITION;
                    //Coordenadas de los UV. Puede haber TEXCOORD1,2... 
                    float2 uv : TEXCOORD0; 
                };
                struct vertexOutput
                {
                    //Nuevas coordenadas
                    float4 position: SV_POSITION;
                    float2 uv : TEXTCOORD0;
                };

                vertexOutput vertexShaderx(vertexInput i) {
                    vertexOutput o;
                    //Los vértices en proyection space.
                    o.position = UnityObjectToClipPos(i.vertex);
                    //o.uv = i.uv; //Coordenadas de los uv.
                    //o.uv = (i.uv * _MainText_ST.xy + _MainText_ST.zw);
                    o.uv = TRANSFORM_TEX(i.uv, _MainText);//Está línea es la misma que la anterior
                    return o;
                }
                fixed4 fragmentShader(vertexOutput o) : SV_TARGET
                {
                    fixed4 col = tex2D(_MainText, o.uv) * _Color;
                    return col;
                }
                ENDCG
            }
        }
}