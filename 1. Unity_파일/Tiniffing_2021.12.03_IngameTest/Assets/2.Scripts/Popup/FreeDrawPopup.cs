using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class FreeDrawPopup : BasePopup
{
    [SerializeField] private RectTransform groupRectTr;
    [SerializeField] private RectTransform closeButtonRect;
    [SerializeField] private Text titleText;
    [SerializeField] private Text adText;
    [SerializeField] private Text speechBubbleText;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRectTr);
        TweenEffect_CloseButton(closeButtonRect);
        SpeechBubbleDoText(speechBubbleText, 87);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    protected override void SpeechBubbleDoText(Text speechBubbleText, int textId)
    {
        base.SpeechBubbleDoText(speechBubbleText, textId);
    }
    public void AdButtonClick()
    {

    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        titleText.text = DataService.Instance.GetText(86);
        adText.text = DataService.Instance.GetText(30);
    }
    public override void Close()
    {
        base.Close();
    }
}
