using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class TiniffingSpotManager : MonoBehaviour
{
    public static TiniffingSpotManager instance;

    [SerializeField]
    private InGameMapInfo inGameMapInfo;

    [SerializeField]
    private TiniffingSpreadController tiniffingSpreadController;

    [SerializeField]
    private InGameEffectSpreadController inGameEffectSpreadController;

    private List<string> selectedTiniffingList; // Ƽ���� ����Ʈ �Ѱܹ��� �뵵 

    private void Awake()
    {
        if (instance == null)
            instance = this;
        else
        {
            Destroy(gameObject);
            return;
        }
    }

    public void OnSpread(int stage_no, bool isDelay = false)
    {   
        if (LocalValue.Map_H == 1) // map �� 2��° ���Ͻ� 
        {
            // ��ü������ ��� ����������Ʈ�� ������ �� �����������
            // stop �����ϰ�� temp state �Լ��� �����ϸ� ���� state �� Mapchange Stop�� TempState�� �Ǿ� ���ѷ�������
            if (InGameTimer.instance.GetState() != InGameTimer.State.Stop)
                InGameTimer.instance.SetTempState();
            InGameTimer.instance.SetStateChange(InGameTimer.State.MapChange);
            InGameManager.instance.TimeStopButtonBlock();
        }
        StartCoroutine(YieldSpread(stage_no, isDelay));
    }

    private IEnumerator YieldSpread(int stage_no, bool isDelay)
    {
        if (isDelay)
        {
            yield return YieldInstructionCache.WaitForSeconds(0.5f);
        }
        if (LocalValue.Map_H == 1) //  map_check_h ==0 �� ��츦 ������ ����ó�� 
        {    
         InGameManager.instance.OnCurtainDownEvent(); // Ŀư �����ֱ�    
         yield return new WaitWhile(InGameManager.instance.IsTweening);
        }
     
        inGameMapInfo.MapChange(stage_no); // map_check ���� , �� �����
       
        int map_check = LocalValue.Map_H;

        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingSpotTable>().Find(x => x.stage_no == stage_no && x.map_check == map_check);

        List<int> gatcha = Gatcha.Instance.ChooseTinGatcha(teeniepingData); // ���� ���õ� ���¿��� �������� ����

        selectedTiniffingList = tiniffingSpreadController.SpreadTiniffing(gatcha, stage_no); //�ʿ� Ƽ���� �Ѹ��� �۾� + return���� ���õ� Ƽ���� �̸� ����Ʈ �Ѱܹ���

        GameManager.instance.SetSelectedTiniffingList(selectedTiniffingList); // GameManager�� ���õ� Ƽ�����̸� ����Ʈ �ѱ��
        InGameManager.instance.SetHintPoleHashSet(selectedTiniffingList); // ��Ʈ�� �ؽü� �ʱ�ȭ

        //Effect Spread
        if (teeniepingData.effect_mode != "NULL")
            inGameEffectSpreadController.Init(teeniepingData);

        InGameManager.instance.Init();

    }

    private void OnDestroy()
    {
        instance = null;
    }
}
