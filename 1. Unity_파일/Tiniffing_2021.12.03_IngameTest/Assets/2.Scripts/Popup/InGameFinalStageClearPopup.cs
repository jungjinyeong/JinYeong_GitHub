using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
using DG.Tweening;
public class InGameFinalStageClearPopup : BasePopup
{

    [SerializeField] private Text goldText;
    [SerializeField] private Text retryText;
    [SerializeField] private Text rewardListText;
    [SerializeField] private Text nextChapterText;
    [SerializeField] private Text starCoinText;
    [SerializeField] private Text stageNoText;
    //[SerializeField] private Text adText;
    [SerializeField] private Text getGoldCountText;
    [SerializeField] private Text getStarcoinCountText;
    [SerializeField] private Text teeniepingNameText; 
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private Image teeniepingImage;

    
    [SerializeField] private GameObject nextChapterButton_LatestObj;
    [SerializeField] private GameObject toBeUpdateButtonObj;
    [SerializeField] private GameObject nextChapterButton_LastObj;

    [SerializeField] private RectTransform groupRect;
    [SerializeField] private RectTransform closeButtonRectTr;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    // Final Clear Display

    [SerializeField] private RectTransform star1RectTr;
    [SerializeField] private RectTransform star2RectTr;
    [SerializeField] private RectTransform star3RectTr;
    [SerializeField] private RectTransform missionTextImageGroup_RectTr;
    [SerializeField] private GameObject missionClear_TextImage_Obj;
    [SerializeField] private GameObject missionCleared_TextImage_Obj;
    [SerializeField] private GameObject missionFail_TextImage_Obj;
    [SerializeField] private RectTransform teeniepingMind_GetCount_Group_RectTr;
    [SerializeField] private RectTransform teeniepingMind_GetCount_Text_RectTr;
    [SerializeField] private RectTransform teeniepingMindImage_Mission_RectTr; // �̼��� Ƽ���� �̹��� 
    [SerializeField] private RectTransform teeniepingMindImage_CrackedRectTr;//Ƽ���� ������ �̹��� ��Ʈ
    [SerializeField] private RectTransform goldRewardGroupRectTr;
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;
    [SerializeField] private RectTransform goldRewardRectTr;
    [SerializeField] private RectTransform starCoinRewardRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;
    [SerializeField] private RectTransform arrowSignGroupRectTr;

    [SerializeField] private RectTransform nextStageButtonRectTr;
    [SerializeField] private RectTransform retryButtonRectTr;

    [SerializeField] private GameObject teeniepingMind_Cracked_EffectObj;//������ ����Ʈ�� �޾ƿ��� ���� �߰�

    private Sequence TeeniepingBadShakeMovementSequence;//Ƽ������ ���� bad���� ��鸮�� �̵� ������


    private Sequence perfectSequence;
    private Sequence fineSequence;
    private Sequence badSequence;

    private Sequence starSequence_1;
    private Sequence starSequence_2;
    private Sequence starSequence_3;


    private int click_stage_number;
    private int click_chapter_number;

    private string mind_color;


    private int now_StarCount;
    private int get_starCount; // ���������� ȹ���� ��Ÿ���� ��
    public override void Init(int id = -1)
    {
        base.Init(id);
        now_StarCount = LocalValue.Now_StarCount;
        get_starCount = LocalValue.Get_StarCoin;
        OnRefresh();
  
        PopTweenEffect_Nomal(groupRect);
        StartCoroutine(InGameClearDIsplay());

    }
  
    IEnumerator InGameClearDIsplay()
    {
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        yield return YieldInstructionCache.WaitForSeconds(0.5f);

        if (now_StarCount == 3)
        {
            StartCoroutine(CharacterSpineDisplay_3_Star());
        }

        if (now_StarCount == 3)
        {
            if (lobbyData.retry == 1) //  // ���� ������ 3��Ŭ�� �߾���. => Ƽ���� ������ ȹ���� ����
            {
                if (get_starCount == 0) // ���ſ� ���� �̹� 3��Ŭ�� �Ѱ��� !! (why? => ��� �� 3��Ŭ�ߴµ�  ���������� ���� ������ 0���ϱ�)
                {
                    MissionClearDisplay_Fine();
                    yield break;
                }
                else // ���ſ� 1��Ŭ�̴� 2��Ŭ�̴� �ؼ� get_starCount�� 1 �̻��ΰ�� 
                {
                    MissionClearDisplay_Perfect();
                    yield break;
                }

            }
            else // �̹��� ó������ 3��Ŭ �� �����̴�
            {
                MissionClearDisplay_Perfect();
                yield break;
            }
            // ó�� �����ؼ� �ٷ� 3��Ŭ => ���ѿ���

        }
        else // ��� �� 3��Ŭ�� �ƴϾ�
        {
            if (lobbyData.retry == 1 && lobbyData.star_count == 3) // ���ſ� �̹� ���ε带 ȹ���߾�
            {
                MissionClearDisplay_Fine();
                yield break;
            }
            else // �� �絵���� �ߵ� ���� ���ſ��� ���ݵ� 3��Ŭ�� ���߾�
            {
                MissionFailDisplay_Bad();
                yield break;
            }
        }
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    //-------------------------------------------------------------------------------------------- Display ------------------------------------------------------------------------------------------

    private void MissionClearDisplay_Perfect()
    {
        Debug.Log("Perfect");

        // �ʱ�ȭ�� �ڵ�
        missionClear_TextImage_Obj.SetActive(true);
        missionCleared_TextImage_Obj.SetActive(false);
        missionFail_TextImage_Obj.SetActive(false);

        Three_Star_Get_Display();
        Perfect_Sequence_Display();
    }
    private void MissionClearDisplay_Fine()
    {
        Debug.Log("Fine");
        // �ʱ�ȭ�� �ڵ�
        missionClear_TextImage_Obj.SetActive(false);
        missionCleared_TextImage_Obj.SetActive(true);
        missionFail_TextImage_Obj.SetActive(false);

        switch (now_StarCount)
        {
            case 1:
                One_Star_Get_Display();
                break;
            case 2:
                Two_Star_Get_Display();
                break;
            case 3:
                Three_Star_Get_Display();
                break;
            default:
                break;
        }
        Fine_Sequence_Display();
    }

    private void MissionFailDisplay_Bad()
    {
        // �ʱ�ȭ�� �ڵ�
        missionClear_TextImage_Obj.SetActive(false);
        missionCleared_TextImage_Obj.SetActive(false);
        missionFail_TextImage_Obj.SetActive(true);

        switch (now_StarCount)
        {
            case 1:
                One_Star_Get_Display();
                break;
            case 2:
                Two_Star_Get_Display();
                break;
            default:
                break;
        }
        Bad_Sequence_Display();
    }
    private void One_Star_Get_Display()
    {
        starSequence_1 = DOTween.Sequence()
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(0.3f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.2f));
    }
    private void Two_Star_Get_Display()
    {
        starSequence_2 = DOTween.Sequence()
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(0.3f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.2f))
            .Insert(0.5f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(0.7f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.2f));
    }
    private void Three_Star_Get_Display()
    {
        starSequence_3 = DOTween.Sequence()
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(0.3f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.2f))
            .Insert(0.5f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(0.7f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.2f))
            .Insert(0.9f, star3RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f))
            .Insert(1.1f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.2f));
    }

    private void Perfect_Sequence_Display()
    {
        perfectSequence = DOTween.Sequence()
        .Insert(1.2f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.2f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.3f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.3f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .InsertCallback(1.4f, () => TeeniepingMind_MissionClear_EffectOn())
        .Insert(1.4f, teeniepingMindImage_Mission_RectTr.transform.DORotate(new Vector2(0, 360f * 5f), 0.5f, RotateMode.LocalAxisAdd))
        .Insert(1.4f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.5f).SetEase(Ease.InSine))
        .Insert(2.1f, teeniepingMind_GetCount_Text_RectTr.DORotate(new Vector3(360f * 2f, 0f, 0f), 0.4f, RotateMode.LocalAxisAdd))
        .InsertCallback(2.25f, () => TeeniepingMind_GetCount_Plus())
        .Insert(2.5f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.7f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.8f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.9f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(3.0f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(3.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(3.2f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(3.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(3.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(3.5f, arrowSignGroupRectTr.DOAnchorPosX(516.2f, 1.2f)).SetEase(Ease.Linear)
        .InsertCallback(3.5f, () => CloseButtonActiveOnCheck())
        .Insert(4.7f, nextStageButtonRectTr.DOAnchorPosX(15f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void Fine_Sequence_Display()
    {
        fineSequence = DOTween.Sequence()
        .Insert(0.8f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.8f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.9f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.9f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.0f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.1f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.2f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.8f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.9f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.0f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.5f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.6f, arrowSignGroupRectTr.DOAnchorPosX(516.2f, 1.2f)).SetEase(Ease.Linear)
        .InsertCallback(3.3f, () => CloseButtonActiveOnCheck())
        .Insert(3.8f, nextStageButtonRectTr.DOAnchorPosX(15f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void Bad_Sequence_Display()
    {
        // float defaultXpos = 

        badSequence = DOTween.Sequence()
        .Insert(0.8f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.8f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.9f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.9f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.0f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.1f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.2f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))
        .InsertCallback(1.3f, () => TeeniepingBadOn())
        .InsertCallback(1.3f, () => TeeniepingBadShakeMovement()).SetLoops(6, LoopType.Yoyo)
        .Insert(1.3f, teeniepingMindImage_CrackedRectTr.GetComponent<Image>().DOFade(1f, 0.5f))
        .Insert(1.9f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(7.7f, 0.1f))//��,��� ���� �ڵ尡 ������ ������ ���� Ÿ�̹��� 
        .InsertCallback(1.9f, () => TeeniepingMind_Cracked_EffectOn())
        .InsertCallback(1.9f, () => TeeniepingMindImage_Cracked_ColorChange_Gray())
        .Insert(2.0f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.2f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.3f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.4f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.5f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.6f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.7f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.8f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.9f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(3.0f, arrowSignGroupRectTr.DOAnchorPosX(516.2f, 1.2f)).SetEase(Ease.Linear)
        .InsertCallback(3.5f, () => CloseButtonActiveOnCheck())
        .Insert(4.2f, retryButtonRectTr.DOAnchorPosX(-14f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void TeeniepingMind_MissionClear_EffectOn()
    {

        switch (mind_color)
        {
            case "blue":
                teeniepingMindImage_Mission_RectTr.GetChild(0).gameObject.SetActive(true);
                break;
            case "green":
                teeniepingMindImage_Mission_RectTr.GetChild(1).gameObject.SetActive(true);
                break;
            case "pink":
                teeniepingMindImage_Mission_RectTr.GetChild(2).gameObject.SetActive(true);
                break;
            case "purple":
                teeniepingMindImage_Mission_RectTr.GetChild(3).gameObject.SetActive(true);
                break;
            case "yellow":
                teeniepingMindImage_Mission_RectTr.GetChild(4).gameObject.SetActive(true);
                break;

        }

    }
    private void TeeniepingMind_GetCount_Plus()
    {
        string teeniepingMind_GetCount_Str = teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text;
        teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = (int.Parse(teeniepingMind_GetCount_Str) + 1).ToString();
    }
    private void TeeniepingMind_Cracked_EffectOn()
    {
        teeniepingMind_Cracked_EffectObj.SetActive(true);
    }
    private void TeeniepingMindImage_Cracked_ColorChange_Gray()
    {
        Color color;
        ColorUtility.TryParseHtmlString("#939393", out color);
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().color = color;
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().DOFade(1, 0f);
    }
    private void TeeniepingBadOn()//���� �̹��� ���ְ�, Ƽ���� ���� �̹��� ����, ����Ʈ ����
    {
        teeniepingMindImage_CrackedRectTr.gameObject.SetActive(true);
        teeniepingMindImage_Mission_RectTr.gameObject.SetActive(false);
        teeniepingMind_Cracked_EffectObj.SetActive(true);
    }
    private void TeeniepingBadShakeMovement()//Ƽ���� ���� ��, �� ���� �ִ� �ڵ�
    {
        TeeniepingBadShakeMovementSequence = DOTween.Sequence()
        .Insert(0f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(9.7f, 0.1f))
        .Insert(0.1f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(5.7f, 0.1f));
    }
    // ĳ���� 3��Ŭ ������ �ִϸ��̼� ����
    IEnumerator CharacterSpineDisplay_3_Star()
    {
        while (true)
        {
            skeletonAnimation.AnimationName = "Clear";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(2.8f);
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(10f);
        }
    }
    // -----------------------------------------------------------------------------Init Setting -----------------------------------------------------------------------------
    private void CloseButtonActiveOnCheck()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == click_stage_number);
        if (lobbyTable.retry == 1) // �絵��üŷ �Ǿ������� ������ �ֽ��� �ƴ�
        {
            closeButtonRectTr.gameObject.SetActive(true);
            TweenEffect_CloseButton(closeButtonRectTr);
        }
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
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // ȹ���� ��Ÿ���� ��
        getGoldCountText.text = string.Format("x{0}",LocalValue.Get_Gold.ToString());
        // adText.text = DataService.Instance.GetText(21);
        if (now_StarCount == 3)
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = (teeniepingData.mind_count - 1).ToString(); // �������ؼ� -1 ���ѳ���
        }
        else
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = teeniepingData.mind_count.ToString(); // ȹ���ϴ� ���� �����ϱ� �׳� ��
        }
        mind_color = teeniepingData.mind_color;
        teeniepingNameText.text = DataService.Instance.GetText(teeniepingData.name_text_id);
        teeniepingImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_Mission_RectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMindCracked/" + teeniepingData.mind_teenieping_cracked_name);

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
