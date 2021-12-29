using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelUpPopup : BasePopup
{
    public Text needSaphireTxt;
    public GameObject canUseUpgrade;
    public Text nowLevelTxt;
    public Text afterLevelTxt;

    private int nowLevel;
    private int needSaphire;


    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
    }


    public void OnBuyButtonClick()
    {

        PopupContainer.CreatePopup(PopupType.LevelUpConfirmPopup).Init();

    }

    public override void OnRefresh()
    {
        base.OnRefresh();
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        nowLevel = saveData.player_level;

        var levelTableData = DataService.Instance.GetData<Table.LevelTable>(nowLevel);

        needSaphire = levelTableData.next_level_need_saphire;

        nowLevelTxt.text = nowLevel.ToString();
        needSaphireTxt.text = needSaphire.ToString();
        afterLevelTxt.text = (nowLevel + 1).ToString();

        if (saveData.saphire < needSaphire) //돈이 부족할때
        {
            canUseUpgrade.SetActive(true);
        }
        else
            canUseUpgrade.SetActive(false);

    }
    public override void Close()
    {
        base.Close();
       //LobbyManager.instance.RefreshAll();
    }
}
