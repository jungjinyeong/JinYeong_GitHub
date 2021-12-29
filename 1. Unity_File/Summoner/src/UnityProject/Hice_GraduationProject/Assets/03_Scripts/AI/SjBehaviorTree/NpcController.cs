///*
// * 
// * 상속으로 구현 필요
// * 
// */

//using System;
//using System.Collections;
//using System.Collections.Generic;
//using SjBT.Actions;
//using UnityEngine;

//// NPC 상태
////public enum NpcStatus { Idle, Moving, Attacking, Dead };

//public class NpcController : MonoBehaviour
//{
    
//    public Vector3 moveTarget;
//    public Brain brain;
//    // 체력
//    public float hp;

//    // 플레이어 오브젝트 
//    private GameObject player;

//    public GameObject Player { get; set; }

//    public NpcStatus Status { get { return _status; } set { _status = value; } }

//    // 몬스터 애니메이터
//    private Animator animator;

//    [SerializeField]
//    // NPC 상태
//    private NpcStatus _status = new NpcStatus();

//    public float moveSpeed;

//    private void OnEnable()
//    {
//        brain = new Brain(this.gameObject);

//        brain.SetTargetPosition(moveTarget);
//    }

//    private void Awake()
//    {
//        if(this.gameObject.name.Contains("Mick"))
//            Player = GameObject.FindGameObjectWithTag("Enemy").gameObject;
//        else 
//            Player = GameObject.FindGameObjectWithTag("Player").gameObject;
//        animator = GetComponent<Animator>();
//    }

//    private void Start()
//    {
//        hp = 50;
//        Status = NpcStatus.Idle;
//    }
//    public void PlayAnimator(string anim)
//    {
//        if (anim == "Attack")
//        {
//            animator.SetTrigger("Attack");
//        }
//        else if(anim == "Dead")
//        {
//            animator.SetTrigger("Dead");
//        }
//        else
//        {

//        }
//    }

//    private IEnumerator DelayStatus(NpcStatus from, NpcStatus to, float sec)
//    {
//        Status = from;
//        yield return new WaitForSeconds(sec);
//        Status = to;
//    }

//    public void CallDelayStatus(NpcStatus from, NpcStatus to, float sec)
//    {
//        StartCoroutine(DelayStatus(from, to, sec));
//    }

//}
