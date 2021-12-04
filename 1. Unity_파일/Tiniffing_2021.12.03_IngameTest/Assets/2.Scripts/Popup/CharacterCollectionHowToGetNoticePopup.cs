using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterCollectionHowToGetNoticePopup : BasePopup
{
    [SerializeField] private Text titleText;
    [SerializeField] private Text howToGetText;
    [SerializeField] private Text descriptionText;
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

    }
    public override void Close()
    {
        base.Close();
    }
}
