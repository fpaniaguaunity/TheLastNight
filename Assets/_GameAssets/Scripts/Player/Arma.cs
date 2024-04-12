using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class Arma : MonoBehaviour
{
    public int capacidad = 100;
    public int municion = 0; 
    public float fuerza = 10;
    public GameObject prefabBala;
    public Transform transformSpawner;

    public AudioClip audioShoot;
    public AudioClip audioNoBullets;

    public void Start(){
        municion = capacidad;
    }
    public void IntentarDisparo(){
        if (municion>0){
            Disparar();
        } else {
            GetComponent<AudioSource>().PlayOneShot(audioNoBullets);
        }
    }
    private void Disparar(){
        GetComponent<AudioSource>().PlayOneShot(audioShoot);
        municion--;
        GameObject bala = Instantiate(prefabBala,transformSpawner.position, transformSpawner.rotation);
        bala.GetComponent<Rigidbody>().AddForce(bala.transform.forward * fuerza);
    }

    public void Reload(){
        municion = capacidad;
    }
}
