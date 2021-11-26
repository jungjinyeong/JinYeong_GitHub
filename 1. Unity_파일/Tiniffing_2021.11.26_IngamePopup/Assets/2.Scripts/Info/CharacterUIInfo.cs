using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class CharacterUIInfo : MonoBehaviour
{
    [SerializeField] private Text characterNameText;
    [SerializeField] private Image character_image;
    [SerializeField] private GameObject selectOnBackground;
    [SerializeField] private GameObject selectOnTextObj;
    [SerializeField] private GameObject activeOffObj;

    private System.Action<int> CharacterInfoRefresh;
    private System.Action OnChracterSelectClickEvent;


    private int id;
    public void Init(int id, System.Action<int> clickEvent, System.Action selectButtonClickEvent)
    {
        this.id = id;
        CharacterInfoRefresh = clickEvent;
        OnChracterSelectClickEvent = selectButtonClickEvent;
        OnRefresh();
    }
    public void OnCharacterButtonClick()
    {
        var characterDataList = DataService.Instance.GetDataList<Table.CharacterTable>();
        var characterData = DataService.Instance.GetData<Table.CharacterTable>(id);
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        for (int i = 0; i < characterDataList.Count; i++)
        {
            characterDataList[i].select = 0;
        }
        characterData.select = 1; // 로비에 나올 녀석으로 선택한다
        saveTable.using_character_id = id;

        DataService.Instance.UpdateDataAll(characterDataList);
        DataService.Instance.UpdateData(characterData);
        DataService.Instance.UpdateData(saveTable);
        CharacterInfoRefresh?.Invoke(id);
        OnChracterSelectClickEvent?.Invoke();
    }
    /* public void OnCharacterNameButtonClick()
     {
         var characterDataList  = DataService.Instance.GetDataList<Table.CharacterTable>();
         var characterData = DataService.Instance.GetData<Table.CharacterTable>(id);
         var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
         for(int i = 0; i<characterDataList.Count; i++)
         {
             characterDataList[i].select = 0;
         }
         characterData.select = 1; // 로비에 나올 녀석으로 선택한다
         saveTable.using_character_id = id;

         DataService.Instance.UpdateDataAll(characterDataList);
         DataService.Instance.UpdateData(characterData);
         DataService.Instance.UpdateData(saveTable);
         OnChracterSelectButtonClickEvent?.Invoke();
     }*/
    private void SelectOn()
    {
        selectOnBackground.SetActive(true);
        selectOnTextObj.SetActive(true);
    }
    private void SelectOff()
    {
        selectOnBackground.SetActive(false);
        selectOnTextObj.SetActive(false);
    }  
   

    private void TextRefresh(Table.CharacterTable characterData)
    {
        characterNameText.text = DataService.Instance.GetText(characterData.name_text_id);
        selectOnTextObj.GetComponent<Text>().text = DataService.Instance.GetText(84);
    }
    private void ActiveController(Table.CharacterTable characterData)
    {
        if (characterData.get == 0)
            activeOffObj.SetActive(true);
    }
    public void SelectOnOffController()
    {
        var characterData = DataService.Instance.GetData<Table.CharacterTable>(id);
        if (characterData.select == 1)
            SelectOn();
        else
            SelectOff();
    }
    private void OnRefresh()
    {
        var characterData = DataService.Instance.GetData<Table.CharacterTable>(id);
        character_image.sprite = Resources.Load<Sprite>("Images/Character/" + characterData.character_image_name);
        TextRefresh(characterData);
        ActiveController(characterData);
        SelectOnOffController();
    }
}
