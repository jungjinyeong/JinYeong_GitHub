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
    [SerializeField] private Text adText;
    [SerializeField] private Text teeniepingNameText;
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private GameObject star1_Obj;
    [SerializeField] private GameObject star2_Obj;
    [SerializeField] private GameObject star3_Obj;
    [SerializeField] private Image teeniepingMindImage;
    [SerializeField] private RectTransform groupRect;
    [SerializeField] private SkeletonAnimation skeletonAnimation;
    // Clear Display-----------------------------------------------------------------
    [SerializeField] private RectTransform star1RectTr;//스타 1 오브젝트
    [SerializeField] private RectTransform star2RectTr;//스타 2 오브젝트
    [SerializeField] private RectTransform star3RectTr;//스타 3 오브젝트
    [SerializeField] private RectTransform teeniepingMind_MissionClear_TextImage_RectTr;//티니핑 미션 이미지 & 현재 스테이지 텍스트
    [SerializeField] private RectTransform teeniepingMind_GetCount_Group_RectTr;//남은 갯수 그룹
    [SerializeField] private RectTransform teeniepingMind_GetCount_Text_RectTr;//남은 갯수 텍스트
    [SerializeField] private RectTransform teeniepingMind_MissionClear_Image_RecrtTr;//티니핑 이미지
    [SerializeField] private RectTransform goldRewardGroupRectTr;//골드 보상 그룹
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;//스타 보상 그룹
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;//티니핑 보상 그룹
    [SerializeField] private RectTransform goldRewardRectTr;//골드 보상 아이콘
    [SerializeField] private RectTransform starCoinRewardRectTr;//스타 보상 아이콘
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;//티니핑 보상 아이콘
    [SerializeField] private RectTransform ArrowSignGroupRectTr;//다음 버튼 그룹
    [SerializeField] private RectTransform nextStageButtonRectTr;//다음 스테이지 버튼
    [SerializeField] private RectTransform retryButtonRectTr;//재도전 버튼
    private Sequence starSequence_1;
    private Sequence starSequence_2;

    private int click_stage_number;
    private int click_chapter_number;
    private int now_StarCount;
    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
        now_StarCount = LocalValue.Now_StarCount;
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        Debug.Log("111111111111");

        if (now_StarCount == 3)
        {
            Debug.Log("now star count : "+ now_StarCount);

            StartCoroutine(CharacterSpineDisplay_3_Star());
            Debug.Log("111111111111");

        }
        
        if (now_StarCount == 3) { }
        if (now_StarCount == 3)
        {
            if (lobbyData.retry == 1) // 재도전을 했을 경우
            {
                if (lobbyData.star_count == 3) // 과거 언젠가 3별클을 했었다. => 티니핑 마음을 획득한 상태
                {
                    MissionClearDisplay_Fine();
                    return;
                }
                
            }
            else // 이번이 처음으로 3별클 한 시점이다
            {
                MissionClearDisplay_Perfect();
                Debug.Log("111111111111");
                return;
            }

            // 처음 도전해서 바로 3별클 => 강한연출

        }
        else // 방금 판 3별클이 아니야
        {
            if (lobbyData.retry == 1 && lobbyData.star_count == 3) // 과거에 이미 마인드를 획득했어
            {
                MissionClearDisplay_Fine();
                return;
            }
            else // 걍 재도전을 했든 말든 과거에도 지금도 3별클을 못했어
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
    private Sequence perfectSequence;
    private void MissionClearDisplay_Perfect()//최초 3별 클 경우, 별이 나오는 도중 미션 클리어 문구와 남은 갯수가 나오고, 티니핑의 마음이 회전하면서 나온다. 그리고 보상 목록 이 좌, 우로 순차적으로 나옴
    {
        perfectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1별 ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 1번
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//별 1번
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2별 ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 2번
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//별 2번
        {
            star3RectTr.GetComponent<GameObject>().SetActive(true);//3별 ON
        })
        .Insert(0.6f, star3RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 3번
        .Insert(0.6f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//미션 클리어 문구
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//남은 갯수
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//별 3번
        .Insert(0.7f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//미션 클리어 문구
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//남은 갯수
        .InsertCallback(0.8f, () => teeniepingMind_MissionClearImageEffectOn())
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DORotate(new Vector2(0, 360f * 5f), 0.5f, RotateMode.LocalAxisAdd))//티니핑 이미지 회전
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1f, 1f), 0.5f).SetEase(Ease.InSine))//티니핑 이미지 크게
        .InsertCallback(1.3f, () => teeniepingMind_MissionClearImageEndEffectOn())
        .Insert(1.4f, teeniepingMind_GetCount_Text_RectTr.DORotate(new Vector3(360f * 2f, 0f, 0f), 0.2f, RotateMode.LocalAxisAdd))//남은 갯수 회전
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.8f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.9f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.5f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.6f, ArrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.8f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999,LoopType.Yoyo));
    }
    private void teeniepingMind_MissionClearImageEffectOn()
    {
        //티니핑 이미지 이펙트 넣어야함
    }
    private void teeniepingMind_MissionClearImageEndEffectOn()
    {
        //티니핑 회전이 끝나고 팡 터지는 이펙트 넣어야함
    }
    private void MissionClearDisplay_Fine()//과거 3별 클 경우
    {
        //if문으로 별 체크
        /*if (now_StarCount == 1)
        {
            starSequence_1 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.GetComponent<GameObject>().SetActive(true);//1별 ON
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 1번
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//별 1번
        }
        if (now_StarCount == 2)
        {
            starSequence_2 = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1별 ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 1번
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//별 1번
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2별 ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 2번
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//별 2번
        }*/
        perfectSequence = DOTween.Sequence()
        .Insert(0.6f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//미션 클리어 문구
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//남은 갯수
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//별 3번
        .Insert(0.7f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//미션 클리어 문구
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//남은 갯수
        .InsertCallback(0.8f, () => teeniepingMind_MissionClearImageEffectOn())
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))//티니핑 이미지 크게
        .Insert(0.9f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))//티니핑 이미지 크게
        .Insert(1f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))//티니핑 이미지 크게
        .InsertCallback(1.3f, () => teeniepingMind_MissionClearImageEndEffectOn())
        .Insert(1.4f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.7f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.8f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.9f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.1f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.2f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.4f, ArrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.6f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void MissionFailDisplay_Bad()//완전한 실패가 아닌 티니핑 마음을 획득 못한 실패여서 별 체크 해줘야함
    {
        if (now_StarCount == 1)
        {
            starSequence_1 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.GetComponent<GameObject>().SetActive(true);//1별 ON
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 1번
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//별 1번
        }
        if (now_StarCount == 2)
        {
            starSequence_2 = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1별 ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 1번
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//별 1번
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2별 ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//별 2번
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//별 2번
        }
    }
    // 캐릭터 3별클 스파인 애니매이션 연출
    IEnumerator CharacterSpineDisplay_3_Star()
    {
        while (true)
        {
            skeletonAnimation.AnimationName = "Clear";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(2.7f);
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(10f);
        }
    }
    // Init Setting
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
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H"); // 로딩바 띄우고 
    }

    public void OnRetryButtonClick() // clear 시 retry 는 로비로 가서 팝업을 켜줌
    {
        LocalValue.isRetryButtonClick = true; // 로비 매니저에서 조건문에 사용할 변수
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");

    }
    public void OnNextStageButtonClick()
    {

        LocalValue.Click_Stage_H = click_stage_number + 1; // 스테이지만 증가
        LocalValue.Click_Chapter_H = click_chapter_number; // 챕터는 그대로
        LocalValue.isNextStageButtonClick = true;  // 로비에서 다음 스테이지 팝업이 켜질 수 있도록
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
    private void TextRefresh(Table.SaveTable saveTable, Table.TiniffingCollectionTable teeniepingData)
    {
        nextStageText.text = string.Format("{0}\n{1}", DataService.Instance.GetText(2), (click_stage_number + 1).ToString());
        stageNoText.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // 획득한 스타코인 양
        getGoldCountText.text = string.Format("x{0}", LocalValue.Get_Gold.ToString());
        adText.text = DataService.Instance.GetText(21);
        teeniepingNameText.text = string.Format("{0}{1}", DataService.Instance.GetText(teeniepingData.name_text_id), DataService.Instance.GetText(80));
        if (LocalValue.isTeeniepingMindGet)
            teeniepingMindCountText.text = string.Format("x{0}", 1);
        else
            teeniepingMindCountText.text = string.Format("x{0}", 0);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        // 다음스테이지 버튼클릭했을때 값 설정
        click_stage_number = LocalValue.Click_Stage_H;
        click_chapter_number = LocalValue.Click_Chapter_H;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == click_chapter_number);
        teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        TextRefresh(saveTable, teeniepingData);
        SetSkeletonDataAsset();
        StarObjectActiveController();
        // 최신 스테이지를 클리어한 것이 아닐때 -> 연출안함
        if (saveTable.stage_no != LocalValue.Click_Stage_H + 1) // 방금 클리어해서 GameManager에서 stage_no ++ 을 해줬을 것을 고려한 조건문
        {
            return;
        }

        LocalValue.isStageClear = true; // 로비매니저에서 연출 여부를 결정함 
        LocalValue.isTeeniepingMindGet = false; // 초기화
    }


}
