using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class Joystick : MonoBehaviour
{

    public static Joystick Instance
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<Joystick>();
                if (instance == null)
                {
                    var instanceContainer = new GameObject("JoyStick");
                    instance = instanceContainer.AddComponent<Joystick>();
                }

            }
            return instance;
        }

    }
    private static Joystick instance;

    public GameObject joyStick;
    public GameObject joyPad;
    Vector3 stickBasePosition;
    public Vector3 joyVector;
    Vector3 joyStickFirstPosition;
    float padRadius;

    private void Start()
    {
        padRadius = joyPad.gameObject.GetComponent<RectTransform>().sizeDelta.y / 2;
        joyStickFirstPosition = joyPad.transform.position; // 처음 위치 저장
    }
    public void PointDown() // 화면이 터치될 때 불리는 함수
    {
        joyPad.transform.position = Input.mousePosition;
        joyStick.transform.position = Input.mousePosition;
        stickBasePosition = Input.mousePosition;
        //SetTrigger
        //걷는 애니메이션 추가
    }
    public void Drag(BaseEventData baseEventData)
    {
        PointerEventData pointerEventData = baseEventData as PointerEventData; // pointereventdata를 이용해 드래그 위치 받아옴
        Vector3 DragPosition = pointerEventData.position;
        joyVector = (DragPosition - stickBasePosition).normalized; // 사람 손 위치에 따라 방향 계산

        float stickDistance = Vector3.Distance(DragPosition, stickBasePosition); // 패드 중심으로부터 드래그한것까지의 거리 -> 거리조절

        if (stickDistance < padRadius) //joystick이 joypad의 범위를 벗어나지 않을때
        {
            joyStick.transform.position = stickBasePosition + joyVector * stickDistance;
        }
        else // 조이패드 바같으로 넘어갈때 -> 제한걸기
        {
            joyStick.transform.position = stickBasePosition + joyVector * padRadius;
        }
    }
    public void PointUp() // 화면에서 손 뗄때
    {
        joyVector = Vector3.zero; // 캐릭터가 미끄러지지 않도록 zero값 설정
        joyPad.transform.position = joyStickFirstPosition;
        joyStick.transform.position = joyStickFirstPosition;
        //SetTrigger 애니매이션 멈춤상태로 가는 애니aa

    }
}

