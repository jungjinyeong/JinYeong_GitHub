using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class FreeDrawPopup : BasePopup
{
    [SerializeField] private RectTransform groupRectTr;
    [SerializeField] private Text titleText;
    [SerializeField] private Text adText;
    [SerializeField] private Text speechBubbleText;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRectTr);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    public void AdButtonClick()
    {

    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        titleText.text = DataService.Instance.GetText(86);
        adText.text = DataService.Instance.GetText(30);
        speechBubbleText.text = DataService.Instance.GetText(87);
    }
    public override void Close()
    {
        base.Close();
    }
}
