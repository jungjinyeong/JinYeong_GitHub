/*
 * 원거리 공격 NPC
 * 
 * 사정거리 안에 적이 있는지 확인한다.
 * 있다면, 공격한다.
 * 
 * 없다면, 다가간다
 * 
 * 원거리 유닛 초기화 : 원거리 프리팹을 에디터에서 npc 스크립트에 끌어온다.
 * 
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT.Nodes;
using SjBT.Actions;
using SjBT;

public class RangerBT : MonoBehaviour
{
    // 리프노드 제외한 노드 생성
    #region Node 생성
    private SequenceNode seqRoot = new SequenceNode();
    private SelectorNode selAttackOrTrace = new SelectorNode();
    private SequenceNode seqAttack = new SequenceNode();
    private SequenceNode seqTrace = new SequenceNode();
    private SequenceNode seqDie = new SequenceNode();
    private DecoratorNode decCheckHp = new DecoratorNode();
    private SequenceNode seqPlayerMoving = new SequenceNode();
    #endregion

    // 리프노드 생성
    #region Task 클래스 생성
    private SearchNearestTarget<RangerNpc> searchNearestTarget;
    private MoveToTarget<RangerNpc> moveToTarget;
    private RangedAttackTarget<RangerNpc> attackTargetDefault;
    private CheckTargetInRange<RangerNpc> checkTargetInRange;
    private KillNpc<RangerNpc> killNpc;
    private RotateToTarget<RangerNpc> rotateToTarget;
    private PlayerMovement<RangerNpc> playerMovement;
    private DoNothingWhenAttackDelayed<RangerNpc> doNothing;
    #endregion

    #region AI 두뇌
    private IEnumerator behaviorProcess;

    private Brain<RangerNpc> brain;
    #endregion


    public void InitBT()
    {
        // Brain 추가.
        brain = GetComponent<RangerNpc>().NpcBrain;

        // NPC 가 할 Task 할당
        searchNearestTarget = new SearchNearestTarget<RangerNpc>(brain, gameObject.tag == "Enemy" ? 1 << LayerMask.NameToLayer("Player") : 1 << LayerMask.NameToLayer("Enemy"), 30f);
        moveToTarget = new MoveToTarget<RangerNpc>(brain);
        checkTargetInRange = new CheckTargetInRange<RangerNpc>(brain, brain.NpcController.NpcAttackRange * 10f);
        attackTargetDefault = new RangedAttackTarget<RangerNpc>(brain);
        killNpc = new KillNpc<RangerNpc>(brain);
        rotateToTarget = new RotateToTarget<RangerNpc>(brain);
        playerMovement = new PlayerMovement<RangerNpc>(brain);
        doNothing = new DoNothingWhenAttackDelayed<RangerNpc>(brain);
        // Task를 Composite Node에 연결



        // 공격 시퀀스 : 근접 찾고, 사거리 안이면, 공격
        seqAttack.AddNode(searchNearestTarget);
        seqAttack.AddNode(rotateToTarget);
        seqAttack.AddNode(checkTargetInRange);
        //seqAttack.AddNode(rotateToTarget);
        seqAttack.AddNode(attackTargetDefault);

        // 추적 시퀀스 : 적에게 다가감
        //seqTrace.AddNode(doNothing);    // 원거리 딜레이
        seqTrace.AddNode(rotateToTarget);
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
        seqRoot.AddNode(seqPlayerMoving);
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
        Debug.Log("BT end");
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
        attackTargetDefault.LaunchProjectile();
        if(GetComponent<BaseNpc>().NpcName == "devil_dragon")
        {
            // 브레스
            StartCoroutine(Bress());
        }
    }

    private IEnumerator Bress()
    {
        var br = Instantiate(Resources.Load<GameObject>("Minions/DragonBressFX"), transform.position + new Vector3(-0.1f, 1.49f, 1.38f), transform.localRotation);
        //br.transform.SetParent(gameObject.transform);
        yield return new WaitForSeconds(2.0f);
        Destroy(br);
    }
}
