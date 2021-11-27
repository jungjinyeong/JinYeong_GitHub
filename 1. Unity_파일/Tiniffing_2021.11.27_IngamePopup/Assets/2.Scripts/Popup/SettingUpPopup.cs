using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SettingUpPopup : BasePopup
{
    // 영어 한글 대응해야되서 글자 다 있어야댐
    [SerializeField]
    private Text titleText;

    [SerializeField]
    private Text bgmText;

    [SerializeField]
    private Text sfxText;

    [SerializeField]
    private Text gameInquiryText;

    [SerializeField]
    private Text gameExitText;

    [SerializeField]
    private Slider bgmSlider;
    
    [SerializeField]
    private Slider sfxSlider;

    private float bgmVolSize ;
    private float sfxVolSize ;

    [SerializeField] RectTransform groupRect;

    public override void Init(int id = -1)
    {
        base.Init(id);
        OnRefresh();
        PopTweenEffect_Small(groupRect);
    }
    protected override void PopTweenEffect_Small(RectTransform groupRect)
    {
        base.PopTweenEffect_Small(groupRect);
    }
    #region Click Events
    public void OnGameInquiryButtonClick()
    {

    }
    public void OnGameExitButtonClick()
    {
        Application.Quit();
    }
  
    public void OnBgmVolumeChanged()
    {
        PlayerPrefs.SetFloat("BGMVolume", bgmSlider.value);// playerprefs 값 변경 
        SoundManager.SetBGMVolume(bgmSlider.value);// 실제 사운드 크기 변경
        Debug.Log("BGM Vol change : " + bgmSlider.value * 100);
    }
    public void OnSfxVolumeChanged()
    {
        PlayerPrefs.SetFloat("SFXVolume", bgmSlider.value); // playerprefs 값 변경
        SoundManager.SetSFXVolume(sfxSlider.value); // 실제 사운드 크기 변경
        Debug.Log("SFX Vol change : " + sfxSlider.value * 100);
    }
    #endregion


    public override void OnRefresh() // 초기화 작업
    {
        base.OnRefresh();
    

        string settingTextTable = DataService.Instance.GetText(8); // 환경설정
        string bgmTextTable = DataService.Instance.GetText(9); // 배경음
        string sfxTextTable = DataService.Instance.GetText(10); // 효과음
        string gameInquriyTextTable = DataService.Instance.GetText(5); // 게임문의
        string gameExitTextTable = DataService.Instance.GetText(6); // 종료

        titleText.text = settingTextTable;
        bgmText.text = bgmTextTable;
        gameExitText.text = gameExitTextTable;
        sfxText.text = sfxTextTable;
        gameInquiryText.text = gameInquriyTextTable;
       
        bgmVolSize = PlayerPrefs.GetFloat("BGMVolume", 1);
        sfxVolSize = PlayerPrefs.GetFloat("SFXVolume", 1);

        bgmSlider.value = bgmVolSize;
        sfxSlider.value = sfxVolSize;
    }
    public override void Close()
    {
        base.Close();

    }

}
