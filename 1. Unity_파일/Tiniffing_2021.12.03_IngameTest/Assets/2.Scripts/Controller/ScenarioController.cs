using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ScenarioController : MonoBehaviour
{
    [SerializeField] private Text scriptText;
    [SerializeField] private Text characterNameText;
    [SerializeField] private Text nextText;
    [SerializeField] private Text skipText;

    [SerializeField] private Image characterImage;

    [SerializeField] private GameObject nextButtonEffectObj;

    private int id;

    private string[] resourceIdArr ;
    private string[] textIdArr;
    private string[] characterIdArr;

    private bool isReadFinished = false;
    private bool isNextButtonClick=false; 
    public void Init(int script_id)
    {
        id = script_id;
        var scriptTable = DataService.Instance.GetData<Table.ScriptTable>(id);
        resourceIdArr = scriptTable.resources_id.Split(':');
        textIdArr = scriptTable.scripts_text_id.Split(':');
        characterIdArr = scriptTable.characters_name_text_id.Split(':');
        OnRefresh();
        StartCoroutine(ScriptCor());
    }
    IEnumerator ScriptCor()
    {
        for(int i = 0; i<resourceIdArr.Length; i++)
        {
            var resourceTable = DataService.Instance.GetData<Table.ResourceTable>(int.Parse(resourceIdArr[i]));
            characterImage.sprite = Resources.Load<Sprite>("Images/Resource/" + resourceTable.resource_name);
            characterNameText.text = DataService.Instance.GetText(int.Parse(characterIdArr[i]));
            scriptText.DOText(DataService.Instance.GetText((int.Parse(textIdArr[i]))), 1.3f).SetEase(Ease.Linear).OnComplete(() => 
            { 
                nextButtonEffectObj.SetActive(true);
                isReadFinished = true;
            });
            yield return new WaitUntil(()=>isNextButtonClick);
            scriptText.DOKill();
            isNextButtonClick = false;
            if (!isReadFinished)
            {
                scriptText.text = DataService.Instance.GetText((int.Parse(textIdArr[i])));
                nextButtonEffectObj.SetActive(true);
                yield return new WaitUntil(() => isNextButtonClick);
                isNextButtonClick = false;
            }
            scriptText.text = "";
            isReadFinished = false;
            nextButtonEffectObj.SetActive(false);
        }
        LocalValue.isScenarioFinished = true;

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.newbie == 0)
        {
            GameObject tutorialObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/Tutorial"), LobbyManager.instance.canvasRectTr);
            tutorialObj.GetComponent<Tutorial>().Init();
        }

        Destroy(gameObject);
    }
    public void OnNextButtonClick()
    {
        isNextButtonClick = true;
    }
    private void OnRefresh()
    {  
        nextText.text = DataService.Instance.GetText(62);
        skipText.text = DataService.Instance.GetText(83);
    }
    public void SkipButtonClick()
    {
        LocalValue.isScenarioFinished = true;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if(saveTable.newbie==0)
        {
            GameObject tutorialObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/Tutorial"), LobbyManager.instance.canvasRectTr);
            tutorialObj.GetComponent<Tutorial>().Init();
        }
        Destroy(gameObject);
    }
}
