using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ItemDescriptionPopup : BasePopup
{
    [SerializeField] private Text hintPoleDescriptionText;
    [SerializeField] private Text timeStopDescriptionText;
    [SerializeField] private Text protectionBraceletDescriptionText;
    [SerializeField] private Text hintPoleNameText;
    [SerializeField] private Text timeStopNameText;
    [SerializeField] private Text protectionBraceletNameText;
    [SerializeField] private Text titleText;

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
        titleText.text = DataService.Instance.GetText(94);
        hintPoleNameText.text = string.Format("¡¤{0}", DataService.Instance.GetText(23));
        timeStopNameText.text = string.Format("¡¤{0}", DataService.Instance.GetText(24));
        protectionBraceletNameText.text = string.Format("¡¤{0}", DataService.Instance.GetText(25));
        hintPoleDescriptionText.text = string.Format("{0}", DataService.Instance.GetText(91));
        timeStopDescriptionText.text = string.Format("{0}", DataService.Instance.GetText(92));
        protectionBraceletDescriptionText.text = string.Format("{0}", DataService.Instance.GetText(93));
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
