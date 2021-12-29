using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class InGameStopPopup : BasePopup
{
    public Slider bgmControlVal;
    public Slider sfxControlVal;

    // public AudioSource bgm;
    // public AudioSource sfx;

    private float bgmVolSize = 1f;
    private float sfxVolSize = 1f;
    /*
    Slider가 움직일 때마다 Value 값이 달라지는데, 이 값은 오른쪽으로 갈수록 1에 가까워지며, 왼쪽으로 갈 수록 0에 가까워진다.
    Music의 Volume 역시 작아질수록 0에 가까워지고 커질수록 1에 가까워지기 때문에 이 점을 이용하여 Slider로 Music의 음량을 조절할 수 있다.
    */

    public override void Init(int id = -1)
    {
        // Text 세팅 원래는 해줘야함
        base.Init(id);

        bgmVolSize = DataService.Instance.GetData<Table.SaveTable>(0).bgm;
        sfxVolSize = DataService.Instance.GetData<Table.SaveTable>(0).sfx;
        bgmControlVal.value = bgmVolSize;
        sfxControlVal.value = sfxVolSize;
        //bgm.volume = bgmVolSize;
        //sfx.volume = sfxVolSize;

    }

    public void OnBGMVolumeChanged()
    {
        SoundManager.instance.masterVolumeBGM = bgmControlVal.value;
        SoundManager.instance.SetCustomVolume();
    }

    public void OnSFXVolumeChanged()
    {
        SoundManager.instance.masterVolumeSFX = sfxControlVal.value;
        SoundManager.instance.SetCustomVolume();
    }
    public void OnHomeButtonClick()
    {
        Time.timeScale = 1;
        PlayerController.instance.DestroyPlayer();
        SceneManager.LoadScene("Lobby");

    }
    public override void Close()
    {
        base.Close();
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        saveData.bgm = bgmControlVal.value;
        saveData.sfx = sfxControlVal.value;
        DataService.Instance.UpdateData(saveData);
        Time.timeScale = 1;
    }


   

}
