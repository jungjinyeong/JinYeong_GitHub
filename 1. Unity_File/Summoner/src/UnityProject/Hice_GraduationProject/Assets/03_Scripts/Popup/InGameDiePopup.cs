using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class InGameDiePopup : BasePopup
{
    public Text stage;
    public Text getSaphire;

    float saphire;
    public override void Init(int id = -1)
    {
        base.Init(id);

        Time.timeScale = 0;

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        stage.text = "STAGE " + saveData.stage + "UnClear";

        saphire = PlayerController.instance.playerSaphire;
        getSaphire.text = saphire.ToString();
    }
    public void OnOkButtonClick()
    {
        Close();

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        saveData.saphire += (int)saphire;
        DataService.Instance.UpdateData(saveData);
        Time.timeScale = 1;
        GoToLobby();

    }
    private void GoToLobby()
    {
        PlayerController.instance.DestroyPlayer();
        SceneManager.LoadScene("Lobby");

    }
}
