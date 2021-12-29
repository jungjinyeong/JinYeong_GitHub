using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MyPageUIInfo : MonoBehaviour
{
    // Start is called before the first frame update
    public void Init()
    {
        // 원래는 textable에서 받아와서 세팅해야하지만 임시로 그냥 에디터에서 한글로 처리하겠음
    }

    public void OnSettingButtonClick()
    {
        MyPageManager.instance.CreateSettingPopup();
    }


    public void OnLevelUpButtonClick()
    {
        MyPageManager.instance.CreateLevelUpPopup();
    }

    public void OnErrorReportButtonClick()
    {
        MyPageManager.instance.CreateErrorReportPopup();
    }

    public void Refresh()
    {

    }
}
