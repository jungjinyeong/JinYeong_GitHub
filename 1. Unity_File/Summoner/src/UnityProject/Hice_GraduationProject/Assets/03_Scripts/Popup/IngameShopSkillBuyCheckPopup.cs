using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class IngameShopSkillBuyCheckPopup : BasePopup
{
  

    public Image skillIconImg;
    public Text skillNameTxt;
    public Text skillLevel1txt;
    public Text skillLevel2txt;
    int needBuyPoint;
    int playerSkillDataId;

    public override void Init(int id = -1)
    {
        base.Init(id);
        playerSkillDataId = id;
        var skillData = DataService.Instance.GetData<Table.IngameShopSkillTable>(id);
        needBuyPoint = skillData.need_point;
        skillIconImg.sprite = Resources.Load<Sprite>("Images/Skill/" + skillData.icon_name);
        skillNameTxt.text = DataService.Instance.GetText(skillData.name_text_id);
        var playerSkillData = DataService.Instance.GetData<Table.PlayerIngameShopSkillLevelTable>(id);
        skillLevel1txt.text = "Lv." + playerSkillData.level;
        skillLevel2txt.text = "Lv." + (playerSkillData.level +1);
    }
    public void OnYesButtonClick()
    {
        PlayerController.instance.SpendPoint(needBuyPoint); // 포인트값 바뀜
        var playerSkillData = DataService.Instance.GetData<Table.PlayerIngameShopSkillLevelTable>(playerSkillDataId);
        playerSkillData.level++;
        DataService.Instance.UpdateData(playerSkillData); // 변수의 정보를 고대로 전달 , 원하는 id 의 튜플 값을 수정한 결과의 튜플이 playerSkillData
        BuySkillManager.instance.buySkillSpriteList.Add(skillIconImg.sprite); // 구매한 이미지 띄우기

        GameManager.instance.ApplyBoughtSkillEffect(playerSkillData.id);    // 구매한 스킬의 Index에 맞게 스킬 효과 적용
        
        Close();
    }

    // no 는 바로 click event에서 close 해줄거임
}
