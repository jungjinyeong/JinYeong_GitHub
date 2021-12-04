using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
public class CharacterCollectionPopup : BasePopup
{
    [SerializeField] private RectTransform closeRectTr;
    [SerializeField] private RectTransform groupRectTr;
    [SerializeField] private ScrollRect totalScrollRect;
    [SerializeField] private ScrollRect ownScrollRect;

    [SerializeField] private GameObject totalTextHighlightObj;
    [SerializeField] private GameObject ownTextHighlightObj;
    [SerializeField] private GameObject totalOnTextObj;
    [SerializeField] private GameObject totalOffTextObj;
    [SerializeField] private GameObject ownOnTextObj;
    [SerializeField] private GameObject ownOffTextObj;

    [SerializeField] private GameObject totalScrollViewObj;
    [SerializeField] private GameObject ownScrollViewObj;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    [SerializeField] private Text characterNameText;
    [SerializeField] private Text titleText;
    [SerializeField] private Text characterExplantionTitleText;
    [SerializeField] private Text characterExplantionDescriptionText;

    public System.Action<int> OnCharacterButtonClickEvent;
    public System.Action OnChracterSelectButtonClickEvent;

    private List<CharacterUIInfo> characterTotalList = new List<CharacterUIInfo>();
    private List<CharacterUIInfo> characterOwnList = new List<CharacterUIInfo>();

    public override void Init(int id = -1)
    {
        base.Init(id);
        TotalCharacterScrollViewController();
        TotalButtonClick();
        OnRefresh();
        PopTweenEffect_Full(groupRectTr);
        OwnCharacterScrollViewController();
        TweenEffect_CloseButton(closeRectTr);
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    protected override void PopTweenEffect_Full(RectTransform groupRect)
    {
        base.PopTweenEffect_Full(groupRect);
    }
    private void TotalCharacterScrollViewController()
    {
        var characterTableTotalDataList = DataService.Instance.GetDataList<Table.CharacterTable>();

        for (int i = 0; i < characterTableTotalDataList.Count; i++)
        {
            GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/Character/CharacterUIInfo"), totalScrollRect.content);
            cloneObj.GetComponent<CharacterUIInfo>().Init(characterTableTotalDataList[i].GetTableId(), OnCharacterButtonClickEvent, OnChracterSelectButtonClickEvent);
            characterTotalList.Add(cloneObj.GetComponent<CharacterUIInfo>());
        }
    }
    
    private void OwnCharacterScrollViewController()
    {
        var characterTableOwnDataList = DataService.Instance.GetDataList<Table.CharacterTable>().FindAll(x => x.get == 1);
        for (int i = 0; i < characterTableOwnDataList.Count; i++)
        {
            GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/Character/CharacterUIInfo"), ownScrollRect.content);
            cloneObj.GetComponent<CharacterUIInfo>().Init(characterTableOwnDataList[i].GetTableId(), OnCharacterButtonClickEvent, OnChracterSelectButtonClickEvent);
            characterOwnList.Add(cloneObj.GetComponent<CharacterUIInfo>());
        }
    }

    private void TotalSelectButtonControll()
    {
        for(int i =0; i<characterTotalList.Count; i++)
        {
            characterTotalList[i].SelectOnOffController();
        }
    } 
    private void OwnSelectButtonControll()
    {
        for(int i =0; i< characterOwnList.Count; i++)
        {
            characterOwnList[i].SelectOnOffController();
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
        titleText.text = DataService.Instance.GetText(64);
        totalOnTextObj.GetComponent<Text>().text = DataService.Instance.GetText(58);
        totalOffTextObj.GetComponent<Text>().text = DataService.Instance.GetText(58);
        ownOnTextObj.GetComponent<Text>().text = DataService.Instance.GetText(59);
        ownOffTextObj.GetComponent<Text>().text = DataService.Instance.GetText(59);
    }
    private void CharacterInfoRefresh(int id)
    {
        var characterTable = DataService.Instance.GetData<Table.CharacterTable>(id);
        characterExplantionTitleText.text = DataService.Instance.GetText(characterTable.title_text_id);
        characterExplantionDescriptionText.text = DataService.Instance.GetText(characterTable.description_text_id);
        SkeletonDataAssetChange(characterTable);
    }
    public void OnGatchaButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.GatchaNoticePopup).Init();
    }
    private void SkeletonDataAssetChange(Table.CharacterTable characterTable)
    {
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        TextRefresh();
        CharacterInfoRefresh(characterTable.GetTableId());
    }
    private void OnEnable()
    {
        OnCharacterButtonClickEvent += CharacterInfoRefresh;
        OnChracterSelectButtonClickEvent += TotalSelectButtonControll;
        OnChracterSelectButtonClickEvent += OwnSelectButtonControll;
    }
    private void OnDisable()
    {
        OnCharacterButtonClickEvent -= CharacterInfoRefresh;
        OnChracterSelectButtonClickEvent -= TotalSelectButtonControll;
        OnChracterSelectButtonClickEvent -= OwnSelectButtonControll;
    }
    public override void Close()
    {
        LobbyManager.instance.CharacterRefresh();
        base.Close();
    }
}
