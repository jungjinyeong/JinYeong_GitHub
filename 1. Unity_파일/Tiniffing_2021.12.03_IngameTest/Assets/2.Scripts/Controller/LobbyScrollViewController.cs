using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;
using Spine.Unity;

public class LobbyScrollViewController : MonoBehaviour
{


    public ScrollRect scrollRect; // LobbyManager에서 scrollRect 가져다 씀
    
    [SerializeField] private RectTransform contentBackGroundTr;

    private RectTransform standardRect;

    private List<GameObject> stageBoxList = new List<GameObject>();

    [HideInInspector] public GameObject characterObj;
 
    public void OnButtonPreesed()
    {
        if (Input.GetMouseButtonUp(0))
        {
            Debug.LogError("scroll rect nomalized pos : " + scrollRect.horizontalNormalizedPosition);
            Debug.LogError("content size : " + scrollRect.content.sizeDelta.x);
        }
    }
    public void ScrollViewInit()
    {
        if (stageBoxList.Count != 0)
        {
            int stageBoxCount = stageBoxList.Count;
            for (int i = 0; i < stageBoxCount; i++)
            {
                Destroy(stageBoxList[0]); //게임 오브젝트 삭제
                stageBoxList.RemoveAt(0); // 0번째 인덱스 공간 삭제         
            }
        }
    }
    public void OnStageBoxSpread(int chapter_no, bool isInGameComming = false, bool isFinalStageClear = false) // player의 chapter
    {
        // chapter_no 는 now_chapter_no 이다
        ScrollViewInit();
        int start_stage = (chapter_no - 1) * 20 + 1;
        var lobbyList = DataService.Instance.GetDataList<Table.LobbyTable>().FindAll(x => x.chapter_no == chapter_no && x.stage_no >= start_stage && x.stage_no <= start_stage + 19);
        lobbyList.OrderBy(x => x.stage_no).ToList();
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);

        for (int i = 0; i < 20; i++)
        {
            if (chapter_no != 1 && i == 0) // 첫번째 챕터가 아닐때 이전챕터 표지판 세워줄거임
            {
                if (LocalValue.isLatestFinalStage && saveTable.now_chapter_no == 1) // 1->2 넘어가는 연출용 
                {

                }
                else
                { 
                    RectTransform cloneBoardRect = Instantiate(Resources.Load<RectTransform>("Prefabs/Stage/BeforeChapterBoard"), scrollRect.content);
                    cloneBoardRect.GetComponent<BeforeChapterBoardUIInfo>().Init();
                    stageBoxList.Add(cloneBoardRect.gameObject);
                }
            }
            RectTransform cloneRect = Instantiate(Resources.Load<RectTransform>("Prefabs/Stage/StageGroup"), scrollRect.content);
            stageBoxList.Add(cloneRect.gameObject);
            cloneRect.gameObject.name = string.Format("Stage{0}", lobbyList[i].stage_no.ToString());
            StageUIInfo stageUIInfo = cloneRect.GetComponent<StageUIInfo>();
            stageUIInfo.Init(lobbyList[i]);
            if (chapter_no != saveTable.chapter_no && !isFinalStageClear)
            {
                if (i == 19)
                    CreateNextChapterBoard();
                continue;
            }
            LobbyEffectDisplay(lobbyList, saveTable, cloneRect, i, isInGameComming,isFinalStageClear );
            if (i == 19) // 다음챕터 표지판
            {
                CreateNextChapterBoard();
            }
        }

        StartCoroutine(FrameRestCor(isFinalStageClear, saveTable, chapter_no));
        //Invoke("FrameRestMethod", 1f);
    }
    IEnumerator FrameRestCor(bool isFinalStageClear, Table.SaveTable saveTable, int chapter_no)
    {
        yield return YieldInstructionCache.WaitForEndOfFrame;
        SetScrollViewPivot(isFinalStageClear, saveTable, chapter_no);
        yield break;
    }


    private void LobbyEffectDisplay(List<Table.LobbyTable> lobbyList, Table.SaveTable saveTable, RectTransform cloneRect, int i, bool isInGameComming, bool isFinalStageClear)
    {
        //마지막 스테이지 클리어일 경우 , 마지막 스테이지 상자가 내려가 있을것임
        if (i == 19 && isFinalStageClear)
        {
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            SetCharacterPosition(cloneRect);
        }
        // 연출이 들어가기에 인게임 방금 클리어했던 상자를 잠시 내려둘거임 , 인게임 클리어를 통해 stage가 증가했을 상황을 고려한 조건
        else if (lobbyList[i].stage_no == saveTable.stage_no - 1 && isInGameComming && !isFinalStageClear)
        {
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            SetCharacterPosition(cloneRect);
        }
        // 일반적인 상황
        else if (lobbyList[i].stage_no == saveTable.stage_no && !isInGameComming && !isFinalStageClear)
        {
            //상자 내려주기
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            Debug.LogError("Normal = " + lobbyList[i].stage_no);
            Debug.LogError("standard Rect x = " + standardRect.anchoredPosition.x);
            // 이때 아직 stanardRect가 생성이 안되어서  Log 값이 0 이 뜰거임 
            SetCharacterPosition(cloneRect);
        }
    }
    private void SetScrollViewPivot(bool isFinalStageClear, Table.SaveTable saveTable, int chapter_no)
    {
        float contentWidth = scrollRect.content.sizeDelta.x;
        float viewPortWidth = scrollRect.viewport.rect.width; // sizeDelta 가 안먹으면 rect.width 쓰면 됨
        float moveRange = contentWidth - viewPortWidth;
        float ratio = 0.5f;
        float targetNormalizedPos;
        if (saveTable.chapter_no!=chapter_no) // 과거 챕터 보고있는 상태
        {
            if (LocalValue.Click_Chapter_H == 0) // click chapter ==0  : 게임들어와서 어떤 스테이지도 누른 적이 없는 상태
            {
                scrollRect.horizontalNormalizedPosition = 0f;
                return;
            }
            else if(LocalValue.Click_Chapter_H != saveTable.now_chapter_no)
            {
                scrollRect.horizontalNormalizedPosition = 0f;
                return;
            }
            else
            {
                GameObject playStage = LobbyManager.instance.contentTr.Find(string.Format("Stage{0}", LocalValue.Click_Stage_H.ToString())).gameObject; // 방금 플레이 했던 스테이지
                targetNormalizedPos = (playStage.GetComponent<RectTransform>().anchoredPosition.x - (viewPortWidth * ratio)) / moveRange;
                if (targetNormalizedPos < 0)
                    targetNormalizedPos = 0;
                else if (targetNormalizedPos > 1)
                    targetNormalizedPos = 1;
                scrollRect.horizontalNormalizedPosition = targetNormalizedPos;
                return;
            }
        }
        float targetPosX = standardRect.anchoredPosition.x;
        targetNormalizedPos = (targetPosX - viewPortWidth * ratio) / moveRange;

        if(targetNormalizedPos<0)
            targetNormalizedPos = 0;
        else if(targetNormalizedPos>1)
            targetNormalizedPos = 1;
        
        scrollRect.horizontalNormalizedPosition = targetNormalizedPos;
    }
    private void SetCharacterPosition(RectTransform cloneRect)
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        characterObj = Instantiate(Resources.Load<GameObject>("Prefabs/Character/SpinePrefab"), cloneRect);
        characterObj.GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 15);
        SkeletonAnimation skeletonAnimation = characterObj.GetComponent<SkeletonAnimation>();
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
    private void CreateNextChapterBoard()
    {
        RectTransform cloneBoardRect = Instantiate(Resources.Load<RectTransform>("Prefabs/Stage/NextChapterBoard"), scrollRect.content);
        cloneBoardRect.GetComponent<NextChapterBoardUIInfo>().Init();
        stageBoxList.Add(cloneBoardRect.gameObject);
    }
}
