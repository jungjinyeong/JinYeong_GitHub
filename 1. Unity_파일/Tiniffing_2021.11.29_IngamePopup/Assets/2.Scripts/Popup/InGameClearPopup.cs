using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
using System.Collections;
using DG.Tweening;
public class InGameClearPopup : BasePopup
{
    [SerializeField] private Text goldText;
    [SerializeField] private Text retryText;
    [SerializeField] private Text rewardListText;
    [SerializeField] private Text nextStageText;
    [SerializeField] private Text starCoinText;
    [SerializeField] private Text stageNoText;
    [SerializeField] private Text getGoldCountText;
    [SerializeField] private Text getStarcoinCountText;
    //[SerializeField] private Text adText;
    [SerializeField] private Text teeniepingNameText;
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private Image teeniepingMindImage;

    [SerializeField] private RectTransform groupRect;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    // Clear Display

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
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);

        if (now_StarCount == 3)
        {
            StartCoroutine(CharacterSpineDisplay_3_Star());
        }

        if (now_StarCount==3)
        {
            if (lobbyData.retry == 1) //  // ���� ������ 3��Ŭ�� �߾���. => Ƽ���� ������ ȹ���� ����
            {
                if (get_starCount == 0) // ���ſ� ���� �̹� 3��Ŭ�� �Ѱ��� !! (why? => ��� �� 3��Ŭ�ߴµ�  ���������� ���� ������ 0���ϱ�)
                {
                    MissionClearDisplay_Fine();
                    return;
                }
                else // ���ſ� 1��Ŭ�̴� 2��Ŭ�̴� �ؼ� get_starCount�� 1 �̻��ΰ�� 
                {
                    MissionClearDisplay_Perfect();
                    return;
                }
                
            }
            else // �̹��� ó������ 3��Ŭ �� �����̴�
            {
                MissionClearDisplay_Perfect();
                return;
            }
            // ó�� �����ؼ� �ٷ� 3��Ŭ => ���ѿ���

        }
        else // ��� �� 3��Ŭ�� �ƴϾ�
        {
            if(lobbyData.retry==1 && lobbyData.star_count==3) // ���ſ� �̹� ���ε带 ȹ���߾�
            {
                MissionClearDisplay_Fine();
                return;
            }
            else // �� �絵���� �ߵ� ���� ���ſ��� ���ݵ� 3��Ŭ�� ���߾�
            {
                MissionFailDisplay_Bad();
                return;
            }
        }

    }

    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    
    //-------------------------------------------------------------------------------------------- Display ------------------------------------------------------------------------------------------

    private void MissionClearDisplay_Perfect()
    {
        // �ʱ�ȭ�� �ڵ�
        missionClear_TextImage_Obj.SetActive(true);
        missionCleared_TextImage_Obj.SetActive(false);
        missionFail_TextImage_Obj.SetActive(false);

        Three_Star_Get_Display();
        Perfect_Sequence_Display();
    }
    private void MissionClearDisplay_Fine()
    {
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
            .OnStart(() =>
            {
                star1RectTr.gameObject.SetActive(true);
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f));
    }
    private void Two_Star_Get_Display()
    {
        starSequence_2 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.gameObject.SetActive(true);
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>
            {
                star2RectTr.gameObject.SetActive(true);
            })
            .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f));
    } 
    private void Three_Star_Get_Display()
    {
        starSequence_3 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.gameObject.SetActive(true);
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>
            {
                star2RectTr.gameObject.SetActive(true);
            })
            .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>
            {
                star3RectTr.gameObject.SetActive(true);
            })
            .Insert(0.5f, star3RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
            .Insert(0.6f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f));
    }
    private void Perfect_Sequence_Display()
    {
        perfectSequence = DOTween.Sequence()
        .Insert(0.6f, star3RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.6f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.7f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .InsertCallback(0.8f, () => TeeniepingMind_MissionClear_EffectOn())
        .Insert(0.8f, teeniepingMindImage_Mission_RectTr.transform.DORotate(new Vector2(0, 360f * 5f), 0.5f, RotateMode.LocalAxisAdd))
        .Insert(0.8f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.5f).SetEase(Ease.InSine))
        .Insert(1.4f, teeniepingMind_GetCount_Text_RectTr.DORotate(new Vector3(360f * 2f, 0f, 0f), 0.2f, RotateMode.LocalAxisAdd))
        .InsertCallback(1.41f, () => TeeniepingMind_GetCount_Plus())
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.8f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.9f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.5f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.6f, arrowSignGroupRectTr.DOAnchorPosX(516.2f, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.8f, nextStageButtonRectTr.DOAnchorPosX(11f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void Fine_Sequence_Display()
    {
        fineSequence = DOTween.Sequence()
        .Insert(0.6f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//?? 3??
        .Insert(0.7f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.8f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))
        .Insert(0.9f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))
        .Insert(1f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.4f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.7f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.8f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.9f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.1f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.2f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.4f, arrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.6f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void Bad_Sequence_Display()
    {
       // float defaultXpos = 

        badSequence = DOTween.Sequence()
        .Insert(0.6f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.7f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.8f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))
        .Insert(0.9f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))
        .Insert(1f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))
        .InsertCallback(1.1f, () => TeeniepingBadOn())
        .InsertCallback(1.1f, () => TeeniepingBadShakeMovement()).SetLoops(6, LoopType.Yoyo)
        .Insert(1.1f, teeniepingMindImage_CrackedRectTr.GetComponent<Image>().DOFade(1f, 0.5f))
        .Insert(1.4f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(7.7f, 0.1f))//��,��� ���� �ڵ尡 ������ ������ ���� Ÿ�̹��� 
        .InsertCallback(1.4f, () => TeeniepingMind_Cracked_EffectOn())
        .InsertCallback(1.4f, () => TeeniepingMindImage_Cracked_ColorChange_Gray())
        .Insert(1.5f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.7f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.8f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.9f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.2f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.5f, arrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.7f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void TeeniepingMind_MissionClear_EffectOn()
    {
        switch(mind_color)
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
        //teeniepingMindImage_CrackedRectTr.gameObject.SetActive(true);
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
        while(true)
        {
            skeletonAnimation.AnimationName = "Clear";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(3f);
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(10f);
        }    
    }

    //--------------------------------------------------------------------------------- Init Setting -------------------------------------------------------------------------------
    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);

        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
    public void OnLoobyGoButtonClick()
    {
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H"); // �ε��� ���� 
    }
   
    public void OnRetryButtonClick() // clear �� retry �� �κ�� ���� �˾��� ����
    {

        LocalValue.isRetryButtonClick = true; // �κ� �Ŵ������� ���ǹ��� ����� ����

        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
        
    }    
    public void OnNextStageButtonClick()
    { 
   
        LocalValue.Click_Stage_H = click_stage_number + 1; // ���������� ����
        LocalValue.Click_Chapter_H = click_chapter_number; // é�ʹ� �״��

        LocalValue.isNextStageButtonClick = true;  // �κ񿡼� ���� �������� �˾��� ���� �� �ֵ���

        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");

    }
   
    private void TextRefresh(Table.SaveTable saveTable ,Table.TiniffingCollectionTable teeniepingData)
    {
        // ���߿� Ƽ���� �� ��� ���������� �ٲ�� �� �ڵ���
        if (now_StarCount == 3)
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = (teeniepingData.mind_count - 1).ToString(); // �������ؼ� -1 ���ѳ���
        }
        else
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = teeniepingData.mind_count.ToString(); // ȹ���ϴ� ���� �����ϱ� �׳� ��
        }
        nextStageText.text = string.Format("{0}\n{1}", DataService.Instance.GetText(2), (click_stage_number + 1).ToString());
        stageNoText.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // ȹ���� ��Ÿ���� ��
        getGoldCountText.text = string.Format("x{0}", LocalValue.Get_Gold.ToString());
       // adText.text = DataService.Instance.GetText(21);
        teeniepingNameText.text = string.Format("{0}{1}", DataService.Instance.GetText(teeniepingData.name_text_id), DataService.Instance.GetText(80));
        if (LocalValue.isTeeniepingMindGet)
            teeniepingMindCountText.text = string.Format("x{0}",1);
        else
            teeniepingMindCountText.text = string.Format("x{0}",0);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();

        // ������������ ��ưŬ�������� �� ����
        click_stage_number = LocalValue.Click_Stage_H;
        click_chapter_number = LocalValue.Click_Chapter_H;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == click_chapter_number);

        mind_color = teeniepingData.mind_color;
        teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_Mission_RectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMindCracked/" + teeniepingData.mind_teenieping_cracked_name);
        TextRefresh(saveTable, teeniepingData);
        SetSkeletonDataAsset();
        // �ֽ� ���������� Ŭ������ ���� �ƴҶ� -> �������
        if (saveTable.stage_no != LocalValue.Click_Stage_H +1) // ��� Ŭ�����ؼ� GameManager���� stage_no ++ �� ������ ���� ����� ���ǹ�
        {
            return;
        }
        
        LocalValue.isStageClear = true; // �κ�Ŵ������� ���� ���θ� ������ 
        LocalValue.isTeeniepingMindGet = false; // �ʱ�ȭ
    }

}
