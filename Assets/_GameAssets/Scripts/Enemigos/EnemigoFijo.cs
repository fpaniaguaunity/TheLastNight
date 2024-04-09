using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemigoFijo : MonoBehaviour
{
    [Header("Tag del GameObject al que va a seguir")]
    public string targetTag = "Player";
    
     private Transform transformPlayer;
    void Start()
    {
        transformPlayer = GameObject.FindGameObjectWithTag(targetTag).transform;
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 direccionCanyon = new Vector3(transformPlayer.position.x, transform.position.y, transformPlayer.position.z);
        transform.LookAt(direccionCanyon);
    }
}
