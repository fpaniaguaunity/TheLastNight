using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemigoDisparador : MonoBehaviour
{
    public Transform puntoDisparo;
    public GameObject prefabProyectil;
    public float fuerzaDisparo;
    public float distanciaDisparo;
    public float cadenciaDisparo;
    public string targetTag;
    private Transform targetTransform;
    private bool isADistancia = false;
    void Start()
    {
        targetTransform = GameObject.FindGameObjectWithTag(targetTag).transform;
        InvokeRepeating("Disparar",0,cadenciaDisparo);
    }

    void Update()
    {
        isADistancia = (targetTransform.position - puntoDisparo.position).magnitude<distanciaDisparo;
    }
    void Disparar(){
        if (!isADistancia) return;
        GameObject proyectil = Instantiate(prefabProyectil, puntoDisparo.position, puntoDisparo.rotation);
        proyectil.GetComponent<Rigidbody>().AddForce(puntoDisparo.forward * fuerzaDisparo);
    }
}
