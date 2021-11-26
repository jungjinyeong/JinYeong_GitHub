using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Linq;

public class InGameUIInfo : MonoBehaviour
{
    [SerializeField]
    private RectTransform ParentCanvasRectTr;    
    [SerializeField] private RectTransform effectDisplayRectTr;
    [SerializeField] private GameObject protectionBridgeBlackBlock;
    [SerializeField] private RectTransform curtainRect;
    [SerializeField] private Text hintPoleCountText;
    [SerializeField] private Text timeStopCountText;
    [SerializeField] private Text protectionBridgeCountText;
    [SerializeField] private Text phaseText;
    [SerializeField] private Transform inGameCanvasTr;
    [SerializeField] private GameObject timeStopTransparentTouchBlock;
    [SerializeField] private RectTransform inGameUIGroupRectTr;
    [SerializeField] private GameObject canvasTouchBlockObj;
    [SerializeField] private GameObject iceBarEffectObj;

    [SerializeField] private Image dangerBackgroundImage;
    [SerializeField] private RectTransform hurryUpTextRectTr;

    private List<GameObject> spreadedBellList= new List<GameObject>();

    private int bell_index; // spreadBellList 하나하나 순서대로 참조할 용도

    public event System.Action OnFinishedTween;

    private Sequence goSequence;
    private Sequence dangerSequence;

    private GameObject timeOverObj;
    private GameObject readyEffectObj;
    private GameObject goEffectObj;
    private GameObject clearEffectObj;
    private GameObject stageFailObj;


    //전역변수
    HashSet<string> hintTiniffingHashSet = new HashSet<string>();

    public void Init()
    {
        OnRefresh();
        // 티니핑 찾았을때 바꿔줄 벨의 인덱스 초기화
        bell_index = 0;
        // 종 세팅
        BellSpread();
        Debug.Log("list count : " + spreadedBellList.Count +1 + " 개");
    }
   
    public void OnHintPoleButtonClick()
    {
        var hintPoleData = DataService.Instance.GetData<Table.ItemTable>(0);
        //힌트봉을 사용할 수 있는지 없는지 여부 체크     예외처리
        if (hintPoleData.count == 0)
        {
            return;
        }
        if (hintTiniffingHashSet.Count == 0) // 힌트봉으로 찾을 녀석이 없다면
        {
            return;
        }    
            // 예외처리 후 나머지는 사용할 수 있는 힌트봉이 있는 상황
            // 일단 힌트 봉 개수 하나 차감 -> DB 업데이트 , UI 업데이트

        // 현재 맵에 남아있는 티니핑 리스트 받아오기  , call by ref
        List<string> remainedTiniffingList = GameManager.instance.GetSelectedTiniffingList();

        if (hintTiniffingHashSet.Count != 0) // 힌트봉으로 찾을 녀석이 아직 남아있다면
        {
            hintPoleData.count--;
            for (int i = 0; i < remainedTiniffingList.Count; i++)
            {
                if (remainedTiniffingList[i] == hintTiniffingHashSet.First())
                {
                    hintTiniffingHashSet.Remove(hintTiniffingHashSet.First()); // hash set 에서 제거하고
                    GameObject hintTiniffing = inGameCanvasTr.Find(remainedTiniffingList[i]).gameObject; // InGameCanvas 아래의 자식에서 이름으로 찾음
                    // remainedTiniffingList의 순서와 실제 인게임캔버스아래 자식으로 있는 순서는 같고 인덱스만 +1 차이남
                    hintTiniffing.GetComponent<FindTiniffingController>().HintEffectOn(); // 힌트 이펙트 온
                    break;
                }
            }
        }
        hintPoleCountText.text = hintPoleData.count.ToString(); //UI update
        DataService.Instance.UpdateData(hintPoleData); // DB update


    }
    public void RemoveHashSetItem(string findedTiniffingName)
    {
        hintTiniffingHashSet.Remove(findedTiniffingName);
    }
    public void SetHintHashSet(List<string> tiniffingList)
    {
        for (int i = 0; i < tiniffingList.Count; i++)
            hintTiniffingHashSet.Add(tiniffingList[i]);
    }

    public void OnTimeStopButtonClick()
    {
        // 아이템이 존재하나? check
        var timeStopData = DataService.Instance.GetData<Table.ItemTable>(1);
        if (timeStopData.count == 0)
        {
            return;  // 종료
        }
        // 아이템 개수 -1 ->  DB , UI 업데이트
        timeStopData.count--;
        DataService.Instance.UpdateData(timeStopData); // db update
        timeStopCountText.text = timeStopData.count.ToString(); // ui update
        // 추가로 아이템 사용 못하게 touchblock 시켜주기
        timeStopTransparentTouchBlock.SetActive(true);
        // 일정 시간 정지
        InGameTimer.instance.SetTempState();
        InGameTimer.instance.SetStateChange(InGameTimer.State.Stop);
        StartCoroutine(TimeStopCor()); // 5초 동안 코루틴 돈다

    }
    IEnumerator TimeStopCor()
    {
        // 시간 정지 기능을 사용한 이후 일정 시간동안(시간이 정지된 동안은) 클릭이 되지 않도록 하여야 함 
        iceBarEffectObj.SetActive(true);
        timeStopTransparentTouchBlock.SetActive(true);
        yield return new WaitForSeconds(5f);
        // 일시 정지 시간이 끝나면 block 해제 시켜주기 
        iceBarEffectObj.SetActive(false);
        timeStopTransparentTouchBlock.SetActive(false);
    }
    public void TimeStopTouchBlockUntilMapChange()
    {
        StartCoroutine(TimeStopTouchBlockUntilMapChangeCor());
    }
     IEnumerator TimeStopTouchBlockUntilMapChangeCor()
    {
        // 시간 정지 기능을 사용한 이후 일정 시간동안(시간이 정지된 동안은) 클릭이 되지 않도록 하여야 함 
        timeStopTransparentTouchBlock.SetActive(true);
        yield return new WaitForSeconds(3f);       
        // 일시 정지 시간이 끝나면 block 해제 시켜주기 
        timeStopTransparentTouchBlock.SetActive(false);
    }

    public void OnUseProtectionBridge() // 보호 브릿지 사용
    {
        var protectionBridgeData = DataService.Instance.GetData<Table.ItemTable>(2); // 보호 브릿지 튜플
        // 보호브릿지 개수 감소시키고 DB 업데이트와 UI 업데이트 
        protectionBridgeData.count--; // 하나 감소
        DataService.Instance.UpdateData(protectionBridgeData); // db update
        protectionBridgeCountText.text = protectionBridgeData.count.ToString(); // ui update
    }
    public void ClearEffectOn()
    {
        clearEffectObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/clear_effect"), effectDisplayRectTr);
        clearEffectObj.transform.GetChild(2).GetChild(2).GetComponent<Text>().text = string.Format("STAGE {0}", LocalValue.Click_Stage_H);
    }
    public void ClearEffectOff()
    {
        clearEffectObj.SetActive(false);
    }
    public void CanvasTouchBlockOn()
    {
        canvasTouchBlockObj.SetActive(true);
    }
    public void OnCurtainUpEvent()
    {
        curtainRect.DOAnchorPosY(1000f, 1.5f).SetEase(Ease.OutQuad); 
    }
    public void OnCurtainDownEvent()
    {
        Tween tween = curtainRect.DOAnchorPosY(0f, 1.5f); // y축 좌표가 0인곳으로 이동, 2초동안
        tween.SetEase(Ease.OutQuad); // 2초의 속도로 pos y위치를 0으로 바꾼다
        tween.onComplete = OnCompleteTween; // tween 이 끝났을때 callback
    }
   
    void OnCompleteTween()
    {
        OnFinishedTween?.Invoke();       
    }
   
    public void TimeOverEventOn()
    {
       timeOverObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/time_over"), effectDisplayRectTr);
    }
    public void TimeOverEvnetOff()
    {
        timeOverObj.SetActive(false);
    }
    
    public void StageFailEventOn()
    {
        stageFailObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/stage_fail"), effectDisplayRectTr);
    }
    public void StageFailEventOff()
    {
        stageFailObj.SetActive(false);
    }
    public void OnPauseButtonClick()
    {
        InGameManager.instance.OnPauseButtonClick();
    }
    public void ReadyEfffectOn()
    {

        readyEffectObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/ready_effect"), effectDisplayRectTr);
        Transform readyImageTr = readyEffectObj.transform.GetChild(1);
        readyImageTr.DOScale(new Vector2(1.2f, 1.2f), 1.5f).OnComplete(() =>
        {
            readyImageTr.DOScale(new Vector2(0, 0), 0.3f);
        });
    }
    public void ReadyEffectOff()
    {
        readyEffectObj.SetActive(false);
    }
    public void GoEffectOn()
    {
        goEffectObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/go_effect"), effectDisplayRectTr);

        Transform goImageTr = goEffectObj.transform.GetChild(1);
        Transform heartspingTr = goEffectObj.transform.GetChild(2);
        Image touchBlockImage = goEffectObj.transform.GetChild(0).GetComponent<Image>();

        goSequence = DOTween.Sequence()
        .Prepend(goImageTr.DOScale(new Vector2(1.2f, 1.2f), 0.6f))
        .Insert(0.7f, goImageTr.DOScale(new Vector2(0, 0), 0.3f))
        .Insert(0.7f, heartspingTr.DOScale(new Vector2(0, 0), 0.3f))
        .Insert(0.7f,touchBlockImage.DOFade(0, 5f));
    }
    public void GoEffectOff()
    {
        goEffectObj.SetActive(false);
    }
    public void InGameDangerStateDisplay()
    {
        dangerBackgroundImage.DOFade((200f / 255f), 0.5f).SetLoops(-1, LoopType.Yoyo);
        dangerSequence = DOTween.Sequence()
        .Join(hurryUpTextRectTr.DOAnchorPosX(30, 0.3f).SetEase(Ease.Linear))
        .Insert(0.3f, hurryUpTextRectTr.DOAnchorPosX(10, 0.8f).SetEase(Ease.Linear))
        .Insert(1.1f, hurryUpTextRectTr.DOAnchorPosX(-700, 0.3f).SetEase(Ease.Linear));
    }
    public void BellSpriteChange()
    {    
        spreadedBellList[bell_index].GetComponent<Image>().sprite = Resources.Load<Sprite>("Images/InGameUI/find_bell");
        spreadedBellList[bell_index].transform.GetChild(0).gameObject.SetActive(true);
        bell_index++; // index 증가
     //   Debug.LogError("bell_index : " + bell_index);
    }
    private void BellSpread()
    {
       // 이미 값이 들어있었다면 List 값 초기화 (map 1 , map2 로 넘어갈때 생길 예외처리) 
        if (spreadedBellList.Count !=0)
        {
            int bell_all_count = spreadedBellList.Count;
           for (int i = 0; i < bell_all_count; i++)
           {
                Destroy(spreadedBellList[0]); //게임 오브젝트 삭제
                spreadedBellList.RemoveAt(0); // 0번째 인덱스 공간 삭제
                // i 번째 인덱스를 제거하면 문제가 발생함
                /* 
                    만약 리스트에 원소가 5개가 존재한다고 하자 
                    removeAt(i) 를 할시 0부터 4까지할텐데
                    removeAt(0) 을 하면 일단 기존의 0번째 공간이 사라지고 나머지들이 땅겨지면서 0 1 2 3 의 인덱스가 남게된다

                 remove(1) -> 0 1 2  남고
                remove(2) -> 0 1  남게됨
                remove(3) 은 당연히 없는 공간을 제거하려하니 argument 에러가 뜰 수 밖에 없다
                  */
            }
        } 
        int bell_count =   GameManager.instance.GetSelectedTiniffingList().Count;
        int space = 0; //초기화
        int x;
        switch(bell_count)
        {
            case 3:
                for(int i =0; i<3; i++)
                {
                    GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/BellPrefab"), inGameUIGroupRectTr);
                     RectTransform cloneRectTr = cloneObj.GetComponent<RectTransform>();
                     x = -100;
                     cloneRectTr.anchoredPosition = new Vector2(x + space, -310);
                    space += 65;
                    spreadedBellList.Add(cloneObj);
                }
                break;
            case 4:
                for (int i = 0; i < 4; i++)
                {
                    GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/BellPrefab"), inGameUIGroupRectTr);
                    RectTransform cloneRectTr = cloneObj.GetComponent<RectTransform>();
                    x = -130;
                    cloneRectTr.anchoredPosition = new Vector2(x + space, -310);
                    space += 65;
                    spreadedBellList.Add(cloneObj);

                }
                break;
            case 5:
                for (int i = 0; i < 5; i++)
                {
                    GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/BellPrefab"), inGameUIGroupRectTr);
                    RectTransform cloneRectTr = cloneObj.GetComponent<RectTransform>();
                    x = -165;
                    cloneRectTr.anchoredPosition = new Vector2(x + space, -310);
                    space += 65;
                    spreadedBellList.Add(cloneObj);

                }
                break;
            case 6:
                for (int i = 0; i < 6; i++)
                {
                    GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/BellPrefab"), inGameUIGroupRectTr);
                    RectTransform cloneRectTr = cloneObj.GetComponent<RectTransform>();
                    x = -195;
                    cloneRectTr.anchoredPosition = new Vector2(x + space, -310);
                    space += 65;
                    spreadedBellList.Add(cloneObj);
                }
                break;
            case 7:
                for (int i = 0; i < 7; i++)
                {
                    GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/BellPrefab"), inGameUIGroupRectTr);
                    RectTransform cloneRectTr = cloneObj.GetComponent<RectTransform>();
                    x = -230;
                    cloneRectTr.anchoredPosition = new Vector2(x + space, -310);
                    space += 65;
                    spreadedBellList.Add(cloneObj);

                }
                break;
            default:
                break;
        }

    }
    public void OnRefresh()  // item UI refresh
    {        
        // 아이템 개수 및 active 설정
        var itemTableList = DataService.Instance.GetDataList<Table.ItemTable>();
        hintPoleCountText.text = itemTableList[0].count.ToString();
        timeStopCountText.text = itemTableList[1].count.ToString();
        protectionBridgeCountText.text = itemTableList[2].count.ToString();
        // 보호 브릿지 액티브
        if (itemTableList[2].active == 0)
        {
            protectionBridgeBlackBlock.SetActive(true); // 블락 이미지 활성화
        }       
        // phase 텍스트 값 세팅
        int map_check_h = LocalValue.Map_H;
        phaseText.text = string.Format("{0} / 2 ", (map_check_h+1).ToString());   
    }
}
