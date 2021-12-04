using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class StageUIInfo : MonoBehaviour
{
    [SerializeField] private Image boxImg;
    [SerializeField] private Text stageNumberText;
    [SerializeField] private Text stageModeText ;
    [SerializeField] private GameObject touchBlock;
    [SerializeField] private Image nameTagImg;
    [SerializeField] private Image milestoneImg;
    [SerializeField] private Shadow stageModeShadow;

    [SerializeField] private GameObject milestoneEffectObj;
    private int stage_number;
    private int chapter_number;

    public void Init(Table.LobbyTable lobbyData)
    {
        StageUISetting(lobbyData);
        OnRefresh(lobbyData);
    }
    private void StageUISetting(Table.LobbyTable lobbyData)
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        // 게임이 끝나면 알아서 다 체크해주기때문에(clear  유무, 별개수, 그에따른 해당 리소스 이름)  굳이 여기서 체킹할 필요없다)

        // 아래는  최신스테이지를 클리어했는데 다음챕터를 눌렀을때만!!!! 작동하는 코드 , 즉 과거 챕터로 넘어가서 하는 경우는 해당안됨 
        if (LocalValue.isLatestFinalStage&& !LocalValue.isRetryButtonClick && lobbyData.stage_no%20==0 )
        {
            boxImg.sprite = Resources.Load<Sprite>("Images/Lobby/unboxing");
        }
        else
            boxImg.sprite = Resources.Load<Sprite>("Images/Lobby/" + lobbyData.box_image_name);
        Outline[] stageModeTextOutlineArr = stageModeText.GetComponents<Outline>();

        Color effectColor;
        switch (lobbyData.mode_type)
        {
            case 0:
                stageModeText.text = DataService.Instance.GetText(0);
                break;
            case 1:
                stageModeText.text = DataService.Instance.GetText(1);
                break;
            case 2:
                stageModeText.text = DataService.Instance.GetText(68); 
                ColorUtility.TryParseHtmlString("#2371BA", out effectColor);
                stageModeTextOutlineArr[0].effectColor = effectColor;
                stageModeTextOutlineArr[1].effectColor = effectColor;
                stageModeShadow.effectColor = effectColor;
                nameTagImg.sprite = Resources.Load<Sprite>("Images/Lobby/cloud_nameTag");
                break;
            case 3:
                stageModeText.text = DataService.Instance.GetText(69);
                ColorUtility.TryParseHtmlString("#7824AD", out effectColor);
                stageModeTextOutlineArr[0].effectColor = effectColor;
                stageModeTextOutlineArr[1].effectColor = effectColor;
                stageModeShadow.effectColor = effectColor;
                nameTagImg.sprite = Resources.Load<Sprite>("Images/Lobby/focus_nameTag");
                break;
            default:
                break;
        }
        if(saveTable.stage_no == lobbyData.stage_no)
        {
            milestoneEffectObj.SetActive(true);
        }
        if (lobbyData.box_image_name == "black_unboxing") // black_unboxing 이면 TouchBlock을 활성화 시킴
        {
            touchBlock.SetActive(true);
            Color color;
            ColorUtility.TryParseHtmlString("#939393", out color);
            milestoneImg.color =  color;
        }
    }
    public void OnBoxClick() // 플레이 팝업 띄우기
    {
        // stage 클리어 팝업 및 stage play 팝업에 사용할 변수   
        LocalValue.Click_Stage_H = stage_number;// click stage 의 정보 저장
        LocalValue.Click_Chapter_H = chapter_number;// click 한 stage 의 chapter 정보 저장
        PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init();
    }
    private void OnRefresh(Table.LobbyTable lobbyData)
    {
        stageNumberText.text = lobbyData.stage_no.ToString();
        stage_number = lobbyData.stage_no;
        chapter_number = lobbyData.chapter_no;
    }

}
