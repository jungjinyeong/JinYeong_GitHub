using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LobbyUIInfo : MonoBehaviour
{

    public Text level;
    public Text playerButton_stage;
    public Text saphire;

   /* public GameObject myPageButton;
    public GameObject lobbyButton;
    public GameObject petSkillButton;
    */
    public void Init()
    {
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        // saveData는 table 스크립트에서 class하나로 구현되어있. 즉 var의 타입은 여기서 saveData의 클래스 가 되는거임
        level.text = saveData.player_level.ToString();
        playerButton_stage.text = "Stage " + saveData.stage.ToString() + "\n플레이";
        saphire.text = saveData.saphire.ToString();

    }

    public void OnPlayButtonClick()
    {
        var playerPetTable = DataService.Instance.GetDataList<Table.PlayerPetTable>().FindAll(x => x.use == 1);
        // 테이블 클래스가 리스트에 하나하나씩 다 박혀있고 결국 리스트 한줄에서 그 요소 하나하나를 보면 table클래스들이 박혀있다

        // 만약 체크된 소환수가 하나도 없으면 경고창 띄우고 종료
        if(playerPetTable.Count==0)
        {
            PopupContainer.CreatePopup(PopupType.SummonerCheckPopup).Init();
            return;
        }
        SceneManager.LoadScene("Stage2_Medieval");
    }

    public void OnMyPageButtonClick()
    {
        LobbyManager.instance.OnMyPageButtonClick();
    }
    public void OnLobbyButtonClick()
    {
        LobbyManager.instance.OnLobbyButtonClick();
    }
    public void OnPetSkillButtonClick()
    {
        LobbyManager.instance.OnPetSkillButtonClick();
    }
}
