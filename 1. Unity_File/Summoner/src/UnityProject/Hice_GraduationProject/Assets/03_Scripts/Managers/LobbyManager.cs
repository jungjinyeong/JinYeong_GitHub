using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class LobbyManager : MonoBehaviour
{
    public static LobbyManager instance;

    public RectTransform canvasRectTr;
    public RectTransform petGroupRectTr; // pet group 위치잡을거임
    public RectTransform lobbyGroupRectTr;
    public RectTransform myPageGroupRectTr;
    public LobbyUIInfo lobbyUIInfo;

    private void Awake()
    {
        instance = this;
        lobbyUIInfo.Init();
        if(PlayerController.instance != null)
        {
            Destroy(PlayerController.instance.gameObject);
        }
    }

    private void Start()
    {
        petGroupRectTr.sizeDelta = canvasRectTr.sizeDelta; //width hegiht size
        petGroupRectTr.anchoredPosition = new Vector2(petGroupRectTr.sizeDelta.x, 0); // pet group 엑스 사이즈만큼 오른쪽으로 가게함, y는 변동없음

        // bgm 실행
        if (SoundManager.instance != null)
            SoundManager.instance.PlayBGM("Tavern Lively (LOOP)");
    }

    public void OnLobbyButtonClick()
    {
        myPageGroupRectTr.anchoredPosition = new Vector2(-canvasRectTr.sizeDelta.x, 0);
        petGroupRectTr.anchoredPosition = new Vector2(canvasRectTr.sizeDelta.x, 0);
        lobbyGroupRectTr.anchoredPosition = new Vector2(0, 0);
    }
    public void OnPetSkillButtonClick()
    {
        //  lobbyGroupRectTr.anchoredPosition = new Vector2(-canvasRectTr.sizeDelta.x, 0);
        myPageGroupRectTr.anchoredPosition = new Vector2(-canvasRectTr.sizeDelta.x, 0); //혹시 마이페이지에서 펫스킬 버튼 클릭시 보내줘야함 
        //하이어키가 마이페이지가 더 앞에 보여서
        petGroupRectTr.anchoredPosition = new Vector2(0, 0);
    }
    public void OnMyPageButtonClick()
    {
        myPageGroupRectTr.anchoredPosition = new Vector2(0, 0);
    }
    public void RefreshAll()
    {
        lobbyUIInfo.Init();
    }

    private void OnDestroy()
    {
        instance = null;
    }


}
