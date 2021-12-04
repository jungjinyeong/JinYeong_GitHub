using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System;

public class PopupContainer : MonoBehaviour
{
    private static List<BasePopup> basePopupList = new List<BasePopup>();   // Ȱ��ȭ�� �˾� ����Ʈ  , ���� �˾�����Ʈ
    private static Transform popupParentTr;  // Popup�� ������ �� ( ������ �� ) �θ�� �����ϱ� ���� ����
    //�̰� ������ �˾����� ���� ������ ���� 

    private static string stringData;
    private static int countData;


    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    //�� �Լ��� ���� ���ʷ� �ε��Ҷ� �ѹ��� ȣ���ϴ� �Լ���. Awake, Start�Լ����ٵ� ���� ȣ��ȴ�.
    static void Init()
    {
        SceneManager.sceneLoaded += OnSceneLoadCompleted;
        //sceneLoaded �̺�Ʈ�� �Լ��� ����� 
        //���� �ε�ɶ����� OnSceneLoadCompleted() �Լ��� ȣ�� , �Լ� ������
        // SceneManager.sceneLoaded �̰� ��������Ʈ��
    }

    // Scene : ���� ȣ���� �� ��
    // LoadSceneMode : ���� ������, �� ���� ���� ������ �������...
    static void OnSceneLoadCompleted(Scene scene, LoadSceneMode mode)
    {
        basePopupList = new List<BasePopup>();
        popupParentTr = null;
        GameObject popupParentObj = GameObject.Find("PopupParent"); //������ ��ġ ã���ڵ� 

        // PopupParent�� ���� ���� ��� �Լ� ����
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
        return popupObj.GetComponent<BasePopup>(); // BasePopup popupObj = new �ڽ�Ŭ�����˾�(); // ��ĳ����  
        // �ڽ�Ŭ������ ���� ������Ʈ�� BasePopup ��Ҹ� �Ѱ��� -> ��ĳ���ð��� �������� -> �ش� �ڽ�Ŭ������ BasePopup���� ��ӹ��� �Լ��� ���(Init,Close,..)
    }

    // ������ �˾��� �����ϱ� ���� �˾�����Ʈ�� ��Ͻ�Ŵ
    // isOverlay �� true�� ���� �˾� ���� �״�� �����ǰ�, isOverlay �� false �� ���� �˾��� ���� ����
    public static int Pop(BasePopup basePopup, bool isOverlay = true)
    {
        // �̹� ������ִ� �˾��� �����ϰ�, �� �˾��� �Ⱥ��̰� �ϰ�ʹٸ� ( isOverlay == false )
        if (basePopupList.Count > 0 && isOverlay == false)
        {
            basePopupList[basePopupList.Count - 1].gameObject.SetActive(false);
        }
        basePopupList.Add(basePopup);

        // �˾��� Panel Depth �� �������ֱ� ���� ��
        return basePopupList.Count;
    }

    // �ֻ���� �˾��� ���� ��󿡼� ����
    public static void Close() // �˾�����
    {
        basePopupList.RemoveAt(basePopupList.Count - 1); // ���� �ֱ��� �˾��� ����Ʈ���� ����
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
    // ���� Ȱ��ȭ�Ǿ��ִ� �˾��� ����. ������ null ���� ����
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
