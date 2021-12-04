using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointTest : MonoBehaviour
{
    public RectTransform buttonTr; 


    private void Awake()
    {
      //  buttonTr.anchoredPosition = new Vector2(-590, -310);
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnButtonClick()
    {
        Debug.Log("anchored position = " + buttonTr.anchoredPosition);
        Debug.Log("world position" + Input.mousePosition);
        Debug.Log("rect transform" + this.transform);
    }
}
