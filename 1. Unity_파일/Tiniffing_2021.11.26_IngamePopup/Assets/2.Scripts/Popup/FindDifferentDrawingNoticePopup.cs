using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FindDifferentDrawingNoticePopup : BasePopup
{
    [SerializeField] private Text findDifferentDrawingText;
    [SerializeField] private Text updateNoticeText;
    [SerializeField] private Text closeText;
    [SerializeField] private RectTransform groupRect;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Small(groupRect);
    }
    protected override void PopTweenEffect_Small(RectTransform groupRect)
    {
        base.PopTweenEffect_Small(groupRect);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        findDifferentDrawingText.text = DataService.Instance.GetText(65);
        updateNoticeText.text = DataService.Instance.GetText(66);
        closeText.text = DataService.Instance.GetText(53);
    }
    public override void Close()
    {
        base.Close();
    }
}
