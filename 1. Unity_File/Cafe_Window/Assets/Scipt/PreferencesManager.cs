using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PreferencesManager : MonoBehaviour
{
    public AudioSource BackGroundSound;
    public AudioSource EffectSound;

    public void SetSoundVolume(float volume)
    {
        BackGroundSound.volume = volume;
    }
    public void SetEffectVolume(float volume)
    {
        EffectSound.volume = volume;
    }
}
