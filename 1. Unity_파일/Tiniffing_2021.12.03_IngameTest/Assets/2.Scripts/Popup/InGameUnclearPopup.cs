using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
using DG.Tweening;
public class InGameUnclearPopup : BasePopup
{

    [SerializeField] private Text retryText;
    [SerializeField] private Text stage_no_txt;
    [SerializeField] private Text goldText;
    [SerializeField] private Text starCoin_txt;
    [SerializeField] private Text reward_list_txt;

    [SerializeField] Image teeniepingMindRewardImage;
    [SerializeField] private RectTransform groupRect;
    [SerializeField] private RectTransform closeButtonRectTr;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    // UnClear Display

    [SerializeField] private RectTransform teeniepingMind_GetCount_Group_RectTr;
    [SerializeField] private RectTransform missionTextImageGroup_RectTr;
    [SerializeField] private RectTransform teeniepingMindImage_Mission_RectTr; // 미션쪽 티니핑 이미지 
    [SerializeField] private RectTransform teeniepingMindImage_CrackedRectTr;//티니핑 깨지는 이미지 렉트
    [SerializeField] private RectTransform goldRewardGroupRectTr;
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;
    [SerializeField] private RectTransform goldRewardRectTr;
    [SerializeField] private RectTransform starCoinRewardRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;
    [SerializeField] private RectTransform arrowSignGroupRectTr;

    [SerializeField] private Text teeniepingMind_GetCount_Text;

    [SerializeField] private RectTransform retryButtonRectTr;

    [SerializeField] private GameObject teeniepingMind_Cracked_EffectObj;//깨지는 이펙트를 받아오기 위해 추가

    private Sequence TeeniepingBadShakeMovementSequence;//티니핑의 마음 bad전용 흔들리는 이동 시퀀스


    private Sequence badSequence;

    private int click_stage_number;
    private int click_chapter_number;
    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
        StartCoroutine(InGameUnClearDIsplay());
    }
    IEnumerator InGameUnClearDIsplay()
    {
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        yield return YieldInstructionCache.WaitForSeconds(0.5f);
        MissionFailDisplay_Bad();
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }

    private void MissionFailDisplay_Bad()
    {
        Bad_Sequence_Display();
    }
    private void Bad_Sequence_Display()
    {
        badSequence = DOTween.Sequence()
        .Insert(0f, missionTextImageGroup_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.1f, missionTextImageGroup_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.1f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.1f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))
        .Insert(0.3f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))
        .Insert(1.4f, teeniepingMindImage_Mission_RectTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))
        .InsertCallback(0.5f, () => TeeniepingBadOn())
        .InsertCallback(0.5f, () => TeeniepingBadShakeMovement()).SetLoops(6, LoopType.Yoyo)
        .Insert(0.5f, teeniepingMindImage_CrackedRectTr.GetComponent<Image>().DOFade(1f, 0.5f))
        .Insert(1.1f, teeniepingMindImage_CrackedRectTr.DOAnchorPosX(7.7f, 0.1f))//좌,우로 흔드는 코드가 끝나는 시점에 맞춰 타이밍을 
        .InsertCallback(1.1f, () => TeeniepingMind_Cracked_EffectOn())
        .InsertCallback(1.1f, () => TeeniepingMindImage_Cracked_ColorChange_Gray())
        .Insert(1.2f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.2f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.5f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.6f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.7f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.8f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.9f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.0f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.1f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.2f, arrowSignGroupRectTr.DOAnchorPosX(516.2f, 1.2f)).SetEase(Ease.Linear)
        .InsertCallback(2.7f, () => TweenEffect_CloseButton(closeButtonRectTr))
        .Insert(3.4f, retryButtonRectTr.DOAnchorPosX(-8f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
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
    // -----------------------------------------------------------------------------Init Setting -----------------------------------------------------------------------------

    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);

        skeletonAnimation.AnimationName = "Fail";
        skeletonAnimation.Initialize(true);
    }

    public void OnLoobyGoButtonClick() // Lobby Go
    {
        LocalValue.Map_H = 0; 
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H"); // 로딩바 띄우고 
    }
    public void OnRetryButtonClick()
    {
        LocalValue.Map_H = 0;
        LocalValue.isStageClear = false; // 연출 여부를 결정함
        LocalValue.isRetryButtonClick = true; // 로비 매니저에서 조건문에 사용할 변수
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
 
    public override void OnRefresh()
    {
        base.OnRefresh();

        click_stage_number = LocalValue.Click_Stage_H;
        click_chapter_number = LocalValue.Click_Chapter_H;

        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == click_chapter_number);

        Debug.Log(" click_chapter_number : " + click_chapter_number + " LocalValue.Click_Chapter_H " + LocalValue.Click_Chapter_H);

        teeniepingMindRewardImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_Mission_RectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMindCracked/" + teeniepingData.mind_teenieping_cracked_name);

        Debug.Log("mind cracked : " + teeniepingData.mind_teenieping_cracked_name);

        teeniepingMind_GetCount_Text.text = string.Format("{0} / 20", teeniepingData.mind_count);
        stage_no_txt.text = string.Format("{0} {1}",DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoin_txt.text = DataService.Instance.GetText(19);
        reward_list_txt.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);

        SetSkeletonDataAsset();

    }
}
