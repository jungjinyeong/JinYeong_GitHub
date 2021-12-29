using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class InGameScorePopup : BasePopup
{

    public Text getSaphire;
    public Text stage;

    float saphire;
    public override void Init(int id = -1)
    {
        base.Init(id);
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
       
        stage.text = "STAGE " + saveData.stage + " CLEAR";

        saphire = PlayerController.instance.playerSaphire;
        getSaphire.text = saphire.ToString();
    }

   
    public void OnOkButtonClick()
    {
        Close();

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        saveData.stage++;
        saveData.saphire += (int)saphire;
        DataService.Instance.UpdateData(saveData);
        GoToLobby();

    }
    private void GoToLobby()
    {
        PlayerController.instance.DestroyPlayer();
        SceneManager.LoadScene("Lobby");

    }
}
