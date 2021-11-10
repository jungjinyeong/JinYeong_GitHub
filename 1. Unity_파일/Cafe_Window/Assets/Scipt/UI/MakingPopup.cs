using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MakingPopup : AiSpawnManiger
{
    public GameObject m_MakingPopup = null;
    public GameObject m_PackGround = null;

    public void Update()
    {
        

    }

    public void MakingOnClick()
    {
        if(m_MakingPopup != null)
        {
            m_MakingPopup.gameObject.SetActive(false);
            m_PackGround.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }

}
