using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ArmaPlayer : MonoBehaviour
{
    public Arma arma;
    //public ArmaSniper arma;
    public AudioClip audioReload;//Variable pública del fichero de audio

    public Image crossHair;
    public Camera camara;
    void Update(){
        if (Input.GetButtonDown("Fire1")){
            ApretarGatillo();
        } else if (Input.GetKeyDown(KeyCode.R)){
            GetComponent<AudioSource>().PlayOneShot(audioReload);
            arma.Reload();
        } else if (Input.GetKeyDown(KeyCode.Mouse1)){
            //Pulsa el botón derecho
            //Activar el CrossHair
            crossHair.enabled=true;
            //Modificar el fieldofview de la camara
            camara.fieldOfView=18;
        } else if (Input.GetKeyUp(KeyCode.Mouse1)){
            //Suelta el botón derecho
//Pulsa el botón derecho
            //Activar el CrossHair
            crossHair.enabled=false;
            //Modificar el fieldofview de la camara
            camara.fieldOfView=60;
        }
    }

    public void ApretarGatillo(){
        arma.IntentarDisparo();
    }
}
