using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemigoEspabilado : MonoBehaviour
{
    [Header("Tag del GameObject al que va a seguir")]
    public string targetTag = "Player";
    public float distanciaSeguimiento = 10;
    public float speed;
    public float minAngle;
    public float maxAngle;
   
    private Transform transformPlayer;
    public float distanciaAPlayer;
    void Start()
    {
        transformPlayer = GameObject.FindGameObjectWithTag(targetTag).transform;
    }
    void Update()
    {
        distanciaAPlayer = (transformPlayer.position - transform.position).magnitude;
        if (distanciaAPlayer<=distanciaSeguimiento){
            transform.LookAt(transformPlayer);
        } 
        transform.Translate(Vector3.forward * speed * Time.deltaTime);          
    }
    void OnCollisionEnter(Collision c){
        transform.Rotate(0, Random.Range(minAngle, maxAngle), 0);
    }
}
