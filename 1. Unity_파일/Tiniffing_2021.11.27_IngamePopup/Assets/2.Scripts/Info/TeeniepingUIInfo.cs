using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TeeniepingUIInfo : MonoBehaviour
{
    [SerializeField] private GameObject royalPingFlagObj;
    [SerializeField] private GameObject nomalPingFlagObj;
    [SerializeField] private Text royalPingText;
    [SerializeField] private Text nomalPingText;
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private Image teeniepingImage;
    [SerializeField] private Image teeniepingMindImage;
    [SerializeField] private GameObject touchBlockObj;
    [SerializeField] private Image frameImage;
    [SerializeField] private GameObject teeniepingMindObj;
    [SerializeField] private GameObject selectOnBackgroundObj;
    [SerializeField] private GameObject lockObj;

    private System.Action<int> OnTeeniepingButtonClickEvent;
    private System.Action OnTeeniepingSelectClickEvent;

    private int id;
    public void Init(int id, System.Action<int> clickEvent, System.Action OnTeeniepingSelectClickEvent)
    {
        this.id = id;
        OnTeeniepingButtonClickEvent = clickEvent;
        this.OnTeeniepingSelectClickEvent = OnTeeniepingSelectClickEvent;
        OnRefresh();
    }
    // 버튼 클릭
   
    private void CheckRoyalPing(Table.TiniffingCollectionTable teeniepingCollectionData)
    {        
        if (teeniepingCollectionData.royal_check == 1)
        {
            royalPingFlagObj.SetActive(true);
            nomalPingFlagObj.SetActive(false);
            frameImage.sprite = Resources.Load<Sprite>("Images/Collection/" + "royal_frame");
        }
        else
        {
            royalPingFlagObj.SetActive(false);
            nomalPingFlagObj.SetActive(true);
        }
    }
    private void TeeniepingGetCheck(Table.TiniffingCollectionTable teeniepingCollectionData)
    {

        Color blockColor;
        ColorUtility.TryParseHtmlString("#070707", out blockColor);
        blockColor.a = 100 / 255f;
        if (teeniepingCollectionData.get_check == 0)
        {
            var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
            var latestTeeniepingCollectionData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == saveTable.chapter_no);
            touchBlockObj.SetActive(true);
            teeniepingImage.color = blockColor;
            frameImage.sprite = Resources.Load<Sprite>("Images/Collection/" + "black_frame");
            royalPingText.text = "?";
            nomalPingText.text = "?";
            lockObj.SetActive(true);
            if (teeniepingCollectionData.GetTableId() != latestTeeniepingCollectionData.GetTableId())  // mind 색깔
            {
                ColorUtility.TryParseHtmlString("#939393", out blockColor);
                //blockColor.a = 200 / 255f;
                teeniepingMindImage.color = blockColor;
            }
        }
        else // get_check == 1
        {

        }

    }
    public void OnTeeniepingButtonClick()
    {
        OnTeeniepingButtonClickEvent?.Invoke(id);
        SelectOn();
    }
    private void SelectOn()
    {
        selectOnBackgroundObj.SetActive(true);
    }
    private void SelectOff()
    {
        selectOnBackgroundObj.SetActive(false);
    }
    public void SelectOnOffController()
    { 
      SelectOff();
    }
    private void TextRefresh(Table.TiniffingCollectionTable teeniepingCollectionData)
    {
        royalPingText.text = DataService.Instance.GetText(teeniepingCollectionData.name_text_id);
        nomalPingText.text = DataService.Instance.GetText(teeniepingCollectionData.name_text_id);
        teeniepingMindCountText.text = string.Format("{0}/20", teeniepingCollectionData.mind_count);
    }
    private void OnRefresh()
    {
        var teeniepingCollectionData = DataService.Instance.GetData<Table.TiniffingCollectionTable>(id);
        CheckRoyalPing(teeniepingCollectionData);
        TextRefresh(teeniepingCollectionData);
        teeniepingImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + teeniepingCollectionData.teenieping_name);
        teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingCollectionData.mind_teenieping_name);
        TeeniepingGetCheck(teeniepingCollectionData);
        if (teeniepingCollectionData.GetTableId() == 0)
            SelectOn();
    }
}
