using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TimerSliderTest : MonoBehaviour
{
  
    [SerializeField]
    private Image testDangerFillImage;

    [SerializeField]
    private Image testFillImage;


    [SerializeField]
    private GameObject Runner;

    [SerializeField]
    private Slider timerSlider;

    private bool isDangerBarChanged=false;
    private float timer;
    private float timeMax;

    [SerializeField]
    private RectTransform fillSliderRectTr;

    private static readonly WaitForSeconds waitForSeconds = new WaitForSeconds(0.1f);

    [SerializeField]
    GameObject obj;

    State state;

    RectTransform cloneRunnerRect;

    void Start()
    {
        timeMax = 120;
        timer = timeMax;


        /*
        GameObject cloneDivisionLine = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), fillBarRectTr);
        GameObject cloneDivisionLine2 = Instantiate(Resources.Load<GameObject>("Prefabs/InGameUI/DivisionLine"), fillBarRectTr);
        */

        testDangerFillImage.sprite = Resources.Load<Sprite>("Images/InGameUI/danger_fill");

        GameObject cloneObj = Instantiate(obj, fillSliderRectTr);
        GameObject cloneObj2 = Instantiate(obj, fillSliderRectTr);

        RectTransform cloneRect = cloneObj.GetComponent<RectTransform>();
        RectTransform cloneRect2 = cloneObj2.GetComponent<RectTransform>();


        float x = (1080 / timeMax) * (60) - 540;


        cloneRect.anchoredPosition = new Vector2(x, 0);

        float x2 = (1080 / timeMax) * 30 - 540;

        cloneRect2.anchoredPosition = new Vector2(x2, 0);

        GameObject cloneObjRunner = Instantiate(Runner, fillSliderRectTr);
        cloneRunnerRect = cloneObjRunner.GetComponent<RectTransform>();

    //    cloneRunnerRect.anchoredPosition = new Vector2(550, 20);



        state = State.Idle;
        Timer();
    }

    public void Timer()
    {

        // coroutine���� timer ���
        StartCoroutine(InGameTimerCor());

        // GameOver

    }
    public void SetMaxTime(int max)
    {
        timeMax = max;
    }
    IEnumerator InGameTimerCor()
    {

        while (state != State.Dead)
        {
            //  Debug.LogError("InGameTimer : "+ timer.ToString());

            if (state == State.Stop) //�Ͻ����� ���
            {
                yield return new WaitForSeconds(10f);
            }

            timer = timer - 0.1f;
            Set_Timer();

            yield return waitForSeconds;

        }


    }



    private void Set_Timer()
    {

        if (timer <= 0)
        {
            state = State.Dead;
        }
        else
        {
            if (timer > timeMax)
                timer = timeMax;
        }
        if (timer < 90)
        {
            state = State.Danger;
            
            if (isDangerBarChanged == false)
                testFillImage.sprite = testDangerFillImage.sprite;

            isDangerBarChanged = true;
        }
        if (state == State.Dead)
        {
            //Game Over ����
            return;
        }

        // fillBar �پ��� �ϴ� ���
        timerSlider.value = timer / timeMax;

       // cloneRunnerRect.anchoredPosition = new Vector2((cloneRunnerRect.anchoredPosition.x) - ((1100 / timeMax) * (0.1f)), cloneRunnerRect.anchoredPosition.y);
        // ��ü����/ �� ������ ������ �ѷ� => ��ü���̿� ���� ������ ���̿� ���� 1�� ������ ����
        // ������ ��ġ���� - (��ü����/�� ������ ������ �ѷ�)*�پ��¼ӵ�


    }

    enum State
    {
        Idle, Dead, Stop, Danger
    }
}
