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

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    // Clear Display

    [SerializeField] private RectTransform missionFail_TextImage_RectTr;
    [SerializeField] private RectTransform teeniepingMind_GetCount_Group_RectTr;
    [SerializeField] private RectTransform teeniepingMindImage_Mission_RectTr; // 미션쪽 티니핑 이미지 
    [SerializeField] private RectTransform teeniepingMindImage_CrackedRectTr;//티니핑 깨지는 이미지 렉트
    [SerializeField] private RectTransform goldRewardGroupRectTr;
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;
    [SerializeField] private RectTransform goldRewardRectTr;
    [SerializeField] private RectTransform starCoinRewardRectTr;
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;
    [SerializeField] private RectTransform arrowSignGroupRectTr;

    [SerializeField] private RectTransform retryButtonRectTr;

    [SerializeField] private GameObject teeniepingMind_Cracked_EffectObj;//깨지는 이펙트를 받아오기 위해 추가

    [SerializeField] private Text teeniepingMind_GetCount_Text;
    private Sequence TeeniepingBadShakeMovementSequence;//티니핑의 마음 bad전용 흔들리는 이동 시퀀스


    private Sequence perfectSequence;
    private Sequence fineSequence;
    private Sequence badSequence;

    private Sequence starSequence_1;
    private Sequence starSequence_2;
    private Sequence starSequence_3;


    private int click_stage_number;
    private int click_chapter_number;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
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

        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == click_chapter_number);


        click_stage_number = LocalValue.Click_Stage_H;
       click_chapter_number = LocalValue.Click_Chapter_H;

        teeniepingMindRewardImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_Mission_RectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        teeniepingMindImage_CrackedRectTr.GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMindCracked/" + teeniepingData.mind_teenieping_cracked_name);

        teeniepingMind_GetCount_Text.text = string.Format("{0} / 20", teeniepingData.mind_count);
        stage_no_txt.text = string.Format("{0} {1}",DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoin_txt.text = DataService.Instance.GetText(19);
        reward_list_txt.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);

        SetSkeletonDataAsset();

    }
}
