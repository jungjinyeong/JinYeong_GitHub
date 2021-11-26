using UnityEngine;

public class UICamera : MonoBehaviour
{
    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
       
    }
}
