using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TaeheeTest : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.A))
        {
            PopupContainer.CreatePopup(PopupType.IngameShopPopup).Init();
        }
    }
}
