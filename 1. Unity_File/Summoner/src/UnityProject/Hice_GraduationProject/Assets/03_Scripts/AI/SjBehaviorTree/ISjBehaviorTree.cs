/*
 * BT 구조 (함수호출) 인터페이스
 */ 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public interface ISjBehaviorTree
{
    // 행동트리 초기화 함수
    void InitBT();
    // 행동트리 시작하는 함수
    void StartBT();
    // 행동트리 멈추는 함수
    void StopBT();
    // 행동트리 진행하는 코루틴
    IEnumerator ProcessBT();
}
