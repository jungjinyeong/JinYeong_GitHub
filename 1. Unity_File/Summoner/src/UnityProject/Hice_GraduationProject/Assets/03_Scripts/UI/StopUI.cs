using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class StopUI : MonoBehaviour
{


   public void OnStopButtonClick()
    {
       Time.timeScale = 0;

        PopupContainer.CreatePopup(PopupType.InGameStopPopup).Init();
    }
}
