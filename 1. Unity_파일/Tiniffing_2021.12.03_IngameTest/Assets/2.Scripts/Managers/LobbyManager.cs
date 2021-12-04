using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Spine.Unity;
public class LobbyManager : MonoBehaviour
{
    public static LobbyManager instance;

    [SerializeField] private LobbyScrollViewController lobbyScrollViewController;
    [SerializeField] private LobbyUIInfo lobbyUIInfo;
    public Transform contentTr;

    public RectTransform teeniepingCollectionRectTr;
    public RectTransform canvasRectTr;
    public GameObject teeniepingMindRewardParentObj;
    public ScrollRect teeniepingCollectionPoolingScrollView;

    private Sequence characterJumpSequence;
    private bool isFinalStageClearDisplayFinished = false;


    private void Awake()  // 이 스크립트가 붙어있는 오브젝트가 달려있는 씬이 로드될때 호출
    {
        if (instance == null)
            instance = this;
        else
        {
            Destroy(gameObject);
            return;
        }
    }

    public void Init()
    {
        //배경세팅
        lobbyUIInfo.Init();
        // scroll view  Setting
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        int chapter_no = saveTable.chapter_no;
        int stage_no = saveTable.stage_no;
        int now_chapter_no = saveTable.now_chapter_no;

        NewbieCheck(saveTable);
        Debug.LogError("stage no :" + LocalValue.Click_Stage_H);
        if (LocalValue.Click_Stage_H == 0)
        {
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
            return;
        }
       
        if (stage_no - 1 != LocalValue.Click_Stage_H || lobbyData.retry == 1) //과거의 스테이지 하는 경우
        {
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
            IsRetryButtonClick();
            IsNextStageButtonClick();
            StartCoroutine(TeeniepingCatchMaskOnCheckCor());
            return;
        }

        if(LocalValue.isToBeUpdatedButtonClick)
        {
            StartCoroutine(GameClearPerformance());
            return;
        }
        // 한 챕터의 마지막 스테이지 클리어 
        if(LocalValue.isLatestFinalStage)
        {
            if (LocalValue.isRetryButtonClick == false) // 넥스트 챕터 눌렀을때
            {
                StartCoroutine(FinalStageClearPerformance());
                Debug.Log("마지막 스테이지 클리어 다음 버튼 클릭");
                return;
            }
            else
            {
                Debug.Log("마지막 스테이지 재도전");
                lobbyScrollViewController.OnStageBoxSpread(chapter_no-1);
                LocalValue.isStageClear = false; //초기화
                IsRetryButtonClick();
                return;
            }
        }

        // 가장 최신 플레이 한 상태에서 다음 챕터로 넘어가지않고 재도전을 했을때, 근데 그 재도전을 하지 않고 다음챕터 버튼이나 이전 챕터 버튼을 눌러서 해당 버튼의 기능에 의해 LobbyManager.instance.init() 이 된 경우
        if(LocalValue.isLatestFinalStage)
        {
            LocalValue.isLatestFinalStage = false;
      //      saveTable.now_chapter_no
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
            return;
        }
        // ------------------------이 아래는 마지막 스테이지를 클리어 한 상황이 아닐때 Init 해주는 코드임--------------------------------------
        InGameClearPerformance(now_chapter_no);

        IsRetryButtonClick();
        IsNextStageButtonClick();
    }
    public void InGameClearPerformance(int now_chapter_no )
    {
        if (LocalValue.isStageClear == true)
        {
            LocalValue.isStageClear = false;
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no, true);
            ClearEffectDisplay();
            if (LocalValue.isRetryButtonClick == false) // 재도전이 아닐 경우에만 코루틴으로 시간 벌어주기
            {
                // yield return 으로 대기시간을 줘야 위의 캐릭터 점핑 시간이 생길듯
            }
        }
        else
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
    }
    public void IsRetryButtonClick()
    {
        // 인 게임 팝업에서 재 도전 버튼을 눌러서  해당 팝업 켜야할 경우 , 연출안보여줌
        if (LocalValue.isRetryButtonClick == true)
        {
            LocalValue.isRetryButtonClick = false; 
            PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init(); // 게임에 들어가기 전에 설정해놨던 click_stage_no 랑 click_chapter_no 로 설정될 거임
        }
    }
    public void IsNextStageButtonClick()
    {
        // 인게임 팝업에서  next stage 버튼 눌러서 다음 스테이지로 가는 팝업 켜야할 경우 , 연출안보여줌
        if (LocalValue.isNextStageButtonClick == true)
        {
            LocalValue.isNextStageButtonClick = false; // 초기화
            PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init(); // InGameClearPopup에서 click_stage_no 를 ++ 해주었기에 그거에 맞게 설정되서 켜질것임
        }
    }
    IEnumerator TeeniepingCatchMaskOnCheckCor()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingCollectionTable = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == saveTable.now_chapter_no);
        if (teeniepingCollectionTable.mind_count == 20 && teeniepingCollectionTable.get_check != 1)
        {
            yield return new WaitUntil(() => LocalValue.isFakeLoadingFinished);
            lobbyUIInfo.TeeniepingMindMaskOn();
        }
        yield break;
    }
    private void ClearEffectDisplay()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int clear_stage_no = saveTable.stage_no - 1;
        int challenge_stage_no = saveTable.stage_no;
        var lobbyDataList = DataService.Instance.GetDataList<Table.LobbyTable>().FindAll(x => x.stage_no == clear_stage_no || x.stage_no == challenge_stage_no); // 0번째가 clear 스테이지 1번째가 도전할 스테이지
        GameObject clearStageObj = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(0).gameObject; //도전해서 클리어 한 스테이지
        GameObject challengeStageObj = contentTr.Find(string.Format("Stage{0}", challenge_stage_no.ToString())).GetChild(0).gameObject; //  앞으로 도전해야할 스테이지

        clearStageObj.transform.GetChild(0).GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Lobby/unboxing"); // Object의 0번째 자식이 BoxImage 오브젝트임
        challengeStageObj.transform.GetChild(0).GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Lobby/black_unboxing");
        clearStageObj.transform.GetChild(5).gameObject.SetActive(true); //touchBlock on

        StartCoroutine(StageClearLobbyScrollViewDisplayCoroutine(clearStageObj, challengeStageObj, lobbyDataList, clear_stage_no));
        StartCoroutine(ScrollViewNomalizedPositionMove(challengeStageObj)); // scrollrect normalized pos move
    }
    IEnumerator FinalStageClearPerformance()
    { // 일단은 chapter가 증가하기 전의 상태의 챕터의 상태로 뿌려줌
        Debug.LogError(" now chapter no : " + DataService.Instance.GetData<Table.SaveTable>(0).now_chapter_no);
        Debug.LogError(" LocalValue.Click_Chapter_H: " + LocalValue.Click_Chapter_H);
        lobbyScrollViewController.OnStageBoxSpread(LocalValue.Click_Chapter_H, true, true);
        LocalValue.isScenarioFinished = false;

        var teeniepingCollectionTable = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == LocalValue.Click_Chapter_H);
        if (teeniepingCollectionTable.mind_count == 20)
        {
            lobbyUIInfo.TeeniepingMindMaskOn();
            yield return new WaitUntil(() => LocalValue.isScenarioFinished);
        }
        else
        {
            // 시간 벌어주기용 
            yield return YieldInstructionCache.WaitForEndOfFrame;
        }
        LocalValue.isLatestFinalStage = false; // 이거 위치는 바뀌면 안됨, 스크롤뷰와 스크롤뷰 코드 사이에 있어야함 
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no = saveTable.chapter_no;
        DataService.Instance.UpdateData(saveTable);
        FinalStageClearLobbyScrollViewDisplay(saveTable);
        yield return new WaitUntil(() => isFinalStageClearDisplayFinished);
        lobbyScrollViewController.OnStageBoxSpread(LocalValue.Click_Chapter_H + 1, false, false);
        lobbyUIInfo.Init();
        PopupContainer.CreatePopup(PopupType.ChapterBookPopup).Init();
    }
   
    private IEnumerator StageClearLobbyScrollViewDisplayCoroutine(GameObject clearStageObj, GameObject challengeStageObj, List<Table.LobbyTable> lobbyDataList, int clear_stage_no)
    {
        GameObject clearStageOEffect = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(2).gameObject;
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        SkeletonAnimation skeletonAnimation = lobbyScrollViewController.characterObj.GetComponent<SkeletonAnimation>();
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.loop = false;
        skeletonAnimation.AnimationName = "Jump";
        skeletonAnimation.Initialize(true);

        RectTransform characterRect = lobbyScrollViewController.characterObj.GetComponent<RectTransform>();
        float xMove1 = characterRect.anchoredPosition.x + 2f;
        float xMove2 = xMove1 + 246f;

        characterJumpSequence = DOTween.Sequence().OnStart(() =>
        {
            clearStageOEffect.SetActive(true);
        })
            .Prepend(characterRect.DOAnchorPosX(xMove1, 1f).SetEase(Ease.Linear)) //점프 차징
        .Insert(0.6f, characterRect.DOAnchorPosX(xMove2, 0.5f).SetEase(Ease.OutQuad)) //점프 동작
        .Insert(0.55f, clearStageObj.GetComponent<RectTransform>().DOAnchorPos(new Vector2(0, 0), 1f)) // 클리어한 박스는 0,0 으로 위치 돌리기)
        .InsertCallback(1f, () => ClearStageSpriteChange(clearStageObj, challengeStageObj, lobbyDataList))//이미지를 바꿔줌
        .Insert(0.9f, characterRect.DOAnchorPosX(xMove2 + 0f, 0.5f).SetEase(Ease.OutQuad)).OnComplete(() => //애니메이션의 자연스러운 동작을 위한 지연
        {
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.loop = true;
            skeletonAnimation.Initialize(true);
        });
        yield return YieldInstructionCache.WaitForSeconds(0.9f);

        RectTransform challengStageRect = challengeStageObj.GetComponent<RectTransform>();
        challengStageRect.DOKill();
        challengStageRect.DOAnchorPosY(-40.2f, 0.47f).SetEase(Ease.OutQuart);//박스를 내려줌
        clearStageObj.transform.GetChild(5).gameObject.SetActive(false); // touchBlock off
    }
    private void ClearStageSpriteChange(GameObject clearStageObj, GameObject challengeStageObj, List<Table.LobbyTable> lobbyDataList)
    {
        Image clearStageImage = clearStageObj.transform.GetChild(0).GetComponent<Image>();
        Image challengeStageImage = challengeStageObj.transform.GetChild(0).GetComponent<Image>();
        clearStageImage.transform.DOScale(new Vector2(0, 0), 0f);
        clearStageImage.sprite = Resources.Load<Sprite>("Images/Lobby/" + lobbyDataList[0].box_image_name);
        challengeStageImage.sprite = Resources.Load<Sprite>("Images/Lobby/" + lobbyDataList[1].box_image_name);
        clearStageImage.transform.DOScale(new Vector2(1, 1), 0.5f);

    }
    private void FinalStageClearLobbyScrollViewDisplay(Table.SaveTable saveTable)
    {
        int clear_stage_no = saveTable.stage_no - 1;
        GameObject clearStageObj = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(0).gameObject; //도전해서 클리어 한 스테이지
        RectTransform characterRect = lobbyScrollViewController.characterObj.GetComponent<RectTransform>();
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == clear_stage_no);
        SkeletonAnimation skeletonAnimation = lobbyScrollViewController.characterObj.GetComponent<SkeletonAnimation>();
        skeletonAnimation.AnimationName = "Jump";
        skeletonAnimation.Initialize(true);
        Image finalStageClearImage = clearStageObj.transform.GetChild(0).GetComponent<Image>();
        GameObject clearStageOEffect = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(3).gameObject;

        float xMove1 = characterRect.anchoredPosition.x + 2f; // 첫 점프 차징
        float xMove2 = xMove1 + 198f; //첫 점프
        float xMove3 = xMove2 + 2f; //둘째 점프 차징
        float xMove4 = xMove3 + 246f; //둘째 점프
        float yMove1 = characterRect.anchoredPosition.y - 145f; //첫 점프

        characterJumpSequence = DOTween.Sequence().OnStart(() =>
        {
            clearStageOEffect.SetActive(true);
        })
        .Prepend(characterRect.DOAnchorPosX(xMove1, 1f).SetEase(Ease.Linear)) //첫 점프 차징
        .Insert(0.6f, characterRect.DOAnchorPosX(xMove2, 0.5f).SetEase(Ease.OutQuad)) // 첫 점프 길이
        .Insert(0.9f, characterRect.DOAnchorPosY(yMove1, 0.6f).SetEase(Ease.OutQuad)) // 첫 점프 높이
        .Insert(0.7f, clearStageObj.GetComponent<RectTransform>().DOAnchorPos(new Vector2(0, 0), 1f)) // 클리어한 박스는 0,0 으로 위치 돌리기
        .InsertCallback(1.3f, () => FinalStageClearSpriteChange(finalStageClearImage, lobbyTable))
        .Insert(1.7f, characterRect.DOAnchorPosX(xMove3, 1f).SetEase(Ease.Linear)) //둘째 점프 차징
        .Insert(2.15f, characterRect.DOAnchorPosX(xMove4, 0.5f).SetEase(Ease.OutQuad)) // 둘째 점프 높이
        .InsertCallback(2.3f, () => FakeLoadingCanvasOn()).OnComplete(() =>
        {
            isFinalStageClearDisplayFinished = true;
        });        
}
private void FinalStageClearSpriteChange(Image finalStageClearImage, Table.LobbyTable lobbyTable)
    {
        finalStageClearImage.transform.DOScale(new Vector2(0, 0), 0f);
        finalStageClearImage.sprite = Resources.Load<Sprite>("Images/Lobby/" + lobbyTable.box_image_name);
        finalStageClearImage.transform.DOScale(new Vector2(1, 1), 0.5f);
    }
    private void FakeLoadingCanvasOn()
    {
        GameObject fakeLoadingCanvas = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/FakeLoadingCanvas"));
        fakeLoadingCanvas.GetComponent<FakeLoadingBar>().Init();
    }
    IEnumerator ScrollViewNomalizedPositionMove(GameObject challengeStageObj)
    {
        yield return YieldInstructionCache.WaitForEndOfFrame;

        float challengeStagePosX = challengeStageObj.transform.parent.GetComponent<RectTransform>().anchoredPosition.x;
        float contentWidth = lobbyScrollViewController.scrollRect.content.sizeDelta.x;
        float viewPortWidth = lobbyScrollViewController.scrollRect.viewport.rect.width;
        float moveRange = contentWidth - viewPortWidth;
        float ratio = 0.5f;
        float challengeStageNomalizedPosX = (challengeStagePosX - viewPortWidth * ratio) / moveRange;
        
        if (challengeStageNomalizedPosX < 0)
            challengeStageNomalizedPosX = 0;
        else if (challengeStageNomalizedPosX > 1)
            challengeStageNomalizedPosX = 1;

        float speed = 0.05f;
        float threshold = 0.001f; // 임계값
        while (lobbyScrollViewController.scrollRect.horizontalNormalizedPosition + threshold < challengeStageNomalizedPosX)
        {
            lobbyScrollViewController.scrollRect.horizontalNormalizedPosition += Time.deltaTime * speed; // Time.deltaTime : frame 과 frame 사이의 시간 
            yield return null; // 제어를 넘겨준다
        }
        lobbyScrollViewController.scrollRect.horizontalNormalizedPosition = challengeStageNomalizedPosX;
    }
    IEnumerator GameClearPerformance()
    {
        lobbyScrollViewController.OnStageBoxSpread(LocalValue.Click_Chapter_H);
        yield return YieldInstructionCache.WaitForEndOfFrame;
    }
    public void LobbyScrollViewStart(int chapter_no)
    {
        lobbyScrollViewController.OnStageBoxSpread(chapter_no);
    }
    private void NewbieCheck(Table.SaveTable saveTable)
    {
        if (saveTable.newbie == 0)
        {
            PopupContainer.CreatePopup(PopupType.ChapterBookPopup).Init();
        }
    }
    public void LobbyRefresh()
    {
        lobbyUIInfo.OnRefresh();
    }
    public void CharacterRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if(saveTable.chapter_no != saveTable.now_chapter_no)
        {
            return;
        }
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        SkeletonAnimation skeletonAnimation = lobbyScrollViewController.characterObj.GetComponent<SkeletonAnimation>();
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
    private void OnDestroy()
    {
        instance = null;
    }
}
