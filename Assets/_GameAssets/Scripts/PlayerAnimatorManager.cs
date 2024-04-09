using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAnimatorManager : MonoBehaviour
{
    private CharacterController characterController;
    private Animator animator;
    private float velocity;
    void Start()
    {
        characterController = GetComponent<CharacterController>();
        animator = GetComponentInChildren<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        velocity = characterController.velocity.magnitude;
        animator.SetFloat("Velocity", velocity);
    }
}
