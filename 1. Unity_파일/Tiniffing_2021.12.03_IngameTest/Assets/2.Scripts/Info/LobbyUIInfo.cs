using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class LobbyUIInfo : MonoBehaviour
{
    [SerializeField] private Text heartCountText;
    [SerializeField] private Text heartTimeText;
    [SerializeField] private Text goldCountText;
    [SerializeField] private Text starCoinCountText;
    [SerializeField] private Text freeDrawText;

    [SerializeField] private Text rewardButtonOnText;
    [SerializeField] private Text rewardButtonOffText;
    [SerializeField] private Text getTeeniepingMindText;
    [SerializeField] private Text getTeeniepingMindCountText;
    [SerializeField] private Text receiveCompleteText;

    [SerializeField] private Image teeniepingMindImage;
    [SerializeField] private Image teeniepingRewardImage;
    [SerializeField] private Image teeniepingReceiveCompleteImage;

    [SerializeField] private GameObject teeniepingMindObj;
    [SerializeField] private GameObject teeniepingRewardObj;
    [SerializeField] private GameObject rewardButtonOffObj;
    [SerializeField] private GameObject rewardButtonOnObj;
    [SerializeField] private GameObject TeeniepingReceiveCompleteObj;
    
    [SerializeField] private RectTransform lobbyGroupTr;

    // TeeniepingMindMask
    [SerializeField] private RectTransform handRectTr;
    [SerializeField] private RectTransform handRectTr_Clone;
    [SerializeField] private GameObject teeniepingMindMaskObj;
    [SerializeField] private GameObject blindObj;
    [SerializeField] private GameObject explanationTeenieping;
    [SerializeField] private GameObject teeniepingMindMaskSpeechBubbleObj;
    [SerializeField] private GameObject teeniepingMindMaskEffectObj;
    [SerializeField] private Text teeniepingMindMaskSpeechBubbleText;

    private Sequence handSequence;

    private bool isTeeniepingMindReceiveButtonClick = false;

    private static readonly WaitForSeconds waitForSeconds = new WaitForSeconds(1f);

    public void Init()
   {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0); // 현재 하트 개수

        OnRefresh();

        if(HeartTime.Instance.IsMax()) // max 상태이면
        {
            heartCountText.text = HeartTime.Instance.GetCountText();
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
            return;
        }
        HeartTime.Instance.OnUpdateTime += OnUpdateTime;
        StartCoroutine(TimeUpdate());
    }
    IEnumerator TimeUpdate()
    {
        while (true)
        {
            HeartTime.Instance.Refresh(); // 업데이트 기능
            yield return waitForSeconds; //1초마다
        }
    }

    void OnDestroy()
    {
        HeartTime.Instance.OnUpdateTime -= OnUpdateTime; // 객체 파괴시 체인 해제       
    }
  
    void OnUpdateTime()
    {
        if (heartCountText != null)
            heartCountText.text = HeartTime.Instance.GetCountText();
        if (heartTimeText != null)
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
    }

    private void HandEffect()
    {
        handRectTr.gameObject.SetActive(true);
        handRectTr_Clone.gameObject.SetActive(true);
        handSequence = DOTween.Sequence()
        .Insert(0f, handRectTr.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0f, handRectTr_Clone.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0.35f, handRectTr.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .Insert(0.35f, handRectTr_Clone.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .InsertCallback(0.36f, () => TeeniepingMindMask_EffectOn())
        .InsertCallback(1.36f, () => TeeniepingMindMask_EffectOff()).OnComplete(() =>
        {
            handSequence.Restart();
        });
    }
    private void TeeniepingMindMask_EffectOn()
    {
        teeniepingMindMaskEffectObj.SetActive(true);
    }
    private void TeeniepingMindMask_EffectOff()
    {
        teeniepingMindMaskEffectObj.SetActive(false);
    }
    public void TeeniepingMindMaskOn()
    {
        teeniepingMindMaskSpeechBubbleObj.SetActive(true);
        explanationTeenieping.SetActive(true);
        blindObj.SetActive(true);
        teeniepingMindMaskSpeechBubbleText.DOText(DataService.Instance.GetText(606), 1.5f).OnComplete(() => {
            teeniepingMindMaskObj.SetActive(true);
            HandEffect();
        });
       
        StartCoroutine(TeeniepingMindMaskCor());
    } 
    IEnumerator TeeniepingMindMaskCor()
    {
        yield return new WaitUntil(()=> isTeeniepingMindReceiveButtonClick);
        TeeniepingMindMaskOff();
        yield break;
    }
    private void TeeniepingMindMaskOff()
    {
        teeniepingMindMaskSpeechBubbleObj.SetActive(false);
        explanationTeenieping.SetActive(false);
        teeniepingMindMaskObj.SetActive(false);
        blindObj.SetActive(false);
        handRectTr.gameObject.SetActive(false);
        handRectTr_Clone.gameObject.SetActive(false);
    }
    private void TeeniepingMindUIRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingCollectionData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == saveTable.now_chapter_no);

        getTeeniepingMindText.text = DataService.Instance.GetText(79);

        if (teeniepingCollectionData.get_check == 1)
        {
            // 수령 완료 UI
            teeniepingReceiveCompleteImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + teeniepingCollectionData.teenieping_name);
            TeeniepingReceiveCompleteObj.SetActive(true);
            teeniepingMindObj.SetActive(false);
            teeniepingRewardObj.SetActive(false);
            rewardButtonOffObj.SetActive(true);
            rewardButtonOnObj.SetActive(false);
        }
        else // 아직 get 상태가 아님 => mindcount 부족 or mindcount 다 채웠을시 보상받기 버튼 block 풀기
        {
            if (teeniepingCollectionData.mind_count == 20)
            {
                // 보상받기 버튼 열어줌
                teeniepingRewardImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + teeniepingCollectionData.teenieping_name);
                TeeniepingReceiveCompleteObj.SetActive(false);
                teeniepingMindObj.SetActive(false);
                teeniepingRewardObj.SetActive(true);
                rewardButtonOffObj.SetActive(false);
                rewardButtonOnObj.SetActive(true);
                rewardButtonOnText.text = DataService.Instance.GetText(78);
            }
            else
            {
                //Block 처리 
                teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingCollectionData.mind_teenieping_name);
                TeeniepingReceiveCompleteObj.SetActive(false);
                teeniepingMindObj.SetActive(true);
                teeniepingRewardObj.SetActive(false);
                rewardButtonOffObj.SetActive(true);
                rewardButtonOnObj.SetActive(false);
                rewardButtonOffText.text = DataService.Instance.GetText(78);
                getTeeniepingMindCountText.text = string.Format("{0}/20", teeniepingCollectionData.mind_count);
            }
        }
    }

    public void OnTeeniepingMindReceiveButtonClick()
    {
        isTeeniepingMindReceiveButtonClick = true;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingCollectionData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == saveTable.now_chapter_no);

        GameObject teeniepingCatchDisplayObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/TeeniepingCatchDisplay"), lobbyGroupTr);
        teeniepingCatchDisplayObj.GetComponent<TeeniepingCatchDisplay>().Init(teeniepingCollectionData.GetTableId());

        //DB처리 후 UI Refresh 시켜주기
        teeniepingCollectionData.get_check = 1;
        DataService.Instance.UpdateData(teeniepingCollectionData);
        TeeniepingMindUIRefresh();
    }
    public void TeeniepingMindQuestionMarkButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.TeeniepingMindDescriptionPopup).Init();
    }
    public void OnHeartButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.HeartStorePopup).Init();
    }
    public void OnGoldBarButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.GoldStorePopup).Init();
    }
    public void OnStarCoinButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.StarCoinPopup).Init();
    }
    public void OnSettingUpButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.SettingUpPopup).Init();
    }
    public void OnStartButtonClick()
    {
        LocalValue.isStartButtonClick = true;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.chapter_no != saveTable.now_chapter_no)
        {
            saveTable.now_chapter_no = saveTable.chapter_no;
            DataService.Instance.UpdateData(saveTable);
            GameObject fakeLoadingCanvas = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/FakeLoadingCanvas"));
            fakeLoadingCanvas.GetComponent<FakeLoadingBar>().Init();
            LobbyManager.instance.LobbyScrollViewStart(saveTable.chapter_no);
            StartCoroutine(StartButtonClickCor());
        }
        else
        {
            PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init();
        }
    }
    IEnumerator StartButtonClickCor()
    {
        yield return YieldInstructionCache.WaitForSeconds(0.5f);
        PopupContainer.CreatePopup(PopupType.StagePlayPopup).Init();
    }
    public void OnCharacterCollectionButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.CharacterCollectionPopup).Init();
    }
    public void OnTeeniepingCollectionButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.TeeniepingCollectionPopup).Init();
    }
    public void OnGatchaButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.GatchaNoticePopup).Init();
    }
    public void OnFindDifferentDrawingButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.FindDifferentDrawingNoticePopup).Init();

    }
    public void OnFreeDrawButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.FreeDrawPopup).Init();
    }
    private void HeartRefresh()
    {
        HeartTime.Instance.HeartCountRefresh();
        if (HeartTime.Instance.IsMax()) // max 상태이면
        {
            heartCountText.text = HeartTime.Instance.GetCountText();
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
            return;
        }
    }
    public void OnRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        goldCountText.text = string.Format("{0:#,0}", saveTable.gold);
        starCoinCountText.text = saveTable.star_coin.ToString();
        freeDrawText.text = DataService.Instance.GetText(85);
        HeartRefresh();
        TeeniepingMindUIRefresh();
    }
}
