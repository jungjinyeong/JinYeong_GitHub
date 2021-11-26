using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InGamePausePopup : BasePopup
{
    [SerializeField]
    private Text resumeText;
    [SerializeField]
    private Text restartText;
    [SerializeField]
    private Text quitText;
    [SerializeField]
    private Text titleText;
  
    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        InGameTimer.instance.SetTempState();
        InGameTimer.instance.SetStateChange(InGameTimer.State.PopupOn);
        Time.timeScale = 0;
    }
 
    public void OnResumeButtonClick()
    {
        Time.timeScale = 1;
        InGameTimer.instance.SetStateChange(InGameTimer.instance.GetTempState());
        Close();
    }
    public void OnRestartButtonClick()
    {
        LocalValue.Map_H = 0;
        LocalValue.isRetryButtonClick = true;
        Time.timeScale = 1;
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
   
    public void OnQuitButtonClick()
    {
        LocalValue.Map_H = 0;
        Time.timeScale = 1;
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        string resume = DataService.Instance.GetText(11);
        string restart = DataService.Instance.GetText(12);
        string quit = DataService.Instance.GetText(13);
        string stageTextTable = DataService.Instance.GetText(2);
        titleText.text = string.Format("{0} {1}",stageTextTable ,LocalValue.Click_Stage_H);
        resumeText.text = resume;
        restartText.text = restart;
        quitText.text = quit;
    }
    public override void Close()
    {      
        base.Close();
    }

}
