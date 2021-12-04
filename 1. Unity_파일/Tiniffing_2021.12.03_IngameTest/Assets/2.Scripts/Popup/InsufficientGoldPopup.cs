using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InsufficientGoldPopup : BasePopup
{
    [SerializeField] private Text noticeText;
    [SerializeField] private Text cancelText;
    [SerializeField] private Text goldStoreShortcutText;
    [SerializeField] private Text insufficientGoldText;

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
    public void GoldStoreShortcutButtonClick()
    {
        Close();
        PopupContainer.CreatePopup(PopupType.GoldStorePopup).Init();
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        noticeText.text = DataService.Instance.GetText(55);
        cancelText.text = DataService.Instance.GetText(75);
        insufficientGoldText.text = DataService.Instance.GetText(76);
        goldStoreShortcutText.text = DataService.Instance.GetText(77);
    }
    public override void Close()
    {
        base.Close();
    }
}
