using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class PackageStorePopup : BasePopup
{

    [SerializeField]
    private Text titleText;

    [SerializeField]
    private Text romiPackageText;
    [SerializeField]
    private Text ianPackageText;
    [SerializeField]
    private Text saraPackageText;
    [SerializeField]
    private Text romiPriceText;
    [SerializeField]
    private Text ianPriceText;
    [SerializeField]
    private Text saraPriceText;
    [SerializeField]
    private Text romiRemarkText;
    [SerializeField]
    private Text saraRemarkText;
    [SerializeField]
    private Text playerGoldText;
    [SerializeField]
    private Text heartCountText;
    [SerializeField]
    private Text heartTimeText;

    [SerializeField]
    private RectTransform sideUpGroupRect;
    [SerializeField]
    private RectTransform closeButtonRect;
    [SerializeField] private RectTransform groupRect;
    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        TweenEffect_SideUpBar(sideUpGroupRect);
        TweenEffect_CloseButton(closeButtonRect);
        PopTweenEffect_Nomal(groupRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    protected override void TweenEffect_SideUpBar(RectTransform sideUpGroupRect)
    {
        base.TweenEffect_SideUpBar(sideUpGroupRect);
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    private void OnUpdateTime()
    {
        if (heartCountText != null)
            heartCountText.text = HeartTime.Instance.GetCountText();
        if (heartTimeText != null)
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
    }

    private void HeartTextRefresh()
    {
        if (HeartTime.Instance.IsMax()) // max 상태이면
        {
            heartCountText.text = HeartTime.Instance.GetCountText();
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
            return;
        }
        HeartTime.Instance.OnUpdateTime += OnUpdateTime;

    }
    private void TextRefresh()
    {
        titleText.text = DataService.Instance.GetText(52);
        
        romiPackageText.text = DataService.Instance.GetText(44);
        ianPackageText.text = DataService.Instance.GetText(45);
        saraPackageText.text = DataService.Instance.GetText(46);
        romiRemarkText.text = DataService.Instance.GetText(47);
        saraRemarkText.text = DataService.Instance.GetText(48);
        romiPriceText.text = DataService.Instance.GetText(49);
        ianPriceText.text = DataService.Instance.GetText(50);
        saraPriceText.text = DataService.Instance.GetText(51);

        playerGoldText.text = playerGoldText.text = string.Format("{0:#,0}", DataService.Instance.GetData<Table.SaveTable>(0).gold);

    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        HeartTextRefresh();
        TextRefresh();
    }

    public override void Close()
    {
        LobbyManager.instance.LobbyRefresh();
        base.Close();
    }
    void OnDestroy()
    {
        HeartTime.Instance.OnUpdateTime -= OnUpdateTime; // 객체 파괴시 체인 해제       
    }
}
