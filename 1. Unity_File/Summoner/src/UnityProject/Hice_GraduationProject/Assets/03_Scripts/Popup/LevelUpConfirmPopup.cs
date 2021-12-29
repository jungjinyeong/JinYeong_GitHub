using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelUpConfirmPopup : BasePopup
{

    public Text confirmText;

   // public LevelUpPopup levelUpPopupPrefab;

    public override void Init(int id = -1)
    {
        base.Init(id);
        confirmText.text = "정말 레벨업 하시겠습니까?";
    }

    public void OnYesButtonClick()
    {

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);

        int nowLevel = saveData.player_level;

        var levelTableData = DataService.Instance.GetData<Table.LevelTable>(nowLevel);

        int needSaphire = levelTableData.next_level_need_saphire;

        if (saveData.saphire >= needSaphire) // 사실 이전 팝업인 LevelUpPopup의  Init()에서 한번 거르지만 혹시나 해서 한번 더 추가
        {
            saveData.saphire -= levelTableData.next_level_need_saphire;

            saveData.player_level++; //레벨 하나 올려주기
        }
        else
            Debug.Log("돈 없어서 안됨 , 근데 여기로 오면 안됨 코드 오류있음 원래 걸러져야함 여기올거는");

        DataService.Instance.UpdateData(saveData); // 바뀐 데이터 반영 write

        //levelUpPopupPrefab.OnRefresh();

        LobbyManager.instance.RefreshAll();

        Close();
    }


}
