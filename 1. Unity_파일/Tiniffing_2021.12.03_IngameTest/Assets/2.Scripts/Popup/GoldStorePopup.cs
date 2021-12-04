using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class GoldStorePopup : BasePopup
{
    [SerializeField]
    private Text titleText;

    [SerializeField]
    private Text speechBubbleText;
    [SerializeField]
    private Text goldAdCountText;
    [SerializeField]
    private Text gold1CountText;
    [SerializeField]
    private Text gold2CountText;
    [SerializeField]
    private Text gold3CountText;
    [SerializeField]
    private Text gold4CountText;
    [SerializeField]
    private Text gold5CountText;
    
    
    [SerializeField]
    private Text goldAdText;
    [SerializeField]
    private Text gold1PriceText;
    [SerializeField]
    private Text gold2PriceText;
    [SerializeField]
    private Text gold3PriceText;
    [SerializeField]
    private Text gold4PriceText;
    [SerializeField]
    private Text gold5PriceText;
    [SerializeField]
    private Text heartStoreText;
    [SerializeField]
    private Text shortcutsText;
    [SerializeField]
    private Text packageText;
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
        SpeechBubbleDoText(speechBubbleText, 38);

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
    protected override void SpeechBubbleDoText(Text speechBubbleText, int textId)
    {
        base.SpeechBubbleDoText(speechBubbleText, textId);
    }
    public void AdButtonClick()
    {

    }
    public void Gold1ButtonClick()
    {
        
    }
    public void Gold2ButtonClick()
    {

    }
    public void Gold3ButtonClick()
    {

    }
    public void Gold4ButtonClick()
    {

    }
    public void Gold5ButtonClick()
    {

    }
    public void PackageButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.PackageStorePopup).Init();
        Close();
    }
    public void HeartStoreShortcutsButtonClick()
    {
        Close();
        PopupContainer.CreatePopup(PopupType.HeartStorePopup).Init();
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
        var baseDetailTableData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 10).data;
        var baseDetailTableDataList_GoldPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().FindAll(x => x.base_table_id == 8);
        string[] goldCountArr = baseDetailTableData.Split(':');

        titleText.text = DataService.Instance.GetText(37);
        goldAdText.text = DataService.Instance.GetText(30);
        heartStoreText.text = DataService.Instance.GetText(36);
        shortcutsText.text = DataService.Instance.GetText(32);
        packageText.text = DataService.Instance.GetText(34);

        goldAdCountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[0]));
        gold1CountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[1]));
        gold2CountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[2]));
        gold3CountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[3]));
        gold4CountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[4]));
        gold5CountText.text = string.Format("{0:#,0}G", int.Parse(goldCountArr[5]));

        gold1PriceText.text = string.Format("{0}{1}", baseDetailTableDataList_GoldPrice[0].data, DataService.Instance.GetText(98));
        gold2PriceText.text = string.Format("{0}{1}", baseDetailTableDataList_GoldPrice[1].data, DataService.Instance.GetText(98));
        gold3PriceText.text = string.Format("{0}{1}", baseDetailTableDataList_GoldPrice[2].data, DataService.Instance.GetText(98));
        gold4PriceText.text = string.Format("{0}{1}", baseDetailTableDataList_GoldPrice[3].data, DataService.Instance.GetText(98));
        gold5PriceText.text = string.Format("{0}{1}", baseDetailTableDataList_GoldPrice[4].data, DataService.Instance.GetText(98));

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

