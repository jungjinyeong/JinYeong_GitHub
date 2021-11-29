using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ChapterBookPopup : BasePopup
{
    [SerializeField] private Text titleText;
    [SerializeField] private Text nextText;
    [SerializeField] private Text chapterText;
    [SerializeField] private RectTransform parentRect;
    [SerializeField] private RectTransform nextButtonRect;
    [SerializeField] private Image touchBlockImg;

    private int script_id;
    private Sequence chapterBookSequence;

    public override void Init(int id = -1)
    {
        base.Init(id);
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var chapterTable = DataService.Instance.GetDataList<Table.ChapterTable>().Find(x => x.chapter_no == saveTable.chapter_no);
        script_id = chapterTable.script_id;
        StartTween();
        OnRefresh();
    }
    public override void Close()
    {
        base.Close();
    }
    private void StartTween()
    {
        Outline[] outlineArr = titleText.GetComponents<Outline>();

        chapterBookSequence = DOTween.Sequence()
        .Prepend(touchBlockImg.DOFade((200 / 255f), 1.35f))
        .Join(parentRect.transform.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.InCubic))
        .Join(parentRect.DOAnchorPosY(10, 1f).SetEase(Ease.Linear))
        .Insert(0.9f, parentRect.DOAnchorPosY(0, 0.1f).SetEase(Ease.Linear))
        .Insert(1.3f, titleText.DOFade(1f, 1f))
        .Insert(1.3f, outlineArr[0].DOFade(1f, 5.5f))
        .Insert(1.3f, outlineArr[1].DOFade(1f, 5.4f))
        .Insert(1.3f, outlineArr[2].DOFade(1f, 5.3f))
        .Insert(2.5f, nextButtonRect.transform.DOScale(new Vector2(1.1f, 1.1f), 0.7f))
        .Insert(3.2f, nextButtonRect.transform.DOScale(new Vector2(1f, 1f), 0.3f))
        .InsertCallback(3.5f, () => NextButtonLoop());
    }
    private void NextButtonLoop()
    {
        nextButtonRect.DOAnchorPosX(302, 0.6f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    public void NextTween()
    {
        StartCoroutine(NextTweenCor());
    }
    private IEnumerator NextTweenCor()
    {
        touchBlockImg.DOFade(0, 1.35f);
        parentRect.DOAnchorPosY(-720, 1f);
        Vector2 v2 = new Vector2(0, 0);
        parentRect.transform.DOScale(v2,0.35f);
        yield return YieldInstructionCache.WaitForSeconds(1f);
        GameObject scenarioObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/Scenario"), LobbyManager.instance.canvasRectTr);
        scenarioObj.GetComponent<ScenarioController>().Init(script_id);
        Close();
    }
    private void TextRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var chapterTable = DataService.Instance.GetDataList<Table.ChapterTable>().Find(x => x.chapter_no == saveTable.chapter_no);
        switch (Application.systemLanguage)
        {
            case SystemLanguage.Korean:
                chapterText.text = string.Format("Á¦ {0} Ã©ÅÍ", saveTable.chapter_no);
                break;
            default:
                chapterText.text = string.Format("{0} Chapter", saveTable.chapter_no);
                break;
        }
        nextText.text = string.Format("{0} >>", DataService.Instance.GetText(62));
        titleText.text = DataService.Instance.GetText(chapterTable.title_text_id);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        TextRefresh();
    }
}
