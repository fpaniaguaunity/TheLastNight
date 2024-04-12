using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Explosionador : MonoBehaviour
{
    public float distanciaExplosion;
    public GameObject prefabExplosion;
    public int damage;
    [Header("Tag del GameObject al que va a seguir")]
    public string targetTag = "Player";
    private float distanciaAlPlayer;
    private Transform transformPlayer;
    void Start()
    {
        transformPlayer = GameObject.FindGameObjectWithTag(targetTag).transform;
    }
    void Update()
    {
        distanciaAlPlayer = (transformPlayer.position - transform.position).magnitude;
        if (distanciaAlPlayer <= distanciaExplosion)
        {
            Instantiate(prefabExplosion, transform.position, transform.rotation);
            Destroy(gameObject);
            //TODO Hacer daño al player
            Debug.LogWarning("TODO: Hacer daño al player");
            transformPlayer.gameObject.GetComponent<PlayerHealthManager>()?.RecibirPupa(damage);
        }
    }
}
