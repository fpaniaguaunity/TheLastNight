using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PatrullajeManagerAvanzado : MonoBehaviour
{
    public List<Transform> targets;
    public bool patrullajeAleatorio = true;

    [Range(0,10)]
    public float tiempoEspera; 

    [Header("A partir de esta distancia deja de patrullar y sigue al player")]
    public float distanciaSeguimientoDirecto;
    public float distanciaAlPlayer;
    public string nombrePlayer = "Player";
    private int nextTarget = 0;
    private NavMeshAgent navMeshAgent;

    private GameObject player;

    private bool esperandoAsignacion=false;

    void Start()
    {
        player = GameObject.Find(nombrePlayer);
        if (player == null){
            Debug.LogError("No se ha encontrado al player en el PatrullajeManagerAvanzado");
        }
        navMeshAgent = GetComponent<NavMeshAgent>();
        if (patrullajeAleatorio)
        {
            nextTarget = Random.Range(0, targets.Count);
        }
        navMeshAgent.destination = targets[nextTarget].position;
    }
    void Update()
    {
        distanciaAlPlayer=(player.transform.position - transform.position).magnitude;
        DeterminarSiguienteTarget();
    }
    private void DeterminarSiguienteTarget()
    {
        if (esperandoAsignacion) return;
        if (!navMeshAgent.pathPending)
        {
            if (distanciaAlPlayer<=distanciaSeguimientoDirecto){
                AsignarTargetPlayer();
            }
            if (navMeshAgent.remainingDistance <= navMeshAgent.stoppingDistance)
            {
                if (!navMeshAgent.hasPath || navMeshAgent.velocity.sqrMagnitude == 0f)
                {
                    if (patrullajeAleatorio)
                    {
                        esperandoAsignacion=true;
                        Invoke("AsignarSiguienteTargetAleatorio",tiempoEspera);
                    }
                    else
                    {
                        esperandoAsignacion=true;
                        Invoke("AsignarSiguienteTargetSecuencial",tiempoEspera);
                    }
                }
            }
        }
    }
    private void AsignarSiguienteTargetAleatorio()
    {
        esperandoAsignacion=false;
        nextTarget = Random.Range(0, targets.Count);
        navMeshAgent.destination = targets[nextTarget].position;
    }
    private void AsignarSiguienteTargetSecuencial()
    {
        esperandoAsignacion=false;
        nextTarget++;
        if (nextTarget == targets.Count) nextTarget = 0;
        navMeshAgent.destination = targets[nextTarget].position;
    }
    private void AsignarTargetPlayer(){
        esperandoAsignacion=false;
        navMeshAgent.destination = player.transform.position;
    }
}