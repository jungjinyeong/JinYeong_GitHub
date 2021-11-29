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

    private int bell_index; // spreadBellList �ϳ��ϳ� ������� ������ �뵵

    public event System.Action OnFinishedTween;

    private Sequence goSequence;
    private Sequence dangerSequence;

    private GameObject timeOverObj;
    private GameObject readyEffectObj;
    private GameObject goEffectObj;
    private GameObject clearEffectObj;
    private GameObject stageFailObj;


    //��������
    HashSet<string> hintTiniffingHashSet = new HashSet<string>();

    public void Init()
    {
        OnRefresh();
        // Ƽ���� ã������ �ٲ��� ���� �ε��� �ʱ�ȭ
        bell_index = 0;
        // �� ����
        BellSpread();
        Debug.Log("list count : " + spreadedBellList.Count +1 + " ��");
    }
   
    public void OnHintPoleButtonClick()
    {
        var hintPoleData = DataService.Instance.GetData<Table.ItemTable>(0);
        //��Ʈ���� ����� �� �ִ��� ������ ���� üũ     ����ó��
        if (hintPoleData.count == 0)
        {
            return;
        }
        if (hintTiniffingHashSet.Count == 0) // ��Ʈ������ ã�� �༮�� ���ٸ�
        {
            return;
        }    
            // ����ó�� �� �������� ����� �� �ִ� ��Ʈ���� �ִ� ��Ȳ
            // �ϴ� ��Ʈ �� ���� �ϳ� ���� -> DB ������Ʈ , UI ������Ʈ

        // ���� �ʿ� �����ִ� Ƽ���� ����Ʈ �޾ƿ���  , call by ref
        List<string> remainedTiniffingList = GameManager.instance.GetSelectedTiniffingList();

        if (hintTiniffingHashSet.Count != 0) // ��Ʈ������ ã�� �༮�� ���� �����ִٸ�
        {
            hintPoleData.count--;
            for (int i = 0; i < remainedTiniffingList.Count; i++)
            {
                if (remainedTiniffingList[i] == hintTiniffingHashSet.First())
                {
                    hintTiniffingHashSet.Remove(hintTiniffingHashSet.First()); // hash set ���� �����ϰ�
                    GameObject hintTiniffing = inGameCanvasTr.Find(remainedTiniffingList[i]).gameObject; // InGameCanvas �Ʒ��� �ڽĿ��� �̸����� ã��
                    // remainedTiniffingList�� ������ ���� �ΰ���ĵ�����Ʒ� �ڽ����� �ִ� ������ ���� �ε����� +1 ���̳�
                    hintTiniffing.GetComponent<FindTiniffingController>().HintEffectOn(); // ��Ʈ ����Ʈ ��
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
        // �������� �����ϳ�? check
        var timeStopData = DataService.Instance.GetData<Table.ItemTable>(1);
        if (timeStopData.count == 0)
        {
            return;  // ����
        }
        // ������ ���� -1 ->  DB , UI ������Ʈ
        timeStopData.count--;
        DataService.Instance.UpdateData(timeStopData); // db update
        timeStopCountText.text = timeStopData.count.ToString(); // ui update
        // �߰��� ������ ��� ���ϰ� touchblock �����ֱ�
        timeStopTransparentTouchBlock.SetActive(true);
        // ���� �ð� ����
        InGameTimer.instance.SetTempState();
        InGameTimer.instance.SetStateChange(InGameTimer.State.Stop);
        StartCoroutine(TimeStopCor()); // 5�� ���� �ڷ�ƾ ����

    }
    IEnumerator TimeStopCor()
    {
        // �ð� ���� ����� ����� ���� ���� �ð�����(�ð��� ������ ������) Ŭ���� ���� �ʵ��� �Ͽ��� �� 
        iceBarEffectObj.SetActive(true);
        timeStopTransparentTouchBlock.SetActive(true);
        yield return new WaitForSeconds(5f);
        // �Ͻ� ���� �ð��� ������ block ���� �����ֱ� 
        iceBarEffectObj.SetActive(false);
        timeStopTransparentTouchBlock.SetActive(false);
    }
    public void TimeStopTouchBlockUntilMapChange()
    {
        StartCoroutine(TimeStopTouchBlockUntilMapChangeCor());
    }
     IEnumerator TimeStopTouchBlockUntilMapChangeCor()
    {
        // �ð� ���� ����� ����� ���� ���� �ð�����(�ð��� ������ ������) Ŭ���� ���� �ʵ��� �Ͽ��� �� 
        timeStopTransparentTouchBlock.SetActive(true);
        yield return new WaitForSeconds(3f);       
        // �Ͻ� ���� �ð��� ������ block ���� �����ֱ� 
        timeStopTransparentTouchBlock.SetActive(false);
    }

    public void OnUseProtectionBridge() // ��ȣ �긴�� ���
    {
        var protectionBridgeData = DataService.Instance.GetData<Table.ItemTable>(2); // ��ȣ �긴�� Ʃ��
        // ��ȣ�긴�� ���� ���ҽ�Ű�� DB ������Ʈ�� UI ������Ʈ 
        protectionBridgeData.count--; // �ϳ� ����
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
        Tween tween = curtainRect.DOAnchorPosY(0f, 1.5f); // y�� ��ǥ�� 0�ΰ����� �̵�, 2�ʵ���
        tween.SetEase(Ease.OutQuad); // 2���� �ӵ��� pos y��ġ�� 0���� �ٲ۴�
        tween.onComplete = OnCompleteTween; // tween �� �������� callback
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
        bell_index++; // index ����
     //   Debug.LogError("bell_index : " + bell_index);
    }
    private void BellSpread()
    {
       // �̹� ���� ����־��ٸ� List �� �ʱ�ȭ (map 1 , map2 �� �Ѿ�� ���� ����ó��) 
        if (spreadedBellList.Count !=0)
        {
            int bell_all_count = spreadedBellList.Count;
           for (int i = 0; i < bell_all_count; i++)
           {
                Destroy(spreadedBellList[0]); //���� ������Ʈ ����
                spreadedBellList.RemoveAt(0); // 0��° �ε��� ���� ����
                // i ��° �ε����� �����ϸ� ������ �߻���
                /* 
                    ���� ����Ʈ�� ���Ұ� 5���� �����Ѵٰ� ���� 
                    removeAt(i) �� �ҽ� 0���� 4�������ٵ�
                    removeAt(0) �� �ϸ� �ϴ� ������ 0��° ������ ������� ���������� �������鼭 0 1 2 3 �� �ε����� ���Եȴ�

                 remove(1) -> 0 1 2  ����
                remove(2) -> 0 1  ���Ե�
                remove(3) �� �翬�� ���� ������ �����Ϸ��ϴ� argument ������ �� �� �ۿ� ����
                  */
            }
        } 
        int bell_count =   GameManager.instance.GetSelectedTiniffingList().Count;
        int space = 0; //�ʱ�ȭ
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
        // ������ ���� �� active ����
        var itemTableList = DataService.Instance.GetDataList<Table.ItemTable>();
        hintPoleCountText.text = itemTableList[0].count.ToString();
        timeStopCountText.text = itemTableList[1].count.ToString();
        protectionBridgeCountText.text = itemTableList[2].count.ToString();
        // ��ȣ �긴�� ��Ƽ��
        if (itemTableList[2].active == 0)
        {
            protectionBridgeBlackBlock.SetActive(true); // ��� �̹��� Ȱ��ȭ
        }       
        // phase �ؽ�Ʈ �� ����
        int map_check_h = LocalValue.Map_H;
        phaseText.text = string.Format("{0} / 2 ", (map_check_h+1).ToString());   
    }
}
