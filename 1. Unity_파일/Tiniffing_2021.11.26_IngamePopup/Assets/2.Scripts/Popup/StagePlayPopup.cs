using System;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using DG.Tweening;
using Spine.Unity;
using System.Collections;


public class StagePlayPopup : BasePopup
{
    [SerializeField] private Text stage_no; // StageGroup prefab���� ���� �Ѱ� �޾ƾ���
    [SerializeField] private Text buyText1;
    [SerializeField] private Text buyText2;
    [SerializeField] private Text buyText3;
    [SerializeField] private Text hintPoleText;
    [SerializeField] private Text timeStopText;
    [SerializeField] private Text protectBraceletText;
    [SerializeField] private Text hintPoleCountText;
    [SerializeField] private Text timeStopCountText;
    [SerializeField] private Text protectBraceletCountText;
    [SerializeField] private Text protectBraceletSpeechBubbleText;
    [SerializeField] private Text teeniepingMindGetConditionText;
    [SerializeField] private Text haveText;
    [SerializeField] private Text notHaveText;
    [SerializeField] private Text exTitleText;

    [SerializeField] private GameObject protectBraceletActiveCheckObj;
    [SerializeField] private GameObject usingObj;
    [SerializeField] private GameObject unUsingObj;
    [SerializeField] private GameObject protectionBraceletSpeechBubbleObj;

    [SerializeField] private Image teeniepingMindImage;
    


    [SerializeField] private RectTransform closeButtonRect;
    [SerializeField] private RectTransform groupRect;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    // Init Display

    [SerializeField] private RectTransform hintPoleRectTr;
    [SerializeField] private RectTransform timeStopRectTr;
    [SerializeField] private RectTransform protectionBraceletRectTr;


    // EX Display

    [SerializeField] private RectTransform checkRect;
    [SerializeField] private GameObject exHitobj;
    [SerializeField] private RectTransform handRect;
    [SerializeField] private RectTransform maskRect;
    [SerializeField] private GameObject blindObj;
    [SerializeField] private RectTransform cloud_1_Rect;
    [SerializeField] private RectTransform cloud_2_Rect;
    [SerializeField] private RectTransform cloud_3_Rect;
    [SerializeField] private RectTransform cloudImageRect_1;
    [SerializeField] private RectTransform cloudImageRect_2;
    [SerializeField] private RectTransform cloudImageRect_3;
    [SerializeField] private GameObject cloudEffectObj_1;
    [SerializeField] private GameObject cloudEffectObj_2;
    [SerializeField] private GameObject cloudEffectObj_3;
    [SerializeField] private RectTransform ex_TeeniepingImageRectTr;
    
    
    private Sequence exSequence;
    private Sequence exTeeniepingSequence;
    private Sequence exEffectSequence;


    // Tutorial    

    [SerializeField] private GameObject stagePlayPopup_Tutorial_Obj;

    [SerializeField] private GameObject heartsping0Obj;
    [SerializeField] private GameObject heartsping1Obj;

    [SerializeField] private GameObject tutorialSpeechBubble0Obj;
    [SerializeField] private GameObject tutorialSpeechBubble1Obj;

    [SerializeField] private Text tutorialSpeechBubble0Text;
    [SerializeField] private Text tutorialSpeechBubble1Text;

    [SerializeField] private GameObject tutorialSpeechBubble0_NextTextObj;
    [SerializeField] private GameObject tutorialSpeechBubble1_NextTextObj;

    [SerializeField] private GameObject mask0;
    [SerializeField] private GameObject mask1;
    [SerializeField] private GameObject mask2;
    [SerializeField] private GameObject mask3;
    [SerializeField] private GameObject mask4;
    [SerializeField] private GameObject mask5;
    [SerializeField] private GameObject mask6;

    [SerializeField] private GameObject arrow;

    [SerializeField] private RectTransform handRectTr;
    [SerializeField] private RectTransform handRectTr_Clone;

    [SerializeField] private GameObject startButtonMaskEffectObj;

    [SerializeField] private GameObject touchScreen;
    [SerializeField] private GraphicRaycaster canvasGroupGraphicRacyCaster;


    private Sequence arrowSequence;
    private Sequence handSequence;

    private bool isTouchScreenClick = false;
    private bool isProtectBraceletCheck=false;

    private int click_stage_number;
    private int click_chapter_number;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        TweenEffect_CloseButton(closeButtonRect);
        PopTweenEffect_Nomal(groupRect);

        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 2)
        {
            EX_TeeniepingTween_Effect();
            Cloud_EX();
        }
        else if (lobbyTable.mode_type==3)
        {
            EX_TeeniepingTween_Effect();
            Shadow_EX();
        }
        else
        {
            EX_TeeniepingTween_Normal();
            Normal_Ex();           
        }

        var tutorialTable = DataService.Instance.GetData<Table.TutorialTable>(0);
        if(tutorialTable.check2==0)
        {
            StartCoroutine(Tutorial());
        }
    }
    protected override void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        base.TweenEffect_CloseButton(closeButtonRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    // ------------------------------------------------------------------Init Tween Display--------------------------------------------------------------------
    // 1. stage ���� ����
    // 2. �̼� ����
    // 3. ������ �ν����� Ŀ����
    // 4. ��ŸƮ ����
    // ����Ʈ ���� ������ ���׻��� , ��ŸƮ ȸ��ȸ��

    [SerializeField] private RectTransform titleRectTr;
    [SerializeField] private RectTransform teeniepingMindMissionRectTr;

    [SerializeField] private RectTransform hintPoleGroupRectTr; 
    [SerializeField] private RectTransform timeStopGroupRectTr; 
    [SerializeField] private RectTransform protectionBraceletGroupRectTr; 


    Sequence hintPoleSequence;
    Sequence timeStopSequence;
    Sequence protectionBraceletSequence;

    private void MissionTweenDisplay()
    {
        teeniepingMindMissionRectTr.DOScale(new Vector2(1.2f, 1.2f), 1f).OnComplete(() =>
        {
            teeniepingMindMissionRectTr.DOScale(new Vector2(1f, 1f), 1f);
        });
    }
    private void TitleTweenDisplay()
    {
        titleRectTr.DOScale(new Vector2(1.2f, 1.2f), 1f).OnComplete(() =>
        {
            titleRectTr.DOScale(new Vector2(1f, 1f), 1f);
        });
    }
    private void ItemGroupTweenDisplay()
    {
        hintPoleGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 1f).OnComplete(() =>
        {
            hintPoleGroupRectTr.DOScale(new Vector2(1f, 1f), 1f);
        });
        timeStopGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 1f).OnComplete(() =>
        {
            hintPoleGroupRectTr.DOScale(new Vector2(1f, 1f), 1f);
        });
        protectionBraceletGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 1f).OnComplete(() =>
        {
            hintPoleGroupRectTr.DOScale(new Vector2(1f, 1f), 1f);
        });
    }


    private void HintPoleDefaultTween()
    {
        hintPoleSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(hintPoleRectTr.DOScale(new Vector2(1.1f,1.1f),0.3f)).SetLoops(2,LoopType.Yoyo).SetDelay(5f).OnComplete(() =>
        {
            hintPoleRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                hintPoleSequence.Restart();
            });
        });
    }
    private void TimeStopDefaultTween()
    {
        timeStopSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(timeStopRectTr.DOScale(new Vector2(1.1f,1.1f),0.3f)).SetLoops(2,LoopType.Yoyo).SetDelay(5f).OnComplete(() =>
        {
            timeStopRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                timeStopSequence.Restart();
            });
        });
    }
    private void ProtectionBraceletDefaultTween()
    {
        protectionBraceletSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(protectionBraceletRectTr.DOScale(new Vector2(1.1f,1.1f),0.3f)).SetLoops(2,LoopType.Yoyo).SetDelay(5f).OnComplete(() =>
        {
            protectionBraceletRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                protectionBraceletSequence.Restart();
            });
        });
    }


    // -----------------------------------------------------------------------------EX Display -----------------------------------------------------------------------------
    private void EX_TeeniepingTween_Effect()
    {
        exTeeniepingSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(ex_TeeniepingImageRectTr.DOScale(new Vector2(1.1f, 1.1f), 0.3f).SetLoops(6, LoopType.Yoyo)).SetDelay(2f).OnComplete(() =>
        {
            ex_TeeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                exTeeniepingSequence.Restart();
            });
        });
    }
    private void EX_TeeniepingTween_Normal()
    {
        exTeeniepingSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(ex_TeeniepingImageRectTr.DOScale(new Vector2(1.1f, 1.1f), 0.3f).SetLoops(6, LoopType.Yoyo)).SetDelay(1.5f).OnComplete(() =>
        {
            ex_TeeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                exTeeniepingSequence.Restart();
            });
        });
    }

    private void Normal_Ex()
    {
        Vector2 defaultPos = handRect.anchoredPosition;
        Vector2 plusPos = new Vector2(-15f, 24f);
        exSequence = DOTween.Sequence()
        .Insert(1.5f, handRect.GetComponent<Image>().DOFade(1, 0.5f))//�հ��� ����
        .Insert(2f, handRect.DOAnchorPos(defaultPos + plusPos, 0.5f))//�հ��� �̵�
        .Insert(2.5f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(2.7f, () => NormalCheckEffectOn())
        .Insert(2.8f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(3.1f, handRect.GetComponent<Image>().DOFade(0, 0.5f))//�հ��� ��
        .Insert(2.8f, checkRect.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.9f, checkRect.DOScale(new Vector2(0.5f, 0.5f), 0.1f))
        .Insert(3f, checkRect.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .InsertCallback(3.5f, () => NormalCheckEffectOff()).OnComplete(() =>
        {
            exSequence.Restart();
        });

    }
    private void NormalCheckEffectOn()//�븻 ����
    {
        checkRect.GetComponent<Image>().DOFade(1, 0f);
        exHitobj.SetActive(true);
    }
    private void NormalCheckEffectOff()//�븻 ����
    {
        checkRect.GetComponent<Image>().DOFade(0, 0.5f);
        exHitobj.SetActive(false);
    }
    private void Cloud_EX()
    {
        Vector2 defaultPos = handRect.anchoredPosition;//�� �⺻ ��ġ x96, y-40
        Vector2 plusPos_1 = new Vector2(+58f, +10f); //2�� ���� �̵�
        Vector2 plusPos_2 = new Vector2(+96f, +16f); //1�� ���� �̵�
        Vector2 plusPos_3 = new Vector2(-5f, +23f); //3�� ���� �̵�
        Vector2 plusPos_4 = new Vector2(-80f, +38f); //���� �̵�

        Vector2 minusHandRectPos = new Vector2(20f, -20f);

        exSequence = DOTween.Sequence()
        .Insert(1f, cloudImageRect_1.GetComponent<Image>().DOFade(1, 0.5f))//����_1 ���̵� ��
        .Insert(1f, cloudImageRect_2.GetComponent<Image>().DOFade(1, 0.5f))//����_2 ���̵� ��
        .Insert(1f, cloudImageRect_3.GetComponent<Image>().DOFade(1, 0.5f))//����_3 ���̵� ��
        .Insert(1.3f, handRect.GetComponent<Image>().DOFade(1, 0.5f))//�հ��� ���̵� ��
        .Insert(1.8f, handRect.DOAnchorPos(cloud_2_Rect.anchoredPosition + minusHandRectPos, 0.8f).SetEase(Ease.Linear))//2�� ���� �̵�
        .Insert(2.6f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(2.7f, () => CloudEffectOn_2())//����Ʈ ȣ��
        .Insert(2.9f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(3.2f, handRect.DOAnchorPos(cloud_1_Rect.anchoredPosition + minusHandRectPos, 0.8f).SetEase(Ease.Linear))//1�� ���� �̵�
        .Insert(4.2f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(4.3f, () => CloudEffectOn_1())//����Ʈ ȣ��
        .Insert(4.5f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(4.8f, handRect.DOAnchorPos(cloud_3_Rect.anchoredPosition + minusHandRectPos, 0.8f).SetEase(Ease.Linear))//3�� ���� �̵�
        .Insert(5.6f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(5.7f, () => CloudEffectOn_3())//����Ʈ ȣ��
        .Insert(5.9f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(6.2f, handRect.DOAnchorPos(checkRect.anchoredPosition + minusHandRectPos, 0.3f).SetEase(Ease.Linear))//���� �̵�
        .Insert(7f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(7.1f, () => FindEffect_Cloud())//����Ʈ ȣ��
        .Insert(7.2f, checkRect.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(7.3f, checkRect.DOScale(new Vector2(0.5f, 0.5f), 0.1f))
        .Insert(7.4f, checkRect.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(7.3f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(7.6f, handRect.GetComponent<Image>().DOFade(0, 0.5f))//�հ��� ���̵� �ƿ�
        .InsertCallback(8.3f, () => checkRectFadeOut()).OnComplete(() =>
        {
            exSequence.Restart();
        });

    }
    private void CloudEffectOn_1()//���� ����
    {
        exEffectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            cloudEffectObj_1.SetActive(true);
        }).SetDelay(5f).OnComplete(() =>
        {
            cloudEffectObj_1.SetActive(false);
        })
        .Join(cloudImageRect_1.DOScale(new Vector2(0.48f, 0.48f), 0.1f).OnComplete(() =>
        {
            cloudImageRect_1.DOScale(new Vector2(0.0001f, 0.0001f), 0.3f);
        }))
        .Insert(3f, cloudImageRect_1.GetComponent<Image>().DOFade(0, 0f))//����_1 ���̵� �ƿ�
        .Insert(3f, cloudImageRect_1.DOScale(new Vector2(0.33f, 0.33f), 0f));
    }
    private void CloudEffectOn_2()//���� ����
    {
        exEffectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            cloudEffectObj_2.SetActive(true);
        }).SetDelay(5f).OnComplete(() =>
        {
            cloudEffectObj_2.SetActive(false);
        })
        .Join(cloudImageRect_2.DOScale(new Vector2(0.4f, 0.4f), 0.1f).OnComplete(() =>
        {
            cloudImageRect_2.DOScale(new Vector2(0.0001f, 0.0001f), 0.3f);
        }))
        .Insert(3f, cloudImageRect_2.GetComponent<Image>().DOFade(0, 0f))//����_2 ���̵� �ƿ�
        .Insert(3f, cloudImageRect_2.DOScale(new Vector2(0.3f, 0.3f), 0f));
    }
    private void CloudEffectOn_3()//���� ����
    {
        exEffectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            cloudEffectObj_3.SetActive(true);
        }).SetDelay(5f).OnComplete(() =>
        {
            cloudEffectObj_3.SetActive(false);
        })
        .Join(cloudImageRect_3.DOScale(new Vector2(0.55f, 0.55f), 0.1f).OnComplete(() =>
        {
            cloudImageRect_3.DOScale(new Vector2(0.0001f, 0.0001f), 0.3f);
        }))
        .Insert(3f, cloudImageRect_3.GetComponent<Image>().DOFade(0, 0f))//����_3 ���̵� �ƿ�
        .Insert(3f, cloudImageRect_3.DOScale(new Vector2(0.4f, 0.4f), 0f));
    }
    private void FindEffect_Cloud()//���� ����
    {
        exEffectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            checkRect.GetComponent<Image>().DOFade(1, 0f);
            exHitobj.SetActive(true);
        }).SetDelay(5f).OnComplete(() =>
        {
            exHitobj.SetActive(false);
        });
    }
    private void checkRectFadeOut() //���� ����
    {
        checkRect.GetComponent<Image>().DOFade(0, 0.5f);
    }
    private void Shadow_EX()
    {
        Vector2 defaultPos = handRect.anchoredPosition;
        Vector2 plusPos = new Vector2(-15f, 24f);
        float maskDefaultPosX = maskRect.anchoredPosition.x;
        float maskDefaultPosY = maskRect.anchoredPosition.y;
        float XPos_1 = maskDefaultPosX + 42.5f;
        float YPos_1 = maskDefaultPosY + -14;
        float XPos_2 = XPos_1 + -42.5f;
        float YPos_2 = YPos_1 + -15f;
        float XPos_3 = XPos_2 + 62.5f;
        float YPos_3 = YPos_2 + 15f;
        float XPos_4 = XPos_3 - 0f;
        float YPos_4 = YPos_3 + 1f;
        float XPos_5 = XPos_4 - 62.5f;
        float YPos_5 = XPos_4 + -64f;
        exSequence = DOTween.Sequence()
        .InsertCallback(0f, () => ShadowOn())
        .Insert(0f, maskRect.DOAnchorPosX(-XPos_1, 1f).SetEase(Ease.OutQuad))//x_4/1
        .Insert(0f, maskRect.DOAnchorPosY(YPos_1, 1f).SetEase(Ease.InQuad))//y_4/1
        .Insert(1f, maskRect.DOAnchorPosX(XPos_2, 1f).SetEase(Ease.InQuad))//x_4/2
        .Insert(1f, maskRect.DOAnchorPosY(YPos_2, 1f).SetEase(Ease.OutQuad))//y_4/2
        .Insert(2f, maskRect.DOAnchorPosX(XPos_3, 1f).SetEase(Ease.OutQuad))//x_4/3
        .Insert(2f, maskRect.DOAnchorPosY(YPos_3, 1f).SetEase(Ease.InQuad))//y_4/3
        .Insert(3f, maskRect.DOAnchorPosX(XPos_4, 1f).SetEase(Ease.InQuad))//x_4/4
        .Insert(3f, maskRect.DOAnchorPosY(YPos_4, 0.3f).SetEase(Ease.Linear))//y_4/4
        .Insert(4f, handRect.GetComponent<Image>().DOFade(1, 0.5f))//�հ��� ����
        .Insert(4.5f, handRect.DOAnchorPos(defaultPos + plusPos, 0.5f))//�հ��� �̵�
        .Insert(5f, handRect.DORotate(new Vector3(0, 0, 11), 0.3f))//�հ��� Ŭ��
        .InsertCallback(5.2f, () => ShadowCheckEffectOn())
        .Insert(5.3f, handRect.DORotate(new Vector3(0, 0, 0), 0.3f))//�հ��� Ŭ�� ����
        .Insert(5.6f, handRect.GetComponent<Image>().DOFade(0, 0.5f))//�հ��� ��
        .Insert(5.7f, maskRect.DOAnchorPosX(XPos_5, 1f).SetEase(Ease.InQuad))//�ǵ��� ����
        .Insert(5.7f, maskRect.DOAnchorPosY(YPos_5, 1f).SetEase(Ease.OutQuad))//�ǵ��� ����
        .InsertCallback(6.7f, () => ShadowCheckEffectOff()).OnComplete(() =>
        {
            exSequence.Restart();
        });
    }
    private void ShadowOn()//������ ����
    {
        maskRect.gameObject.SetActive(true);
        blindObj.SetActive(true);
    }
    private void ShadowCheckEffectOn()//������ ����
    {
        checkRect.GetComponent<Image>().DOFade(1, 0f);
    }
    private void ShadowCheckEffectOff()//������ ����
    {
        checkRect.GetComponent<Image>().DOFade(0, 0.5f);
    }

    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);

        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
  
    public void OnPlayButtonClick()
    {
        var tutorialTable = DataService.Instance.GetData<Table.TutorialTable>(0);
        if(tutorialTable.check2==0)
        {
            tutorialTable.check2 = 1;
            DataService.Instance.UpdateData(tutorialTable);
            mask6.SetActive(false);
        }
        LocalValue.Map_H = 0; // map check �ʱ�ȭ
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(false);
            exSequence.Pause();
        }

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        if (saveTable.heart_count > 0)
            LoadingSceneController.Instance.LoadInGameScene_H("InGameScene_H", click_chapter_number, click_stage_number);
        else
        {
            PopupContainer.CreatePopup(PopupType.InsufficientHeartPopup).Init();
        }
        
        if(LocalValue.isLatestFinalStage) // ������ �������� ���� �絵�� ��ư�� ������ ���� �÷��� ��ư���� �������� ||  �絵�������ʰ� �˾� �� �� �ٸ� �������� ��ư�� Ŭ���ؼ� �÷��̽�
        {
            LocalValue.isLatestFinalStage = false; // �ʱ�ȭ
        }
    }
    public void OnHintPoleBuyButtonClick()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(false);
            exSequence.Pause();
        }
        PopupContainer.SetNameData("HintPole");
        PopupContainer.CreatePopup(PopupType.ItemPurchasePopup).Init();
    }
    public void OnTimeStopBuyButtonClick()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(false);
            exSequence.Pause();
        }
        PopupContainer.SetNameData("TimeStop");
        PopupContainer.CreatePopup(PopupType.ItemPurchasePopup).Init();
    }
    public void OnProtectBraceletBuyButtonClick()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(false);
            exSequence.Pause();
        }
        PopupContainer.SetNameData("ProtectionBracelet");
        PopupContainer.CreatePopup(PopupType.ItemPurchasePopup).Init();
    }
    public void OnDescriptionButtonClick()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(false);
            exSequence.Pause();
        }
        Debug.LogError("description click");
        PopupContainer.CreatePopup(PopupType.ItemDescriptionPopup).Init();
    }
    // ----------------------------------------------------------------------------- Tutorial -----------------------------------------------------------------------------
    IEnumerator Tutorial()
    {
        stagePlayPopup_Tutorial_Obj.SetActive(true);
        Tutorial_Step0();
        yield return new WaitUntil(()=>isTouchScreenClick);
        Tutorial_Step1();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step2();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step3();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step4();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step5();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step6();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step7();
        yield return new WaitUntil(() => isTouchScreenClick);
        Tutorial_Step8();
    }
    private void Tutorial_Step0()
    {
        heartsping0Obj.SetActive(true);
        tutorialSpeechBubble0Obj.SetActive(true);
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(962), 1.5f).SetEase(Ease.Linear).OnComplete(() => { tutorialSpeechBubble0_NextTextObj.SetActive(true); });

    }

    private void Tutorial_Step1()
    {
        isTouchScreenClick = false;
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(963), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask0.SetActive(true);
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
        });
    } 
    private void Tutorial_Step2()
    {
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOKill();
        isTouchScreenClick = false;
        mask0.SetActive(false);
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(964), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
            mask1.SetActive(true);
        });

    }
    private void Tutorial_Step3()
    {
        isTouchScreenClick = false;
        mask1.SetActive(false);
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(965), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask2.SetActive(true);
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
        });
    }
    private void Tutorial_Step4()
    {
        mask2.SetActive(false);
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        isTouchScreenClick = false;
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(966), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask3.SetActive(true);
            tutorialSpeechBubble1_NextTextObj.SetActive(true);
        });
    }
    private void Tutorial_Step5()
    {
        mask3.SetActive(false);
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        isTouchScreenClick = false;
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(967), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask4.SetActive(true);
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
        });
    } 
    private void Tutorial_Step6()
    {
        mask4.SetActive(false);
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        isTouchScreenClick = false;
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(968), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask5.SetActive(true);
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
        });
    } 
    private void Tutorial_Step7()
    {
        tutorialSpeechBubble0Text.text = "";
        tutorialSpeechBubble0Text.DOKill();
        tutorialSpeechBubble0_NextTextObj.SetActive(false);
        isTouchScreenClick = false;
        tutorialSpeechBubble0Text.DOText(DataService.Instance.GetText(969), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            arrow.SetActive(true);
            ArrowMovementDisplay();
            ProtectionBraceletCheckOn();
            tutorialSpeechBubble0_NextTextObj.SetActive(true);
        });
    }
    private void Tutorial_Step8()
    {

        tutorialSpeechBubble1Obj.SetActive(true);
        heartsping0Obj.SetActive(false);
        tutorialSpeechBubble0Obj.SetActive(false);
        mask5.SetActive(false);
        arrow.SetActive(false);
        // protection bracelet check off
        protectBraceletActiveCheckObj.SetActive(false);
        usingObj.SetActive(false);
        unUsingObj.SetActive(true);
        protectionBraceletSpeechBubbleObj.SetActive(false);
        isTouchScreenClick = false;
        tutorialSpeechBubble1Obj.SetActive(true);
        heartsping1Obj.SetActive(true);
        tutorialSpeechBubble1Text.DOText(DataService.Instance.GetText(970), 1.68f).SetEase(Ease.Linear).OnComplete(() => 
        {
            mask6.SetActive(true);
            HandEffect();
            isTouchScreenClick = false;
            Destroy(canvasGroupGraphicRacyCaster);
        });
    }
   
    private void ArrowMovementDisplay()
    {
        RectTransform arrowRect = arrow.GetComponent<RectTransform>();
        float defaultPos = arrowRect.anchoredPosition.x;
        float movePos = -7f;

        arrowSequence = DOTween.Sequence()
        .Prepend(arrowRect.DOAnchorPosX(defaultPos + movePos, 0.45f)).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    
    private void HandEffect()//������ Ŭ��
    {
        handRectTr.gameObject.SetActive(true);
        handRectTr_Clone.gameObject.SetActive(true);
        handSequence = DOTween.Sequence()
        .Insert(0f, handRectTr.GetComponent<Image>().DOFade(1f, 1f).SetEase(Ease.Linear))
        .Insert(0f, handRectTr_Clone.GetComponent<Image>().DOFade(1f, 1f).SetEase(Ease.Linear))
        .Insert(1f, handRectTr.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(1f, handRectTr_Clone.DORotate(new Vector3(0, 180, 20), 0.35f).SetEase(Ease.InQuad).SetLoops(2, LoopType.Yoyo))
        .Insert(1.35f, handRectTr.GetComponent<Image>().DOFade(0f, 1f).SetEase(Ease.Linear))
        .Insert(1.35f, handRectTr_Clone.GetComponent<Image>().DOFade(0f, 1f).SetEase(Ease.Linear))
        .InsertCallback(1.36f, () => StartButtonMask_EffectOn())
        .InsertCallback(1.5f, () => StartButtonMask_EffectOff()).OnComplete(() =>
        {
            handSequence.Restart();
        });
    }
    private void StartButtonMask_EffectOn()
    {
        startButtonMaskEffectObj.SetActive(true);
    }
    private void StartButtonMask_EffectOff()
    {
        startButtonMaskEffectObj.SetActive(false);
    }
    // -----------------------------------------------------------------------------  -----------------------------------------------------------------------------
    public void OnProtectBraceletCheckButtonClick()
    {
        var protectBraceletData = DataService.Instance.GetData<Table.ItemTable>(2);

        //Ŭ���� ���¿��� Ŭ���� false  , ��Ŭ���� ���¿��� Ŭ���� true
        if (isProtectBraceletCheck)
        {
            protectBraceletActiveCheckObj.SetActive(false);
            protectionBraceletSpeechBubbleObj.SetActive(false);
            usingObj.SetActive(false);
            unUsingObj.SetActive(true);
            isProtectBraceletCheck = false;
            protectBraceletData.active = 0;
        }
        else
        {
            protectBraceletActiveCheckObj.SetActive(true);
            protectionBraceletSpeechBubbleObj.SetActive(true);
            usingObj.SetActive(true);
            unUsingObj.SetActive(false);
            isProtectBraceletCheck = true;
            protectBraceletData.active = 1;
        }
        DataService.Instance.UpdateData(protectBraceletData);
    }
    public void OnTouchScreenClick()
    {
        isTouchScreenClick = true;
    }
    private void TextRefresh()
    {
        var itemData = DataService.Instance.GetDataList<Table.ItemTable>();
        buyText1.text = DataService.Instance.GetText(22);
        buyText2.text = DataService.Instance.GetText(22);
        buyText3.text = DataService.Instance.GetText(22);

        teeniepingMindGetConditionText.text = DataService.Instance.GetText(27);
        protectBraceletSpeechBubbleText.text = DataService.Instance.GetText(26);

        exTitleText.text = DataService.Instance.GetText(90);
        haveText.text = DataService.Instance.GetText(88);
        notHaveText.text = DataService.Instance.GetText(89);

        hintPoleText.text = DataService.Instance.GetText(23);
        timeStopText.text = DataService.Instance.GetText(24);
        protectBraceletText.text = DataService.Instance.GetText(25);

        hintPoleCountText.text = string.Format("x{0}",itemData[0].count.ToString());
        timeStopCountText.text = string.Format("x{0}",itemData[1].count.ToString());
        protectBraceletCountText.text = string.Format("x{0}",itemData[2].count.ToString());
    }
    private void StageTextRefresh()
    {
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        if (LocalValue.isNextStageButtonClick) // �� ���ӿ��� ������������ ��ư �������
        {
            LocalValue.isNextStageButtonClick = false; //�ʱ�ȭ ����
            // ClickStage_H �� ����˾����� �̸� �÷��ش� , ���� �׳� ���� �ȴ�
            click_stage_number = LocalValue.Click_Stage_H;// Ŭ�� stage ����
            click_chapter_number = LocalValue.Click_Chapter_H; // Ŭ���� é�� ����
            stage_no.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString()); // text �� ����
        }
        else if(LocalValue.isStartButtonClick)
        {
            click_stage_number = saveData.stage_no;
            click_chapter_number = saveData.chapter_no;
            LocalValue.Click_Stage_H = click_stage_number;
            LocalValue.Click_Chapter_H = click_chapter_number;
            stage_no.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        }
        else // �絵�� ���������� �ƴϸ� �׳� stage box Ŭ��������
        {
            click_stage_number = LocalValue.Click_Stage_H;// Ŭ�� stage ����
            click_chapter_number = LocalValue.Click_Chapter_H; // Ŭ���� é�� ����
            stage_no.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString()); // text �� ����
        }
    }
    private void TeeniepingMindGetCheckSetting()
    {
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        var teeniepingCollectionData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == LocalValue.Click_Chapter_H);
        teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingCollectionData.mind_teenieping_name);
        if (lobbyTable.star_count==3)
        {
            haveText.gameObject.SetActive(true);
            notHaveText.gameObject.SetActive(false);
        }
        else
        {
            haveText.gameObject.SetActive(false);
            notHaveText.gameObject.SetActive(true);
            Color blockColor;
            ColorUtility.TryParseHtmlString("#939393", out blockColor);
            teeniepingMindImage.color = blockColor;
        }
    }
    private void ProtectionBraceletCheckOn()
    {
        protectBraceletActiveCheckObj.SetActive(true);
        isProtectBraceletCheck = true;
        usingObj.SetActive(true);
        unUsingObj.SetActive(false);
        protectionBraceletSpeechBubbleObj.SetActive(true);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        var itemData = DataService.Instance.GetDataList<Table.ItemTable>();
        TextRefresh();
        StageTextRefresh();
        SetSkeletonDataAsset();
        TeeniepingMindGetCheckSetting();
        // �����˾� ����ũ ����ó��
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        if (lobbyTable.mode_type == 3)
        {
            maskRect.gameObject.SetActive(true);
            exSequence.Play();
        }
        if (itemData[2].active==1)
        {
            ProtectionBraceletCheckOn();
        }
    }
    public override void Close()
    {
        base.Close();
        LocalValue.isStartButtonClick = false; //�ʱ�ȭ
    }

    private void OnDestroy()
    {
        LocalValue.isStartButtonClick = false; //�ʱ�ȭ
    }
   
}
