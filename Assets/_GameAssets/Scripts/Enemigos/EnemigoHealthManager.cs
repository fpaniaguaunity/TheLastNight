using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemigoHealthManager : MonoBehaviour
{
    public int salud=100;
    public void HacerPupa(int pupa){
        salud-=pupa;
    }
}
