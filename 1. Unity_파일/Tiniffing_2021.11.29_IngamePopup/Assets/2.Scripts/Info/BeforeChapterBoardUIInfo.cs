using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BeforeChapterBoardUIInfo : MonoBehaviour
{
    [SerializeField]
    private Text beforeChapterText;


   // int now_chapter_no;
    public void Init()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);   
       /* if (LocalValue.isLatestFinalStage)
        {
            now_chapter_no = saveTable.now_chapter_no-1;
        }
        else
            now_chapter_no = saveTable.now_chapter_no;*/
        beforeChapterText.text = string.Format("{0} {1}", DataService.Instance.GetText(14), (saveTable.now_chapter_no -1 ).ToString());
    }

    public void OnButtonclick()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no--;
        DataService.Instance.UpdateData(saveTable);
        GameObject fakeLoadingCanvas = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/FakeLoadingCanvas"));
        fakeLoadingCanvas.GetComponent<FakeLoadingBar>().Init();
        LobbyManager.instance.Init();
    }
}
