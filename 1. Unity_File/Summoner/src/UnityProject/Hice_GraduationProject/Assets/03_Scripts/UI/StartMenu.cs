using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class StartMenu : MonoBehaviour
{
    public Button startBtn;
    private void Start()
    {
        // 임시로 여기서 BGM호출
        if (SoundManager.instance != null)
            SoundManager.instance.PlayBGM("Tavern Lively (LOOP)");
    }

    public void StartGame()
    {
        SceneManager.LoadScene("SeongjinWorkScene");
    }


}
