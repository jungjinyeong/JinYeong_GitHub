using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class HeartStorePopup : BasePopup
{


    [SerializeField]
    private Text titleText;

    [SerializeField]
    private Text speechBubbleText;

    [SerializeField]
    private Text heart_ad_text;

    [SerializeField]
    private Text heart1_text;

    [SerializeField]
    private Text heart2_text;
    [SerializeField]
    private Text heart3_text;

    [SerializeField]
    private Text heart4_text;
    [SerializeField]
    private Text heart5_text;

    [SerializeField]
    private Text ad_priceTag_text;

    [SerializeField]
    private Text goldStoreText;

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
    private RectTransform closeButtonRect;
    [SerializeField]
    private RectTransform sideUpGroupRect;
    [SerializeField]
    private RectTransform groupRect;


    [SerializeField] private Text heartPriceText1;
    [SerializeField] private Text heartPriceText2;
    [SerializeField] private Text heartPriceText3;
    [SerializeField] private Text heartPriceText4;
    [SerializeField] private Text heartPriceText5;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        TweenEffect_SideUpBar(sideUpGroupRect);
        TweenEffect_CloseButton(closeButtonRect);
        PopTweenEffect_Nomal(groupRect);
        SpeechBubbleDoText(speechBubbleText, 33);
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
    public void Heart1ButtonClick()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == 0).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int price = int.Parse(heartPriceData);

        if (saveTable.gold < int.Parse(heartPriceData))
        {
            Close();
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(0);
            PopupContainer.SetNameData("Heart");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void Heart2ButtonClick()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == 1).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int price = int.Parse(heartPriceData);

        if (saveTable.gold < int.Parse(heartPriceData))
        {
            Close();
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(1);
            PopupContainer.SetNameData("Heart");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void Heart3ButtonClick()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == 2).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int price = int.Parse(heartPriceData);

        if (saveTable.gold < int.Parse(heartPriceData))
        {
            Close();
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(2);
            PopupContainer.SetNameData("Heart");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void Heart4ButtonClick()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == 3).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int price = int.Parse(heartPriceData);

        if (saveTable.gold < int.Parse(heartPriceData))
        {
            Close();
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(3);
            PopupContainer.SetNameData("Heart");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void Heart5ButtonClick()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == 4).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        int price = int.Parse(heartPriceData);

        if (saveTable.gold < int.Parse(heartPriceData))
        {
            Close();
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(4);
            PopupContainer.SetNameData("Heart");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void PackageButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.PackageStorePopup).Init();
        Close();
    }
    public void GoldStoreShortcutsButtonClick()
    {
        // close() 를 먼저해야한다. 
        // 그렇게하지 않을시  Create() 된 팝업에서 바로가기 버튼을 바로 눌렀다고 했을때  그 전 팝업의 Close() 와 Create() 가 동시에 일어나면서 충돌 문제가 발생한다.
        Close();
        PopupContainer.CreatePopup(PopupType.GoldStorePopup).Init();
    }
    private void OnUpdateTime()
    {
        if (heartCountText != null)
            heartCountText.text = HeartTime.Instance.GetCountText();
        if (heartTimeText != null)
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
    }
    private void SideUpBarHeartTextRefresh()
    {
        if (HeartTime.Instance.IsMax()) // max 상태이면
        {
            heartCountText.text = HeartTime.Instance.GetCountText();
            heartTimeText.text = HeartTime.Instance.GetRemainTimeText();
            return;
        }
        HeartTime.Instance.OnUpdateTime += OnUpdateTime;

    }
    private void HeartTextRefresh()
    {
        var baseDetailTableData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 9).data;
        var baseDetailTableDataList_HeartPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().FindAll(x => x.base_table_id == 7);
        string[] heartNumberArr = baseDetailTableData.Split(':');

        heart_ad_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[0], DataService.Instance.GetText(29));
        ad_priceTag_text.text = DataService.Instance.GetText(30);
        heart1_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[1], DataService.Instance.GetText(29));
        heart2_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[2], DataService.Instance.GetText(29));
        heart3_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[3], DataService.Instance.GetText(29));
        heart4_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[4], DataService.Instance.GetText(29));
        heart5_text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(28), heartNumberArr[5], DataService.Instance.GetText(29));

        heartPriceText1.text = string.Format("{0}", baseDetailTableDataList_HeartPrice[0].data);
        heartPriceText2.text = string.Format("{0}", baseDetailTableDataList_HeartPrice[1].data);
        heartPriceText3.text = string.Format("{0}", baseDetailTableDataList_HeartPrice[2].data);
        heartPriceText4.text = string.Format("{0}", baseDetailTableDataList_HeartPrice[3].data);
        heartPriceText5.text = string.Format("{0}", baseDetailTableDataList_HeartPrice[4].data);
    }
    private void TextRefresh()
    {
        HeartTextRefresh();
        titleText.text = DataService.Instance.GetText(35);  
        goldStoreText.text = DataService.Instance.GetText(31);
        shortcutsText.text = DataService.Instance.GetText(32);
        packageText.text  = DataService.Instance.GetText(34);

        playerGoldText.text = playerGoldText.text = string.Format("{0:#,0}", DataService.Instance.GetData<Table.SaveTable>(0).gold);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        SideUpBarHeartTextRefresh();
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
