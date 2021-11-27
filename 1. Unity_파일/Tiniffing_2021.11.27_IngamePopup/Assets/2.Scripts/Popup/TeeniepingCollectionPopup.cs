using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class TeeniepingCollectionPopup : BasePopup
{
    [SerializeField] private Text titleText;
    [SerializeField] private Text teeniepingNameText;
    [SerializeField] private Text collectionRewardText;
    [SerializeField] private Text mainDescriptionText;
    [SerializeField] private Text subDescriptionText;
    [SerializeField] private Text teeniepingStoryText;

    [SerializeField] private GameObject totalTextHighlightObj;
    [SerializeField] private GameObject ownTextHighlightObj;
    [SerializeField] private GameObject totalOnTextObj;
    [SerializeField] private GameObject totalOffTextObj;
    [SerializeField] private GameObject ownOnTextObj;
    [SerializeField] private GameObject ownOffTextObj;


    [SerializeField] private Image teeniepingImage;
    [SerializeField] private ScrollRect totalScrollRect;
    [SerializeField] private ScrollRect ownScrollRect;
    [SerializeField] private GameObject totalScrollViewObj;
    [SerializeField] private GameObject ownScrollViewObj;

    [SerializeField] private RectTransform teeniepingIconRect;

    public System.Action<int> OnTeeniepingButtonClickEvent;
    public System.Action OnTeeniepingSelectClickEvent;


    private List<TeeniepingUIInfo> teeniepingTotalList = new List<TeeniepingUIInfo>();
    private List<TeeniepingUIInfo> teeniepingOwnList = new List<TeeniepingUIInfo>();

    public override void Init(int id = -1)
    {
        base.Init(id);
        TotalTeeniepingScrollViewController();
        OnRefresh();
        TweenEffect_TeeniepingIcon();
        OwnTeeniepingScrollViewController();
    }
    private void TweenEffect_TeeniepingIcon()
    {
        teeniepingIconRect.DOAnchorPosY(-25, 0.5f).SetLoops(-1, LoopType.Yoyo);
    }
    private void TotalTeeniepingScrollViewController()
    {
        var totalTeeniepingDataList = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>();
        for (int i = 0; i < totalTeeniepingDataList.Count; i++)
        {
            GameObject teeniepingObj = Instantiate(Resources.Load<GameObject>("Prefabs/Tiniffing/TeeniepingUIInfo"), totalScrollRect.content);
            teeniepingObj.GetComponent<TeeniepingUIInfo>().Init(totalTeeniepingDataList[i].GetTableId(), OnTeeniepingButtonClickEvent, OnTeeniepingSelectClickEvent);
            teeniepingTotalList.Add(teeniepingObj.GetComponent<TeeniepingUIInfo>());
        }
    }
    private void OwnTeeniepingScrollViewController()
    {
        var ownTeeniepingDataList = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().FindAll(x=>x.get_check == 1);
        for (int i = 0; i < ownTeeniepingDataList.Count; i++)
        {
            GameObject teeniepingObj = Instantiate(Resources.Load<GameObject>("Prefabs/Tiniffing/TeeniepingUIInfo"), ownScrollRect.content);
            teeniepingObj.GetComponent<TeeniepingUIInfo>().Init(ownTeeniepingDataList[i].GetTableId(), OnTeeniepingButtonClickEvent, OnTeeniepingSelectClickEvent);
            teeniepingOwnList.Add(teeniepingObj.GetComponent<TeeniepingUIInfo>());
        }
    }
    private void OnEnable()
    {
        OnTeeniepingButtonClickEvent += TeeniepingInfoRefresh;
        OnTeeniepingSelectClickEvent += TotalSelectControll;
        OnTeeniepingSelectClickEvent += OwnSelectControll;
    }
    private void OnDisable()
    {
        OnTeeniepingButtonClickEvent -= TeeniepingInfoRefresh;
        OnTeeniepingSelectClickEvent -= TotalSelectControll;
        OnTeeniepingSelectClickEvent -= OwnSelectControll;
    }
    private void TotalSelectControll()
    {
        for (int i = 0; i < teeniepingTotalList.Count; i++)
        {
            teeniepingTotalList[i].SelectOnOffController();
        }
    }
    private void OwnSelectControll()
    {
        for (int i = 0; i < teeniepingOwnList.Count; i++)
        {
            teeniepingOwnList[i].SelectOnOffController();
        }
    }
    public void TotalButtonClick()
    {
        totalTextHighlightObj.SetActive(true);
        ownTextHighlightObj.SetActive(false);
        totalOnTextObj.SetActive(true);
        totalOffTextObj.SetActive(false);
        ownOnTextObj.SetActive(false);
        ownOffTextObj.SetActive(true);
        totalScrollViewObj.SetActive(true);
        ownScrollViewObj.SetActive(false);
        
    }
    public void OwnButtonClick()
    {
        totalTextHighlightObj.SetActive(false);
        ownTextHighlightObj.SetActive(true);
        totalOnTextObj.SetActive(false);
        totalOffTextObj.SetActive(true);
        ownOnTextObj.SetActive(true);
        ownOffTextObj.SetActive(false);
        totalScrollViewObj.SetActive(false);
        ownScrollViewObj.SetActive(true);
    }
    private void TextRefresh()
    {
        titleText.text = DataService.Instance.GetText(56);
        collectionRewardText.text = DataService.Instance.GetText(57);

        totalOnTextObj.GetComponent<Text>().text = DataService.Instance.GetText(58);
        totalOffTextObj.GetComponent<Text>().text = DataService.Instance.GetText(58);
        ownOnTextObj.GetComponent<Text>().text = DataService.Instance.GetText(59);
        ownOffTextObj.GetComponent<Text>().text = DataService.Instance.GetText(59);
    }
    private void TeeniepingInfoRefresh(int id)
    {
        Debug.Log("id : " + id);
        var teeniepingData = DataService.Instance.GetData<Table.TiniffingCollectionTable>(id);
        teeniepingNameText.text = DataService.Instance.GetText(teeniepingData.name_text_id);
        teeniepingStoryText.text = DataService.Instance.GetText(teeniepingData.title_description_text_id);
        mainDescriptionText.text = DataService.Instance.GetText(teeniepingData.main_description_text_id);
        subDescriptionText.text = DataService.Instance.GetText(teeniepingData.sub_description_text_id);
        Debug.LogError(string.Format("¹øÈ£ Â÷·Ê·¯ {0}, {1}, {2}, {3}" , teeniepingData.name_text_id , teeniepingData.title_description_text_id , teeniepingData.main_description_text_id , teeniepingData.sub_description_text_id));
        Debug.Log(""+DataService.Instance.GetData<Table.ResourceTable>(teeniepingData.teenieping_description_resource_id));
        var resourceData = DataService.Instance.GetData<Table.ResourceTable>(teeniepingData.teenieping_description_resource_id);
        teeniepingImage.sprite = Resources.Load<Sprite>("Images/Resource/" + resourceData.resource_name) ;
    }
    public void CollectionRewardButton()
    {
        PopupContainer.CreatePopup(PopupType.TeeniepingCollectionRewardPopup).Init();
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        TextRefresh();
        TotalButtonClick();
        TeeniepingInfoRefresh(0);
    }
    public override void Close()
    {
        base.Close();
    }
}
