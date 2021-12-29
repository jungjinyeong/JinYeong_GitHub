using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyPageManager : MonoBehaviour
{

    public static MyPageManager instance;


    public MyPageUIInfo myPageUIInfo;

    private void Awake()
    {
        instance = this;
        myPageUIInfo.Init();
    }


    public void CreateSettingPopup()
    {
        PopupContainer.CreatePopup(PopupType.SettingPopup).Init();
    }


    public void CreateLevelUpPopup()
    {
        PopupContainer.CreatePopup(PopupType.LevelUpPopup).Init();
    }

    public void CreateErrorReportPopup()
    {
        PopupContainer.CreatePopup(PopupType.ErrorReportPopup).Init();
    }

    public void RefreshAll()
    {
        myPageUIInfo.Init();
    }
    private void OnDestroy()
    {
        instance = null;
    }
}
