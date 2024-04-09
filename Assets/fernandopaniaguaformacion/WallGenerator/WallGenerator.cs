using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class WallGenerator : MonoBehaviour
{
    [Header("Collider del terreno a delimitar")]
    public Collider baseCollider;
    private GameObject[] muros= new GameObject[4];
    [Header("¡Importante! Activa para generar")]
    public bool generar;
    [Header("Activa para eliminar")]
    public bool eliminar = true;
    [Header("Profundidad del muro")]
    [Range(0, 10)]
    public float profundidad = 0.1f;
    [Header("Altura del muro")]
    [Range(0, 50)]
    public float altura = 2f;

    private static string rootGameObjectName;
    void Awake()
    {
        rootGameObjectName = gameObject.name + "WallContainer";
        GameObject root = GameObject.Find(rootGameObjectName);
        Bounds bounds = baseCollider.bounds;

        if (eliminar && root != null)
        {
            eliminar = false;
            Transform[] existingItems = root.GetComponentsInChildren<Transform>();
            foreach (Transform t in existingItems)
            {
                if (t != null && t != transform)
                {
                    DestroyImmediate(t.gameObject);
                }
            }
        }
        if (generar && !Application.isPlaying)
        {
            generar = false;
            eliminar = false;
            if (root == null)
            {
                root = new GameObject(rootGameObjectName);
                root.transform.SetParent(transform);
                root.transform.localPosition = Vector3.zero;
                //Si es un terreno, el pivote se encuentra en un vértice y hay que calcular el centro
                Terrain terrain = gameObject.GetComponentInChildren<Terrain>();
                if (terrain != null)
                {
                    print(terrain.terrainData.size.x);
                    root.transform.Translate(terrain.terrainData.size.x * 0.5f, 0, terrain.terrainData.size.z * 0.5f);
                }
            }
            for (int i=0; i<muros.Length; i++)
            {
                muros[i] = GameObject.CreatePrimitive(PrimitiveType.Cube);
                muros[i].transform.SetParent(root.transform);
                muros[i].transform.localPosition = Vector3.zero;
                muros[i].transform.rotation = Quaternion.identity;
                muros[i].transform.localScale = new Vector3(bounds.size.x, altura, profundidad);
                muros[i].transform.Translate(0, altura * 0.5f, 0);
                muros[i].transform.Rotate(0, i * 90, 0);
                muros[i].transform.Translate(Vector3.forward * bounds.size.x * 0.5f);
                muros[i].gameObject.name = "Wall" + i;
            }
        }
    }
}
