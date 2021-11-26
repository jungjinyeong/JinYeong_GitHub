using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
public class InGameFinalStageClearPopup : BasePopup
{

    [SerializeField] private Text goldText;
    [SerializeField] private Text retryText;
    [SerializeField] private Text rewardListText;
    [SerializeField] private Text nextChapterText;
    [SerializeField] private Text remainSecondText;
    [SerializeField] private Text starCoinText;
    [SerializeField] private Text stageNoText;
    [SerializeField] private Text remainTimeText;
    [SerializeField] private Text speechBubbleText;
    [SerializeField] private Text getGoldCountText;
    [SerializeField] private Text getStarcoinCountText;
    [SerializeField] private Text teeniepingNameText; 
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private Image teeniepingImage;
    [SerializeField] private Text adText;
    [SerializeField] private GameObject star1_Obj;
    [SerializeField] private GameObject star2_Obj;
    [SerializeField] private GameObject star3_Obj;
    
    [SerializeField] private GameObject nextChapterButton_LatestObj;
    [SerializeField] private GameObject toBeUpdateButtonObj;
    [SerializeField] private GameObject nextChapterButton_LastObj;

    [SerializeField] private RectTransform groupRect;
    [SerializeField] private RectTransform closeRect;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    private int click_stage_number;
    private int click_chapter_number;


    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == click_stage_number);
        if (lobbyTable.retry == 1) // �絵��üŷ �Ǿ������� ������ �ֽ��� �ƴ�
        {
            closeRect.gameObject.SetActive(true);
            TweenEffect_CloseButton(closeRect);
        }
        PopTweenEffect_Nomal(groupRect);
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);

        skeletonAnimation.AnimationName = "Clear";
        skeletonAnimation.Initialize(true);
    }
    public void CloseButtonClick()
    {
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    public void OnNextChapterButtonClick_Latest()
    {
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    public void OnNextChapterButtonClick_Last()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no++;
        DataService.Instance.UpdateData(saveTable);
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    public void OnToBeUpdatedButtonClick()
    {
        LocalValue.isToBeUpdatedButtonClick = true;
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    public void OnRetryButtonClick()
    {
        LocalValue.isStageClear = true; // ���� ���θ� ������
        LocalValue.isRetryButtonClick = true; // �κ� �Ŵ������� ���ǹ��� ����� ����
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    private void StarObjectActiveController()
    {
        switch (LocalValue.Now_StarCount)
        {
            case 1:
                star1_Obj.SetActive(true);
                break;
            case 2:
                star1_Obj.SetActive(true);
                star2_Obj.SetActive(true);
                break;
            case 3:
                star1_Obj.SetActive(true);
                star2_Obj.SetActive(true);
                star3_Obj.SetActive(true);
                break;
        }
    }
   
    private void TextRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter ==click_chapter_number);
        
        if(saveTable.game_clear==1 && saveTable.chapter_no-1==LocalValue.Click_Chapter_H)
        {
            nextChapterText.text = DataService.Instance.GetText(66); // ������Ʈ �����Դϴ� ����
            toBeUpdateButtonObj.SetActive(true);
        }
        else
        {
            switch (Application.systemLanguage)
            {
                case SystemLanguage.Korean:
                    nextChapterText.text = string.Format("{0} {1}", DataService.Instance.GetText(14), (click_chapter_number + 1).ToString());
                    break;
                default: //����
                    nextChapterText.text = string.Format("{0}\n{1}", DataService.Instance.GetText(14), (click_chapter_number + 1).ToString());
                    break;
            }
        }     
        stageNoText.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        speechBubbleText.text = DataService.Instance.GetText(20);
        remainTimeText.text = DataService.Instance.GetText(16);
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        remainSecondText.text = string.Format("{0}:{1}", (LocalValue.Remain_Second / 60).ToString("D2"), (LocalValue.Remain_Second % 60).ToString("D2"));
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // ȹ���� ��Ÿ���� ��
        getGoldCountText.text = string.Format("x{0}",LocalValue.Get_Gold.ToString());
        adText.text = DataService.Instance.GetText(21);
        teeniepingNameText.text = DataService.Instance.GetText(teeniepingData.name_text_id);
        teeniepingImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        if (LocalValue.isTeeniepingMindGet)
            teeniepingMindCountText.text = string.Format("x{0}", 1);
        else
            teeniepingMindCountText.text = string.Format("x{0}", 0);

    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        click_stage_number = LocalValue.Click_Stage_H;
        click_chapter_number = LocalValue.Click_Chapter_H;
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == click_stage_number);
        TextRefresh();
        StarObjectActiveController();
        SetSkeletonDataAsset();
        // �ֽ� ���������� Ŭ������ ���� �ƴҶ� -> �������
        if (lobbyTable.retry==1) // �絵��üŷ �Ǿ������� ������ �ֽ��� �ƴ�
        {
            nextChapterButton_LastObj.SetActive(true); // �׳� é�� �Ѿ�� ��ư ��
            return;
        }

        LocalValue.isLatestFinalStage = true; // ����
        LocalValue.isTeeniepingMindGet = false; // �ʱ�ȭ
    }

}
