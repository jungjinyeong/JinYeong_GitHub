using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AiController : MonoBehaviour
{
    private bool m_bIsFloor = false;
    private float m_fCurVerticalVelocity = 0f; //세로
    private float m_fCurHorizontalVelocity = -50f; //가로
    private float m_fMoveVelocity = -50f; // 임시 가로 속도 (정지 안했을때 속도)
    //중력 값 생성
    Rigidbody2D rigid;

    private AiHpController m_HpController = null;
    private UnitData m_UnitData = null;

    //start 보다 먼저 실행 코드
    void Awake()
    {
        rigid = GetComponent<Rigidbody2D>();
        m_UnitData = GetComponentInChildren<UnitData>();
        m_HpController = GetComponentInChildren<AiHpController>();
        if (m_UnitData != null)
        Debug.Log($"****[UnitData] Unit Name : {m_UnitData.m_strName}");
    }

    private void Start()
    {
        m_fCurHorizontalVelocity = m_fMoveVelocity;
    }

    //이동 코드 실행
    void FixedUpdate()
    {
        AiMove();

        if(m_bIsFloor == false) //바닥에 안닿아있으면 중력을 준다.
        {
            m_fCurVerticalVelocity = rigid.velocity.y;
        }
        else // 바닥에 닿아으면 중력 0
        {
            m_fCurVerticalVelocity = 0;
        }

    }


    //이동 코드
    void AiMove()
    {
        rigid.velocity = new Vector2(m_fCurHorizontalVelocity, m_fCurVerticalVelocity);
    }

    //충돌 했을 때 가져오는 함수
    private void OnCollisionEnter2D(Collision2D collision)
    {
        //"MyUnit"이름과 충돌했을 경우
        if (collision.gameObject.name == "Unit_Me")
        {
            m_fCurHorizontalVelocity = 0f;
            Debug.Log("Unit_Me와 충돌");
            AlarmManager.Instance.EventOnAlarm();
            return;
        }
        //"Unit"태그와 충돌했을 경우
        else if (collision.gameObject.tag == "Unit")
        {
            m_fCurHorizontalVelocity = 0f;
            Debug.Log("Unit 충돌 & 스피드 0");
        }
        //바닥이랑 충돌했을 경우
        if(collision.gameObject.tag == "Floor")
        {
            m_fCurVerticalVelocity = 0f;
            m_bIsFloor = true;
            Debug.Log("바닥이양");
        }
    }

    //계속 충돌하고 있을 때 가져오는 함수
    private void OnCollisionStay2D(Collision2D collision)
    {
        
    }

    //충돌 하고 떨어졌을 때 가져오는 함수
    private void OnCollisionExit2D(Collision2D collision)
    {

        
    }


}
