using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TeeniepingCollectionHowToGetNoticePopup : BasePopup
{
    [SerializeField] private Text titleText;
    [SerializeField] private Text howToGetText;
    [SerializeField] private Text descriptionText;
    [SerializeField] private RectTransform groupRect;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        SetText();
        PopTweenEffect_Small(groupRect);
    }
    protected override void PopTweenEffect_Small(RectTransform groupRect)
    {
        base.PopTweenEffect_Small(groupRect);
    }
    private void SetText()
    {
        descriptionText.text = string.Format("√©≈Õ {0}ø°º≠ »πµÊ«“ ºˆ ¿÷Ω¿¥œ¥Ÿ.",PopupContainer.GetIndexData());
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        titleText.text = DataService.Instance.GetText(55);
    }
    public override void Close()
    {
        base.Close();
    }
}
