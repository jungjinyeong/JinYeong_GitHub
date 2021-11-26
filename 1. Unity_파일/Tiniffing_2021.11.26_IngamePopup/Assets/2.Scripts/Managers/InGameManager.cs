using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using DG.Tweening;


public class InGameManager : MonoBehaviour
{
    public static InGameManager instance;
    [SerializeField] private Camera uiCamera;
    [SerializeField] private RectTransform inGamePlayCanvas;
    [SerializeField] private InGameUIInfo inGameUIInfo;

    public RectTransform canvasTr;
    public bool isTweening;

    private void Awake()  // 이 스크립트가 붙어있는 오브젝트가 달려있는 씬이 로드될때 호출
    {
        if (instance == null)
            instance = this;
        else if (instance != this)
        {
            Destroy(gameObject);
        }
        inGameUIInfo.OnFinishedTween += OnFinishedTween;
    }

    private void OnDestroy()
    {
        inGameUIInfo.OnFinishedTween -= OnFinishedTween;
        instance = null;
    }


    public void Init()
    {
        inGameUIInfo.Init(); // 기본 UI 세팅

        GameObject cameraObj = GameObject.Find("UICamera");
        uiCamera = cameraObj.GetComponent<Camera>();
        int sequence = LocalValue.Click_Chapter_H;
        string in_game_max_time = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 3 && x.sequence == sequence).data;
        int map_check_h = LocalValue.Map_H;
        if (map_check_h == 0)
        {
            InGameTimer.instance.SetTimerMax(int.Parse(in_game_max_time));
            InGameTimer.instance.Init();
            // 연출
            StartCoroutine(EffectDisplayCoroutine());
        }
        else // map_check_h == 1
        {
            // 커튼을 내려주는 작업은 TiniffingSpotManager에서 이미 처리했음
            // 커튼 올려줘야함
            OnCurtainUpEvent();
        }
    }

    // 연출용 코루틴
    IEnumerator EffectDisplayCoroutine()
    {

        ReadyEffectOn();
        yield return new WaitForSeconds(1.801f);
        ReadyEffectOff();
        GoEffectOn();
        yield return new WaitForSeconds(0.901f);
        GoEffectOff();
        OnCurtainUpEvent();
        // 커튼 올라가는 시간 0.8초
        yield return new WaitForSeconds(0.8f);
        InGameTimer.instance.Timer();
    }
    public void TimeStopButtonBlock()
    {
        inGameUIInfo.TimeStopTouchBlockUntilMapChange();
    }
    public void ClearEffectOn()
    {
        inGameUIInfo.ClearEffectOn();
    }
    public void ClearEffectOff()
    {
        inGameUIInfo.ClearEffectOff();
    }
    public void CanvasTouchBlockOn()
    {
        inGameUIInfo.CanvasTouchBlockOn();
    }
    private void ReadyEffectOff()
    {
        inGameUIInfo.ReadyEffectOff();
    }
    private void GoEffectOff()
    {
        inGameUIInfo.GoEffectOff();
    }
    public void ReadyEffectOn()
    {
        inGameUIInfo.ReadyEfffectOn();
    }
    public void GoEffectOn()
    {

        inGameUIInfo.GoEffectOn();
    }
    public void DangerDisplay()
    {
        inGameUIInfo.InGameDangerStateDisplay();
    }
    public void OnMissTouch()
    {

        var protectionBridgeData = DataService.Instance.GetData<Table.ItemTable>(2);
        if (protectionBridgeData.active == 0 || protectionBridgeData.count == 0) // 활성화 안되어 있는 상태 or 남아있는 개수가 없거나
        {
            // 시간이 줄어듦
            InGameTimer.instance.SetTimerMinus(3f);
        }
        else // 활성화 되어있는 상태 + 개수가 남아있는 상태
        {
                inGameUIInfo.OnUseProtectionBridge(); // 사용처리
                Vector2 screenPoint;
                RectTransformUtility.ScreenPointToLocalPointInRectangle(inGamePlayCanvas, Input.mousePosition, uiCamera, out screenPoint);
                GameObject protectBridgeEffect = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/protect_bridge_effect"),inGamePlayCanvas);
                protectBridgeEffect.GetComponent<RectTransform>().anchoredPosition = screenPoint;
        }
    }
    public void TimeOverEventOn()
    {
        inGameUIInfo.TimeOverEventOn();
    }
    public void TimeOverEventOff()
    {
        inGameUIInfo.TimeOverEvnetOff();
    }
    public void StageFailEventOn()
    {
        inGameUIInfo.StageFailEventOn();
    }
    public void StageFailEventOff()
    {
        inGameUIInfo.StageFailEventOff();
    }
    public void OnCurtainUpEvent()
    {
        inGameUIInfo.OnCurtainUpEvent();
    }
    public void OnCurtainDownEvent()
    {
        isTweening = true;
        inGameUIInfo.OnCurtainDownEvent();

    }
    public void OnPauseButtonClick()
    {
        PopupContainer.CreatePopup(PopupType.InGamePausePopup).Init();
    }

    public void OnBellImageChange()
    {
        inGameUIInfo.BellSpriteChange();
    }
    public void RemoveHintPoleHashSet(string findObjName)
    {
        inGameUIInfo.RemoveHashSetItem(findObjName);
    }
    public void SetHintPoleHashSet(List<string> tiniffingList)
    {
        inGameUIInfo.SetHintHashSet(tiniffingList);
    }
    void OnFinishedTween()
    {
        isTweening = false;
    }

    public bool IsTweening()
    {
        return isTweening;
    }
}
