using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class NextChapterBoardUIInfo : MonoBehaviour
{
    [SerializeField]
    private Text nextChapterText;

    [SerializeField]
    private GameObject touchBlock;

    [SerializeField] private GameObject updateButtonObj;

   // int now_chapter_no;
    public void Init()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        TouchBlockController(saveTable);
       /* if (LocalValue.isLatestFinalStage)
        {
            now_chapter_no = saveTable.now_chapter_no - 1;
        }
        else
            now_chapter_no = saveTable.now_chapter_no;*/
        nextChapterText.text = string.Format("{0} {1}", DataService.Instance.GetText(14), (saveTable.now_chapter_no + 1).ToString());

        if (saveTable.game_clear == 1)
            updateButtonObj.SetActive(true);
    }
    private void TouchBlockController(Table.SaveTable saveTable)
    {
        if (saveTable.chapter_no == saveTable.now_chapter_no)
        {
            TouchBlockOn();
        }
        else if (saveTable.chapter_no > saveTable.now_chapter_no)
        {
            TouchBlockOff();
        }
        else
        {
            Debug.LogError("now_chapter_no 디비값이 이상합니다");
            return;
        }
    }
    private void TouchBlockOn()
    {
        touchBlock.SetActive(true);
    }
    private void TouchBlockOff()
    {
        touchBlock.SetActive(false);
    }
    public void OnUpdateButtonClick()
    {
        // 추후 업데이트 예정입니다 팝업
    }
    public void OnNextChapterButtonClick()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no++;
        Debug.Log("now chapter no 1" + saveTable.now_chapter_no);
        DataService.Instance.UpdateData(saveTable);
        Debug.Log("now chapter no 2" + saveTable.now_chapter_no);

        GameObject fakeLoadingCanvas = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/FakeLoadingCanvas"));
        fakeLoadingCanvas.GetComponent<FakeLoadingBar>().Init();
        LobbyManager.instance.Init();

    }
}
