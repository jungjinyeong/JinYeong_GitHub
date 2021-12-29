using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PetSkillConfirmPopup : BasePopup
{

    int petId;
    public Text confrimText; 

    public override void Init(int id = -1)
    {
        base.Init(id);
        petId = id;
    }
    private void Awake()
    {

        Debug.Log("petskillconfimpopup 접근하니?");
         confrimText.text = "정말 업그레이드 하시겠습니까?";
    }
    public void OnOkButtonClick() //ok 버튼 
    {
        var playerPetData = DataService.Instance.GetData<Table.PlayerPetTable>(petId);
        int playerPetLevel = playerPetData.level;
        var petData = DataService.Instance.GetData<Table.PetTable>(petId);
        int inc_need_saphire =petData.inc_need_saphire;
        int need_saphire = petData.need_saphire;

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);

        saveData.saphire = saveData.saphire - (need_saphire + inc_need_saphire*(playerPetLevel));
        //바뀐 saphire = saphire의 현재 값 - 사용한 사파이어
        DataService.Instance.UpdateData(saveData); // 플레이어 사파이어 차감한거 테이블가서 반영

        playerPetData.level++;
        playerPetData.own = 1;

        DataService.Instance.UpdateData(playerPetData); // playerPetTable 가서 player level 올려준거 반영

        Debug.Log("차감된 후 사파이어 : " + saveData.saphire);

        Close();

        LobbyManager.instance.RefreshAll();
        PetManager.instance.RefreshAll();
    }
}
