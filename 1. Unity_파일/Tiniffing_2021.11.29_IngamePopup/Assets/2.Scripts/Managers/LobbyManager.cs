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


    private void Awake()  // �� ��ũ��Ʈ�� �پ��ִ� ������Ʈ�� �޷��ִ� ���� �ε�ɶ� ȣ��
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
        //��漼��
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
       
        if (stage_no - 1 != LocalValue.Click_Stage_H || lobbyData.retry == 1) //������ �������� �ϴ� ���
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
        // �� é���� ������ �������� Ŭ���� 
        if(LocalValue.isLatestFinalStage)
        {
            if (LocalValue.isRetryButtonClick == false) // �ؽ�Ʈ é�� ��������
            {
                StartCoroutine(FinalStageClearPerformance());
                Debug.Log("������ �������� Ŭ���� ���� ��ư Ŭ��");
                return;
            }
            else
            {
                Debug.Log("������ �������� �絵��");
                lobbyScrollViewController.OnStageBoxSpread(chapter_no-1);
                LocalValue.isStageClear = false; //�ʱ�ȭ
                IsRetryButtonClick();
                return;
            }
        }

        // ���� �ֽ� �÷��� �� ���¿��� ���� é�ͷ� �Ѿ���ʰ� �絵���� ������, �ٵ� �� �絵���� ���� �ʰ� ����é�� ��ư�̳� ���� é�� ��ư�� ������ �ش� ��ư�� ��ɿ� ���� LobbyManager.instance.init() �� �� ���
        if(LocalValue.isLatestFinalStage)
        {
            LocalValue.isLatestFinalStage = false;
      //      saveTable.now_chapter_no
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
            return;
        }
        // ------------------------�� �Ʒ��� ������ ���������� Ŭ���� �� ��Ȳ�� �ƴҶ� Init ���ִ� �ڵ���--------------------------------------
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
            if (LocalValue.isRetryButtonClick == false) // �絵���� �ƴ� ��쿡�� �ڷ�ƾ���� �ð� �����ֱ�
            {
                // yield return ���� ���ð��� ��� ���� ĳ���� ���� �ð��� �����
            }
        }
        else
            lobbyScrollViewController.OnStageBoxSpread(now_chapter_no);
    }
    public void IsRetryButtonClick()
    {
        // �� ���� �˾����� �� ���� ��ư�� ������  �ش� �˾� �Ѿ��� ��� , ����Ⱥ�����
        if (LocalValue.isRetryButtonClick == true)
        {
            LocalValue.isRetryButtonClick = false; 
            PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init(); // ���ӿ� ���� ���� �����س��� click_stage_no �� click_chapter_no �� ������ ����
        }
    }
    public void IsNextStageButtonClick()
    {
        // �ΰ��� �˾�����  next stage ��ư ������ ���� ���������� ���� �˾� �Ѿ��� ��� , ����Ⱥ�����
        if (LocalValue.isNextStageButtonClick == true)
        {
            LocalValue.isNextStageButtonClick = false; // �ʱ�ȭ
            PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init(); // InGameClearPopup���� click_stage_no �� ++ ���־��⿡ �װſ� �°� �����Ǽ� ��������
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
        var lobbyDataList = DataService.Instance.GetDataList<Table.LobbyTable>().FindAll(x => x.stage_no == clear_stage_no || x.stage_no == challenge_stage_no); // 0��°�� clear �������� 1��°�� ������ ��������
        GameObject clearStageObj = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(0).gameObject; //�����ؼ� Ŭ���� �� ��������
        GameObject challengeStageObj = contentTr.Find(string.Format("Stage{0}", challenge_stage_no.ToString())).GetChild(0).gameObject; //  ������ �����ؾ��� ��������

        clearStageObj.transform.GetChild(0).GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Lobby/unboxing"); // Object�� 0��° �ڽ��� BoxImage ������Ʈ��
        challengeStageObj.transform.GetChild(0).GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/Lobby/black_unboxing");
        clearStageObj.transform.GetChild(5).gameObject.SetActive(true); //touchBlock on

        StartCoroutine(StageClearLobbyScrollViewDisplayCoroutine(clearStageObj, challengeStageObj, lobbyDataList, clear_stage_no));
        StartCoroutine(ScrollViewNomalizedPositionMove(challengeStageObj)); // scrollrect normalized pos move
    }
    IEnumerator FinalStageClearPerformance()
    { // �ϴ��� chapter�� �����ϱ� ���� ������ é���� ���·� �ѷ���
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
            // �ð� �����ֱ�� 
            yield return YieldInstructionCache.WaitForEndOfFrame;
        }
        LocalValue.isLatestFinalStage = false; // �̰� ��ġ�� �ٲ�� �ȵ�, ��ũ�Ѻ�� ��ũ�Ѻ� �ڵ� ���̿� �־���� 
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
            .Prepend(characterRect.DOAnchorPosX(xMove1, 1f).SetEase(Ease.Linear)) //���� ��¡
        .Insert(0.6f, characterRect.DOAnchorPosX(xMove2, 0.5f).SetEase(Ease.OutQuad)) //���� ����
        .Insert(0.55f, clearStageObj.GetComponent<RectTransform>().DOAnchorPos(new Vector2(0, 0), 1f)) // Ŭ������ �ڽ��� 0,0 ���� ��ġ ������)
        .InsertCallback(1f, () => ClearStageSpriteChange(clearStageObj, challengeStageObj, lobbyDataList))//�̹����� �ٲ���
        .Insert(0.9f, characterRect.DOAnchorPosX(xMove2 + 0f, 0.5f).SetEase(Ease.OutQuad)).OnComplete(() => //�ִϸ��̼��� �ڿ������� ������ ���� ����
        {
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.loop = true;
            skeletonAnimation.Initialize(true);
        });
        yield return YieldInstructionCache.WaitForSeconds(0.9f);

        RectTransform challengStageRect = challengeStageObj.GetComponent<RectTransform>();
        challengStageRect.DOKill();
        challengStageRect.DOAnchorPosY(-40.2f, 0.47f).SetEase(Ease.OutQuart);//�ڽ��� ������
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
        GameObject clearStageObj = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(0).gameObject; //�����ؼ� Ŭ���� �� ��������
        RectTransform characterRect = lobbyScrollViewController.characterObj.GetComponent<RectTransform>();
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == clear_stage_no);
        SkeletonAnimation skeletonAnimation = lobbyScrollViewController.characterObj.GetComponent<SkeletonAnimation>();
        skeletonAnimation.AnimationName = "Jump";
        skeletonAnimation.Initialize(true);
        Image finalStageClearImage = clearStageObj.transform.GetChild(0).GetComponent<Image>();
        GameObject clearStageOEffect = contentTr.Find(string.Format("Stage{0}", clear_stage_no.ToString())).GetChild(3).gameObject;

        float xMove1 = characterRect.anchoredPosition.x + 2f; // ù ���� ��¡
        float xMove2 = xMove1 + 198f; //ù ����
        float xMove3 = xMove2 + 2f; //��° ���� ��¡
        float xMove4 = xMove3 + 246f; //��° ����
        float yMove1 = characterRect.anchoredPosition.y - 145f; //ù ����

        characterJumpSequence = DOTween.Sequence().OnStart(() =>
        {
            clearStageOEffect.SetActive(true);
        })
        .Prepend(characterRect.DOAnchorPosX(xMove1, 1f).SetEase(Ease.Linear)) //ù ���� ��¡
        .Insert(0.6f, characterRect.DOAnchorPosX(xMove2, 0.5f).SetEase(Ease.OutQuad)) // ù ���� ����
        .Insert(0.9f, characterRect.DOAnchorPosY(yMove1, 0.6f).SetEase(Ease.OutQuad)) // ù ���� ����
        .Insert(0.7f, clearStageObj.GetComponent<RectTransform>().DOAnchorPos(new Vector2(0, 0), 1f)) // Ŭ������ �ڽ��� 0,0 ���� ��ġ ������
        .InsertCallback(1.3f, () => FinalStageClearSpriteChange(finalStageClearImage, lobbyTable))
        .Insert(1.7f, characterRect.DOAnchorPosX(xMove3, 1f).SetEase(Ease.Linear)) //��° ���� ��¡
        .Insert(2.15f, characterRect.DOAnchorPosX(xMove4, 0.5f).SetEase(Ease.OutQuad)) // ��° ���� ����
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
        float threshold = 0.001f; // �Ӱ谪
        while (lobbyScrollViewController.scrollRect.horizontalNormalizedPosition + threshold < challengeStageNomalizedPosX)
        {
            lobbyScrollViewController.scrollRect.horizontalNormalizedPosition += Time.deltaTime * speed; // Time.deltaTime : frame �� frame ������ �ð� 
            yield return null; // ��� �Ѱ��ش�
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
