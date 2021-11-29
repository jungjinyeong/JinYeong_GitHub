using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

public class ItemPurchasePopup : BasePopup
{
    [SerializeField] private Text titleText;

    [SerializeField] private RectTransform closeButtonRect; 
    [SerializeField] private RectTransform groupRect;

    [SerializeField] private GameObject hintPoleOnObj;
    [SerializeField] private GameObject timeStopOnObj;
    [SerializeField] private GameObject protectionBraceletOnObj;
    [SerializeField] private GameObject hintPoleButtonOffObj;
    [SerializeField] private GameObject timeStopButtonOffObj;
    [SerializeField] private GameObject protectionBraceletButtonOffObj;

    [SerializeField] private GameObject hintPoleGroupObj;
    [SerializeField] private GameObject timeStopGroupObj;
    [SerializeField] private GameObject protectionBraceletGroupObj;

    [SerializeField] private Text hintPoleMenuBarText;
    [SerializeField] private Text timeStopMenuBarText;
    [SerializeField] private Text protectionBraceletMenuBarText;
    [SerializeField] private Text hintPoleMenuBarOffText;
    [SerializeField] private Text timeStopMenuBarOffText;
    [SerializeField] private Text protectionBraceletMenuBarOffText;

    [SerializeField] private Text hintPoleDescriptionText;
    [SerializeField] private Text hintPoleAdRestrictionText;
    [SerializeField] private Text timeStopDescriptionText;
    [SerializeField] private Text timeStopAdRestrictionText;
    [SerializeField] private Text protectionBraceletDescriptionText;
    [SerializeField] private Text protectionBraceletAdRestrictionText;

    [SerializeField] private Text hintPoleAdText;
    [SerializeField] private Text hintPolePrice1Text;
    [SerializeField] private Text hintPolePrice2Text;
    [SerializeField] private Text hintPolePrice3Text;
    
    [SerializeField] private Text hintPoleAdCountText;
    [SerializeField] private Text hintPoleCount1Text;
    [SerializeField] private Text hintPoleCount2Text;
    [SerializeField] private Text hintPoleCount3Text;

    [SerializeField] private Text hintPoleAdCountNumberText;
    [SerializeField] private Text hintPoleCountNumber1Text;
    [SerializeField] private Text hintPoleCountNumber2Text;
    [SerializeField] private Text hintPoleCountNumber3Text;

    [SerializeField] private Text timeStopAdText;
    [SerializeField] private Text timeStopPrice1Text;
    [SerializeField] private Text timeStopPrice2Text;
    [SerializeField] private Text timeStopPrice3Text;

    [SerializeField] private Text timeStopAdCountText;
    [SerializeField] private Text timeStopCount1Text;
    [SerializeField] private Text timeStopCount2Text;
    [SerializeField] private Text timeStopCount3Text;
    
    [SerializeField] private Text timeStopAdCountNumberText;
    [SerializeField] private Text timeStopCountNumber1Text;
    [SerializeField] private Text timeStopCountNumber2Text;
    [SerializeField] private Text timeStopCountNumber3Text;

    [SerializeField] private Text protectionBraceletAdText;
    [SerializeField] private Text protectionBraceletPrice1Text;
    [SerializeField] private Text protectionBraceletPrice2Text;
    [SerializeField] private Text protectionBraceletPrice3Text;

    [SerializeField] private Text protectionBraceletAdCountText;
    [SerializeField] private Text protectionBraceletCount1Text;
    [SerializeField] private Text protectionBraceletCount2Text;
    [SerializeField] private Text protectionBraceletCount3Text;

    [SerializeField] private Text protectionBraceletAdCountNumberText;
    [SerializeField] private Text protectionBraceletCountNumber1Text;
    [SerializeField] private Text protectionBraceletCountNumber2Text;
    [SerializeField] private Text protectionBraceletCountNumber3Text;



    public override void Init(int id = -1)
    {
        base.Init(id);
        SelectItem();
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
        TweenEffect_CloseButton(closeButtonRect);
    }
    private void SelectItem()
    {
        switch(PopupContainer.GetNameData())
        {
            case "HintPole":
                HintPoleButtonClick();
                break;
            case "TimeStop":
                TimeStopButtonClick();
                break;
            case "ProtectionBracelet":
                ProtectionBraceletButtonClick();
                break;
            default:
                break;
        }
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    
    public void HintPoleButtonClick()
    {
        hintPoleOnObj.SetActive(true);
        timeStopOnObj.SetActive(false);
        protectionBraceletOnObj.SetActive(false);

        hintPoleButtonOffObj.SetActive(false);
        timeStopButtonOffObj.SetActive(true);
        protectionBraceletButtonOffObj.SetActive(true);

        hintPoleGroupObj.SetActive(true);
        timeStopGroupObj.SetActive(false);
        protectionBraceletGroupObj.SetActive(false);
    }
    public void TimeStopButtonClick()
    {
        hintPoleOnObj.SetActive(false);
        timeStopOnObj.SetActive(true);
        protectionBraceletOnObj.SetActive(false);

        hintPoleButtonOffObj.SetActive(true);
        timeStopButtonOffObj.SetActive(false);
        protectionBraceletButtonOffObj.SetActive(true);

        hintPoleGroupObj.SetActive(false);
        timeStopGroupObj.SetActive(true);
        protectionBraceletGroupObj.SetActive(false);
    }
    public void ProtectionBraceletButtonClick()
    {
        hintPoleOnObj.SetActive(false);
        timeStopOnObj.SetActive(false);
        protectionBraceletOnObj.SetActive(true);

        hintPoleButtonOffObj.SetActive(true);
        timeStopButtonOffObj.SetActive(true);
        protectionBraceletButtonOffObj.SetActive(false);

        hintPoleGroupObj.SetActive(false);
        timeStopGroupObj.SetActive(false);
        protectionBraceletGroupObj.SetActive(true);
    }
    public void HintPoleAdButtonClick()
    {

    }
    public void HintPolePrice1ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 0);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[0]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(0);
            PopupContainer.SetNameData("HintPole");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init(); 
        }
    }
    public void HintPolePrice2ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 0);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[1]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(1);
            PopupContainer.SetNameData("HintPole");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void HintPolePrice3ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 0);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[2]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(2);
            PopupContainer.SetNameData("HintPole");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void TimeStopAdButtonClick()
    {
        
    }
    public void TimeStopPrice1ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 1);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[0]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(0);
            PopupContainer.SetNameData("TimeStop");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void TimeStopPrice2ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 1);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[1]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(1);
            PopupContainer.SetNameData("TimeStop");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void TimeStopPrice3ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 1);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if(saveTable.gold <int.Parse(priceArr[2]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(2);
            PopupContainer.SetNameData("TimeStop");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void ProtectionBraceletAdButtonClick()
    {
        
    }
    public void ProtectionBraceletPrice1ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 2);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[0]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(0);
            PopupContainer.SetNameData("ProtectionBracelet");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void ProtectionBraceletPrice2ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 2);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[1]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(1);
            PopupContainer.SetNameData("ProtectionBracelet");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    public void ProtectionBraceletPrice3ButtonClick()
    {
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 2);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.gold < int.Parse(priceArr[2]))
        {
            PopupContainer.CreatePopup(PopupType.InsufficientGoldPopup).Init();
        }
        else
        {
            PopupContainer.SetIndexData(2);
            PopupContainer.SetNameData("ProtectionBracelet");
            PopupContainer.CreatePopup(PopupType.PurchaseConfirmPopup).Init();
        }
    }
    private void HintPoleTextRefresh()
    {
        var baseDetailTableDataCount = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x=>x.base_table_id ==5 && x.sequence==0);
        var countArr = baseDetailTableDataCount.data.Split(':');
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x=>x.base_table_id ==6 && x.sequence==0);
        var priceArr = baseDetailTableDataPrice.data.Split(':');
        hintPoleDescriptionText.text = DataService.Instance.GetText(71);
       // hintPoleAdRestrictionText.text  = string.Format("({0} )")

        hintPoleAdText.text = string.Format("{0}",DataService.Instance.GetText(30));
        hintPolePrice1Text.text = string.Format("{0}", priceArr[0]);
        hintPolePrice2Text.text = string.Format("{0}", priceArr[1]);
        hintPolePrice3Text.text = string.Format("{0}", priceArr[2]);

        hintPoleAdCountText.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(23), countArr[0], DataService.Instance.GetText(29));
        hintPoleCount1Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(23), countArr[1], DataService.Instance.GetText(29));
        hintPoleCount2Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(23), countArr[2], DataService.Instance.GetText(29)); 
        hintPoleCount3Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(23), countArr[3], DataService.Instance.GetText(29));

        hintPoleAdCountNumberText.text = string.Format("x{0}",countArr[0]);
         hintPoleCountNumber1Text.text = string.Format("x{0}", countArr[1]);
        hintPoleCountNumber2Text.text = string.Format("x{0}", countArr[2]);
        hintPoleCountNumber3Text.text = string.Format("x{0}", countArr[3]);
    }
    private void TimeStopTextRefresh()
    {
        var baseDetailTableData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 1);
        var countArr = baseDetailTableData.data.Split(':');
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 1);
        var priceArr = baseDetailTableDataPrice.data.Split(':');

        timeStopDescriptionText.text = DataService.Instance.GetText(72);
        // hintPoleAdRestrictionText.text  = string.Format("({0} )")

        timeStopAdText.text = string.Format("{0}", DataService.Instance.GetText(30));
        timeStopPrice1Text.text = string.Format("{0}", priceArr[0]);
        timeStopPrice2Text.text = string.Format("{0}", priceArr[1]);
        timeStopPrice3Text.text = string.Format("{0}", priceArr[2]);

        timeStopAdCountText.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(24), countArr[0], DataService.Instance.GetText(29));
        timeStopCount1Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(24), countArr[1], DataService.Instance.GetText(29));
        timeStopCount2Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(24), countArr[2], DataService.Instance.GetText(29));
        timeStopCount3Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(24), countArr[3], DataService.Instance.GetText(29));

        timeStopAdCountNumberText.text = string.Format("x{0}", countArr[0]);
        timeStopCountNumber1Text.text = string.Format("x{0}", countArr[1]);
        timeStopCountNumber2Text.text = string.Format("x{0}", countArr[2]);
        timeStopCountNumber3Text.text = string.Format("x{0}", countArr[3]);
    }
    private void ProtectionBraceletTextRefresh()
    {
        var baseDetailTableData = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 5 && x.sequence == 2);
        var countArr = baseDetailTableData.data.Split(':');
        var baseDetailTableDataPrice = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 6 && x.sequence == 2);
        var priceArr = baseDetailTableDataPrice.data.Split(':');

        protectionBraceletDescriptionText.text = DataService.Instance.GetText(73);
        // hintPoleAdRestrictionText.text  = string.Format("({0} )")

        protectionBraceletAdText.text = string.Format("{0}", DataService.Instance.GetText(30));
        protectionBraceletPrice1Text.text = string.Format("{0}", priceArr[0]);
        protectionBraceletPrice2Text.text = string.Format("{0}", priceArr[1]);
        protectionBraceletPrice3Text.text = string.Format("{0}", priceArr[2]);

        protectionBraceletAdCountText.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(25), countArr[0], DataService.Instance.GetText(29));
        protectionBraceletCount1Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(25), countArr[1], DataService.Instance.GetText(29));
        protectionBraceletCount2Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(25), countArr[2], DataService.Instance.GetText(29));
        protectionBraceletCount3Text.text = string.Format("{0} {1}{2}", DataService.Instance.GetText(25), countArr[3], DataService.Instance.GetText(29));

        protectionBraceletAdCountNumberText.text = string.Format("x{0}", countArr[0]);
        protectionBraceletCountNumber1Text.text = string.Format("x{0}", countArr[1]);
        protectionBraceletCountNumber2Text.text = string.Format("x{0}", countArr[2]);
        protectionBraceletCountNumber3Text.text = string.Format("x{0}", countArr[3]);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        HintPoleTextRefresh();
        TimeStopTextRefresh();
        ProtectionBraceletTextRefresh();
    }
    public override void Close()
    {
        base.Close();
    }
}
