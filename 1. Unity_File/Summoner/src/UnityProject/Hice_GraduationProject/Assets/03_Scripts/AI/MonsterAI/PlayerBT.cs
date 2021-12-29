/*
 * 각 NPC마다 들어갈 실질적인 AI
 * 
 */ 


using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT.Nodes;
using SjBT.Actions;  

public class PlayerBT : MonoBehaviour//, ISjBehaviorTree
{
    //// 리프노드 제외한 노드 생성
    //private SequenceNode root = new SequenceNode();
    //private SelectorNode selector = new SelectorNode();
    //private SequenceNode moving = new SequenceNode();
    //private SequenceNode dead = new SequenceNode();
    //private SelectorNode fury = new SelectorNode();

    //// 테스트용 데코레이터 
    //private DecoratorNode deco = new DecoratorNode();

    //// 리프노드 생성
    //#region Task 클래스 생성
    //// 이상 클래스는 auto 사용.
    //private Finish fin = new Finish();
    //private Die die = new Die();

    //private FuryAttack FuryAttack;
    //private NotFuryAttack NotFuryAttack;
    //private MoveToTarget MoveToTarget1;
    //private RotateToTarget RotateToTarget1;
    //private StartAttack StartAttack1;
    //private CloseToTarget CloseToTarget;
    //private ReadyToDie ReadyToDie;
    //private Finish Fin;
    //private Die Die;
    //#endregion

    //#region AI 두뇌
    //private IEnumerator behaviorProcess;

    //private Brain aiBrain;
    //#endregion

    //public void InitBT()
    //{
    //    aiBrain = GetComponent<NpcController>().brain;

    //    MoveToTarget1 = new MoveToTarget(aiBrain);
    //    Fin = new Finish(aiBrain);
    //    CloseToTarget = new CloseToTarget(aiBrain);
    //    RotateToTarget1 = new RotateToTarget(aiBrain);
    //    StartAttack1 = new StartAttack(aiBrain);
    //    NotFuryAttack = new NotFuryAttack(aiBrain);
    //    FuryAttack = new FuryAttack(aiBrain);
    //    ReadyToDie = new ReadyToDie(aiBrain);
    //    Die = new Die(aiBrain);

    //    root.AddNode(selector);
    //    root.AddNode(Fin);

    //    moving.AddNode(CloseToTarget);
    //    moving.AddNode(MoveToTarget1);
    //    moving.AddNode(RotateToTarget1);
    //    moving.AddNode(StartAttack1);


    //    fury.AddNode(NotFuryAttack);
    //    fury.AddNode(FuryAttack);

    //    dead.AddNode(ReadyToDie);
    //    dead.AddNode(fury);
    //    dead.AddNode(Die);

    //    behaviorProcess = ProcessBT();

    //    deco.SetDecoratorInfo(DecoTest, moving.GetType());
    //    selector.AddNode(deco);
    //    deco.AddNode(moving);


    //    // selector.AddNode(moving);
    //    selector.AddNode(dead);

    //}

    //public void StartBT()
    //{
    //    StartCoroutine(behaviorProcess);
    //}

    //public void StopBT()
    //{
    //    StartCoroutine(behaviorProcess);
    //}

    //public IEnumerator ProcessBT()
    //{
    //    while (!root.Call())
    //    {
    //        yield return new WaitForEndOfFrame();
    //    }
    //    Debug.Log("BT end");
    //}

    //private void Start()
    //{
    //    Debug.Log("BT Start");
    //    InitBT();
    //    StartBT();

    //}

    //public bool DecoTest()
    //{
    //    return true;
    //    //if (5 > 3)
    //    //{
    //    //    Debug.Log("데코테스트 함수 실행됨");
    //    //    return true;
    //    //}
    //    //else
    //    //    return false;
    //}
}
