using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class IntroUIInfo : MonoBehaviour
{
    [SerializeField] private Text googleLoginText;
    [SerializeField] private Image catchTeeniepingImage;

    private void Start()
    {
        Init();
    }
    public void Init()
    {
        SoundManager.PlayBGM(BgmType.LobbyBGM);
        OnRefresh();
    }
    public void OnGoogleLoginButtonClick()
    {
        LoadingSceneController.Instance.LoadLobbyScene_H("LobbyScene_H");
    }
    private void OnRefresh()
    {
        googleLoginText.text = string.Format("Google {0}", DataService.Instance.GetText(63));
        switch (Application.systemLanguage)
        {
            case SystemLanguage.Korean:
                break;
            default:
                catchTeeniepingImage.sprite = Resources.Load<Sprite>("Images/intro_title_image");               
                break;
        }
    }

}
