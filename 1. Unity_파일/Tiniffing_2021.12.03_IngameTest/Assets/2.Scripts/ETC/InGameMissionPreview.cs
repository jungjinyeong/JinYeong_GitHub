using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class InGameMissionPreview : MonoBehaviour
{
    [SerializeField] private RectTransform groupRectTr;

    [SerializeField] private GameObject clearGroupObj;
    [SerializeField] private GameObject findEffectObj;
    [SerializeField] private GameObject ExObj;
    [SerializeField] private GameObject TimerObj;
    [SerializeField] private GameObject starTitleObj;
    [SerializeField] private GameObject skipButtonObj;
    [SerializeField] private GameObject teeniepingMindEffectObj;

    [SerializeField] private RectTransform teeniepingMindRectTr;
    [SerializeField] private RectTransform checkRectTr;
    [SerializeField] private RectTransform handRectTr;
    [SerializeField] private RectTransform clearTextImageRectTr;
    [SerializeField] private Image TouchBlockImage;

   // [SerializeField] private Text titleText;
    [SerializeField] private Text missionDescriptionText;

    [SerializeField] private Slider timerSlider;

    Sequence EX_DisplaySequence;
    Sequence ClearTextImageSequence;
    Sequence ListProductionSequence;

    [HideInInspector] public bool isMissionPreviewFinished = false;

    private float timeMax;
    private float timer;
    private bool isTimerPlay = true;
    public void Init()
    {
        OnRefresh();
        Display();
    }
    private void Display()
    {
        timeMax = 20;
        timer = timeMax;
        StartCoroutine(TimerCor());
        EX_Display();
    }

    private void EX_Display()
    {
        Vector2 defaultPos = handRectTr.anchoredPosition;
        Vector2 plusPos = new Vector2(-15f, 24f);
        EX_DisplaySequence = DOTween.Sequence().
        Prepend(groupRectTr.transform.DOScale(new Vector2(1f, 1f), 0.3f))//팝업 사이즈 복구
        .Insert(0.3f, handRectTr.GetComponent<Image>().DOFade(1, 0.3f))//손가락 켰음
        .Insert(0.6f, handRectTr.DOAnchorPos(defaultPos + plusPos, 0.3f))//손가락 이동
        .Insert(0.9f, handRectTr.DORotate(new Vector3(0, 0, 11), 0.2f))//손가락 클릭
        .InsertCallback(1.1f, () => CheckEffectOn())
        .Insert(1.1f, handRectTr.DORotate(new Vector3(0, 0, 0), 0.2f))//손가락 클릭 해제
        .Insert(1.3f, handRectTr.GetComponent<Image>().DOFade(0, 0.5f))//손가락 끔
        .Insert(1.1f, checkRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//체크 업
        .Insert(1.2f, checkRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))//체크 다운
        .Insert(1.3f, checkRectTr.DOScale(new Vector2(1f, 1f), 0.1f))//체크 복구
        .InsertCallback(1.8f, () => CheckEffectOff())
        .InsertCallback(1.8f, () => TimerStop())
        .InsertCallback(2f, () => ClearObjOn())
        .InsertCallback(3f, () => ListProduction())
        .InsertCallback(4.5f, ()=> ReduceObjectScale())
        .Insert(4.5f,TouchBlockImage.DOFade(0, 0.5f))
        .OnComplete(() =>
        {
            isMissionPreviewFinished = true;
            gameObject.SetActive(false);
        });
    }
    private void ReduceObjectScale()
    {
        skipButtonObj.SetActive(false);
        groupRectTr.DOScale(new Vector2(0.001f, 0.001f), 0.3f);
    }
    public void OnSkipButtonClick()
    {
        skipButtonObj.SetActive(false);
        groupRectTr.DOScale(new Vector2(0.001f, 0.001f), 0.3f).OnComplete(() => 
        {
            isMissionPreviewFinished = true;
            gameObject.SetActive(false);
        });
    }
    private void TimerStop()
    {
        isTimerPlay = false;
    }
    private void CheckEffectOn()//노말 전용
    {
        checkRectTr.GetComponent<Image>().DOFade(1, 0f);
        findEffectObj.SetActive(true);
    }
    private void CheckEffectOff()//노말 전용
    {
        checkRectTr.GetComponent<Image>().DOFade(0, 0.5f);
        findEffectObj.SetActive(false);
    }
    private void ClearObjOn()
    {
        clearGroupObj.SetActive(true);
        ClearTextImageSequence = DOTween.Sequence()
        .Prepend(checkRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.1f, clearTextImageRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(0.2f, clearTextImageRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(0.3f, clearTextImageRectTr.DORotate(new Vector3(0, 0, 5), 0.1f))
        .Insert(0.4f, clearTextImageRectTr.DORotate(new Vector3(0, 0, -5), 0.1f))
        .Insert(0.5f, clearTextImageRectTr.DORotate(new Vector3(0, 0, 0), 0.1f));
    }
    private void ListProduction()
    {
        TimerObj.SetActive(false);
        ExObj.SetActive(false);
        clearGroupObj.SetActive(false);
        starTitleObj.SetActive(true);
        ListProductionSequence = DOTween.Sequence()
        .Prepend(starTitleObj.transform.DOScale(new Vector2(1f, 1f), 0.1f))
        .InsertCallback(0.2f, ()=>TeeniepingMindEffectOn())
        .Insert(0.2f, teeniepingMindRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(0.3f, teeniepingMindRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(0.4f, teeniepingMindRectTr.DOScale(new Vector2(1f, 1f), 0.1f));
    }
    private void TeeniepingMindEffectOn()
    {
        teeniepingMindEffectObj.SetActive(true);
    }
    IEnumerator TimerCor()
    {
        while (isTimerPlay)
        {
            timer = timer - 0.1f;
            timerSlider.value = timer / timeMax;
            yield return YieldInstructionCache.WaitForSeconds(0.1f);
        }
    }
    private void OnRefresh()
    {
        missionDescriptionText.text = DataService.Instance.GetText(97);
    }

}
