using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System;

public class PopupContainer : MonoBehaviour
{
    private static List<BasePopup> basePopupList = new List<BasePopup>();   // 활성화된 팝업 리스트  , 켜진 팝업리스트
    private static Transform popupParentTr;  // Popup이 생성될 때 ( 복제할 때 ) 부모로 설정하기 위한 변수
    //이거 밑으로 팝업들이 들어가서 생성될 거임 

    private static string stringData;
    private static int countData;


    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    //이 함수는 씬을 최초로 로딩할때 한번만 호출하는 함수다. Awake, Start함수보다도 먼저 호출된다.
    static void Init()
    {
        SceneManager.sceneLoaded += OnSceneLoadCompleted;
        //sceneLoaded 이벤트에 함수를 등록함 
        //씬이 로드될때마다 OnSceneLoadCompleted() 함수를 호출 , 함수 포인터
        // SceneManager.sceneLoaded 이거 딜리게이트임
    }

    // Scene : 현재 호출이 된 씬
    // LoadSceneMode : 단일 씬인지, 씬 위에 씬이 겹쳐진 모드인지...
    static void OnSceneLoadCompleted(Scene scene, LoadSceneMode mode)
    {
        basePopupList = new List<BasePopup>();
        popupParentTr = null;
        GameObject popupParentObj = GameObject.Find("PopupParent"); //생성할 위치 찾는코드 

        // PopupParent가 씬에 없을 경우 함수 종료
        if (popupParentObj == null)
        {
            return;
        }
        popupParentTr = popupParentObj.transform;
    }

    public static BasePopup CreatePopup(PopupType popupType)
    {
        GameObject prefab = Resources.Load<GameObject>("Prefabs/Popup/" + popupType.ToString());
        GameObject popupObj = Instantiate(prefab, popupParentTr);
        return popupObj.GetComponent<BasePopup>(); // BasePopup popupObj = new 자식클래스팝업(); // 업캐스팅  
        // 자식클래스로 만든 오브젝트에 BasePopup 요소만 넘겼음 -> 업캐스팅같은 느낌이지 -> 해당 자식클래스의 BasePopup한테 상속받은 함수를 사용(Init,Close,..)
    }

    // 생성된 팝업을 관리하기 위해 팝업리스트에 등록시킴
    // isOverlay 가 true면 기존 팝업 위에 그대로 생성되고, isOverlay 가 false 면 기존 팝업을 끄고 생성
    public static int Pop(BasePopup basePopup, bool isOverlay = true)
    {
        // 이미 띄워져있는 팝업이 존재하고, 그 팝업을 안보이게 하고싶다면 ( isOverlay == false )
        if (basePopupList.Count > 0 && isOverlay == false)
        {
            basePopupList[basePopupList.Count - 1].gameObject.SetActive(false);
        }
        basePopupList.Add(basePopup);

        // 팝업의 Panel Depth 를 설정해주기 위한 값
        return basePopupList.Count;
    }

    // 최상단의 팝업을 관리 대상에서 제외
    public static void Close() // 팝업제거
    {
        basePopupList.RemoveAt(basePopupList.Count - 1); // 가장 최근의 팝업을 리스트에서 제거
        if (basePopupList.Count > 0)
        {
            basePopupList[basePopupList.Count - 1].gameObject.SetActive(true);
            basePopupList[basePopupList.Count - 1].OnRefresh();
        }
    }
   
    public static List<BasePopup> PopupList()
        {
            return basePopupList;
        }
    // 현재 활성화되어있는 팝업을 리턴. 없으면 null 값을 리턴
    public static BasePopup GetActivatedPopup()
    {
        if (basePopupList.Count == 0)
        {
            return null;
        }
        return basePopupList[basePopupList.Count - 1];
    }
    public static void SetNameData (string data)
    {
        stringData = data;    
    }
    public static string GetNameData()
    {
        return stringData;
    }
    public static void SetIndexData (int data)
    {
        countData = data;    
    }
    public static int GetIndexData()
    {
        return countData;
    }
}

public enum PopupType
{
    StagePlayPopup, 
    InGameClearPopup,
    InGameFinalStageClearPopup,
    InGameUnclearPopup,
    SettingUpPopup,
    GoldStorePopup,
    HeartStorePopup,
    InGamePausePopup,
    PackageStorePopup,
    StarCoinPopup,
    TeeniepingCollectionPopup,
    TeeniepingCollectionRewardPopup,
    ChapterBookPopup,
    GatchaNoticePopup,
    FindDifferentDrawingNoticePopup,
    CharacterCollectionPopup,
    ItemPurchasePopup,
    PurchaseConfirmPopup,
    InsufficientGoldPopup,
    TeeniepingMindDescriptionPopup,
    FreeDrawPopup,
    ItemDescriptionPopup,
    InsufficientHeartPopup,
    CharacterCollectionHowToGetNoticePopup,
    TeeniepingCollectionHowToGetNoticePopup
}
