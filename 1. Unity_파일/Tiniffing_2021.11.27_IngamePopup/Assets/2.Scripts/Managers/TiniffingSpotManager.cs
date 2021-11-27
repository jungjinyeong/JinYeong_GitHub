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

    private List<string> selectedTiniffingList; // 티니핑 리스트 넘겨받을 용도 

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
        if (LocalValue.Map_H == 1) // map 이 2번째 맵일시 
        {
            // 맵체인지의 경우 템프스테이트를 설정할 때 주의해줘야함
            // stop 상태일경우 temp state 함수를 실행하면 현재 state 는 Mapchange Stop이 TempState가 되어 무한루프돈다
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
        if (LocalValue.Map_H == 1) //  map_check_h ==0 일 경우를 제외한 예외처리 
        {    
         InGameManager.instance.OnCurtainDownEvent(); // 커튼 내려주기    
         yield return new WaitWhile(InGameManager.instance.IsTweening);
        }
     
        inGameMapInfo.MapChange(stage_no); // map_check 세팅 , 맵 깔아줌
       
        int map_check = LocalValue.Map_H;

        var teeniepingData = DataService.Instance.GetDataList<Table.TiniffingSpotTable>().Find(x => x.stage_no == stage_no && x.map_check == map_check);

        List<int> gatcha = Gatcha.Instance.ChooseTinGatcha(teeniepingData); // 맵이 선택된 상태에서 랜덤으로 뽑음

        selectedTiniffingList = tiniffingSpreadController.SpreadTiniffing(gatcha, stage_no); //맵에 티니핑 뿌리기 작업 + return으로 선택된 티니핑 이름 리스트 넘겨받음

        GameManager.instance.SetSelectedTiniffingList(selectedTiniffingList); // GameManager에 선택된 티니핑이름 리스트 넘기기
        InGameManager.instance.SetHintPoleHashSet(selectedTiniffingList); // 힌트봉 해시셋 초기화

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
