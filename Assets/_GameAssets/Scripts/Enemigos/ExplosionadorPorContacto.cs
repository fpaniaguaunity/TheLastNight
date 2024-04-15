using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class ExplosionadorPorContacto : MonoBehaviour
{
    public GameObject prefabExplosion;
    public int damage;
    [Header("Tag del GameObject al que va a hacer daño")]
    public string targetTag = "Player";
    public void OnCollisionEnter(Collision collision)
    {
        Instantiate(prefabExplosion, transform.position, transform.rotation);
        Destroy(gameObject);
        collision.transform.gameObject.GetComponent<PlayerHealthManager>()?.RecibirPupa(damage);
    }
}
