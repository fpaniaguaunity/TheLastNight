using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance;
    //Atributos del juego
    public float salud;
    public int saludMaxima;
    public int puntuacion;

    //ESTO SE PUEDE HACER CON EVENTOS
    public Image imageVida;

    private void Awake()
    {
        Instance = this;
        DontDestroyOnLoad(gameObject);
    }

    private void Start(){
        ActualizarBarraDeSalud();
    }

    public void DecrementarSalud(int decrementoSalud)
    {
        salud=salud-decrementoSalud;
        if (salud<=0){
            salud=0;
            TerminarJuego();
        }
        ActualizarBarraDeSalud();
    }
    public void IncrementarSalud(int incrementoSalud)
    {
        salud=salud+incrementoSalud;
        if (salud>=saludMaxima){
            salud=saludMaxima;
        }
        ActualizarBarraDeSalud();
    }
    private void ActualizarBarraDeSalud(){
        imageVida.fillAmount=salud/saludMaxima;
    }
    public void TerminarJuego(){

    }
}
