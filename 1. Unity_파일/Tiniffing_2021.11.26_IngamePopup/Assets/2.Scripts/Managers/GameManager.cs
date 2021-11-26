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
            // Awake�� ���α׷��� �����Ҷ� �ѹ��� ȣ��Ǳ⶧���� awake�� ���µ� instance�� ä�����ִٴ°Ŵ� �̹� �� ������ ȣ��Ǿ��ٴ� �ǹ��̹Ƿ�
            // ��� �����Ѱ��� �����ش�.
            return;

        }
        _instance = this;
        DontDestroyOnLoad(gameObject);

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.now_chapter_no = saveTable.chapter_no; // ���������� now_chapter_no ��  �ֽ� é�ͷ� �ʱ�ȭ

        var maxHeartCount = DataService.Instance.GetData<Table.BaseTable>(0).data; // ��Ʈ �ƽ� ���� �����ִ� ��
        var oneHeartGetNeedTime = DataService.Instance.GetData<Table.BaseTable>(1).data; // ��Ʈ �ϳ� ������� �ð�

        HeartTime.Instance.SetMaxCount(maxHeartCount);
        HeartTime.Instance.SetMaxTime(oneHeartGetNeedTime);
       // saveTable.heart_count = 5;
        int heartCount = saveTable.heart_count;
        int processtime;

        if (saveTable.newbie == 0) // �� ó�� ������ ����
        {
            processtime = 0;
        }
        else // ��������
        {
            processtime = OnTimeDifferenceCalculator();
        }

        HeartTime.Instance.Initialize(heartCount, processtime);
        Debug.LogError($"{nameof(saveTable.newbie)} = {saveTable.newbie}, {nameof(heartCount)} = {heartCount}, {nameof(processtime)} = {processtime}");
        
        DataService.Instance.UpdateData(saveTable);

        // OnTimeDifferenceCalculator() 
        // ���� ������� ���ӱ��� �ð����̰�� �� ó�� 
        // LobbySceneInit() ���� ���� ȣ��Ǿ�� ��! -> ������ DB �� ����������ؼ� 

        // heart Time�� Refresh�� LobbyUIInfo���� �� ����
    }
    private void Start() //�� �ε�� �ش����̾�Ű ���ӿ�����Ʈ ������� ��� ���� �ѹ�
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
        if (Input.GetKeyDown(KeyCode.Escape)) // �ڷΰ��� ��ư Ŭ��
        {
            if (PopupContainer.GetActivatedPopup() != null && !LocalValue.isStageFinished) // �̹� �� �ִ� �˾��� �����ϸ�
            {
                PopupContainer.GetActivatedPopup().Close(); // �ش� �˾��� ���ش�
            }
            else // Ȱ��ȭ�Ǿ��ִ� �˾��� �������� �ʴ´ٸ�
            {
                if (SceneManager.GetActiveScene().name == "InGameScene_H" && !LocalValue.isStageFinished) // ���� ���� InGame ���̸鼭 ���������� ���� ��Ȳ�� �ƴҶ�
                {                    
                    PopupContainer.CreatePopup(PopupType.InGamePausePopup).Init();
                }
                else if (SceneManager.GetActiveScene().name == "LobbyScene_H")
                {
                    // ȯ�漳�� �˾� ����
                    PopupContainer.CreatePopup(PopupType.SettingUpPopup).Init();
                }
            }
        }
    }

    public void SetSelectedTiniffingList(List<string> selectedTiniffingList) // ����ϴ� ���忡�� ���Ӹ޴����� ���� Set  ���ý�Ų��
    {
        this.selectedTiniffingList = selectedTiniffingList.ToList();
    }
    public List<string>  GetSelectedTiniffingList()  // ����ϴ� ���忡�� Get
    {

        return selectedTiniffingList;
    }

    // ����Ʈ�� �ִ� Ƽ���� ����� �ϳ��ϳ� ����鼭 �� List�� Count�� 0�� �Ǿ��� �� Ŭ����!
    public void IngameClearCheck(string findTiniffingName)
    {
        selectedTiniffingList.Remove(findTiniffingName); // ã�� Ƽ���� ����Ʈ���� �����

        //�ϳ��� �� Ŭ����
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
        LocalValue.isScenarioFinished = false;// �ó����� ���ø�Ʈ üũ �ʱ�ȭ��
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

        //map_check �� 0�̸� ���� ������ �ƴϰ� 1�̸� ������ clear�� üŷ�������
        if (map_check_h == 0)
        {
            LocalValue.Map_H = 1;
            TiniffingSpotManager.instance.OnSpread( stage_no, isDelay: true);
            return;
        }
        // map_check ==1 �̾����� Ŭ���� �ߴٸ�
        StageClear(chapter_no, stage_no);
    }
    private void StageClear(int chapter_no, int stage_no)
    {
        InGameTimer.instance.ClearGame_Variable_Setting();         // InGameTimer�� state�� clear�� �ٲٰ� �����ð� return �ޱ�
        float remainTime = InGameTimer.instance.GetRemainTime(); // �����ð� �޾ƿ���
        LocalValue.Remain_Second = (int)remainTime;

        // �κ����̺� ������Ʈ�� ���� �����޾ƿ���
        var lobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == stage_no);
        var nextLobbyData = DataService.Instance.GetDataList<Table.LobbyTable>().Find(x => x.stage_no == stage_no + 1); // ���� stage ���� ��������ϱ����� �뵵
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        CheckPlayTimeAndGiveReward(saveTable, lobbyData, nextLobbyData, remainTime, chapter_no);
        lobbyData.clear = 1; // Ŭ���� üũ
        DataService.Instance.UpdateData(lobbyData); // �ٲ����� ��� ������Ʈ
        DataService.Instance.UpdateData(nextLobbyData);
        CheckIsLatestClear(saveTable, stage_no);
        LocalValue.isStageFinished = true;
    }
    private void CheckPlayTimeAndGiveReward(Table.SaveTable saveTable , Table.LobbyTable lobbyData, Table.LobbyTable nextLobbyData, float remainTime, int chapter_no)
    {
        // ������ ���� �޾ƿ���
        string baseDetailStarCountCheckStr = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 2 && x.sequence == chapter_no).data;
        string[] standard_of_star_count_check_array = baseDetailStarCountCheckStr.Split(':'); // �޾ƿ� string �����͸� : �������� �߶� �迭�� ����
        int now_star_count = 0;

        if (remainTime >= int.Parse(standard_of_star_count_check_array[1]))
        {
            // �� 3��
            now_star_count = 3;
            lobbyData.box_image_name = "3_boxing"; // 3���� ���� ��� ���� �ʿ���� , ��Ʈ���ҵ� ����

            var teeniepingMindData = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>().Find(x => x.get_chapter == chapter_no);
            // -------------��ŸƼ�� üŷ----------------
            if (lobbyData.clear == 1)
            {
                lobbyData.retry = 1;
                if (lobbyData.star_count < now_star_count) //��� Ŭ���� �� ���� ���� ������ �� ���� ��
                {
                    HeartTime.Instance.AddHeart();
                    Debug.LogError("user starcount : " + lobbyData.star_count.ToString()  );
                    saveTable.star_coin += now_star_count - lobbyData.star_count; // ���̸�ŭ ��ŸƼ�� �߰�
                    saveTable.gold += (now_star_count - lobbyData.star_count) * 100;
                    LocalValue.Get_StarCoin = now_star_count - lobbyData.star_count; // ClearPopup�� �����Ͽ� ������ ȹ���� ��Ÿ���� ��               
                    LocalValue.Get_Gold = (now_star_count - lobbyData.star_count) * 100;
                    lobbyData.star_count = 3;
                    teeniepingMindData.mind_count++;
                    LocalValue.isTeeniepingMindGet = true;
                    DataService.Instance.UpdateData(teeniepingMindData);
                }
                else // �������� 3��Ŭ�̾��� �̹��� 3��Ŭ
                {
                    LocalValue.Get_StarCoin = 0;
                    LocalValue.Get_Gold = 0;
                }
                LocalValue.Now_StarCount = 3; // clear popup title �� ������ �������� ����� ��  
            }
            else // ó�� �÷��� �� �����������
            {
                HeartTime.Instance.AddHeart();
                LocalValue.Now_StarCount = 3; // clear popup title �� ������ �������� ����� ��
                LocalValue.Get_StarCoin = 3;
                LocalValue.Get_Gold = 300;
                lobbyData.star_count = 3;
                saveTable.star_coin += lobbyData.star_count; // �� ���� ��ŭ ��ŸƼ�� �߰�����
                saveTable.gold += 300;
                nextLobbyData.box_image_name = "unboxing"; // ������������ �ڽ� ��ڽ̻��·� ����
                teeniepingMindData.mind_count++;
                LocalValue.isTeeniepingMindGet = true;
                DataService.Instance.UpdateData(teeniepingMindData);
            }
        }
        else if (remainTime >= int.Parse(standard_of_star_count_check_array[0]))
        {
            //�� 2��
            now_star_count = 2;
            if (lobbyData.clear == 1) // �̹� Ŭ��� �ѹ� �� ������ ���
            {
                Debug.LogError("user starcount : " + lobbyData.star_count.ToString());

                lobbyData.retry = 1; // �絵�� �ߴٴ°� üũ���ֱ�
                // ----------------��ŸƼ�� üŷ----------------------  
                if (lobbyData.star_count < now_star_count) // ��� Ŭ���� �� ���� ���� ������ �� ���� �ÿ��� 1)�ڽ��̹����� �ٲ� 2)������ �ٲ� 3) ��ŸƼ���߰�
                {
                    saveTable.star_coin += now_star_count - lobbyData.star_count; // ���̸�ŭ ��ŸƼ�� �߰�
                    saveTable.gold += (now_star_count - lobbyData.star_count) * 100;
                    LocalValue.Get_StarCoin = now_star_count - lobbyData.star_count; // ClearPopup�� �����Ͽ� ������ ȹ���� ��Ÿ���� ��
                    LocalValue.Get_Gold = (now_star_count - lobbyData.star_count) * 100;
                    lobbyData.box_image_name = "2_boxing";
                    lobbyData.star_count = now_star_count;
                }
                else // �������� 2��Ŭ�̾��� �̹��� 2��Ŭ
                {
                    LocalValue.Get_StarCoin = 0;
                    LocalValue.Get_Gold = 0;
                }
                LocalValue.Now_StarCount = 2; // clear popup title �� ������ �������� ����� ��
            }
            else // ó�� �÷��� �� �����������
            {
                LocalValue.Now_StarCount = 2; // clear popup title �� ������ �������� ����� ��
                LocalValue.Get_StarCoin = 2;
                LocalValue.Get_Gold = 200;
                lobbyData.box_image_name = "2_boxing"; // �ڽ� �̹��� ü����
                lobbyData.star_count = 2; // lobbydata  starcount update
                saveTable.star_coin += lobbyData.star_count; // �� ���� ��ŭ ��ŸƼ�� �߰�����
                saveTable.gold += 200;
                nextLobbyData.box_image_name = "unboxing"; // ������������ �ڽ� ��ڽ̻��·� ����
            }
        }
        else
        {
            // �� 1��
            if (lobbyData.clear == 1) // �̹� Ŭ��� �ѹ� �� ������ ���
            {
                lobbyData.retry = 1;
                // ----------------��ŸƼ�� üŷ---------------------
                // �ϴ� �̹� Ŭ��� �ѹ� �ߴ� ���¿���, �� 1���� ����� ��� ��ŸƼ�� �߰��� üŷ�� ���� ����
                // �ֳ��ϸ� ���� ���� ��� �� 1���� ����� ���̰�, �̹� �ǵ� �� 1���̸�  �� ���̰� 0�� ���̳ʽ� �ϰ���  
                // ���� ���������� ������ �̹� �ѹ� �߾��� �̹����� �� 1���� ������ ���� �ڽ� �̹����� �ٲ��ʿ䰡 ����
                // �ش��� gold ���� ������Ʈ �� �ʿ䰡 ����
                LocalValue.Get_StarCoin = 0; // �������� 1��Ŭ �̹����� 1��Ŭ
                LocalValue.Get_Gold = 0;
                LocalValue.Now_StarCount = 1; // clear popup title �� ������ �������� ����� ��
            }
            else // ó�� �÷��� �� �����������
            {
                LocalValue.Now_StarCount = 1; // clear popup title �� ������ �������� ����� ��
                LocalValue.Get_StarCoin = 1;
                LocalValue.Get_Gold = 100;
                lobbyData.box_image_name = "1_boxing"; // �ڽ� �̹��� ü����
                lobbyData.star_count = 1;
                saveTable.star_coin += lobbyData.star_count; // �� ���� ��ŭ ��ŸƼ�� �߰�����
                nextLobbyData.box_image_name = "unboxing"; // ������������ �ڽ� ��ڽ̻��·� ����
                saveTable.gold += 100;
            }
        }
    }
    private void CheckIsLatestClear(Table.SaveTable saveTable, int stage_no)
    {
        // Ŭ����� ���� �������� üũ
        if (saveTable.chapter_no == saveTable.now_chapter_no && saveTable.stage_no == LocalValue.Click_Stage_H) // ���� �ֽ� ���������� Ŭ���� �� �� �϶�
        {
            if (stage_no % 20 == 0) // ������ �������� ��ȣ�� �׻� 20�� �����
            {  
                saveTable.chapter_no++;
                saveTable.stage_no++;
//                saveTable.now_chapter_no = saveTable.chapter_no;
                if(saveTable.chapter_no==4)
                {
                    saveTable.game_clear = 1;
                }
                DataService.Instance.UpdateData(saveTable);
              
                // ���� �� �˾�
                StartCoroutine(FinalStageClearCoroutine());
            }
            else // �� ���������� �ƴҶ�
            {
                saveTable.stage_no++;
                DataService.Instance.UpdateData(saveTable);

                // ���� �� �˾�
                StartCoroutine(StageClearCoroutine());
            }
        }
        else // �ֽ� é�� �� ���������� �ϰ� �ִ� ���� �ƴ϶� ������ ���� �����ϰ� �ִ� ���
        {
            DataService.Instance.UpdateData(saveTable);
            if (stage_no%20 == 0)
                StartCoroutine(FinalStageClearCoroutine());
            else
                StartCoroutine(StageClearCoroutine());
        }
    }
    // ���� ���� ������ ���� ��Ʈ üŷ���ִ� �Լ�
    private int OnTimeDifferenceCalculator()
    {
        DateTime now = DateTime.Now;
        TimeSpan timeSpan;
        DateTime lastTime;

        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        string last_time = saveTable.last_time;
        int cct = saveTable.cumulative_cycle_time;

        lastTime = Convert.ToDateTime(last_time); // ���� ���� �޾ƿ� ��Ʈ�� Ÿ���� ���ӽð��� DateTime���� �� ��ȯ
        timeSpan = now - lastTime; //  �� ���� ������ �ð����� 
        // milisecond
        int progressTime = (int)timeSpan.TotalSeconds; // double ���̶� int�� ����ȯ �������
        progressTime += cct; // + �� ���� �� �����ð�
        Debug.Log("progresstime : " + progressTime);
        return progressTime;       
    }
#if UNITY_EDITOR
#elif UNITY_ANDROID || UNITY_IOS
    private void OnApplicationPause(bool pause) // Ȩ ��ư Ŭ�� => �˾� => ȯ�漳�� 
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        saveTable.last_time = DateTime.Now.ToString();
        saveTable.cumulative_cycle_time = HeartTime.Instance.GetProgressTime();
        DataService.Instance.UpdateData(saveTable);

        if (pause == true && !LocalValue.isStageFinished && PopupContainer.GetActivatedPopup() ==null) // ���� ���ִ� �˾��� ���� ���������� Ŭ����� ��Ȳ�� �ƴҽ�
        {
            if (SceneManager.GetActiveScene().name == "InGameScene_H") // ���� ���� InGame ���̶�� 
            {
                // �� ���� ���� �Ͻ����� �˾� ����
                PopupContainer.CreatePopup(PopupType.InGamePausePopup).Init();
            }
        }
    }
#endif
    private void OnApplicationQuit()  //���ø����̼��� ����Ǳ� ���� ��� ���ӿ�����Ʈ�� �����մϴ�.    // ������ => cct �� �����ؾߵ� ���⼭
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
