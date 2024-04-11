using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProyectilAvanzado : MonoBehaviour
{

    public GameObject efectoImpactoConAudio;
    public int pupa;
    public bool autodestruccion;
    public string tagEnemigo;
    public 

    void OnCollisionEnter(Collision collision){
        if (efectoImpactoConAudio){
            Instantiate(efectoImpactoConAudio, transform.position, transform.rotation);
        } else {
            Debug.LogWarning("El arma no tiene asociado un prefab de explosión (o similar)");
        }
        if (collision.gameObject.CompareTag(tagEnemigo))
        {
            if (collision.gameObject.GetComponent<EnemigoHealthManager>() != null){
                    collision.gameObject.GetComponent<EnemigoHealthManager>().HacerPupa(pupa);
            } else {
                Debug.LogWarning("El enemigo no tiene el componente EnemigoHealthManager");
            }
        }
        if (autodestruccion) 
        {
            Destroy(gameObject);
        }
        

    }
}
