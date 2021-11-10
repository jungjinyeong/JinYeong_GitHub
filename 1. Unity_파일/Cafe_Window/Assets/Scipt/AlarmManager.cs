using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AlarmManager : MonoBehaviour
{
    //알람 매니저 생성[Instance 사용 시 어디서든 사용 가능]
    public static AlarmManager Instance;

    //알람 팝업 [생성 및 초기화]
    public GameObject m_Alarm = null;
    public GameObject m_Event_Popup = null;
    public GameObject m_Event_Popup_BackGround = null;

    private void Start()
    {
        if(Instance == null)
        {
            Instance = this;
        }
        if (m_Event_Popup != null)
        {
            m_Event_Popup.gameObject.SetActive(false);
        }
        if (m_Alarm != null)
        {
            m_Alarm.gameObject.SetActive(false);
        }
    }

    public void EventOnAlarm()
    {
        Debug.Log("알람 충돌 이벤트 발생");
        if (m_Alarm != null)
        {
            m_Alarm.gameObject.SetActive(true);
        }
    }
    public void AlarmOnClick()
    {
        if(m_Event_Popup != null)
        {
            m_Event_Popup_BackGround.gameObject.SetActive(true);
            m_Event_Popup.gameObject.SetActive(true);
            SoundManager.Instance.Button_Sound();
        }
    }
    public void EvetPopup_Exit_OnClick()
    {
        if(m_Event_Popup != null)
        {
            m_Event_Popup.gameObject.SetActive(false);
            m_Event_Popup_BackGround.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }
    public void EvetPopup_Exit_BackGround_OnClick()
    {
        if (m_Event_Popup != null)
        {
            m_Event_Popup.gameObject.SetActive(false);
            m_Event_Popup_BackGround.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }
}