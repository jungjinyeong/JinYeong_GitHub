using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundManager : MonoBehaviour
{
    public static SoundManager Instance;

    public AudioSource Sound;

    private void Start()
    {
        if(Instance == null)
        {
            Instance = this;
        }
    }

    public void Button_Sound()
    {
        Sound.Play();
    }
  
}
