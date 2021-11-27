using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using DG.Tweening;


public class InGameTimer : MonoBehaviour
{
    public static InGameTimer instance;

    [SerializeField] private Image fillImage;

    [SerializeField] private Slider timerSlider;

    [SerializeField] private RectTransform sliderRectTr;
    [SerializeField] private Image timestopFillImage;

    private GameObject star_1;
    private GameObject star_2;
    private GameObject star_3;

    private int standard_0;
    private int standard_1;

    private float timer;
    private float timeMax;
    private bool isDangerBarChanged = false;
    private bool isTimeStopBarChanged = false;
    private float remain_time;

    private State state;
    private State temp_state;
    private void Awake()  // �� ��ũ��Ʈ�� �پ��ִ� ������Ʈ�� �޷��ִ� ���� �ε�ɶ� ȣ��
    {
        if (instance == null)
            instance = this;
        /*else if (instance != this)
        {
            Destroy(gameObject);
            return;
        }*/
    }

    public void Init() // init ȣ������ Max ����
    {

        timer = timeMax;

        //�� ������ �޾ƿ��� 1, 2, 3�� ��

        star_1 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_1"), sliderRectTr);
        star_2 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_2"), sliderRectTr);
        star_3 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_3"), sliderRectTr);

        // �� ������Ʈ rect ����
        RectTransform star_1_Rect = star_1.GetComponent<RectTransform>();
        RectTransform star_2_Rect = star_2.GetComponent<RectTransform>();
        RectTransform star_3_Rect = star_3.GetComponent<RectTransform>();

        // danger_fill image �޾ƿ���
        //dangerFillImg.sprite = Resources.Load<Sprite>("Images/InGameUI/danger_fill");

        // ��輱 ������ ����
        GameObject cloneDivisionLine = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), sliderRectTr);
        GameObject cloneDivisionLine2 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), sliderRectTr);

        // ��輱 ������Ʈ ��Ʈ Ʈ������ �ޱ�
        RectTransform cloneDivisionLine_Rect = cloneDivisionLine.GetComponent<RectTransform>();
        RectTransform cloneDivisionLine2_Rect = cloneDivisionLine2.GetComponent<RectTransform>();

        // BaseDetailTable �������� ������ é�͹�ȣ ���� 
        int sequence = LocalValue. Click_Chapter_H;
        // ���� ���������� �ش��ϴ� ���������� �ش��ϴ� ���м� ���� ������ �޾ƿ���
        var star_division_data = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 2 && x.sequence == sequence).data;

        // ������ ����
        string[] division_standard_get_star = star_division_data.Split(':');

        standard_0 = int.Parse(division_standard_get_star[0]);
        standard_1 = int.Parse(division_standard_get_star[1]);



        float x = (1080 / timeMax) * (standard_1) - 540; // �� 2���� �� 3�� ����

        cloneDivisionLine_Rect.anchoredPosition = new Vector2(x, 0); // 2�� 3 ������ ���м� ��ġ


        float x2 = (1080 / timeMax) * (standard_0) - 540;  // �� 1���� �� 2�� ����

        cloneDivisionLine2_Rect.anchoredPosition = new Vector2(x2, 0); // 1�� 2 ������ ���м� ��ġ


        float abs_x = Math.Abs(x);
        float abs_x2 = Math.Abs(x2);

        // ���� x ��ǥ ����
        float star_3_xPos = (1080 + abs_x - 540) / 2;
        float star_2_xPos = (abs_x + abs_x2 - 540) / 2;
        float star_1_xPos = (x2 + 0 - 540) / 2;


        // �� ��ġ�ϱ�
        star_3_Rect.anchoredPosition = new Vector2(star_3_xPos, -21);  // �θ��� ���� rect transform�� �������� x������ star_3_xPos ��ŭ y ������ -5 ��ŭ
        star_2_Rect.anchoredPosition = new Vector2(star_2_xPos, -21);
        star_1_Rect.anchoredPosition = new Vector2(star_1_xPos, -21);

        state = State.Idle;

        // Timer��  init ���� ���ְ� ready go ���� ����������� 
        //Timer();
    }
    public State GetTempState()
    {
        return temp_state;
    }
    public State GetState()
    {
        return state;
    }
    public void SetTempState_ver2(State changeState)
    {
        temp_state = changeState;
    }
    public void SetTempState()
    {
        temp_state = state;
    }
    public void SetStateChange(State state)
    {
        this.state = state;
    }
    public void SetTimerMinus(float value)
    {
        timer -= value;
    }
    public void SetTimerMax(float timeMax)
    {
        this.timeMax = timeMax;
    }
    public float GetRemainTime()
    {
        return remain_time;
    }

    public void Timer()
    {
        // coroutine���� timer ���
        StartCoroutine(InGameTimerCor());
    }
   
   
    IEnumerator InGameTimerCor()
    {

        while (state != State.Dead && state != State.Clear)
        {
            if (state == State.Stop) //Ÿ�ӽ�ž ������ ��� -> �Ͻ����� ���
            {
                // �ϴ� Stop ���°� ���۵Ǹ� ������ While���� ������ �� 5���Ŀ� ���´�. �� ���� ���°� �ٲ�ٰ� �ϴ��� �����Ѵ�.

                float i = 5;
                while (i > 0)
                {
                    i -= 0.2f;
                    Set_Timer();
                    if (state == State.Dead)
                    {
                        LocalValue.isStageFinished = true;

                        InGameManager.instance.OnCurtainDownEvent();

                        //Game Over ���� -> ������ ��ȯ
                        InGameManager.instance.TimeOverEventOn(); // timeover object on

                        yield return YieldInstructionCache.WaitForSeconds(2f); // 2�� ���ӽð�

                        InGameManager.instance.TimeOverEventOff(); // timeover ������Ʈ off

                        InGameManager.instance.StageFailEventOn();

                        yield return YieldInstructionCache.WaitForSeconds(2f);// fail ���� ������ �ð�

                        InGameManager.instance.StageFailEventOff(); // fail object off

                        // ��Ŭ���� �˾� 
                        PopupContainer.CreatePopup(PopupType.InGameUnclearPopup).Init();

                        yield break;
                    }
                    if (state == State.MapChange)
                    {
                        timestopFillImage.DOFade(0, 1f);// DoFade(��ǥ��, �ɸ��½ð�);
                        goto MapChange;
                    }
                    yield return YieldInstructionCache.WaitForSeconds(0.2f);
                }
                isTimeStopBarChanged = false;
                timestopFillImage.DOFade(0, 1f);// DoFade(��ǥ��, �ɸ��½ð�);
                state = temp_state;
            }
            MapChange: 
            if (state == State.MapChange)
            {
                
                yield return YieldInstructionCache.WaitForSeconds(3f);
                //3�� ��ٸ� �� ���� ���·� �ٲ��ֱ�
                state = temp_state;
            }
            if(state == State.PopupOn)
            {
                yield return new WaitWhile(()=> state == temp_state);
            }

            timer = timer - 0.1f;
            Set_Timer();

            yield return YieldInstructionCache.WaitForSeconds(0.1f); // 0.1��

        }

        if (state == State.Dead)
        {
            LocalValue.isStageFinished = true;

            InGameManager.instance.OnCurtainDownEvent();

               //Game Over ���� -> ������ ��ȯ
            InGameManager.instance.TimeOverEventOn(); // timeover object on

            yield return YieldInstructionCache.WaitForSeconds(2f); // 2�� ���ӽð�

            InGameManager.instance.TimeOverEventOff(); // timeover ������Ʈ off

            InGameManager.instance.StageFailEventOn();

            yield return YieldInstructionCache.WaitForSeconds(2f); // fail ���� ������ �ð�

            InGameManager.instance.StageFailEventOff(); // fail object off

            // ��Ŭ���� �˾� 
            PopupContainer.CreatePopup(PopupType.InGameUnclearPopup).Init();
            yield break;
        }
    }

    public void ClearGame_Variable_Setting()
    {
        remain_time = timer;
        state = State.Clear;
    }

    private void Set_Timer()
    {
        if (timer < standard_0 && isDangerBarChanged == false)
        {
            state = State.Danger;
            temp_state = State.Danger;

            if (isDangerBarChanged == false)
                fillImage.sprite = Resources.Load<Sprite>("Images/InGameUI/danger_fill");
            // InGameManager�� �����ؼ� inGameUIInfo ȣ��
            InGameManager.instance.DangerDisplay();
            isDangerBarChanged = true;
        }
        else if (timer > 0 && timer <= 1.5f)
        {
            // Ÿ�̸Ӱ� �� �ȳ������� ��Ÿ�� ���׻���°� ����ó���� ������ֱ�
            InGameManager.instance.CanvasTouchBlockOn();

            // �����̴��� Ÿ�̸Ӱ� ������ ���̴°� �����ֱ�
            fillImage.gameObject.SetActive(false);
        }
        else if (timer <= 0)
        {
            InGameManager.instance.CanvasTouchBlockOn(); //������ֱ�

            state = State.Dead;
            timer = 0;
        }

        if (isTimeStopBarChanged == false && state == State.Stop)
        {
            isTimeStopBarChanged = true;
            timestopFillImage.DOFade(1, 0f);
        }

        float plusTimer = 1f;
        // �� UI ����
        if (timer <= standard_1+ plusTimer && timer > standard_0+ plusTimer)
        {
            star_3.transform.GetChild(1).GetComponent<Image>().DOFade(0, 0.5f);
            star_3.transform.GetChild(2).gameObject.SetActive(true);
            
        }
        else if (timer <= standard_0 + plusTimer && timer>0+ plusTimer)
        {
            star_2.transform.GetChild(1).GetComponent<Image>().DOFade(0, 0.5f);
            star_2.transform.GetChild(2).gameObject.SetActive(true);
        }
        else if(timer<=0+ plusTimer)
        {
            star_1.transform.GetChild(1).GetComponent<Image>().DOFade(0, 0.5f);
            star_1.transform.GetChild(2).gameObject.SetActive(true);
        }

        // fillBar �پ��� �ϴ� ���
        timerSlider.value = timer / timeMax;

        // cloneRunnerRect.anchoredPosition = new Vector2((cloneRunnerRect.anchoredPosition.x) - ((1100 / timeMax) * (0.1f)), cloneRunnerRect.anchoredPosition.y);
        // ��ü����/ �� ������ ������ �ѷ� => ��ü���̿� ���� ������ ���̿� ���� 1�� ������ ����
        // ������ ��ġ���� - (��ü����/�� ������ ������ �ѷ�)*�پ��¼ӵ�

    }

    public enum State
    {
        Idle, 
        Dead, 
        Stop, 
        Danger,
        MapChange,
        Clear,
        PopupOn
    }
}
