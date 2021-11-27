using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PurchaseConfirmPopup : BasePopup
{
    [SerializeField] private Text noticeText;
    [SerializeField] private Text cancelText;
    [SerializeField] private Text purchaseText;
    [SerializeField] private Text confirmText;

    [SerializeField] private RectTransform groupRect;

    private string selectName;
    private int purchaseIndex;
    public override void Init(int id = -1)
    {
        base.Init(id);
        purchaseIndex = PopupContainer.GetIndexData();
        SelectPopupKind();
        PopTweenEffect_Small(groupRect);
    }
    protected override void PopTweenEffect_Small(RectTransform groupRect)
    {
        base.PopTweenEffect_Small(groupRect);
    }
    private void SelectPopupKind()
    {
        switch(PopupContainer.GetNameData())
        {
            case "HintPole":
                selectName = "HintPole";
                HintPoleInit();
                break;
            case "TimeStop":
                selectName = "TimeStop";
                TimeStopInit();
                break;
            case "ProtectionBracelet":
                selectName = "ProtectionBracelet";
                ProtectionBraceletInit();
                break;
            case "Heart":
                selectName = "Heart";
                HeartInit();
                break;
            default:
                break;
        }
    }
    private void HintPoleInit()
    {
        var hintPoleCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 0).data;
        string[] countArr = hintPoleCountData.Split(':');
        int count = int.Parse(countArr[purchaseIndex + 1]);

        confirmText.text = string.Format("{0}x{1}{2} {3}", DataService.Instance.GetText(23), count, DataService.Instance.GetText(29), DataService.Instance.GetText(74));
    } 
    private void TimeStopInit()
    {
        var hintPoleCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 1).data;
        string[] countArr = hintPoleCountData.Split(':');
        int count = int.Parse(countArr[purchaseIndex + 1]);

        confirmText.text = string.Format("{0}x{1}{2} {3}", DataService.Instance.GetText(24), count, DataService.Instance.GetText(29), DataService.Instance.GetText(74));
    } 
    private void ProtectionBraceletInit()
    {
        var hintPoleCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 2).data;
        string[] countArr = hintPoleCountData.Split(':');
        int count = int.Parse(countArr[purchaseIndex + 1]);

        confirmText.text = string.Format("{0}x{1}{2} {3}", DataService.Instance.GetText(25), count, DataService.Instance.GetText(29), DataService.Instance.GetText(74));
    }
    private void HeartInit()
    {
        var heartCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 9).data;
        string[] heartcountArr = heartCountData.Split(':');
        int heartCount = int.Parse(heartcountArr[purchaseIndex + 1]);

        confirmText.text = string.Format("{0}x{1}{2} {3}", DataService.Instance.GetText(28), heartCount, DataService.Instance.GetText(29), DataService.Instance.GetText(74));
    } 

    public void PurchaseButtonClick()
    {
        switch (selectName)
        {
            case "HintPole":
                PurchaseHintPole();
                break;
            case "TimeStop":
                PurchaseTimeStop();
                break;
            case "ProtectionBracelet":
                PurchaseProtectionBracelet();
                break;
            case "Heart":
                PurchaseHeart();
                break; 
            default:
                break;
        }
    }
    private void PurchaseHintPole()
    {
        var hintPolePriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 0).data;
        var hintPoleCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 0).data;
        var itemTableData = DataService.Instance.GetData<Table.ItemTable>(0);
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string[] priceArr = hintPolePriceData.Split(':');
        string[] countArr = hintPoleCountData.Split(':');

        int price = int.Parse(priceArr[purchaseIndex]);
        int count = int.Parse(countArr[purchaseIndex+1]);

        saveTable.gold -= price;
        itemTableData.count += count;

        DataService.Instance.UpdateData(saveTable);
        DataService.Instance.UpdateData(itemTableData);
        LobbyManager.instance.LobbyRefresh();
        Close();
    }
    private void PurchaseTimeStop()
    {
        var timeStopPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 1).data;
        var timeStopCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 1).data;
        var itemTableData = DataService.Instance.GetData<Table.ItemTable>(1);
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string[] priceArr = timeStopPriceData.Split(':');
        string[] countArr = timeStopCountData.Split(':');

        int price = int.Parse(priceArr[purchaseIndex]);
        int count = int.Parse(countArr[purchaseIndex + 1]);

        saveTable.gold -= price;
        itemTableData.count += count;
        DataService.Instance.UpdateData(saveTable);
        DataService.Instance.UpdateData(itemTableData);
        LobbyManager.instance.LobbyRefresh();
        Close();
    }
    private void PurchaseProtectionBracelet()
    {
        var protectionBraceletPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 2).data;
        var protectionBraceletCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 2).data;
        var itemTableData = DataService.Instance.GetData<Table.ItemTable>(2);
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string[] priceArr = protectionBraceletPriceData.Split(':');
        string[] countArr = protectionBraceletCountData.Split(':');

        int price = int.Parse(priceArr[purchaseIndex]);
        int count = int.Parse(countArr[purchaseIndex + 1]);

        saveTable.gold -= price;
        itemTableData.count += count;

        DataService.Instance.UpdateData(saveTable);
        DataService.Instance.UpdateData(itemTableData);
        LobbyManager.instance.LobbyRefresh();
        Close();
    }
    private void PurchaseHeart()
    {
        var heartPriceData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 7 && x.sequence == purchaseIndex).data;
        var heartCountData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 9).data;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string[] heartcountArr = heartCountData.Split(':');

        int price = int.Parse(heartPriceData);
        int heartCount = int.Parse(heartcountArr[purchaseIndex + 1]);
         
        saveTable.gold -= price;
        saveTable.heart_count += heartCount;

        DataService.Instance.UpdateData(saveTable);
        HeartTime.Instance.HeartCountRefresh();
        Close();
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
