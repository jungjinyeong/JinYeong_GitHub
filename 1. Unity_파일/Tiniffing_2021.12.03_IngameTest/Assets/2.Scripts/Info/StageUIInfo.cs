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
        // ������ ������ �˾Ƽ� �� üũ���ֱ⶧����(clear  ����, ������, �׿����� �ش� ���ҽ� �̸�)  ���� ���⼭ üŷ�� �ʿ����)

        // �Ʒ���  �ֽŽ��������� Ŭ�����ߴµ� ����é�͸� ����������!!!! �۵��ϴ� �ڵ� , �� ���� é�ͷ� �Ѿ�� �ϴ� ���� �ش�ȵ� 
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
        if (lobbyData.box_image_name == "black_unboxing") // black_unboxing �̸� TouchBlock�� Ȱ��ȭ ��Ŵ
        {
            touchBlock.SetActive(true);
            Color color;
            ColorUtility.TryParseHtmlString("#939393", out color);
            milestoneImg.color =  color;
        }
    }
    public void OnBoxClick() // �÷��� �˾� ����
    {
        // stage Ŭ���� �˾� �� stage play �˾��� ����� ����   
        LocalValue.Click_Stage_H = stage_number;// click stage �� ���� ����
        LocalValue.Click_Chapter_H = chapter_number;// click �� stage �� chapter ���� ����
        PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init();
    }
    private void OnRefresh(Table.LobbyTable lobbyData)
    {
        stageNumberText.text = lobbyData.stage_no.ToString();
        stage_number = lobbyData.stage_no;
        chapter_number = lobbyData.chapter_no;
    }

}
