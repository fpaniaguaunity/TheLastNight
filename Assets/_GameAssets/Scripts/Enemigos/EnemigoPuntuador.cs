using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class EnemigoPuntuador : MonoBehaviour
{
    public int puntos;
    public void OnDestroy(){
        GameObject.Find("GameManager")?.GetComponent<GameManager>()?.Puntuar(puntos);
    }
}
