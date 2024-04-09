using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemigoGauntlet : MonoBehaviour
{
    public float speed;
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
        transform.Translate(Vector3.forward * speed * Time.deltaTime);
        transform.LookAt(transformPlayer);
    }
}
