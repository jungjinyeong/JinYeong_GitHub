using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InGameShopOpener : MonoBehaviour
{

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.collider.CompareTag("Player"))
        {
            PopupContainer.CreatePopup(PopupType.IngameShopPopup).Init();
        }
    }

}
