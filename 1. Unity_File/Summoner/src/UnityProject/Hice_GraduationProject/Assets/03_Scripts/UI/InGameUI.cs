using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class HealthPoint : UnityEvent<GameObject, float>
{ }

public class InGameUI : MonoBehaviour
{
    public static InGameUI instance;

    public HealthPoint healthPointEvent;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Destroy(gameObject);
        }
        DontDestroyOnLoad(gameObject);
        healthPointEvent = new HealthPoint();
    }

    public void ApplyChangedHealthPoint(GameObject target, float targetAmount)
    {
        healthPointEvent?.Invoke(target, targetAmount);
    }
}
