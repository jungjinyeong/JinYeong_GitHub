/*
 * Monkey
 * 
 * 빨간색 원숭이
 * 사정거리 안에 적이 있는지 확인한다.
 * 있다면, 공격한다.
 * 
 * 없다면, 다가간다
 * 
 * 아예 적이 사정거리 안에 없다면 플레이어를 따라간다.
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT.Nodes;
using SjBT.Actions;
using SjBT;

public class MonkeyBT : MonoBehaviour, ISjBehaviorTree
{
    // 리프노드 제외한 노드 생성
    #region Node 생성
    private SequenceNode seqRoot = new SequenceNode();
    private SelectorNode selAttackOrTrace = new SelectorNode();
    private SequenceNode seqAttack = new SequenceNode();
    private SequenceNode seqTrace = new SequenceNode();
    private SequenceNode seqDie = new SequenceNode();
    private DecoratorNode decCheckHp = new DecoratorNode();
    #endregion

    // 리프노드 생성
    #region Task 클래스 생성
    private SearchNearestTarget<MonkeyNpc> searchNearestTarget;
    private MoveToTarget<MonkeyNpc> moveToTarget;
    private AttackTargetDefault<MonkeyNpc> attackTargetDefault;
    private CheckTargetInRange<MonkeyNpc> checkTargetInRange;
    private KillNpc<MonkeyNpc> killNpc;
    private RotateToTarget<MonkeyNpc> rotateToTarget;
    #endregion

    #region AI 두뇌
    private IEnumerator behaviorProcess;

    private Brain<MonkeyNpc> brain;
    #endregion

    public void InitBT()
    {
        // Brain 추가.
        brain = GetComponent<MonkeyNpc>().NpcBrain;

        // NPC 가 할 Task 할당
        searchNearestTarget = new SearchNearestTarget<MonkeyNpc>(brain, 1 << LayerMask.NameToLayer("Player"), 30f);
        moveToTarget = new MoveToTarget<MonkeyNpc>(brain);
        checkTargetInRange = new CheckTargetInRange<MonkeyNpc>(brain, brain.NpcController.NpcAttackRange);
        attackTargetDefault = new AttackTargetDefault<MonkeyNpc>(brain);
        killNpc = new KillNpc<MonkeyNpc>(brain);
        rotateToTarget = new RotateToTarget<MonkeyNpc>(brain);

        // Task를 Composite Node에 연결

        // 공격 시퀀스 : 근접 찾고, 사거리 안이면, 공격
        seqAttack.AddNode(searchNearestTarget);
        seqAttack.AddNode(rotateToTarget);
        seqAttack.AddNode(checkTargetInRange);
        seqAttack.AddNode(attackTargetDefault);

        // 추적 시퀀스 : 적에게 다가감
        //seqAttack.AddNode(rotateToTarget);
        seqTrace.AddNode(moveToTarget);

        // 사망 시퀀스 : NPC 죽음
        seqDie.AddNode(killNpc);

        // 체력이 0이하인지 체크한 후, 참이면 사망 처리 데코레이터
        decCheckHp.AddNode(seqDie);
        decCheckHp.SetDecoratorInfo(CheckHpCondition, seqDie.GetType());

        // 공격/ 추적 시퀀스 셀렉터
        selAttackOrTrace.AddNode(seqAttack);
        selAttackOrTrace.AddNode(seqTrace);

        // 루트에 셀렉터와 데코레이터 추가.
        seqRoot.AddNode(selAttackOrTrace);
        seqRoot.AddNode(decCheckHp);

        // BT 코루틴
        behaviorProcess = ProcessBT();
    }

    public void StartBT()
    {
        StartCoroutine(behaviorProcess);
    }

    public void StopBT()
    {
        StartCoroutine(behaviorProcess);
    }

    public IEnumerator ProcessBT()
    {
        while (!seqRoot.Call())
        {
            yield return new WaitForEndOfFrame();
        }
        StartCoroutine(DestroyNpc());
    }
    IEnumerator DestroyNpc()
    {
        yield return new WaitForSeconds(2f);
        Destroy(gameObject);
    }

    private void Start()
    {
        Debug.Log("BT Start");
        InitBT();
        StartBT();
    }


    // 데코레이터에 전달할 HP 체크 함수
    public bool CheckHpCondition()
    {
        if (brain.NpcController.NpcHp <= 0f)
        {
            return true;
        }
        return false;
    }

    // 애니메이션 클립에 삽입돼 실행되는 이벤트 함수
    public void AttackFunction()
    {
        attackTargetDefault.AttackEffect();
    }
}
