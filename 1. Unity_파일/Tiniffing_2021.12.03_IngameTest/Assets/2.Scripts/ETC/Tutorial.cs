using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
// LobbyMask1������ ��� -> TeeniepingCatchDisplay ���⿡�� TouchBlock �� ���� ��� -> LobbyMask2 �� ���� ��� -> TeeniepingCollectionMask1������ ��� -> TeeniepingCollectionMask2�� ���� ���
public class Tutorial : MonoBehaviour
{
    [SerializeField] private GameObject lobbyObj;
    //[Lobby] StageBox

    //[Lobby] TeeniepingMind
    [SerializeField] private GameObject heartspingRewardReceiveCompleteObj;
    [SerializeField] private GameObject heartspingRewardObj;
    [SerializeField] private GameObject heartspingMindObj;
    [SerializeField] private GameObject rewardButtonOffObj;
    [SerializeField] private GameObject rewardButtonOnObj;

    // [TeeniepingCollection]
    [SerializeField] private GameObject teeniepingCollectionObj;

    // Heartsping Image
    [SerializeField] private GameObject lobbyHeartsping0;
    [SerializeField] private GameObject lobbyHeartsping1;
    [SerializeField] private GameObject teeniepingCollectionHeartsping1;

    //SpeechBubble
    [SerializeField] private GameObject lobbySpeechBubble0Obj;
    [SerializeField] private GameObject lobbySpeechBubble1Obj;
    [SerializeField] private GameObject teeniepingCollectionSpeechBubble1Obj;

    // Mask
    [SerializeField] private GameObject teeniepingMindMask;
    [SerializeField] private GameObject teeniepingCollectionButtonMaskObj;
    [SerializeField] private GameObject startButtonMaskObj;
    [SerializeField] private GameObject teeniepingCollectionMask0;
    [SerializeField] private GameObject teeniepingCollectionMask1;
    
    // Text
    [SerializeField] private Text GetTeeniepingMindText;
    [SerializeField] private Text lobbySpeechBubble0Text;
    [SerializeField] private Text lobbySpeechBubble1Text;
    [SerializeField] private Text teeniepingCollectionSpeechBubble1Text;
    
    // Hand Effect
    [SerializeField] private RectTransform handRectTr; // mind
    [SerializeField] private RectTransform handRectTr2; //button
    [SerializeField] private RectTransform handRectTr3; // start

    // NextText RectTr
    [SerializeField] RectTransform lobbySpeechBubble0_NextTextRect;
    [SerializeField] RectTransform lobbySpeechBubble1_NextTextRect;
    [SerializeField] RectTransform teeniepingCollectionSpeechBubble1_NextTextRect;

    // TouchScreen
    [SerializeField] private GameObject lobbyTouchScreenObj;

    // ���� ��ġ ���
    [SerializeField] private GameObject teeniepingCollectionButtonTouchBlockObj;
 
    private bool isLobbyTouchScreenClick = false;
    private bool isTeeniepingCollectionTouchScreenClick = false;

    public void Init()
    {
        LobbyManager.instance.teeniepingMindRewardParentObj.SetActive(false); // TeeniepingMind �ڿ��ִ°� ���ֱ� // ĵ�����԰��־ ����ũ ������� �ٷ� Ƣ���
        OnRefresh();
        StartCoroutine(Intro());
    }
    private bool isReadFinished = false;
    IEnumerator Intro()
    {
        IntroSetting();
        // do text �� ��������ٰ� ���ϴ� �ؽ�Ʈ�� �ִ°Ŷ� �̹� ���� ���õǾ������� �ȵ�
        lobbySpeechBubble0Text.DOText(DataService.Instance.GetText(950), 1.5f).SetEase(Ease.Linear).OnComplete(() =>
        {
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        });
        yield return new WaitUntil(() => isLobbyTouchScreenClick);
        isLobbyTouchScreenClick = false;
        if (!isReadFinished)
        {
            lobbySpeechBubble0Text.DOKill();
            lobbySpeechBubble0Text.text = DataService.Instance.GetText(950);
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isLobbyTouchScreenClick);
            isLobbyTouchScreenClick = false;
            isReadFinished = false; // �ʱ�ȭ
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);

        }
        else // ���о�����
        {
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        TeeniepingMindDescriptionSetting();
        yield return new WaitUntil(() => isLobbyTouchScreenClick);
        isLobbyTouchScreenClick = false;
        if (!isReadFinished)
        {
            lobbySpeechBubble0Text.DOKill();
            lobbySpeechBubble0Text.text = DataService.Instance.GetText(951);
            teeniepingMindMask.SetActive(true); // �ٷ� ����ũ ����
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isLobbyTouchScreenClick);
            isLobbyTouchScreenClick = false;
            isReadFinished = false; // �ʱ�ȭ
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
        }
        else // �� �������
        {
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        Repeat_LobbySpeechBubble0(952);
        yield return new WaitUntil(() => isLobbyTouchScreenClick);
        isLobbyTouchScreenClick = false;
        if (!isReadFinished)
        {
            lobbySpeechBubble0Text.DOKill();
            lobbySpeechBubble0Text.text = DataService.Instance.GetText(952);
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isLobbyTouchScreenClick);
            isLobbyTouchScreenClick = false;
            isReadFinished = false; // �ʱ�ȭ
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
        }
        else // �� �������
        {
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        Repeat_LobbySpeechBubble0(953);
        yield return new WaitUntil(() => isLobbyTouchScreenClick);
        isLobbyTouchScreenClick = false;
        if (!isReadFinished)
        {
            lobbySpeechBubble0Text.DOKill();
            lobbySpeechBubble0Text.text = DataService.Instance.GetText(953);
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isLobbyTouchScreenClick);
            isLobbyTouchScreenClick = false;
            isReadFinished = false; // �ʱ�ȭ
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
        }
        else // �� �������
        {
            lobbySpeechBubble0Text.text = "";
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        lobbyTouchScreenObj.SetActive(false); // ȭ�� ��ü ��ġ�Ǵ°� ����
        lobbySpeechBubble0Text.DOText(DataService.Instance.GetText(954), 1f).SetEase(Ease.Linear).OnComplete(() => 
        {
            HeartspingMindRewardActive();
        });  // Ƽ���� ĳġ�� ��ġ���� �� ������ => Ƽ����ĳġ��ư active 
       
    }

    private void Repeat_LobbySpeechBubble0(int textId)
    {
        lobbySpeechBubble0Text.text = "";
        lobbySpeechBubble0Text.DOKill();
        lobbySpeechBubble0_NextTextRect.gameObject.SetActive(false);
        isLobbyTouchScreenClick = false;
        lobbySpeechBubble0Text.DOText(DataService.Instance.GetText(textId), 1.5f).SetEase(Ease.Linear).OnComplete(() =>
        { 
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        }); 
    }


    private void IntroSetting()
    {
        lobbyObj.SetActive(true);
        lobbyHeartsping0.SetActive(true);
        lobbySpeechBubble0Obj.SetActive(true);  
        heartspingMindObj.SetActive(true);
        rewardButtonOffObj.SetActive(true);
        heartspingRewardReceiveCompleteObj.SetActive(false);
    }
    private void TeeniepingMindDescriptionSetting()
    {

        lobbySpeechBubble0Text.DOText(DataService.Instance.GetText(951), 1.5f).SetEase(Ease.Linear).OnComplete(() => //�������� �ߺ��� ��
        {
            lobbySpeechBubble0_NextTextRect.gameObject.SetActive(true);
            teeniepingMindMask.SetActive(true);
            isReadFinished = true;
        });

    }

    private void HeartspingMindRewardActive()
    {
        heartspingMindObj.SetActive(false);
        heartspingRewardObj.SetActive(true);
        rewardButtonOnObj.SetActive(true);
        rewardButtonOffObj.SetActive(false);
        HandEffect();
    }

    // Ƽ���� ĳġ ��ư�Լ�
    public void HeartspingRewardButtonClick()
    {
        rewardButtonOnObj.SetActive(false);
        rewardButtonOffObj.SetActive(true);
        heartspingMindObj.SetActive(false);
        heartspingRewardObj.SetActive(false);
        heartspingRewardReceiveCompleteObj.SetActive(true);
        lobbyHeartsping0.SetActive(false);
        lobbySpeechBubble0Obj.SetActive(false);
        handRectTr.gameObject.SetActive(false);
        handRectTr_Clone.gameObject.SetActive(false);
        teeniepingMindMask.SetActive(false);
        HeartspingCatchDisplay();
    }
    IEnumerator AfterCompleteTeeniepingCatch()
    {
        lobbyTouchScreenObj.SetActive(true); // Ƽ���� ĳġ ��ư �������� �����Ҷ� ������� �ٽ� ���ֱ�
        lobbyHeartsping1.SetActive(true);
        lobbySpeechBubble1Obj.SetActive(true);
        lobbySpeechBubble1Text.DOText(DataService.Instance.GetText(955), 1.5f).SetEase(Ease.Linear).OnComplete(() => 
        { 
            lobbySpeechBubble1_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        });
        //��� �ʹ� ���ϴµ� ? ~~~~ ĳġ�� Ƽ������ �˾ƺ���
        yield return new WaitUntil(() => isLobbyTouchScreenClick);
        isLobbyTouchScreenClick = false;
        lobbySpeechBubble1Text.DOKill();

        if (!isReadFinished)
        {
            lobbySpeechBubble1Text.text = DataService.Instance.GetText(955);
            lobbySpeechBubble1_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isLobbyTouchScreenClick);
            isLobbyTouchScreenClick = false;
            isReadFinished = false; // �ʱ�ȭ
            lobbySpeechBubble1Text.text = "";
            lobbySpeechBubble1_NextTextRect.gameObject.SetActive(false);
        }
        else // ���о�����
        {
            lobbySpeechBubble1Text.text = "";
            lobbySpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        // Ƽ���� ���� �� ������Ʈ ���ֱ� 
       
        TeeniepingCollectionButtonCor();      
    }
 

    public void LobbyTouchScreenClick()
    {
        isLobbyTouchScreenClick = true;
        Debug.Log("Touch Screen Click");
    }
    // ---------------------------------------------------------------------------------TeeniepingCollectionButton---------------------------------------------------------------------------
    private void TeeniepingCollectionButtonCor()
    {
        lobbySpeechBubble1Text.DOText(DataService.Instance.GetText(956), 1.5f).SetEase(Ease.Linear).OnComplete(() => // ������ ��ġ���� ��
        {
            // ���� ��ġ�������
            teeniepingCollectionButtonMaskObj.SetActive(true);
            teeniepingCollectionButtonTouchBlockObj.SetActive(false);
            lobbyTouchScreenObj.SetActive(false); // �ٽ� ��ġ��ũ�� ����� ���� Ŭ����
            HandEffect2();
        });
    }
    // ---------------------------------------------------------------------------------HandEffect-------------------------------------------------------------------------------------------
    [SerializeField] private RectTransform handRectTr_Clone;
    [SerializeField] private RectTransform handRectTr2_Clone;
    [SerializeField] private RectTransform handRectTr3_Clone;

    [SerializeField] private GameObject teeniepingMindEffectObj;
    [SerializeField] private GameObject teeniepingCollectionButtonEffectObj;
    [SerializeField] private GameObject startButtonEffectObj;
    
    Sequence handSequence1;
    Sequence handSequence2;
    Sequence handSequence3;


    private void HandEffect()
    {
        handRectTr.gameObject.SetActive(true);
        handRectTr_Clone.gameObject.SetActive(true);
        handSequence1 = DOTween.Sequence()
        .Insert(0f, handRectTr.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0f, handRectTr_Clone.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0.35f, handRectTr.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .Insert(0.35f, handRectTr_Clone.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .InsertCallback(0.36f, () => TeeniepingMindMask_EffectOn())
        .InsertCallback(1.36f, () => TeeniepingMindMask_EffectOff()).OnComplete(() =>
        {
            handSequence1.Restart();
        });
    }

    private void HandEffect2()// ���ʹ���
    {
        handRectTr2.gameObject.SetActive(true);
        handRectTr2_Clone.gameObject.SetActive(true);
        handSequence2 = DOTween.Sequence()
        .Insert(0f, handRectTr2.DORotate(new Vector3(0, 0, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0f, handRectTr2_Clone.DORotate(new Vector3(0, 0, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0.35f, handRectTr2.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .Insert(0.35f, handRectTr2_Clone.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .InsertCallback(0.36f, () => TeeniepingCollectionButtonMask_EffectOn())
        .InsertCallback(1.36f, () => TeeniepingCollectionButtonMask_EffectOff()).OnComplete(() =>
        {
            handSequence2.Restart();
        });
    }
    private void HandEffect3() // ������
    {
        handRectTr3.gameObject.SetActive(true);
        handRectTr3_Clone.gameObject.SetActive(true);
        handSequence3 = DOTween.Sequence()
        .Insert(0f, handRectTr3.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0f, handRectTr3_Clone.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(0.35f, handRectTr3.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .Insert(0.35f, handRectTr3_Clone.GetComponent<Image>().DOFade(0f, 0.35f).SetEase(Ease.Linear))
        .InsertCallback(0.36f, () => StartButtonMask_EffectOn())
        .InsertCallback(1.36f, () => StartButtonMask_EffectOff()).OnComplete(() =>
        {
            handSequence3.Restart();
        });
    }

    private void TeeniepingMindMask_EffectOn()
    {
        teeniepingMindEffectObj.SetActive(true);
    }
    private void TeeniepingMindMask_EffectOff()
    {
        teeniepingMindEffectObj.SetActive(false);
    } 
    private void TeeniepingCollectionButtonMask_EffectOn()
    {
        teeniepingCollectionButtonEffectObj.SetActive(true);
    }
    private void TeeniepingCollectionButtonMask_EffectOff()
    {
        teeniepingCollectionButtonEffectObj.SetActive(false);
    }
    private void StartButtonMask_EffectOn()
    {
        startButtonEffectObj.SetActive(true);
    }
    private void StartButtonMask_EffectOff()
    {
        startButtonEffectObj.SetActive(false);
    }

    // ---------------------------------------------------------------------------------TeeniepingCollection---------------------------------------------------------------------------
    public void TeeniepingCollectionButtonClick()
    {
        lobbyObj.SetActive(false);
        handRectTr2.gameObject.SetActive(false);
        handRectTr2_Clone.gameObject.SetActive(false);
        // �ʱ�ȭ
        lobbySpeechBubble1Text.text = "";
        lobbySpeechBubble1Text.DOKill();
        lobbySpeechBubble0Text.text = "";
        lobbySpeechBubble0Text.DOKill();

        StartCoroutine(TeeniepingCollectionCor());
    }
    private void TeeniepingCollectionIntroSetting()
    {
        teeniepingCollectionObj.SetActive(true);
        teeniepingCollectionMask0.SetActive(false);
        teeniepingCollectionMask1.SetActive(false);
        teeniepingCollectionSpeechBubble1Obj.SetActive(true);
        teeniepingCollectionHeartsping1.SetActive(true);
    }

    IEnumerator TeeniepingCollectionCor()
    {
        
        TeeniepingCollectionIntroSetting(); //mask 0
        teeniepingCollectionSpeechBubble1Text.DOText(DataService.Instance.GetText(957), 1.5f).SetEase(Ease.Linear).OnComplete(() =>  //�츮 Ƽ������ ��� ���⿡�� �� �� �־�~
     { 
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        }); 
        yield return new WaitUntil(()=>isTeeniepingCollectionTouchScreenClick);
        isTeeniepingCollectionTouchScreenClick = false;
        if (!isReadFinished)
        {
            teeniepingCollectionSpeechBubble1Text.DOKill();
            teeniepingCollectionSpeechBubble1Text.text = DataService.Instance.GetText(957);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
            isTeeniepingCollectionTouchScreenClick = false;
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        else // ���о�����
        {
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        teeniepingCollectionSpeechBubble1Text.DOText(DataService.Instance.GetText(958), 1.5f).SetEase(Ease.Linear).OnComplete(() => 
        {
            teeniepingCollectionMask0.SetActive(true);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
        }); 

        yield return new WaitUntil(()=>isTeeniepingCollectionTouchScreenClick);
        isTeeniepingCollectionTouchScreenClick = false;
        if (!isReadFinished)
        {
            teeniepingCollectionSpeechBubble1Text.DOKill();
            teeniepingCollectionSpeechBubble1Text.text = DataService.Instance.GetText(958);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            teeniepingCollectionMask0.SetActive(true);

            yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
            isTeeniepingCollectionTouchScreenClick = false;
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        else // ���о�����
        {
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        teeniepingCollectionMask0.SetActive(false);

        teeniepingCollectionSpeechBubble1Text.DOText(DataService.Instance.GetText(959), 1.5f).SetEase(Ease.Linear).OnComplete(() => 
        { 
            teeniepingCollectionMask1.SetActive(true);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        }); 
        yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
        isTeeniepingCollectionTouchScreenClick = false;
        if (!isReadFinished)
        {
            teeniepingCollectionSpeechBubble1Text.DOKill();
            teeniepingCollectionSpeechBubble1Text.text = DataService.Instance.GetText(959);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            teeniepingCollectionMask1.SetActive(true);

            yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
            isTeeniepingCollectionTouchScreenClick = false;
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        else // ���о�����
        {
            teeniepingCollectionSpeechBubble1Text.text = "";
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
            isReadFinished = false; // �ʱ�ȭ
        }
        teeniepingCollectionMask1.SetActive(false);

        teeniepingCollectionSpeechBubble1Text.DOText(DataService.Instance.GetText(960), 1.5f).SetEase(Ease.Linear).OnComplete(() =>  // �κ�� ������?
        {
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);
            isReadFinished = true;
        });
        yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
        isTeeniepingCollectionTouchScreenClick = false;
        if (!isReadFinished)
        {
            teeniepingCollectionSpeechBubble1Text.DOKill();
            teeniepingCollectionSpeechBubble1Text.text = DataService.Instance.GetText(960);
            teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(true);

            yield return new WaitUntil(() => isTeeniepingCollectionTouchScreenClick);
            isTeeniepingCollectionTouchScreenClick = false;
        }
 
        isReadFinished = false; // �ʱ�ȭ
        teeniepingCollectionSpeechBubble1_NextTextRect.gameObject.SetActive(false);
        teeniepingCollectionSpeechBubble1Text.text = "";
        teeniepingCollectionObj.SetActive(false);
        
        StartCoroutine(LobbyTutorial2());
     
    }
    public void TeeniepingCollectionTouchScreenClick()
    {
        isTeeniepingCollectionTouchScreenClick = true;
        Debug.Log("TeeniepingCollectionTouchScreenClick");
    }
    //-------------------------------------------------------------------------------Back to Lobby & Start Button-------------------------------------------------------------------
    private void LobbyTutorial2Setting()
    {
        lobbyObj.SetActive(true);
        lobbyTouchScreenObj.SetActive(true); // �ٽ� ��ġ��ũ�� ���ֱ�
        lobbyHeartsping0.SetActive(true);
        lobbySpeechBubble0Obj.SetActive(true);

        lobbyHeartsping1.SetActive(false);
        lobbySpeechBubble1Obj.SetActive(false);
        teeniepingMindMask.SetActive(false);
        teeniepingCollectionButtonMaskObj.SetActive(false);
    }
 
    IEnumerator LobbyTutorial2()
    {
        LobbyTutorial2Setting();
        
        lobbySpeechBubble0Text.DOText(DataService.Instance.GetText(961), 1.5f).SetEase(Ease.Linear).OnComplete(() => 
        {
            startButtonMaskObj.SetActive(true);
            lobbyTouchScreenObj.SetActive(false); // ��ġ��ũ�� ����� start��ư Ŭ����
            HandEffect3();
        });
        yield return new WaitUntil(() => LocalValue.isStartButtonClick);
       
        // newbie update
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.newbie = 1;
        var tutorialTable = DataService.Instance.GetData<Table.TutorialTable>(0);
        tutorialTable.check1 = 1;
        DataService.Instance.UpdateData(tutorialTable);
        DataService.Instance.UpdateData(saveTable);
        LobbyManager.instance.teeniepingMindRewardParentObj.SetActive(true); // TeeniepingMind �ڿ��ִ°� �ٽ� ���ֱ� 
        Debug.Log("tutorial destroy");
        Destroy(gameObject);
    }
    // ---------------------------------------------------------------------------------TeeniepingDisplay---------------------------------------------------------------------------

    [SerializeField] private GameObject heartspingCatchDisplayObj;

    [SerializeField] private RectTransform teeniepingCatchRect; // Ƽ���� �̹���
    [SerializeField] private RectTransform teeniepingCatchTextRect; // ĳġ ���� �ؽ�Ʈ

    [SerializeField] private Image heartspingCatchDisplayBackgroundImg;

    [SerializeField] private Text teeniepingCatchText;
    [SerializeField] private Text teeniepingCatchDisplayNextText;

    [SerializeField] private GameObject TeeniepingCatchDisplayNextObj;

    [SerializeField] private Transform teeniepingCollectionButtonTr;

    // TeeniepingCollectionButtonRect
    [SerializeField] private RectTransform teeniepingCollectionButtonRectTr;

    private Sequence teeniepingCatchSequence;


    [SerializeField] private GameObject bottomGlowEffectObj;
    [SerializeField] private GameObject heartFlashEffectObj;

    [SerializeField] private RectTransform starEffectRectTr;

    private void HeartspingCatchDisplay()
    {
        heartspingCatchDisplayObj.SetActive(true);
        HeartCoinTween();
    }
    private void HeartCoinTween()
    {
        teeniepingCatchSequence = DOTween.Sequence()
    .OnStart(() =>
    {
        bottomGlowEffectObj.SetActive(true);
        heartFlashEffectObj.SetActive(true);
    })
    .Join(starEffectRectTr.DOAnchorPosY(256, 1.5f).SetEase(Ease.Linear))
    .Join(heartspingCatchDisplayBackgroundImg.DOFade(1, 1f))
    .Insert(1f, teeniepingCatchRect.transform.DORotate(new Vector2(0, 360), 0.1f, RotateMode.LocalAxisAdd).SetLoops(9, LoopType.Restart))
    .Insert(1f, teeniepingCatchRect.transform.DOScale(new Vector2(0.8f, 0.8f), 1.8f).SetEase(Ease.InSine))
    .Insert(1.9f, teeniepingCatchRect.transform.DORotate(new Vector2(0, 360), 0.1f, RotateMode.LocalAxisAdd).SetLoops(4, LoopType.Restart))
    .Insert(1.9f, teeniepingCatchRect.transform.DOScale(new Vector2(1.5f, 1.5f), 1f))
    .Insert(3f, teeniepingCatchRect.transform.DOScale(new Vector2(1.45f, 1.45f), 1f).SetEase(Ease.Linear).SetLoops(999999999, LoopType.Yoyo))
    .Insert(1.9f, teeniepingCatchTextRect.transform.DOScale(new Vector2(3.2f, 3.2f), 0.6f))
    .Insert(2.5f, teeniepingCatchTextRect.transform.DOScale(new Vector2(3f, 3f), 0.1f))
    .InsertCallback(3f, () => TeeniepingCatchDisplayNextButtonOn());
    }
    private void TeeniepingCatchDisplayNextButtonOn()
    {
        TeeniepingCatchDisplayNextObj.SetActive(true);
    }
    public void HeartspingCatchDisplayOnNextButtonClick()
    {
        heartspingCatchDisplayBackgroundImg.DOFade(0, 1f);
        teeniepingCatchText.gameObject.SetActive(false);
        TeeniepingCatchDisplayNextObj.SetActive(false);
        teeniepingCatchRect.transform.DOKill();
        TeeniepingWindMillEffectTween();
    }
    private void TeeniepingWindMillEffectTween()
    {
        int screenWidth = Screen.width;
        int screenHeight = Screen.height;
        Vector2 teeniepingCollectionButtonRectPos 
            = new Vector2(teeniepingCollectionButtonRectTr.anchoredPosition.x-screenWidth/2 , teeniepingCollectionButtonRectTr.anchoredPosition.y - screenHeight/2);
        teeniepingCatchSequence = DOTween.Sequence().OnStart(() =>
     {
         teeniepingCatchRect.transform.DOScale(new Vector2(0f, 0f), 0.7f).OnComplete(() => { teeniepingCatchRect.gameObject.SetActive(false); });
     })
    .Join(teeniepingCatchRect.DOAnchorPos(teeniepingCollectionButtonRectPos, 0.5f).SetEase(Ease.InCubic))
    .Insert(0.45f, teeniepingCollectionButtonTr.DOScale(new Vector2(1.2f, 1.2f), 0.2f)).OnComplete(() =>
     {
         teeniepingCollectionButtonTr.DOScale(new Vector2(1.000031f, 1.000031f), 0.2f).OnComplete(() =>
         {
             teeniepingCollectionButtonTr.DOScale(new Vector2(1f, 1f), 0.1f).SetDelay(0.2f).OnComplete(() =>
             {
                 StartCoroutine(AfterCompleteTeeniepingCatch());                 
                 Destroy(heartspingCatchDisplayObj);
             });
             
         });
     });    
    }
    // ---------------------------------------------------------------------------------TeeniepingCollectionPopup ����---------------------------------------------------------------------------
    // 1. �ϴ� ������ �ʿ���� 0
    // 2. �����θ� ����Ʈ�� �ھ� 0
    // 3. ������ �ְ� 0
    // 4. �ؽ�Ʈ ���� 0
    // 5. �ѷ��ֱ� �ؾߴ� 0
    // 6. Destroy 0
    [SerializeField] private Text titleText;
    [SerializeField] private Text teeniepingNameText;
    [SerializeField] private Text collectionRewardText;
    [SerializeField] private Text mainDescriptionText;
    [SerializeField] private Text subDescriptionText;
    [SerializeField] private Text teeniepingStoryText;

    [SerializeField] private Text totalOnText;
    [SerializeField] private Text ownOffText;

    [SerializeField] private Image teeniepingIconImage;
    [SerializeField] private ScrollRect totalScrollRect;
    [SerializeField] private GameObject totalScrollViewObj;

    [SerializeField] private RectTransform teeniepingIconRect;

    public System.Action<int> OnTeeniepingButtonClickEvent;
    public System.Action OnTeeniepingSelectClickEvent;
    
    private void TeeniepingCollectionInit()
    {
        TotalTeeniepingScrollViewController();
        TweenEffect_TeeniepingIcon();
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
        }
    }
    private void TeeniepingCollectionTextRefresh()
    {
        totalOnText.text = DataService.Instance.GetText(58);
        ownOffText.text = DataService.Instance.GetText(59);
        collectionRewardText.text = DataService.Instance.GetText(57);
    }
    private void TeeniepingInfoRefresh(int id)
    {
        var teeniepingData = DataService.Instance.GetData<Table.TiniffingCollectionTable>(id);
        teeniepingNameText.text = DataService.Instance.GetText(teeniepingData.name_text_id);
        teeniepingStoryText.text = DataService.Instance.GetText(teeniepingData.title_description_text_id);
        mainDescriptionText.text = DataService.Instance.GetText(teeniepingData.main_description_text_id);
        subDescriptionText.text = DataService.Instance.GetText(teeniepingData.sub_description_text_id);
        var resourceData = DataService.Instance.GetData<Table.ResourceTable>(teeniepingData.teenieping_description_resource_id);
        teeniepingIconImage.sprite = Resources.Load<Sprite>("Images/Resource/" + resourceData.resource_name);
    }
   
    private void OnRefresh()
    {
        teeniepingCatchDisplayNextText.text = DataService.Instance.GetText(62);

        TeeniepingCollectionInit();
        TeeniepingCollectionTextRefresh();
        TeeniepingInfoRefresh(0);
    }
}
