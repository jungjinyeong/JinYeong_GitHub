using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SettingUpPopup : BasePopup
{
    // ���� �ѱ� �����ؾߵǼ� ���� �� �־�ߴ�
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
        PlayerPrefs.SetFloat("BGMVolume", bgmSlider.value);// playerprefs �� ���� 
        SoundManager.SetBGMVolume(bgmSlider.value);// ���� ���� ũ�� ����
        Debug.Log("BGM Vol change : " + bgmSlider.value * 100);
    }
    public void OnSfxVolumeChanged()
    {
        PlayerPrefs.SetFloat("SFXVolume", bgmSlider.value); // playerprefs �� ����
        SoundManager.SetSFXVolume(sfxSlider.value); // ���� ���� ũ�� ����
        Debug.Log("SFX Vol change : " + sfxSlider.value * 100);
    }
    #endregion


    public override void OnRefresh() // �ʱ�ȭ �۾�
    {
        base.OnRefresh();
    

        string settingTextTable = DataService.Instance.GetText(8); // ȯ�漳��
        string bgmTextTable = DataService.Instance.GetText(9); // �����
        string sfxTextTable = DataService.Instance.GetText(10); // ȿ����
        string gameInquriyTextTable = DataService.Instance.GetText(5); // ���ӹ���
        string gameExitTextTable = DataService.Instance.GetText(6); // ����

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
