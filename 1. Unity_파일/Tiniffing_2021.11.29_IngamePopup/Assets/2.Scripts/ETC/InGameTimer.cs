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
    private void Awake()  // 이 스크립트가 붙어있는 오브젝트가 달려있는 씬이 로드될때 호출
    {
        if (instance == null)
            instance = this;
        /*else if (instance != this)
        {
            Destroy(gameObject);
            return;
        }*/
    }

    public void Init() // init 호출전에 Max 설정
    {

        timer = timeMax;

        //별 프리팹 받아오기 1, 2, 3개 다

        star_1 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_1"), sliderRectTr);
        star_2 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_2"), sliderRectTr);
        star_3 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/star_3"), sliderRectTr);

        // 별 오브젝트 rect 설정
        RectTransform star_1_Rect = star_1.GetComponent<RectTransform>();
        RectTransform star_2_Rect = star_2.GetComponent<RectTransform>();
        RectTransform star_3_Rect = star_3.GetComponent<RectTransform>();

        // danger_fill image 받아오기
        //dangerFillImg.sprite = Resources.Load<Sprite>("Images/InGameUI/danger_fill");

        // 경계선 프리팹 복사
        GameObject cloneDivisionLine = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), sliderRectTr);
        GameObject cloneDivisionLine2 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), sliderRectTr);

        // 경계선 오브젝트 렉트 트랜스폼 받기
        RectTransform cloneDivisionLine_Rect = cloneDivisionLine.GetComponent<RectTransform>();
        RectTransform cloneDivisionLine2_Rect = cloneDivisionLine2.GetComponent<RectTransform>();

        // BaseDetailTable 시퀀스값 접근할 챕터번호 설정 
        int sequence = LocalValue. Click_Chapter_H;
        // 현재 스테이지에 해당하는 시퀀스값에 해당하는 구분선 기준 데이터 받아오기
        var star_division_data = DataService.Instance.GetDataList<Table.BaseDetailTable>().Find(x => x.base_table_id == 2 && x.sequence == sequence).data;

        // 데이터 분할
        string[] division_standard_get_star = star_division_data.Split(':');

        standard_0 = int.Parse(division_standard_get_star[0]);
        standard_1 = int.Parse(division_standard_get_star[1]);



        float x = (1080 / timeMax) * (standard_1) - 540; // 별 2개와 별 3개 구분

        cloneDivisionLine_Rect.anchoredPosition = new Vector2(x, 0); // 2와 3 사이의 구분선 배치


        float x2 = (1080 / timeMax) * (standard_0) - 540;  // 별 1개와 별 2개 구분

        cloneDivisionLine2_Rect.anchoredPosition = new Vector2(x2, 0); // 1과 2 사이의 구분선 배치


        float abs_x = Math.Abs(x);
        float abs_x2 = Math.Abs(x2);

        // 별의 x 좌표 설정
        float star_3_xPos = (1080 + abs_x - 540) / 2;
        float star_2_xPos = (abs_x + abs_x2 - 540) / 2;
        float star_1_xPos = (x2 + 0 - 540) / 2;


        // 별 배치하기
        star_3_Rect.anchoredPosition = new Vector2(star_3_xPos, -21);  // 부모의 기준 rect transform을 바탕으로 x축으로 star_3_xPos 만큼 y 축으로 -5 만큼
        star_2_Rect.anchoredPosition = new Vector2(star_2_xPos, -21);
        star_1_Rect.anchoredPosition = new Vector2(star_1_xPos, -21);

        state = State.Idle;

        // Timer는  init 먼저 해주고 ready go 들어갈때 접근해줘야함 
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
        // coroutine으로 timer 기능
        StartCoroutine(InGameTimerCor());
    }
   
   
    IEnumerator InGameTimerCor()
    {

        while (state != State.Dead && state != State.Clear)
        {
            if (state == State.Stop) //타임스탑 아이템 사용 -> 일시정지 기능
            {
                // 일단 Stop 상태가 시작되면 무조건 While문을 돌게한 뒤 5초후에 나온다. 그 사이 상태가 바뀐다고 하더라도 무시한다.

                float i = 5;
                while (i > 0)
                {
                    i -= 0.2f;
                    Set_Timer();
                    if (state == State.Dead)
                    {
                        LocalValue.isStageFinished = true;

                        InGameManager.instance.OnCurtainDownEvent();

                        //Game Over 연출 -> 프리팹 소환
                        InGameManager.instance.TimeOverEventOn(); // timeover object on

                        yield return YieldInstructionCache.WaitForSeconds(2f); // 2초 지속시간

                        InGameManager.instance.TimeOverEventOff(); // timeover 오브젝트 off

                        InGameManager.instance.StageFailEventOn();

                        yield return YieldInstructionCache.WaitForSeconds(2f);// fail 연출 지속할 시간

                        InGameManager.instance.StageFailEventOff(); // fail object off

                        // 언클리어 팝업 
                        PopupContainer.CreatePopup(PopupType.InGameUnclearPopup).Init();

                        yield break;
                    }
                    if (state == State.MapChange)
                    {
                        timestopFillImage.DOFade(0, 1f);// DoFade(목표값, 걸리는시간);
                        goto MapChange;
                    }
                    yield return YieldInstructionCache.WaitForSeconds(0.2f);
                }
                isTimeStopBarChanged = false;
                timestopFillImage.DOFade(0, 1f);// DoFade(목표값, 걸리는시간);
                state = temp_state;
            }
            MapChange: 
            if (state == State.MapChange)
            {
                
                yield return YieldInstructionCache.WaitForSeconds(3f);
                //3초 기다린 후 원래 상태로 바꿔주기
                state = temp_state;
            }
            if(state == State.PopupOn)
            {
                yield return new WaitWhile(()=> state == temp_state);
            }

            timer = timer - 0.1f;
            Set_Timer();

            yield return YieldInstructionCache.WaitForSeconds(0.1f); // 0.1초

        }

        if (state == State.Dead)
        {
            LocalValue.isStageFinished = true;

            InGameManager.instance.OnCurtainDownEvent();

               //Game Over 연출 -> 프리팹 소환
            InGameManager.instance.TimeOverEventOn(); // timeover object on

            yield return YieldInstructionCache.WaitForSeconds(2f); // 2초 지속시간

            InGameManager.instance.TimeOverEventOff(); // timeover 오브젝트 off

            InGameManager.instance.StageFailEventOn();

            yield return YieldInstructionCache.WaitForSeconds(2f); // fail 연출 지속할 시간

            InGameManager.instance.StageFailEventOff(); // fail object off

            // 언클리어 팝업 
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
            // InGameManager로 접근해서 inGameUIInfo 호출
            InGameManager.instance.DangerDisplay();
            isDangerBarChanged = true;
        }
        else if (timer > 0 && timer <= 1.5f)
        {
            // 타이머가 얼마 안남았을때 연타시 버그생기는거 예외처리용 블락켜주기
            InGameManager.instance.CanvasTouchBlockOn();

            // 슬라이더가 타이머가 끝나고도 보이는거 막아주기
            fillImage.gameObject.SetActive(false);
        }
        else if (timer <= 0)
        {
            InGameManager.instance.CanvasTouchBlockOn(); //블락켜주기

            state = State.Dead;
            timer = 0;
        }

        if (isTimeStopBarChanged == false && state == State.Stop)
        {
            isTimeStopBarChanged = true;
            timestopFillImage.DOFade(1, 0f);
        }

        float plusTimer = 1f;
        // 별 UI 변경
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

        // fillBar 줄어들게 하는 기능
        timerSlider.value = timer / timeMax;

        // cloneRunnerRect.anchoredPosition = new Vector2((cloneRunnerRect.anchoredPosition.x) - ((1100 / timeMax) * (0.1f)), cloneRunnerRect.anchoredPosition.y);
        // 전체길이/ 이 길이의 가상의 총량 => 전체길이에 대한 가상의 길이에 대한 1의 비율이 나옴
        // 기존의 위치에서 - (전체길이/이 길이의 가상의 총량)*줄어드는속도

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
