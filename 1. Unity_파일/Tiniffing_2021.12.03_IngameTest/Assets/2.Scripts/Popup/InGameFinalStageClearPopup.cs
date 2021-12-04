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
    [SerializeField] private RectTransform teeniepingMindImage_Mission_RectTr; // 미션쪽 티니핑 이미지 
    [SerializeField] private RectTransform teeniepingMindImage_CrackedRectTr;//티니핑 깨지는 이미지 렉트
    [SerializeField] private RectTransform goldRewardGroupRectTr;
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;
    [SerializeField] private RectTransform goldRewardRectTr;
    [SerializeField] private RectTransform starCoinRewardRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;
    [SerializeField] private RectTransform arrowSignGroupRectTr;

    [SerializeField] private RectTransform nextStageButtonRectTr;
    [SerializeField] private RectTransform retryButtonRectTr;

    [SerializeField] private GameObject teeniepingMind_Cracked_EffectObj;//깨지는 이펙트를 받아오기 위해 추가

    private Sequence TeeniepingBadShakeMovementSequence;//티니핑의 마음 bad전용 흔들리는 이동 시퀀스


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
    private int get_starCount; // 실제적으로 획득한 스타코인 수
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
            if (lobbyData.retry == 1) //  // 과거 언젠가 3별클을 했었다. => 티니핑 마음을 획득한 상태
            {
                if (get_starCount == 0) // 과거에 내가 이미 3별클을 한거지 !! (why? => 방금 판 3별클했는데  실제적으로 얻은 코인이 0개니깐)
                {
                    MissionClearDisplay_Fine();
                    yield break;
                }
                else // 과거에 1별클이던 2별클이던 해서 get_starCount가 1 이상인경우 
                {
                    MissionClearDisplay_Perfect();
                    yield break;
                }

            }
            else // 이번이 처음으로 3별클 한 시점이다
            {
                MissionClearDisplay_Perfect();
                yield break;
            }
            // 처음 도전해서 바로 3별클 => 강한연출

        }
        else // 방금 판 3별클이 아니야
        {
            if (lobbyData.retry == 1 && lobbyData.star_count == 3) // 과거에 이미 마인드를 획득했어
            {
                MissionClearDisplay_Fine();
                yield break;
            }
            else // 걍 재도전을 했든 말든 과거에도 지금도 3별클을 못했어
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

        // 초기화용 코드
        missionClear_TextImage_Obj.SetActive(true);
        missionCleared_TextImage_Obj.SetActive(false);
        missionFail_TextImage_Obj.SetActive(false);

        Three_Star_Get_Display();
        Perfect_Sequence_Display();
    }
    private void MissionClearDisplay_Fine()
    {
        Debug.Log("Fine");
        // 초기화용 코드
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
        // 초기화용 코드
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
        .Insert(1.9f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(7.7f, 0.1f))//좌,우로 흔드는 코드가 끝나는 시점에 맞춰 타이밍을 
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
    private void TeeniepingBadOn()//깨진 이미지 켜주고, 티니핑 원본 이미지 꺼짐, 이펙트 켜줌
    {
        teeniepingMindImage_CrackedRectTr.gameObject.SetActive(true);
        teeniepingMindImage_Mission_RectTr.gameObject.SetActive(false);
        teeniepingMind_Cracked_EffectObj.SetActive(true);
    }
    private void TeeniepingBadShakeMovement()//티니핑 마음 좌, 우 흔들어 주는 코드
    {
        TeeniepingBadShakeMovementSequence = DOTween.Sequence()
        .Insert(0f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(9.7f, 0.1f))
        .Insert(0.1f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(5.7f, 0.1f));
    }
    // 캐릭터 3별클 스파인 애니매이션 연출
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
        if (lobbyTable.retry == 1) // 재도전체킹 되어있으면 무조건 최신이 아님
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
        LocalValue.isStageClear = true; // 연출 여부를 결정함
        LocalValue.isRetryButtonClick = true; // 로비 매니저에서 조건문에 사용할 변수
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }

   
    private void TextRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter ==click_chapter_number);
        
        if(saveTable.game_clear==1 && saveTable.chapter_no-1==LocalValue.Click_Chapter_H)
        {
            nextChapterText.text = DataService.Instance.GetText(66); // 업데이트 예정입니다 문구
            toBeUpdateButtonObj.SetActive(true);
        }
        else
        {
            switch (Application.systemLanguage)
            {
                case SystemLanguage.Korean:
                    nextChapterText.text = string.Format("{0} {1}", DataService.Instance.GetText(14), (click_chapter_number + 1).ToString());
                    break;
                default: //영어
                    nextChapterText.text = string.Format("{0}\n{1}", DataService.Instance.GetText(14), (click_chapter_number + 1).ToString());
                    break;
            }
        }     
        stageNoText.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // 획득한 스타코인 양
        getGoldCountText.text = string.Format("x{0}",LocalValue.Get_Gold.ToString());
        // adText.text = DataService.Instance.GetText(21);
        if (now_StarCount == 3)
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = (teeniepingData.mind_count - 1).ToString(); // 연출위해서 -1 시켜놓음
        }
        else
        {
            teeniepingMind_GetCount_Text_RectTr.GetComponent<Text>().text = teeniepingData.mind_count.ToString(); // 획득하는 것이 없으니깐 그냥 둠
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


        // 최신 스테이지를 클리어한 것이 아닐때 -> 연출안함
        if (lobbyTable.retry==1) // 재도전체킹 되어있으면 무조건 최신이 아님
        {
            nextChapterButton_LastObj.SetActive(true); // 그냥 챕터 넘어가는 버튼 온
            return;
        }

        LocalValue.isLatestFinalStage = true; // 연출
        LocalValue.isTeeniepingMindGet = false; // 초기화
    }

}
