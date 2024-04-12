using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class PlayerHealthManager : MonoBehaviour
{
    private GameManager gameManager;
    void Start(){
        gameManager = GameObject.Find("GameManager").GetComponent<GameManager>();    
    }
    public void RecibirPupa(int pupa){
        gameManager.DecrementarSalud(pupa);
    }

}
