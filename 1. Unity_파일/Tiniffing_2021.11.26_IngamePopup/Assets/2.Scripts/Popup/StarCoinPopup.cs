using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class StarCoinPopup : BasePopup
{
    [SerializeField]
    private Text noticeText;
    [SerializeField]
    private Text starCoinText;
    [SerializeField]
    private Text starCoinDescriptionText;
    [SerializeField]
    private Text closeText; 
    [SerializeField]
    private RectTransform groupRect;

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
        starCoinText.text = DataService.Instance.GetText(19);
        closeText.text = DataService.Instance.GetText(53);
        starCoinDescriptionText.text = DataService.Instance.GetText(54);
        noticeText.text= DataService.Instance.GetText(55);
    }
    public override void Close()
    {
        base.Close();
    }
}
