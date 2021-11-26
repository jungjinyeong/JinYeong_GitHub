using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;
public class InGameUnclearPopup : BasePopup
{


 //   [SerializeField] private Text unclearText;

  //  [SerializeField] private Text goLobbyText;

    [SerializeField]
    private Text retryText;
    [SerializeField]
    private Text stage_no_txt;
    [SerializeField]
    private Text speech_bubble_txt;
    [SerializeField]
    private Text remain_time_txt;
    [SerializeField]
    private Text goldText;
    [SerializeField]
    private Text starCoin_txt;
    [SerializeField]
    private Text reward_list_txt;
    [SerializeField]
    private Text remainSecondText;

    [SerializeField] private RectTransform groupRect;

    [SerializeField] private SkeletonAnimation skeletonAnimation;

    private int click_stage_number;
    private int click_chapter_number;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    private void SetSkeletonDataAsset()
    {
        var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x => x.select == 1);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);
        skeletonAnimation.skeletonDataAsset = Resources.Load<SkeletonDataAsset>("Spines/" + characterTable.character_spine_name);

        skeletonAnimation.AnimationName = "Fail";
        skeletonAnimation.Initialize(true);
    }

    public void OnLoobyGoButtonClick() // Lobby Go
    {
        LocalValue.Map_H = 0; 
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H"); // 로딩바 띄우고 
    }
    public void OnRetryButtonClick()
    {
        LocalValue.Map_H = 0;
        LocalValue.isStageClear = false; // 연출 여부를 결정함
        LocalValue.isRetryButtonClick = true; // 로비 매니저에서 조건문에 사용할 변수
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
 
    public override void OnRefresh()
    {
        base.OnRefresh();


  
       click_stage_number = LocalValue.Click_Stage_H;
       click_chapter_number = LocalValue.Click_Chapter_H;


        stage_no_txt.text = string.Format("{0} {1}",DataService.Instance.GetText(2), click_stage_number.ToString());
        speech_bubble_txt.text = DataService.Instance.GetText(17);
        remain_time_txt.text = DataService.Instance.GetText(16);
        goldText.text = DataService.Instance.GetText(18);
        starCoin_txt.text = DataService.Instance.GetText(19);
        reward_list_txt.text = DataService.Instance.GetText(15);
        retryText.text = DataService.Instance.GetText(7);

        SetSkeletonDataAsset();

    }
}
