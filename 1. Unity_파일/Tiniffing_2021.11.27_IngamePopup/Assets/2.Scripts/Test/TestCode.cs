using System.Collections;
using UnityEngine;

public class TestCode : MonoBehaviour
{
    private static readonly WaitForSeconds waitForSeconds = new WaitForSeconds(1f);

    [SerializeField] int count = 2;
    [SerializeField] float progressTime = 400f;

    [SerializeField] int testNum = 3;

    [SerializeField] string result1;
    [SerializeField] string result2;

    private HeartTime heartTime;

    void Awake()
    {
        DontDestroyOnLoad(this);

        heartTime = new HeartTime();

        heartTime.SetMaxCount(6);
        heartTime.SetMaxTime(900f);
        heartTime.Initialize(count, progressTime);

        heartTime.OnUpdateTime += OnUpdateTime; // TestCode�� �Լ� �ɾ��ֱ�
    }

    void OnDestroy()
    {
        heartTime.OnUpdateTime -= OnUpdateTime; // ��ü �ı��� ü�� ����
    }

    IEnumerator Start()
    {
        while (true)
        {
            heartTime.Refresh(); // ������Ʈ ���
            yield return waitForSeconds;
        }
    }

    void Update()
    {
        if (Input.GetKeyUp(KeyCode.Space))
        {
            Debug.LogError("Test!!");
            heartTime.AddMaxCount(testNum);
        }
    }

    void OnUpdateTime()
    {
        result1 = heartTime.GetCountText();
        result2 = heartTime.GetRemainTimeText();
    }
}
