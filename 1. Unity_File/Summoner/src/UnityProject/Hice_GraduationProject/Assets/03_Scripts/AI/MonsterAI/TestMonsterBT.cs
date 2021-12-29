///*
// * 테스트 몬스터는 적이 가까이 있는지 확인 후, 적에게 다가가서, 공격한다.
// * hp가 0이하면 죽는다.
// */ 

//using System.Collections;
//using System.Collections.Generic;
//using UnityEngine;
//using SjBT.Nodes;
//using SjBT.Actions;
//using System.ComponentModel.Design.Serialization;

//public class TestMonsterBT : MonoBehaviour, ISjBehaviorTree
//{
//    // 리프노드 제외한 노드 생성
//    private SequenceNode seqRoot = new SequenceNode();
//    private SelectorNode selMoveOrAttack = new SelectorNode();
//    private SequenceNode seqAttack = new SequenceNode();
//    private SequenceNode seqMove = new SequenceNode();
//    private DecoratorNode decDeadCondition = new DecoratorNode();

//    // 리프노드 생성
//    #region Task 클래스 생성
//    private CloseToTarget taskCloseToTarget;
//    private StartAttack taskStartAttack;
//    private MoveToTarget taskMoveToTarget;
//    private Die taskDie;
//    #endregion

//    #region AI 두뇌
//    private IEnumerator behaviorProcess;

//    private Brain aiBrain;
//    #endregion

//    public void InitBT()
//    {
//        // Task 생성
//        aiBrain = GetComponent<NpcController>().brain;
//        taskCloseToTarget = new CloseToTarget(aiBrain);
//        taskStartAttack = new StartAttack(aiBrain);
//        taskMoveToTarget = new MoveToTarget(aiBrain);
//        taskDie = new Die(aiBrain);

//        // node 조립
//        seqAttack.AddNode(taskCloseToTarget);
//        seqAttack.AddNode(taskStartAttack);
//        seqMove.AddNode(taskMoveToTarget);
//        selMoveOrAttack.AddNode(seqAttack);
//        selMoveOrAttack.AddNode(seqMove);
//        seqRoot.AddNode(selMoveOrAttack);
//        // 데코레이터 추가
//        seqRoot.AddNode(decDeadCondition);
//        decDeadCondition.SetDecoratorInfo(IsMinusHp, taskDie.GetType());
//        decDeadCondition.AddNode(taskDie);

//        // BT 코루틴 할당
//        behaviorProcess = ProcessBT();
//    }


//    public void StartBT()
//    {
//        StartCoroutine(behaviorProcess);
//    }

//    public void StopBT()
//    {
//        StartCoroutine(behaviorProcess);
//    }

//    public IEnumerator ProcessBT()
//    {
//        while (!seqRoot.Call())
//        {
//            yield return new WaitForEndOfFrame();
//        }
//        Debug.Log("BT end");
//    }

//    private void Start()
//    {
//        Debug.Log("BT Start");
//        InitBT();
//        StartBT();
//    }

//    // hp가 0 이하면 NPC 사망처리
//    public bool IsMinusHp()
//    {
//        if(GetComponent<NpcController>().hp <= 0)
//        {
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }
//}
