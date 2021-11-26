using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
using System.Collections;
using DG.Tweening;

public class InGameClearPopup : BasePopup
{
    [SerializeField] private Text goldText;
    [SerializeField] private Text retryText;
    [SerializeField] private Text rewardListText;
    [SerializeField] private Text nextStageText;
    [SerializeField] private Text starCoinText;
    [SerializeField] private Text stageNoText;

    [SerializeField] private Text getGoldCountText;
    [SerializeField] private Text getStarcoinCountText;
    [SerializeField] private Text adText;
    [SerializeField] private Text teeniepingNameText;
    [SerializeField] private Text teeniepingMindCountText;
    [SerializeField] private GameObject star1_Obj;
    [SerializeField] private GameObject star2_Obj;
    [SerializeField] private GameObject star3_Obj;
    [SerializeField] private Image teeniepingMindImage;
    [SerializeField] private RectTransform groupRect;
    [SerializeField] private SkeletonAnimation skeletonAnimation;
    // Clear Display-----------------------------------------------------------------
    [SerializeField] private RectTransform star1RectTr;//��Ÿ 1 ������Ʈ
    [SerializeField] private RectTransform star2RectTr;//��Ÿ 2 ������Ʈ
    [SerializeField] private RectTransform star3RectTr;//��Ÿ 3 ������Ʈ
    [SerializeField] private RectTransform teeniepingMind_MissionClear_TextImage_RectTr;//Ƽ���� �̼� �̹��� & ���� �������� �ؽ�Ʈ
    [SerializeField] private RectTransform teeniepingMind_GetCount_Group_RectTr;//���� ���� �׷�
    [SerializeField] private RectTransform teeniepingMind_GetCount_Text_RectTr;//���� ���� �ؽ�Ʈ
    [SerializeField] private RectTransform teeniepingMind_MissionClear_Image_RecrtTr;//Ƽ���� �̹���
    [SerializeField] private RectTransform goldRewardGroupRectTr;//��� ���� �׷�
    [SerializeField] private RectTransform starCoinRewardGroupRectTr;//��Ÿ ���� �׷�
    [SerializeField] private RectTransform teeniepingMindRewardGroupRectTr;//Ƽ���� ���� �׷�
    [SerializeField] private RectTransform goldRewardRectTr;//��� ���� ������
    [SerializeField] private RectTransform starCoinRewardRectTr;//��Ÿ ���� ������
    [SerializeField] private RectTransform teeniepingMindRewardRectTr;//Ƽ���� ���� ������
    [SerializeField] private RectTransform ArrowSignGroupRectTr;//���� ��ư �׷�
    [SerializeField] private RectTransform nextStageButtonRectTr;//���� �������� ��ư
    [SerializeField] private RectTransform retryButtonRectTr;//�絵�� ��ư
    private Sequence starSequence_1;
    private Sequence starSequence_2;

    private int click_stage_number;
    private int click_chapter_number;
    private int now_StarCount;
    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
        now_StarCount = LocalValue.Now_StarCount;
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);
        Debug.Log("111111111111");

        if (now_StarCount == 3)
        {
            Debug.Log("now star count : "+ now_StarCount);

            StartCoroutine(CharacterSpineDisplay_3_Star());
            Debug.Log("111111111111");

        }
        
        if (now_StarCount == 3) { }
        if (now_StarCount == 3)
        {
            if (lobbyData.retry == 1) // �絵���� ���� ���
            {
                if (lobbyData.star_count == 3) // ���� ������ 3��Ŭ�� �߾���. => Ƽ���� ������ ȹ���� ����
                {
                    MissionClearDisplay_Fine();
                    return;
                }
                
            }
            else // �̹��� ó������ 3��Ŭ �� �����̴�
            {
                MissionClearDisplay_Perfect();
                Debug.Log("111111111111");
                return;
            }

            // ó�� �����ؼ� �ٷ� 3��Ŭ => ���ѿ���

        }
        else // ��� �� 3��Ŭ�� �ƴϾ�
        {
            if (lobbyData.retry == 1 && lobbyData.star_count == 3) // ���ſ� �̹� ���ε带 ȹ���߾�
            {
                MissionClearDisplay_Fine();
                return;
            }
            else // �� �絵���� �ߵ� ���� ���ſ��� ���ݵ� 3��Ŭ�� ���߾�
            {
                MissionFailDisplay_Bad();
                return;
            }
        }


    }

    protected override void PopTweenEffect_Nomal(RectTransform groupRect)

    {
        base.PopTweenEffect_Nomal(groupRect);
    }

    //-------------------------------------------------------------------------------------------- Display ------------------------------------------------------------------------------------------
    private Sequence perfectSequence;
    private void MissionClearDisplay_Perfect()//���� 3�� Ŭ ���, ���� ������ ���� �̼� Ŭ���� ������ ���� ������ ������, Ƽ������ ������ ȸ���ϸ鼭 ���´�. �׸��� ���� ��� �� ��, ��� ���������� ����
    {
        perfectSequence = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1�� ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 1��
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//�� 1��
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2�� ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 2��
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//�� 2��
        {
            star3RectTr.GetComponent<GameObject>().SetActive(true);//3�� ON
        })
        .Insert(0.6f, star3RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 3��
        .Insert(0.6f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�̼� Ŭ���� ����
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//���� ����
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//�� 3��
        .Insert(0.7f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//�̼� Ŭ���� ����
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//���� ����
        .InsertCallback(0.8f, () => teeniepingMind_MissionClearImageEffectOn())
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DORotate(new Vector2(0, 360f * 5f), 0.5f, RotateMode.LocalAxisAdd))//Ƽ���� �̹��� ȸ��
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1f, 1f), 0.5f).SetEase(Ease.InSine))//Ƽ���� �̹��� ũ��
        .InsertCallback(1.3f, () => teeniepingMind_MissionClearImageEndEffectOn())
        .Insert(1.4f, teeniepingMind_GetCount_Text_RectTr.DORotate(new Vector3(360f * 2f, 0f, 0f), 0.2f, RotateMode.LocalAxisAdd))//���� ���� ȸ��
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.8f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.9f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.1f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.4f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.5f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.6f, ArrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.8f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999,LoopType.Yoyo));
    }
    private void teeniepingMind_MissionClearImageEffectOn()
    {
        //Ƽ���� �̹��� ����Ʈ �־����
    }
    private void teeniepingMind_MissionClearImageEndEffectOn()
    {
        //Ƽ���� ȸ���� ������ �� ������ ����Ʈ �־����
    }
    private void MissionClearDisplay_Fine()//���� 3�� Ŭ ���
    {
        //if������ �� üũ
        /*if (now_StarCount == 1)
        {
            starSequence_1 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.GetComponent<GameObject>().SetActive(true);//1�� ON
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 1��
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//�� 1��
        }
        if (now_StarCount == 2)
        {
            starSequence_2 = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1�� ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 1��
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//�� 1��
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2�� ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 2��
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//�� 2��
        }*/
        perfectSequence = DOTween.Sequence()
        .Insert(0.6f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�̼� Ŭ���� ����
        .Insert(0.6f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//���� ����
        .Insert(0.7f, star3RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//�� 3��
        .Insert(0.7f, teeniepingMind_MissionClear_TextImage_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//�̼� Ŭ���� ����
        .Insert(0.7f, teeniepingMind_GetCount_Group_RectTr.DOScale(new Vector2(1f, 1f), 0.1f))//���� ����
        .InsertCallback(0.8f, () => teeniepingMind_MissionClearImageEffectOn())
        .Insert(0.8f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).SetEase(Ease.InSine))//Ƽ���� �̹��� ũ��
        .Insert(0.9f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(0.8f, 0.8f), 0.1f).SetEase(Ease.InSine))//Ƽ���� �̹��� ũ��
        .Insert(1f, teeniepingMind_MissionClear_Image_RecrtTr.transform.DOScale(new Vector2(1f, 1f), 0.1f).SetEase(Ease.InSine))//Ƽ���� �̹��� ũ��
        .InsertCallback(1.3f, () => teeniepingMind_MissionClearImageEndEffectOn())
        .Insert(1.4f, goldRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.6f, goldRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(1.7f, goldRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(1.8f, starCoinRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(1.9f, starCoinRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2f, starCoinRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.1f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))
        .Insert(2.2f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(0.8f, 0.8f), 0.1f))
        .Insert(2.3f, teeniepingMindRewardGroupRectTr.DOScale(new Vector2(1f, 1f), 0.1f))
        .Insert(2.4f, ArrowSignGroupRectTr.DOAnchorPosX(0, 1.2f)).SetEase(Ease.Linear)
        .Insert(3.6f, nextStageButtonRectTr.DOAnchorPosX(527f, 0.3f).SetLoops(99999999, LoopType.Yoyo));
    }
    private void MissionFailDisplay_Bad()//������ ���а� �ƴ� Ƽ���� ������ ȹ�� ���� ���п��� �� üũ �������
    {
        if (now_StarCount == 1)
        {
            starSequence_1 = DOTween.Sequence()
            .OnStart(() =>
            {
                star1RectTr.GetComponent<GameObject>().SetActive(true);//1�� ON
            })
            .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 1��
            .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//�� 1��
        }
        if (now_StarCount == 2)
        {
            starSequence_2 = DOTween.Sequence()
        .OnStart(() =>
        {
            star1RectTr.GetComponent<GameObject>().SetActive(true);//1�� ON
        })
        .Insert(0.1f, star1RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 1��
        .Insert(0.2f, star1RectTr.DOScale(new Vector2(1f, 1f), 0.1f)).OnComplete(() =>//�� 1��
        {
            star2RectTr.GetComponent<GameObject>().SetActive(true);//2�� ON
        })
        .Insert(0.3f, star2RectTr.DOScale(new Vector2(1.2f, 1.2f), 0.1f))//�� 2��
        .Insert(0.4f, star2RectTr.DOScale(new Vector2(1f, 1f), 0.1f));//�� 2��
        }
    }
    // ĳ���� 3��Ŭ ������ �ִϸ��̼� ����
    IEnumerator CharacterSpineDisplay_3_Star()
    {
        while (true)
        {
            skeletonAnimation.AnimationName = "Clear";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(2.7f);
            skeletonAnimation.AnimationName = "Idle1";
            skeletonAnimation.Initialize(true);
            yield return YieldInstructionCache.WaitForSeconds(10f);
        }
    }
    // Init Setting
    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.AnimationName = "Idle1";
        skeletonAnimation.Initialize(true);
    }
    public void OnLoobyGoButtonClick()
    {
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H"); // �ε��� ���� 
    }

    public void OnRetryButtonClick() // clear �� retry �� �κ�� ���� �˾��� ����
    {
        LocalValue.isRetryButtonClick = true; // �κ� �Ŵ������� ���ǹ��� ����� ����
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");

    }
    public void OnNextStageButtonClick()
    {

        LocalValue.Click_Stage_H = click_stage_number + 1; // ���������� ����
        LocalValue.Click_Chapter_H = click_chapter_number; // é�ʹ� �״��
        LocalValue.isNextStageButtonClick = true;  // �κ񿡼� ���� �������� �˾��� ���� �� �ֵ���
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    private void StarObjectActiveController()
    {
        switch (LocalValue.Now_StarCount)
        {
            case 1:
                star1_Obj.SetActive(true);
                break;
            case 2:
                star1_Obj.SetActive(true);
                star2_Obj.SetActive(true);
                break;
            case 3:
                star1_Obj.SetActive(true);
                star2_Obj.SetActive(true);
                star3_Obj.SetActive(true);
                break;
        }
    }
    private void TextRefresh(Table.SaveTable saveTable, Table.TiniffingCollectionTable teeniepingData)
    {
        nextStageText.text = string.Format("{0}\n{1}", DataService.Instance.GetText(2), (click_stage_number + 1).ToString());
        stageNoText.text = string.Format("{0} {1}", DataService.Instance.GetText(2), click_stage_number.ToString());
        goldText.text = DataService.Instance.GetText(18);
        starCoinText.text = DataService.Instance.GetText(19);
        rewardListText.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);
        getStarcoinCountText.text = string.Format("x{0}", LocalValue.Get_StarCoin.ToString()); // ȹ���� ��Ÿ���� ��
        getGoldCountText.text = string.Format("x{0}", LocalValue.Get_Gold.ToString());
        adText.text = DataService.Instance.GetText(21);
        teeniepingNameText.text = string.Format("{0}{1}", DataService.Instance.GetText(teeniepingData.name_text_id), DataService.Instance.GetText(80));
        if (LocalValue.isTeeniepingMindGet)
            teeniepingMindCountText.text = string.Format("x{0}", 1);
        else
            teeniepingMindCountText.text = string.Format("x{0}", 0);
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        // ������������ ��ưŬ�������� �� ����
        click_stage_number = LocalValue.Click_Stage_H;
        click_chapter_number = LocalValue.Click_Chapter_H;
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == click_chapter_number);
        teeniepingMindImage.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingMind/" + teeniepingData.mind_teenieping_name);
        TextRefresh(saveTable, teeniepingData);
        SetSkeletonDataAsset();
        StarObjectActiveController();
        // �ֽ� ���������� Ŭ������ ���� �ƴҶ� -> �������
        if (saveTable.stage_no != LocalValue.Click_Stage_H + 1) // ��� Ŭ�����ؼ� GameManager���� stage_no ++ �� ������ ���� ����� ���ǹ�
        {
            return;
        }

        LocalValue.isStageClear = true; // �κ�Ŵ������� ���� ���θ� ������ 
        LocalValue.isTeeniepingMindGet = false; // �ʱ�ȭ
    }


}
