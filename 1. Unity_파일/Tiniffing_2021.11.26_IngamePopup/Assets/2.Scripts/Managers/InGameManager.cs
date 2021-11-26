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

    private void Awake()  // �� ��ũ��Ʈ�� �پ��ִ� ������Ʈ�� �޷��ִ� ���� �ε�ɶ� ȣ��
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
        inGameUIInfo.Init(); // �⺻ UI ����

        GameObject cameraObj = GameObject.Find("UICamera");
        uiCamera = cameraObj.GetComponent<Camera>();
        int sequence = LocalValue.Click_Chapter_H;
        string in_game_max_time = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 3 && x.sequence == sequence).data;
        int map_check_h = LocalValue.Map_H;
        if (map_check_h == 0)
        {
            InGameTimer.instance.SetTimerMax(int.Parse(in_game_max_time));
            InGameTimer.instance.Init();
            // ����
            StartCoroutine(EffectDisplayCoroutine());
        }
        else // map_check_h == 1
        {
            // Ŀư�� �����ִ� �۾��� TiniffingSpotManager���� �̹� ó������
            // Ŀư �÷������
            OnCurtainUpEvent();
        }
    }

    // ����� �ڷ�ƾ
    IEnumerator EffectDisplayCoroutine()
    {

        ReadyEffectOn();
        yield return new WaitForSeconds(1.801f);
        ReadyEffectOff();
        GoEffectOn();
        yield return new WaitForSeconds(0.901f);
        GoEffectOff();
        OnCurtainUpEvent();
        // Ŀư �ö󰡴� �ð� 0.8��
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
        if (protectionBridgeData.active == 0 || protectionBridgeData.count == 0) // Ȱ��ȭ �ȵǾ� �ִ� ���� or �����ִ� ������ ���ų�
        {
            // �ð��� �پ��
            InGameTimer.instance.SetTimerMinus(3f);
        }
        else // Ȱ��ȭ �Ǿ��ִ� ���� + ������ �����ִ� ����
        {
                inGameUIInfo.OnUseProtectionBridge(); // ���ó��
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
