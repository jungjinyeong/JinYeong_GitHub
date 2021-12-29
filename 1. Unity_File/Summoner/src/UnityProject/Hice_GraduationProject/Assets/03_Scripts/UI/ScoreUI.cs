using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

public class ScoreUI : MonoBehaviour
{
    private Text gainedGold;

    private void Start()
    {
        gainedGold = GetComponent<Text>();
        PlayerController.instance.OnPlayerGetGold.AddListener(UpdateGoldAmount);
        UpdateGoldAmount(PlayerController.instance.playerGold);

        // 사파이어 획득량도 표시하고 싶을 경우
        /*
         * Text ganedSaphire;
         * PlayerController.instance.OnPlayerGetSaphire.AddListner(UpdateSaphireAmount);
         * UpdateSaphireAmount(PlayerController.instance.playerSaphire);
         */ 
    }

    private void UpdateGoldAmount(float amount)
    {
        gainedGold.text = amount.ToString();
    }

    /* 사파이어 획득량도 표시하고 싶은 경우
     private void UpdateSaphireAmount(float amount)
     {
        gainedSaphire.text = amount.ToString();
    }
     */ 
}
