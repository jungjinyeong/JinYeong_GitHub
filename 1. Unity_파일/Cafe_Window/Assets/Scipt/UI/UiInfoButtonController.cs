using System.Collections;
using UnityEngine;

public class UiInfoButtonController : MonoBehaviour
{
    //원두 가공, 우유 가공, 상점[생성 및 초기화]
    public GameObject m_BeansPopup = null;
    public GameObject m_MilkPopup = null;
    public GameObject m_ShopPopup = null;

    //환경설정 [생성 및 초기화]
    public GameObject M_PreferencesPopup = null;

    //홀, 주방, 레시피, 가방[생성 및 초기화]
    public GameObject m_HallPage = null;
    public GameObject m_KitchenPage = null;
    public GameObject m_RecipePage = null;
    public GameObject m_BagPage = null;

    public void Start()
    {
        //실행 후 미리 팝업 off [원두 가공, 우유 가공, 상점]
        m_BeansPopup.gameObject.SetActive(false);
        m_MilkPopup.gameObject.SetActive(false);
        m_ShopPopup.gameObject.SetActive(false);

        //실행 후 미리 팝업 off [환경설정]
        M_PreferencesPopup.gameObject.SetActive(false);

        //실행 후 미리 팝업 On [홀]
        m_HallPage.gameObject.SetActive(true);

        //실행 후 미리 팝업 off [주방, 레시피, 가방]
        m_KitchenPage.gameObject.SetActive(false);
        m_RecipePage.gameObject.SetActive(false);
        m_BagPage.gameObject.SetActive(false);
        

    }
    //커피 가공 팝업 실행 메소드
    public void Beans_Making_Popup_OnClick()
    {
        if(m_BeansPopup != null)
        {
            m_BeansPopup.gameObject.SetActive(true);
            Debug.Log("원두 가공 실행");
            SoundManager.Instance.Button_Sound();
        }
        
    }
    //커피 가공 팝업 닫기 메소드
    public void Beans_Exit_Onclick()
    {
        if(m_BeansPopup != null)
        {
            m_BeansPopup.gameObject.SetActive(false);
            Debug.Log("원두 가공 팝업 닫기");
            SoundManager.Instance.Button_Sound();
        }
    }
    //우유 가공 팝업 실행 메소드
    public void Milk_Making_Popup_OnClick()
    {
        if(m_MilkPopup != null)
        {
            m_MilkPopup.gameObject.SetActive(true);
            Debug.Log("우유 가공 실행");
            SoundManager.Instance.Button_Sound();
        }
    }
    //우유 가공 팝업 닫기 메소드
    public void Milk_Exit_OnClick()
    {
        if(m_MilkPopup != null)
        {
            m_MilkPopup.gameObject.SetActive(false);
            Debug.Log("우유 가공 팝업 닫기");
            SoundManager.Instance.Button_Sound();
        }
    }
    //상점 팝업 실행 메소드
    public void Shop_Popup_OnClick()
    {
        if (m_ShopPopup != null)
        {
            m_ShopPopup.gameObject.SetActive(true);
            Debug.Log("상점 실행");
            SoundManager.Instance.Button_Sound();
        }
        
    }
    //상점 팝업 닫기 메소드
    public void Shop_Exit_OnClick()
    {
        if (m_ShopPopup != null)
        {
            m_ShopPopup.gameObject.SetActive(false);
            Debug.Log("상점 팝업 닫기");
            SoundManager.Instance.Button_Sound();
        }
    }
    //홀 페이지 오픈 조건
    public void Hall_Page_OnClick()
    {
        if(m_HallPage != null)
        {
            m_HallPage.gameObject.SetActive(true);
            m_KitchenPage.gameObject.SetActive(false);
            m_RecipePage.gameObject.SetActive(false);
            m_BagPage.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }
    //주방 페이지 오픈 조건
    public void Kitchen_Page_OnClick()
    {
        if (m_KitchenPage != null)
        {
            m_KitchenPage.gameObject.SetActive(true);
            m_HallPage.gameObject.SetActive(false);
            m_RecipePage.gameObject.SetActive(false);
            m_BagPage.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }
    //레시피 페이지 오픈 조건
    public void Recipe_Page_OnClick()
    {
        if (m_RecipePage != null)
        {
            m_RecipePage.gameObject.SetActive(true);
            m_HallPage.gameObject.SetActive(false);
            m_KitchenPage.gameObject.SetActive(false);
            m_BagPage.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();

        }
    }
    //가방 페이지 오픈 조건
    public void Bag_Page_OnClick()
    {
        if (m_BagPage != null)
        {
            m_BagPage.gameObject.SetActive(true);
            m_HallPage.gameObject.SetActive(false);
            m_KitchenPage.gameObject.SetActive(false);
            m_RecipePage.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }

    public void PreferencesPopup_OnClick()
    {
        if (M_PreferencesPopup != null)
        {
            M_PreferencesPopup.gameObject.SetActive(true);
            SoundManager.Instance.Button_Sound();
        }
    }

    public void PreferencesPopup_Exit_OnClick()
    {
        if (M_PreferencesPopup != null)
        {
            M_PreferencesPopup.gameObject.SetActive(false);
            SoundManager.Instance.Button_Sound();
        }
    }
}