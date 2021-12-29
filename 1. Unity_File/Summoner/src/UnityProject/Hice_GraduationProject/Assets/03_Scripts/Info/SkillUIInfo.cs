using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SkillUIInfo : MonoBehaviour
{
    public Image iconImage;
    public Text titleText;
    public Text descText;
    public Text pointText;
    public Text levelText;
    public CanvasGroup alphaCanvasGroup;
    public GameObject pointObj;

    int ingameShopSkillId;

    public void Init(int ingameShopSkillId)
    {
        var ingameShopSkillData = DataService.Instance.GetData<Table.IngameShopSkillTable>(ingameShopSkillId);
        this.ingameShopSkillId = ingameShopSkillId;
        iconImage.sprite = Resources.Load<Sprite>("Images/Skill/" + ingameShopSkillData.icon_name);
        titleText.text = DataService.Instance.GetText(ingameShopSkillData.name_text_id);
        descText.text = DataService.Instance.GetText(ingameShopSkillData.desc_text_id);
        pointText.text = ingameShopSkillData.need_point.ToString();

        var playerSkillLevel = DataService.Instance.GetData<Table.PlayerIngameShopSkillLevelTable>(ingameShopSkillId).level;


        if (playerSkillLevel == ingameShopSkillData.max_level) //level max
        {
            pointObj.SetActive(false);
            levelText.text = "Max";
            alphaCanvasGroup.alpha = 0.3f;

        }
        else
        {
            pointObj.SetActive(true);
            levelText.text = "Lv." + playerSkillLevel; // + 연산 때문에 Tostring() 따로 할 필요없음

            if (PlayerController.instance.playerGold < ingameShopSkillData.need_point) //돈이 부족
            {
                alphaCanvasGroup.alpha = 0.3f;
            }
            else
                alphaCanvasGroup.alpha = 1;
        }

    }

    public void OnRefresh ()
    {
        Init(ingameShopSkillId);
    }

    public void OnSkillBuyButtonClick()
    {
        if (alphaCanvasGroup.alpha < 1)
            return;
        PopupContainer.CreatePopup(PopupType.IngameShopSkillBuyCheckPopup).Init(ingameShopSkillId);
    }
}
