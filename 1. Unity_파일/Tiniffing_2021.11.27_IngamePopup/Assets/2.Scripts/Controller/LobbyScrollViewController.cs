using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;
using Spine.Unity;

public class LobbyScrollViewController : MonoBehaviour
{


    public ScrollRect scrollRect; // LobbyManager���� scrollRect ������ ��
    
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
                Destroy(stageBoxList[0]); //���� ������Ʈ ����
                stageBoxList.RemoveAt(0); // 0��° �ε��� ���� ����         
            }
        }
    }
    public void OnStageBoxSpread(int chapter_no, bool isInGameComming = false, bool isFinalStageClear = false) // player�� chapter
    {
        // chapter_no �� now_chapter_no �̴�
        ScrollViewInit();
        int start_stage = (chapter_no - 1) * 20 + 1;
        var lobbyList = DataService.Instance.GetDataList<Table.LobbyTable>().FindAll(x => x.chapter_no == chapter_no && x.stage_no >= start_stage && x.stage_no <= start_stage + 19);
        lobbyList.OrderBy(x => x.stage_no).ToList();
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);

        for (int i = 0; i < 20; i++)
        {
            if (chapter_no != 1 && i == 0) // ù��° é�Ͱ� �ƴҶ� ����é�� ǥ���� �����ٰ���
            {
                if (LocalValue.isLatestFinalStage && saveTable.now_chapter_no == 1) // 1->2 �Ѿ�� ����� 
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
            if (i == 19) // ����é�� ǥ����
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
        //������ �������� Ŭ������ ��� , ������ �������� ���ڰ� ������ ��������
        if (i == 19 && isFinalStageClear)
        {
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            SetCharacterPosition(cloneRect);
        }
        // ������ ���⿡ �ΰ��� ��� Ŭ�����ߴ� ���ڸ� ��� �����Ѱ��� , �ΰ��� Ŭ��� ���� stage�� �������� ��Ȳ�� ����� ����
        else if (lobbyList[i].stage_no == saveTable.stage_no - 1 && isInGameComming && !isFinalStageClear)
        {
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            SetCharacterPosition(cloneRect);
        }
        // �Ϲ����� ��Ȳ
        else if (lobbyList[i].stage_no == saveTable.stage_no && !isInGameComming && !isFinalStageClear)
        {
            //���� �����ֱ�
            RectTransform childRect = cloneRect.GetChild(0).GetComponent<RectTransform>();
            childRect.anchoredPosition = new Vector2(0, -40.2f);
            standardRect = cloneRect;
            Debug.LogError("Normal = " + lobbyList[i].stage_no);
            Debug.LogError("standard Rect x = " + standardRect.anchoredPosition.x);
            // �̶� ���� stanardRect�� ������ �ȵǾ  Log ���� 0 �� ����� 
            SetCharacterPosition(cloneRect);
        }
    }
    private void SetScrollViewPivot(bool isFinalStageClear, Table.SaveTable saveTable, int chapter_no)
    {
        float contentWidth = scrollRect.content.sizeDelta.x;
        float viewPortWidth = scrollRect.viewport.rect.width; // sizeDelta �� �ȸ����� rect.width ���� ��
        float moveRange = contentWidth - viewPortWidth;
        float ratio = 0.5f;
        float targetNormalizedPos;
        if (saveTable.chapter_no!=chapter_no) // ���� é�� �����ִ� ����
        {
            if (LocalValue.Click_Chapter_H == 0) // click chapter ==0  : ���ӵ��ͼ� � ���������� ���� ���� ���� ����
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
                GameObject playStage = LobbyManager.instance.contentTr.Find(string.Format("Stage{0}", LocalValue.Click_Stage_H.ToString())).gameObject; // ��� �÷��� �ߴ� ��������
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
