using System.Text;
using UnityEngine;
using UnityEngine.Assertions;

public class HeartTime
{
    private static HeartTime instance;
    public static HeartTime Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new HeartTime();
            }
            return instance;

        }
    }


    private readonly StringBuilder stringBuilder;

    private int count; // 현재 가지고 있는 하트 개수
    private int maxCount; // 최대 얻을 수 있는 하트개수

    private float savedTime;
    private float progressTime; // 1개 얻기위해 남아있는 타임  , 
    private float maxTime; // 1개 얻기위해 필요한 시간 : 15분 (900초)

    public event System.Action OnUpdateTime; // 외부에서 함수 걸어줄 Action event

    public HeartTime()
    {
        stringBuilder = new StringBuilder();
    }

    public void Initialize(int count, float time)// count, progress타임
    {
        this.count = count;
        this.progressTime = time;
        
        if(!IsMax())
            savedTime = Time.time;

        
        RefreshEvent();
    }
 
    public void SetMaxCount(int maxCount, bool isRefresh = false)
    {
        this.maxCount = maxCount;

        if (isRefresh)
        {
            RefreshEvent();
        }
    }

    public void SetMaxTime(float maxTime, bool isRefresh = false)
    {
        this.maxTime = maxTime;

        if (isRefresh)
        {
            RefreshEvent();
        }
    }
    public void HeartCountRefresh()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        count = saveTable.heart_count;
        RefreshEvent();
    }

    public int GetProgressTime()
    {
        return (int)progressTime; //  System.TimeSpan.FromSeconds(progressTime).Seconds();
    }
    public void AddMaxCount(int value) // 광고나 캐쉬로 하트를 구매할 시 하트  add 할 함수
    {
        RefreshEvent();
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);

        count += value;

        saveTable.heart_count = count;
        DataService.Instance.UpdateData(saveTable); // update

        OnUpdateTime?.Invoke();
    }
    public void AddHeart()
    {
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        ++count;
        saveTable.heart_count = count;
        DataService.Instance.UpdateData(saveTable);
        RefreshEvent();
        OnUpdateTime?.Invoke(); // 체인 걸려있으면 해당 함수를 실행
    }
    public void UseHeart()
    {
        if(IsMax())
        {
            savedTime = Time.time;
            progressTime = 0;
        }
        var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
        --count;       
        saveTable.heart_count = count;
        DataService.Instance.UpdateData(saveTable);    
        RefreshEvent();
        OnUpdateTime?.Invoke(); // 체인 걸려있으면 해당 함수를 실행
    }

    public bool IsMax() // 현재 유저의 하트 개수가 Max인지 아닌지 여부 체크
    {
        return count >= maxCount;
    }

    public void Refresh()
    {
        Assert.IsTrue(maxTime > 0f, "First SetMaxTime");
        float nowTime = Time.time;

        if (!IsMax())
        {
            float diff = nowTime - savedTime; // 게임 켜진 처음에는 savedTime 빼줄게 없음 0으로 되어있을거임
            progressTime += diff;
            TimeCalculate();
            OnUpdateTime?.Invoke();
        }
        savedTime = nowTime;
    }

    public string GetCountText() // 현재 하트 개수를 텍스트로 받아오는 함수
    {
        stringBuilder.Length = 0;
        return stringBuilder.Append(count).ToString();
    }
    
    public string GetRemainTimeText() // 1개 얻기위해 현재 남은시간을 텍스트로 받아오는 함수
    {
        if (IsMax())
            return "Max";

        return System.TimeSpan.FromSeconds(maxTime - progressTime)
            .ToString(@"mm\:ss");
    }

    private void TimeCalculate() // 하트 개수 증가 시켜주는 곳
    {
        while (progressTime >= maxTime) //  흘러간 시간 >=  하나 얻는데 필요한 시간
        {
            progressTime -= maxTime; // 15분 에서 외부로부터 전달받은 time을 빼줌 

            if (IsMax()) 
                break;
                  
            ++count;  // max 아니면 하트 카운트 하나 증가
            var saveTable = DataService.Instance.GetData<Table.SaveTable>(0);
            saveTable.heart_count = count;
            DataService.Instance.UpdateData(saveTable);
        }
    }

    private void RefreshEvent()
    {
        if (IsMax())
        {
            OnUpdateTime?.Invoke();
            return;
        }
        Refresh();   
    }
    
}