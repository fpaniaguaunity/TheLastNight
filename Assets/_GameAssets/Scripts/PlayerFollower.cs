using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerFollower : MonoBehaviour
{
    public GameObject player; 
    void Start()
    {
        transform.position = new Vector3(player.transform.position.x, transform.position.y, player.transform.position.z);
    }
    void Update()
    {
        transform.position = new Vector3(player.transform.position.x, transform.position.y, player.transform.position.z);       
    }
}
