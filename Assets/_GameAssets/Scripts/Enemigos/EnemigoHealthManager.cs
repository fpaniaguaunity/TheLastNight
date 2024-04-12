using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EnemigoHealthManager : MonoBehaviour
{
    [Header("Objeto que se va a instanciar cuando el enemigo 'muera'")]
    public GameObject prefabObjetoReemplazo;
    public int salud=100;

    private Slider sliderSalud;

    void Start(){
        sliderSalud = GetComponentInChildren<Slider>();
    }
    public void HacerPupa(int pupa){
        salud-=pupa;
        sliderSalud.value = salud;
        if (salud<=0){
            Instantiate(prefabObjetoReemplazo, transform.position, transform.rotation);
            Destroy(gameObject);
        }
    }
}
