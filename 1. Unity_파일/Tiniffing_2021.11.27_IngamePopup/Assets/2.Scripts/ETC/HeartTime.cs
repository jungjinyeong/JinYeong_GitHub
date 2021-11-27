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

    private int count; // ���� ������ �ִ� ��Ʈ ����
    private int maxCount; // �ִ� ���� �� �ִ� ��Ʈ����

    private float savedTime;
    private float progressTime; // 1�� ������� �����ִ� Ÿ��  , 
    private float maxTime; // 1�� ������� �ʿ��� �ð� : 15�� (900��)

    public event System.Action OnUpdateTime; // �ܺο��� �Լ� �ɾ��� Action event

    public HeartTime()
    {
        stringBuilder = new StringBuilder();
    }

    public void Initialize(int count, float time)// count, progressŸ��
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
    public void AddMaxCount(int value) // ���� ĳ���� ��Ʈ�� ������ �� ��Ʈ  add �� �Լ�
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
        OnUpdateTime?.Invoke(); // ü�� �ɷ������� �ش� �Լ��� ����
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
        OnUpdateTime?.Invoke(); // ü�� �ɷ������� �ش� �Լ��� ����
    }

    public bool IsMax() // ���� ������ ��Ʈ ������ Max���� �ƴ��� ���� üũ
    {
        return count >= maxCount;
    }

    public void Refresh()
    {
        Assert.IsTrue(maxTime > 0f, "First SetMaxTime");
        float nowTime = Time.time;

        if (!IsMax())
        {
            float diff = nowTime - savedTime; // ���� ���� ó������ savedTime ���ٰ� ���� 0���� �Ǿ���������
            progressTime += diff;
            TimeCalculate();
            OnUpdateTime?.Invoke();
        }
        savedTime = nowTime;
    }

    public string GetCountText() // ���� ��Ʈ ������ �ؽ�Ʈ�� �޾ƿ��� �Լ�
    {
        stringBuilder.Length = 0;
        return stringBuilder.Append(count).ToString();
    }
    
    public string GetRemainTimeText() // 1�� ������� ���� �����ð��� �ؽ�Ʈ�� �޾ƿ��� �Լ�
    {
        if (IsMax())
            return "Max";

        return System.TimeSpan.FromSeconds(maxTime - progressTime)
            .ToString(@"mm\:ss");
    }

    private void TimeCalculate() // ��Ʈ ���� ���� �����ִ� ��
    {
        while (progressTime >= maxTime) //  �귯�� �ð� >=  �ϳ� ��µ� �ʿ��� �ð�
        {
            progressTime -= maxTime; // 15�� ���� �ܺηκ��� ���޹��� time�� ���� 

            if (IsMax()) 
                break;
                  
            ++count;  // max �ƴϸ� ��Ʈ ī��Ʈ �ϳ� ����
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