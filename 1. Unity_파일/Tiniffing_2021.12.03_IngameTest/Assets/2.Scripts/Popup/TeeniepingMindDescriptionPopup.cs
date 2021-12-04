using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TeeniepingMindDescriptionPopup : BasePopup
{
    [SerializeField] private Text teeniepingMindText; 
    [SerializeField] private Text teeniepingMindDescriptionText; 
    [SerializeField] private Text closeText; 
    [SerializeField] private Text noticeText;
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
        teeniepingMindText.text = DataService.Instance.GetText(81);
        teeniepingMindDescriptionText.text = DataService.Instance.GetText(82);
        closeText.text = DataService.Instance.GetText(53);
        noticeText.text = DataService.Instance.GetText(55);
    }
    public override void Close()
    {
        base.Close();
    }
}
