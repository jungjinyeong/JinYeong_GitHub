using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
public class TeeniepingCatchDisplay : MonoBehaviour
{
    [SerializeField] private RectTransform teeniepingCatchRect;
    [SerializeField] private RectTransform teeniepingCatchTextRect;
    [SerializeField] private RectTransform nextButtonRect;

    [SerializeField] private Image backgroundImg;
    [SerializeField] private Image teeniepingImg;

    [SerializeField] private Text teeniepingCatchText;

    [SerializeField] private GameObject nextButtonObj;

    [SerializeField] private GameObject bottomGlowEffectObj;
    [SerializeField] private GameObject heartFlashEffectObj;

    [SerializeField] private RectTransform starEffectRectTr;
         
    private Transform teeniepingCollectionButtonTr;

    private Sequence teeniepingCatchSequence;
    private int teeniepingId;
    private int script_id;
    
    public void Init(int id)
    {
        teeniepingId = id;
        teeniepingCollectionButtonTr = LobbyManager.instance.teeniepingCollectionRectTr;
        OnRefresh();
        HeartCoinTween();
    }
    private void HeartCoinTween()
    {
     teeniepingCatchSequence = DOTween.Sequence()
    .OnStart(() =>
    {
        bottomGlowEffectObj.SetActive(true);
        heartFlashEffectObj.SetActive(true);
    })
    .Join(starEffectRectTr.DOAnchorPosY(256, 1.5f).SetEase(Ease.Linear))
    .Join(backgroundImg.DOFade(1, 1f))
    .Insert(1f, teeniepingCatchRect.transform.DORotate(new Vector2(0, 360), 0.1f, RotateMode.LocalAxisAdd).SetLoops(9, LoopType.Restart))
    .Insert(1f, teeniepingCatchRect.transform.DOScale(new Vector2(0.8f, 0.8f), 1.8f).SetEase(Ease.InSine))
    .Insert(1.9f, teeniepingCatchRect.transform.DORotate(new Vector2(0, 360), 0.1f, RotateMode.LocalAxisAdd).SetLoops(4, LoopType.Restart))
    .Insert(1.9f, teeniepingCatchRect.transform.DOScale(new Vector2(1.5f, 1.5f), 1f))
    .Insert(3f, teeniepingCatchRect.transform.DOScale(new Vector2(1.45f, 1.45f), 1f).SetEase(Ease.Linear).SetLoops(999999999, LoopType.Yoyo))
    .Insert(1.9f, teeniepingCatchTextRect.transform.DOScale(new Vector2(3.2f, 3.2f), 0.6f))
    .Insert(2.5f, teeniepingCatchTextRect.transform.DOScale(new Vector2(3f, 3f), 0.1f))
    .InsertCallback(3f, () => NextButtonOn());
    }
    private void NextButtonOn()
    {
        nextButtonRect.gameObject.SetActive(true);
    }
    public void OnNextButtonClick()
    {
        backgroundImg.DOFade(0, 1f);
        teeniepingCatchText.gameObject.SetActive(false);
        nextButtonObj.SetActive(false);
        teeniepingCatchRect.transform.DOKill();
        TeeniepingWindMillEffectTween();       
    }
    private void TeeniepingWindMillEffectTween()
    {

        int screenWidth = Screen.width;
        int screenHeight = Screen.height;
        RectTransform teeniepingCollectionButtonRectTr = LobbyManager.instance.teeniepingCollectionRectTr;
        Vector2 downMenuPos = new Vector2(50, 50);
        Vector2 teeniepingCollectionButtonRectPos
            = new Vector2(teeniepingCollectionButtonRectTr.anchoredPosition.x +downMenuPos.x - screenWidth / 2, 
                          teeniepingCollectionButtonRectTr.anchoredPosition.y + downMenuPos.y - screenHeight / 2);

        teeniepingCatchSequence = DOTween.Sequence()
     .OnStart(() =>
     {
         teeniepingCatchRect.transform.DOScale(new Vector2(0f, 0f), 0.7f).OnComplete(() => { teeniepingCatchRect.gameObject.SetActive(false); });
     })
     .Join(teeniepingCatchRect.DOAnchorPos(teeniepingCollectionButtonRectPos, 0.5f).SetEase(Ease.InCubic))
     .Insert(0.45f, teeniepingCollectionButtonTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f)).OnComplete(() =>
     {
         teeniepingCollectionButtonTr.DOScale(new Vector2(1.000031f, 1.000031f), 0.2f).OnComplete(() =>
         {
             GameObject scenarioObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/Scenario"), LobbyManager.instance.canvasRectTr);
             scenarioObj.GetComponent<ScenarioController>().Init(script_id);
             Destroy(gameObject);
         });
     });
    }
    private void OnRefresh()
    {
        var teeniepingData = DataService.Instance.GetData<Table.TiniffingCollectionTable>(teeniepingId);
        teeniepingImg.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + teeniepingData.teenieping_name);
        script_id = teeniepingData.script_id;
    }
}

