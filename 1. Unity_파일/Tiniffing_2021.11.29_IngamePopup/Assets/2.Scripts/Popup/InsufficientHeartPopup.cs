using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InsufficientHeartPopup : BasePopup
{
    [SerializeField] private Text noticeText;
    [SerializeField] private Text insufficientHeartText;
    [SerializeField] private Text cancelText;
    [SerializeField] private Text heartstoreShortcutText;

    [SerializeField] private RectTransform groupRect;
    public override void Init(int id = -1)
    {
        base.Init(id);
        PopTweenEffect_Small(groupRect);
        OnRefresh();
    }
    protected override void PopTweenEffect_Small(RectTransform groupRect)
    {
        base.PopTweenEffect_Small(groupRect);
    }
    private void TextRefresh()
    {
        cancelText.text = DataService.Instance.GetText(75);
        noticeText.text = DataService.Instance.GetText(55);
        insufficientHeartText.text = DataService.Instance.GetText(95);
        heartstoreShortcutText.text = DataService.Instance.GetText(96);
    }
    public void OnHeartStoreShortcutButtonClick()
    {
        Close();
        PopupContainer.CreatePopup(PopupType.HeartStorePopup).Init();
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        TextRefresh();
    }
    public override void Close()
    {
        base.Close();
    }
}
