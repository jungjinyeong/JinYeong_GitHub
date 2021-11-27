using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System.Linq;

public class GameManager : MonoBehaviour
{
    private static GameManager _instance;

    private List<string> selectedTiniffingList;

    public static GameManager instance
    {
        get
        {
            if (!_instance)
            {
                _instance = new GameObject().AddComponent<GameManager>();
                _instance.gameObject.name = "GameManager";
            }
            return _instance;
        }
    }


    private void Awake()
    {
        if(_instance)
        {
            Destroy(gameObject);
            // Awake는 프로그램이 시작할때 한번만 호출되기때문에 awake로 갔는데 instance가 채워져있다는거는 이미 전 씬에서 호출되었다는 의미이므로
            // 방금 생성한것을 없애준다.
            return;

        }
        _instance = this;
        DontDestroyOnLoad(gameObject);

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no = saveTable.chapter_no; // 켜질때마다 now_chapter_no 를  최신 챕터로 초기화

        var maxHeartCount = DataService.Instance.GetData<Table.BaseTable>(0).data; // 하트 맥스 개수 적혀있는 곳
        var oneHeartGetNeedTime = DataService.Instance.GetData<Table.BaseTable>(1).data; // 하트 하나 얻기위한 시간

        HeartTime.Instance.SetMaxCount(maxHeartCount);
        HeartTime.Instance.SetMaxTime(oneHeartGetNeedTime);
       // saveTable.heart_count = 5;
        int heartCount = saveTable.heart_count;
        int processtime;

        if (saveTable.newbie == 0) // 겜 처음 시작한 유저
        {
            processtime = 0;
        }
        else // 기존유저
        {
            processtime = OnTimeDifferenceCalculator();
        }

        HeartTime.Instance.Initialize(heartCount, processtime);
        Debug.LogError($"{nameof(saveTable.newbie)} = {saveTable.newbie}, {nameof(heartCount)} = {heartCount}, {nameof(processtime)} = {processtime}");
        
        DataService.Instance.UpdateData(saveTable);

        // OnTimeDifferenceCalculator() 
        // 접송 종료부터 접속까지 시간차이계산 후 처리 
        // LobbySceneInit() 보다 먼저 호출되어야 함! -> 빠르게 DB 값 변경해줘야해서 

        // heart Time의 Refresh는 LobbyUIInfo에서 할 거임
    }
    private void Start() //신 로드시 해당하이어키 게임오브젝트 켜진놈들 모두 최초 한번
    {
        //UnityEditor.EditorUtility.ClearProgressBar();
    }
    private void Update()
    {
       /* if (Application.platform == RuntimePlatform.Android)
        {
            BackKey();
        }*/
    }
    private void LobbySceneInit()
    {
        LobbyManager.instance.Init();
    }

    private void BackKey()
    {
        if (Input.GetKeyDown(KeyCode.Escape)) // 뒤로가기 버튼 클릭
        {
            if (PopupContainer.GetActivatedPopup() != null && !LocalValue.isStageFinished) // 이미 떠 있는 팝업이 존재하면
            {
                PopupContainer.GetActivatedPopup().Close(); // 해당 팝업을 꺼준다
            }
            else // 활성화되어있는 팝업이 존재하지 않는다면
            {
                if (SceneManager.GetActiveScene().name == "InGameScene_H" && !LocalValue.isStageFinished) // 현재 씬이 InGame 씬이면서 스테이지가 끝난 상황이 아닐때
                {                    
                    PopupContainer.CreatePopup(PopupType.InGamePausePopup).Init();
                }
                else if (SceneManager.GetActiveScene().name == "LobbyScene_H")
                {
                    // 환경설정 팝업 열기
                    PopupContainer.CreatePopup(PopupType.SettingUpPopup).Init();
                }
            }
        }
    }

    public void SetSelectedTiniffingList(List<string> selectedTiniffingList) // 사용하는 입장에서 게임메니저에 값을 Set  셋팅시킨다
    {
        this.selectedTiniffingList = selectedTiniffingList.ToList();
    }
    public List<string>  GetSelectedTiniffingList()  // 사용하는 입장에서 Get
    {

        return selectedTiniffingList;
    }

    // 리스트에 있는 티니핑 목록을 하나하나 지우면서 그 List의 Count가 0이 되었을 때 클리어!
    public void IngameClearCheck(string findTiniffingName)
    {
        selectedTiniffingList.Remove(findTiniffingName); // 찾은 티니핑 리스트에서 지우기

        //하나의 맵 클리어
        if (selectedTiniffingList.Count == 0) 
            MapClear();
    }
    IEnumerator FinalStageClearCoroutine()
    {
        InGameManager.instance.OnCurtainDownEvent();

        yield return YieldInstructionCache.WaitForSeconds(1.5f);
        InGameManager.instance.ClearEffectOn();
        yield return YieldInstructionCache.WaitForSeconds(2f);

        InGameManager.instance.ClearEffectOff();

        PopupContainer.CreatePopup(PopupType.InGameFinalStageClearPopup).Init();
    }
    IEnumerator StageClearCoroutine()
    {
        LocalValue.isScenarioFinished = false;// 시나리오 컴플리트 체크 초기화용
        var lobbyTable = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == LocalValue.Click_Stage_H);

        InGameManager.instance.OnCurtainDownEvent();

        yield return YieldInstructionCache.WaitForSeconds(1.5f);
        InGameManager.instance.ClearEffectOn();
        yield return new WaitForSeconds(2f);

        InGameManager.instance.ClearEffectOff();

        if(lobbyTable.stage_no%5==0 && lobbyTable.retry==0)
        {
            GameObject scenarioObj = Instantiate(Resources.Load<GameObject>("Prefabs/ETC/Scenario"),InGameManager.instance.canvasTr);
            scenarioObj.GetComponent<ScenarioController>().Init(lobbyTable.script_id);
            yield return new WaitUntil(()=> LocalValue.isScenarioFinished);
        }

        PopupContainer.CreatePopup(PopupType.InGameClearPopup).Init();
    }
    private void MapClear()
    {
        int chapter_no = LocalValue.Click_Chapter_H;
        int map_check_h = LocalValue.Map_H;
        int stage_no = LocalValue.Click_Stage_H;

        //map_check 가 0이면 아직 끝난게 아니고 1이면 끝나서 clear를 체킹해줘야함
        if (map_check_h == 0)
        {
            LocalValue.Map_H = 1;
            TiniffingSpotManager.instance.OnSpread( stage_no, isDelay: true);
            return;
        }
        // map_check ==1 이었을때 클리어 했다면
        StageClear(chapter_no, stage_no);
    }
    private void StageClear(int chapter_no, int stage_no)
    {
        InGameTimer.instance.ClearGame_Variable_Setting();         // InGameTimer의 state를 clear로 바꾸고 남은시간 return 받기
        float remainTime = InGameTimer.instance.GetRemainTime(); // 남은시간 받아오기
        LocalValue.Remain_Second = (int)remainTime;

        // 로비테이블 업데이트를 위해 정보받아오기
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == stage_no);
        var nextLobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == stage_no + 1); // 다음 stage 정보 열어줘야하기위한 용도
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        CheckPlayTimeAndGiveReward(saveTable, lobbyData, nextLobbyData, remainTime, chapter_no);
        lobbyData.clear = 1; // 클리어 체크
        DataService.Instance.UpdateData(lobbyData); // 바뀐정보 디비에 업데이트
        DataService.Instance.UpdateData(nextLobbyData);
        CheckIsLatestClear(saveTable, stage_no);
        LocalValue.isStageFinished = true;
    }
    private void CheckPlayTimeAndGiveReward(Table.SaveTable saveTable , Table.LobbyTable lobbyData, Table.LobbyTable nextLobbyData, float remainTime, int chapter_no)
    {
        // 별개수 기준 받아오기
        string baseDetailStarCountCheckStr = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 2 && x.sequence == chapter_no).data;
        string[] standard_of_star_count_check_array = baseDetailStarCountCheckStr.Split(':'); // 받아온 string 데이터를 : 기준으로 잘라서 배열에 저장
        int now_star_count = 0;

        if (remainTime >= int.Parse(standard_of_star_count_check_array[1]))
        {
            // 별 3개
            now_star_count = 3;
            lobbyData.box_image_name = "3_boxing"; // 3개는 굳이 경우 따질 필요없음 , 하트감소도 없음

            var teeniepingMindData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == chapter_no);
            // -------------스타티켓 체킹----------------
            if (lobbyData.clear == 1)
            {
                lobbyData.retry = 1;
                if (lobbyData.star_count < now_star_count) //방금 클리어 한 판이 별의 개수가 더 많을 시
                {
                    HeartTime.Instance.AddHeart();
                    Debug.LogError("user starcount : " + lobbyData.star_count.ToString()  );
                    saveTable.star_coin += now_star_count - lobbyData.star_count; // 차이만큼 스타티켓 추가
                    saveTable.gold += (now_star_count - lobbyData.star_count) * 100;
                    LocalValue.Get_StarCoin = now_star_count - lobbyData.star_count; // ClearPopup에 보상목록에 보여줄 획득한 스타코인 양               
                    LocalValue.Get_Gold = (now_star_count - lobbyData.star_count) * 100;
                    lobbyData.star_count = 3;
                    teeniepingMindData.mind_count++;
                    LocalValue.isTeeniepingMindGet = true;
                    DataService.Instance.UpdateData(teeniepingMindData);
                }
                else // 그전에도 3별클이었고 이번도 3별클
                {
                    LocalValue.Get_StarCoin = 0;
                    LocalValue.Get_Gold = 0;
                }
                LocalValue.Now_StarCount = 3; // clear popup title 에 보여줄 스테이지 결과용 별  
            }
            else // 처음 플레이 한 스테이지라면
            {
                HeartTime.Instance.AddHeart();
                LocalValue.Now_StarCount = 3; // clear popup title 에 보여줄 스테이지 결과용 별
                LocalValue.Get_StarCoin = 3;
                LocalValue.Get_Gold = 300;
                lobbyData.star_count = 3;
                saveTable.star_coin += lobbyData.star_count; // 별 개수 만큼 스타티켓 추가해줌
                saveTable.gold += 300;
                nextLobbyData.box_image_name = "unboxing"; // 다음스테이지 박스 언박싱상태로 변경
                teeniepingMindData.mind_count++;
                LocalValue.isTeeniepingMindGet = true;
                DataService.Instance.UpdateData(teeniepingMindData);
            }
        }
        else if (remainTime >= int.Parse(standard_of_star_count_check_array[0]))
        {
            //별 2개
            now_star_count = 2;
            if (lobbyData.clear == 1) // 이미 클리어를 한번 한 상태일 경우
            {
                Debug.LogError("user starcount : " + lobbyData.star_count.ToString());

                lobbyData.retry = 1; // 재도전 했다는거 체크해주기
                // ----------------스타티켓 체킹----------------------  
                if (lobbyData.star_count < now_star_count) // 방금 클리어 한 판이 별의 개수가 더 많을 시에만 1)박스이미지를 바꿈 2)별개수 바꿈 3) 스타티켓추가
                {
                    saveTable.star_coin += now_star_count - lobbyData.star_count; // 차이만큼 스타티켓 추가
                    saveTable.gold += (now_star_count - lobbyData.star_count) * 100;
                    LocalValue.Get_StarCoin = now_star_count - lobbyData.star_count; // ClearPopup에 보상목록에 보여줄 획득한 스타코인 양
                    LocalValue.Get_Gold = (now_star_count - lobbyData.star_count) * 100;
                    lobbyData.box_image_name = "2_boxing";
                    lobbyData.star_count = now_star_count;
                }
                else // 그전에도 2별클이었고 이번도 2별클
                {
                    LocalValue.Get_StarCoin = 0;
                    LocalValue.Get_Gold = 0;
                }
                LocalValue.Now_StarCount = 2; // clear popup title 에 보여줄 스테이지 결과용 별
            }
            else // 처음 플레이 한 스테이지라면
            {
                LocalValue.Now_StarCount = 2; // clear popup title 에 보여줄 스테이지 결과용 별
                LocalValue.Get_StarCoin = 2;
                LocalValue.Get_Gold = 200;
                lobbyData.box_image_name = "2_boxing"; // 박스 이미지 체인지
                lobbyData.star_count = 2; // lobbydata  starcount update
                saveTable.star_coin += lobbyData.star_count; // 별 개수 만큼 스타티켓 추가해줌
                saveTable.gold += 200;
                nextLobbyData.box_image_name = "unboxing"; // 다음스테이지 박스 언박싱상태로 변경
            }
        }
        else
        {
            // 별 1개
            if (lobbyData.clear == 1) // 이미 클리어를 한번 한 상태일 경우
            {
                lobbyData.retry = 1;
                // ----------------스타티켓 체킹---------------------
                // 일단 이미 클리어를 한번 했던 상태에서, 별 1개를 얻었을 경우 스타티켓 추가를 체킹할 것은 없다
                // 왜냐하면 이전 판이 적어도 별 1개를 얻었을 것이고, 이번 판도 별 1개이면  그 차이가 0과 마이너스 일것임  
                // 또한 마찬가지의 이유로 이미 한번 했었고 이번판이 별 1개의 결과라면 굳이 박스 이미지를 바꿀필요가 없음
                // 해당경우 gold 또한 업데이트 할 필요가 없다
                LocalValue.Get_StarCoin = 0; // 그전에도 1별클 이번에도 1별클
                LocalValue.Get_Gold = 0;
                LocalValue.Now_StarCount = 1; // clear popup title 에 보여줄 스테이지 결과용 별
            }
            else // 처음 플레이 한 스테이지라면
            {
                LocalValue.Now_StarCount = 1; // clear popup title 에 보여줄 스테이지 결과용 별
                LocalValue.Get_StarCoin = 1;
                LocalValue.Get_Gold = 100;
                lobbyData.box_image_name = "1_boxing"; // 박스 이미지 체인지
                lobbyData.star_count = 1;
                saveTable.star_coin += lobbyData.star_count; // 별 개수 만큼 스타티켓 추가해줌
                nextLobbyData.box_image_name = "unboxing"; // 다음스테이지 박스 언박싱상태로 변경
                saveTable.gold += 100;
            }
        }
    }
    private void CheckIsLatestClear(Table.SaveTable saveTable, int stage_no)
    {
        // 클리어시 현재 스테이지 체크
        if (saveTable.chapter_no == saveTable.now_chapter_no && saveTable.stage_no == LocalValue.Click_Stage_H) // 가장 최신 스테이지를 클리어 한 것 일때
        {
            if (stage_no % 20 == 0) // 마지막 스테이지 번호는 항상 20의 배수임
            {  
                saveTable.chapter_no++;
                saveTable.stage_no++;
//                saveTable.now_chapter_no = saveTable.chapter_no;
                if(saveTable.chapter_no==4)
                {
                    saveTable.game_clear = 1;
                }
                DataService.Instance.UpdateData(saveTable);
              
                // 연출 및 팝업
                StartCoroutine(FinalStageClearCoroutine());
            }
            else // 끝 스테이지가 아닐때
            {
                saveTable.stage_no++;
                DataService.Instance.UpdateData(saveTable);

                // 연출 및 팝업
                StartCoroutine(StageClearCoroutine());
            }
        }
        else // 최신 챕터 및 스테이지를 하고 있는 것이 아니라 과거의 것을 재탕하고 있는 경우
        {
            DataService.Instance.UpdateData(saveTable);
            if (stage_no%20 == 0)
                StartCoroutine(FinalStageClearCoroutine());
            else
                StartCoroutine(StageClearCoroutine());
        }
    }
    // 게임 껐다 켰을때 얻을 하트 체킹해주는 함수
    private int OnTimeDifferenceCalculator()
    {
        DateTime now = DateTime.Now;
        TimeSpan timeSpan;
        DateTime lastTime;

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string last_time = saveTable.last_time;
        int cct = saveTable.cumulative_cycle_time;

        lastTime = Convert.ToDateTime(last_time); // 디비로 부터 받아온 스트링 타입의 접속시간을 DateTime으로 형 변환
        timeSpan = now - lastTime; //  앱 끄고 켰을때 시간차이 
        // milisecond
        int progressTime = (int)timeSpan.TotalSeconds; // double 형이라 int로 형변환 해줘야함
        progressTime += cct; // + 앱 끄기 전 누적시간
        Debug.Log("progresstime : " + progressTime);
        return progressTime;       
    }
#if UNITY_EDITOR
#elif UNITY_ANDROID || UNITY_IOS
    private void OnApplicationPause(bool pause) // 홈 버튼 클릭 => 팝업 => 환경설정 
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.last_time = DateTime.Now.ToString();
        saveTable.cumulative_cycle_time = HeartTime.Instance.GetProgressTime();
        DataService.Instance.UpdateData(saveTable);

        if (pause == true && !LocalValue.isStageFinished && PopupContainer.GetActivatedPopup() ==null) // 현재 떠있는 팝업이 없고 스테이지가 클리어된 상황이 아닐시
        {
            if (SceneManager.GetActiveScene().name == "InGameScene_H") // 현재 씬이 InGame 씬이라면 
            {
                // 인 게임 씬의 일시정지 팝업 열기
                PopupContainer.CreatePopup(PopupType.InGamePausePopup).Init();
            }
        }
    }
#endif
    private void OnApplicationQuit()  //애플리케이션이 종료되기 전에 모든 게임오브젝트에 전달합니다.    // 꺼질때 => cct 도 저장해야됨 여기서
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.last_time = DateTime.Now.ToString();
        saveTable.cumulative_cycle_time = HeartTime.Instance.GetProgressTime();
        DataService.Instance.UpdateData(saveTable);
}
    private void OnDestroy()
    {
        //instance = null;
    }
}
