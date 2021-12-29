/*
 * 행동트리 
 * 
 * Selector는 자식 노드를 실행하여, 이 중 하나라도 True를 리턴하면 True를 리턴한다.
 * Selector의 자식 하나가 False를 리턴하면, selector는 다음 자식노드를 탐색한다.
 * 
 * Sequence는 모든 자식 노드가 True를 리턴할 때, True를 리턴한다. 
 * Sequence는 자식 중 하나라도 False면 False를 리턴한다.
 */


using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT.Nodes;
using System;
using System.Linq;

namespace SjBT
{
    // AI 의 Brain
    public class Brain<T> where T : BaseNpc
    {
        public T NpcController { get; private set; }

        public Transform NpcTransform { get; set; }

        public Transform Target { get; set; }

        public PlayerController PlayerController { get; private set; }

        public Brain(T script)
        {
            NpcController = script;
            PlayerController = GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerController>();
            NpcTransform = NpcController.GetComponent<Transform>();
        }

        // 선택된 Task에 맞게 NPC의 상태 변경
        public void ChangeNpcStatus(NpcStatus to)
        {
            NpcController.ChangeNpcStatus(to);
        }

        // 매개변수로 입력받은 sec 만큼 대기 후 to 로 NPC상태 변경
        public void ChangeDelayedNpcStatus(NpcStatus to, float delayedSec)
        {
            NpcController.ChangeDelayedNpcStatus(to, delayedSec);
        }

        // NPC의 현 상태가 매개변수로 들어온 상태들 중 하나인지 체크한다.
        public bool IsStatusCoincideWithArrayElements(params NpcStatus[] array)
        {
            // array의 원소와 Status가 일치하면 true 반환.
            return array.Contains<NpcStatus>(NpcController.Status);
        }
    }

    // AI의 action 클래스
    namespace Actions
    {

        // NPC에 설정되어있는 Target으로 이동하는 액션
        public class MoveToTarget<T> : Node where T : BaseNpc
        {

            private Brain<T> brain;

            public MoveToTarget(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if (brain.Target == null)
                {
                    //Debug.LogError("There is No Target transform in this Brain.");
                    return true;
                }

                // 이 코드는 Attacking 상태 일때는 실행하지 않겠다는 의미.
                if (brain.IsStatusCoincideWithArrayElements(new[] { NpcStatus.Attacking }))
                {
                    return true;
                }

                if (Vector3.Distance(brain.NpcTransform.position, brain.Target.position) >= brain.NpcController.NpcAttackRange)
                {
                    brain.ChangeNpcStatus(NpcStatus.Moving);
                    brain.NpcController.Agent.isStopped = false;
                    brain.NpcController.Agent.SetDestination(brain.Target.position);
                    return true;
                }

                brain.NpcController.Agent.isStopped = true;
                //brain.ChangeNpcStatus(NpcStatus.Idle);

                return false;
            }
        }

        // 범위 내 적 탐색하는 액션
        public class SearchNearestTarget<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            // 탐색 범위는, NPC에서 전달하도록 함.
            private float searchRange;

            // 탐색할 레이어마스크
            int layerForSearching;

            public SearchNearestTarget(Brain<T> br, float range = 15f)
            {
                brain = br;
                searchRange = range;
                layerForSearching = 1 << LayerMask.NameToLayer("Enemy");
            }

            public SearchNearestTarget(Brain<T> br, LayerMask layerForSearching, float range = 15f)
            {
                brain = br;
                searchRange = range;
                this.layerForSearching = layerForSearching;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                // 이 코드는 Attacking 상태 일때는 실행하지 않겠다는 의미.
                if (brain.IsStatusCoincideWithArrayElements(new [] { NpcStatus.Attacking, NpcStatus.Dead }))
                {
                    return false;
                }

                var detectedObjects = Physics.OverlapSphere(brain.NpcTransform.position, searchRange, layerForSearching);

                if (detectedObjects != null)
                {
                    for(int i = 0; i < detectedObjects.Length; i++)
                    {
                        if (detectedObjects[i].CompareTag("Player"))
                        {
                            if(detectedObjects[i].GetComponent<PlayerController>().status == PlayerController.PlayerStatus.Dead)
                            {
                                if (brain.NpcController.CompareTag("Enemy"))
                                {
                                    brain.Target = null;
                                }
                                continue;
                            }
                            else
                            {
                                brain.Target = detectedObjects[i].transform;
                                return true;
                            }
                        }
                        else if (detectedObjects[i].CompareTag("Minion") || detectedObjects[i].CompareTag("Enemy"))
                        {
                            if (detectedObjects[i].transform.GetComponent<BaseNpc>().Status == NpcStatus.Dead)
                            {
                                continue;
                            }
                            else
                            {
                                brain.Target = detectedObjects[i].transform;
                                return true;
                            }
                        }
                    }
                    brain.Target = null;
                }

                // 타겟이 없다면 Idle 상태로 전이
                brain.ChangeNpcStatus(NpcStatus.Idle);
                return false;
            }
        }

        // 적이 공격범위 안에 있는지 체크
        public class CheckTargetInRange<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            // 탐색 범위는, NPC에서 전달하도록 함.
            private float searchRange;

            public CheckTargetInRange(Brain<T> br, float range = 2f)
            {
                brain = br;
                searchRange = range;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                // 타겟이 공격 사정거리 이내에 있다면
                if (Vector3.Distance(brain.NpcTransform.position, brain.Target.position) <= searchRange)
                {
                    return true;
                }

                return false;
            }
        }

        // 근거리 공격 애니메이션 액션
        public class AttackTargetDefault<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            public AttackTargetDefault(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if(brain.NpcController.Status == NpcStatus.Attacking)
                {
                    return false;
                }
                
                brain.ChangeNpcStatus(NpcStatus.Attacking);
                brain.NpcController.Agent.isStopped = true;
                brain.ChangeDelayedNpcStatus(NpcStatus.Idle, brain.NpcController.NpcAttackSpeed) ;

                return true;
            }

            // 공격 반영 함수
            public void AttackEffect()
            {
                if (brain.Target == null)
                {
                    return;
                }

                // 상대가 사거리에 있는지 확인 후 공격 실시.
                if (Vector3.Distance(brain.NpcTransform.position, brain.Target.position) <= brain.NpcController.NpcAttackRange)
                {
                    //Debug.Log("공격성공: " + transform.name);
                    // 전기, 불 등 이펙트도 여기에 넣을 수 있을것 같음.
                    // 그럼 피격한 상대는? 공격 매개변수로 속성을 넣어준다면?
                    // 피격한 상대는 ApplyDamage등 함수에서 매개변수로 온 것의 이펙트를 반영한다?
                    // 근접은 위처럼할수 있음
                    // 원거리는 원거리 발사체가 필요. 피격은 동일할거같다. 피격또한 ApplyDamage에 들어갈것이기에.
                    // ApplyDamage 각각 끼워넣어야할듯.

                    // 공격 상대가 플레이어가 아닌 NPC라면,
                    if (!brain.Target.CompareTag("Player"))
                    {
                        brain.Target.GetComponent<BaseNpc>().ApplyDamage(brain.NpcController.CalculateDamage(brain.NpcController.NpcAttackDamage));
                        //brain.NpcController.PlayHitVisualEffect(brain.Target.position);
                    }
                    else
                    {
                        // 플레이어의 체력 깎기.
                        brain.PlayerController.ApplyDamage(brain.NpcController.CalculateDamage(brain.NpcController.NpcAttackDamage));
                    }

                    // 공격시, 시전자의 시각효과는 여기서 재생.
                    brain.NpcController.PlayAttackVisualEffect();
                    brain.NpcController.PlayHitVisualEffect(brain.Target.position, brain.Target);
                  
                    Debug.Log("히트, 어택 시각효과 로직 더 세분화 해야 함. 지금은 너무 스파게티임");
                }
            }
        }

        // 원거리 공격시 딜레이 중이라면 아무 행동도 하지 않는 액션
        public class DoNothingWhenAttackDelayed<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            public DoNothingWhenAttackDelayed(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if(brain.Target!= null && brain.Target.GetComponent<BaseNpc>().Status == NpcStatus.Dead)
                {
                    return false;
                }
                // 2 means player attack has been delayed
                if(brain.NpcController.isAttackReserved == 2)
                {
                    return false;
                }
                return true;
            } 
        }

        // 원거리 공격 애니메이션 액션
        public class RangedAttackTarget<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;
            LineRenderer lr;
            Vector3 targetPos;
            public RangedAttackTarget(Brain<T> br)
            {
                brain = br;
                lr = brain.NpcTransform.GetComponent<LineRenderer>(); 
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if (brain.NpcController.Status == NpcStatus.Attacking )
                {
                    return false;
                }

                if (brain.NpcController.isAttackReserved < 1)
                {
                    // 레이저 발사
                    lr.enabled = true;
                    lr.SetPosition(0, brain.NpcTransform.position);
                    Vector3 relativeVector = brain.Target.position - brain.NpcTransform.position;
                    relativeVector = relativeVector.normalized;
                    lr.SetPosition(1, brain.NpcTransform.position + relativeVector * 20f);

                    // 이 발사 명령 당시의 적의 포지션을 타겟으로 설정
                    targetPos = brain.Target.position;

                    brain.NpcController.isAttackReserved = 1;
                    brain.NpcController.ToggleReservedAttack(2);
                    //Debug.Log("원거리공격 명령 시작..");
                    brain.ChangeNpcStatus(NpcStatus.Idle);
                    return false;
                }
                else if (brain.NpcController.isAttackReserved == 1)
                {
                    //Debug.Log("원거리공격 명령 딜레이 중..");
                    return false;
                }
                brain.NpcController.ToggleReservedAttack(0, true);
                lr.enabled = false;
                lr.SetPosition(0, Vector3.zero);
                lr.SetPosition(1, Vector3.zero);
                //Debug.Log("원거리 공격 실행");
                brain.ChangeNpcStatus(NpcStatus.Attacking);
                brain.NpcController.Agent.isStopped = true;
                brain.ChangeDelayedNpcStatus(NpcStatus.Idle, brain.NpcController.NpcAttackSpeed);

                return true;
            }

            // 투사체 발사 함수
            public void LaunchProjectile()
            {
                if(brain.Target == null)
                {
                    return;
                }
                Debug.Log("투사체 발사");
                // 투사체 생성
                Vector3 pos = brain.NpcTransform.position + new Vector3(0f, 0.8f, 0f);
                Vector3 rot = targetPos - brain.NpcTransform.position; 
                var proj = GameObject.Instantiate(brain.NpcController.projectileObject, pos, Quaternion.LookRotation(rot));
                
                // 투사체의 정보 입력
                proj.GetComponent<ProjectileInfo>().SetProjectileDamage(brain.NpcController.CalculateDamage(brain.NpcController.NpcAttackDamage));
                proj.GetComponent<ProjectileInfo>().SetProjectileEffect(brain.NpcController.GetVisualHitEffects());
                proj.GetComponent<ProjectileInfo>().SetProjectileOwner(brain.NpcController.IsOpponent);

                // 공격시, 시전자의 시각효과는 여기서 재생.
                brain.NpcController.PlayAttackVisualEffect();
            }
        }


        // 사망 처리하는 액션
        public class KillNpc<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            public KillNpc(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if(brain.NpcController.Status == NpcStatus.Dead)
                {
                    return true;
                }
                brain.ChangeNpcStatus(NpcStatus.Dead);
                brain.NpcTransform.GetComponent<Collider>().enabled = false;
                brain.NpcController.Agent.isStopped = true;
                
                Debug.Log("사망");
                // 플레이어의 사파이어, 골드 증가
                brain.PlayerController.IncreaseSapphire(brain.NpcController.NpcSaphire);
                brain.PlayerController.IncreaseGold(brain.NpcController.NpcGold);
                
                return true;
            }
        }

        // 타겟을 정면으로 바라보도록 하는 액션
        public class RotateToTarget<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            public RotateToTarget(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if (brain.Target == null) 
                {
                    //Debug.LogError("There is No Target transform in this Brain.");
                    return false;
                }

                var relativeDir = brain.Target.position - brain.NpcTransform.position;
                if(relativeDir != Vector3.zero)
                {
                    brain.NpcTransform.rotation = Quaternion.Slerp(brain.NpcTransform.rotation, Quaternion.LookRotation(relativeDir), Time.deltaTime * brain.NpcController.NpcMovementSpeed * 10f);

                    if (Quaternion.Angle(brain.NpcTransform.rotation, Quaternion.LookRotation(relativeDir)) > 20f)
                    {
                        return false;
                    }
                }
                
                return true;

            }
        }

        // 플레이어의 이동 여부를 판단하는 액션
        public class PlayerMovement<T> : Node where T : BaseNpc
        {
            private Brain<T> brain;

            public PlayerMovement(Brain<T> br)
            {
                brain = br;
            }

            public override bool Call()
            {
                return DoTask();
            }

            public override bool DoTask()
            {
                if (brain.PlayerController.IsPlayerMoving())
                {
                    brain.NpcController.Agent.isStopped = true;
                    brain.ChangeNpcStatus(NpcStatus.Idle);             
                    return false;
                }
                return true;
            }
        }

    }
        
        
    // Behavior Tree의 노드 클래스 
    namespace Nodes
    {
        public abstract class Node
        {
            public abstract bool Call();

            public abstract bool DoTask();
        }

        public class CompositeNode : Node
        {
            private List<Node> nodes = new List<Node>();

            public override bool Call()
            {
                throw new System.NotImplementedException();
            }

            public void AddNode(Node node)
            {
                nodes.Add(node);
            }

            public List<Node> GetNodes()
            {
                return nodes;
            }

            public override bool DoTask()
            {
                throw new System.NotImplementedException();
            }
        }

        // 데코레이터는 델리게이트로 연결된 조건문 검사 후 참이면 자식 실행, 거짓이면 종료한다.
        public class DecoratorNode : CompositeNode
        {
            public delegate bool Condition();

            private Condition decorateCondition = null;
            private Type decorateType = null;

            public void SetDecoratorInfo(Condition cond, Type type)
            {
                decorateCondition = cond;
                decorateType = type;
            }

            public override bool Call()
            {
                if (decorateCondition())
                {
                    var node = GetNodes();

                    // 예외처리
                    if (node.Count <= 0)
                        throw new System.IndexOutOfRangeException();

                    return node[0].Call();
                }
                else
                {
                    if (decorateType == typeof(SelectorNode))
                        return true;
                    else
                        return false;
                }
            }
        }



        // 셀렉터는 자식노드가 SUCCESS를 반환할 때 까지 순회. 실패하면 다음 것 순회
        public class SelectorNode : CompositeNode
        {
            public override bool Call()
            {
                foreach (var node in GetNodes())
                {
                    if (node.Call())
                    {
                        return true;
                    }
                }
                return false;
            }
        }

        // 시퀀스는 자식 노드가 FAILURE를 반환할 때 까지 순회. 실패하면 다시 순회.
        // 시퀀스의 자식은 Task이고, task가 false를 반환했다면 아직 task를 처리하지 않았음을 의미.
        public class SequenceNode : CompositeNode
        {
            public override bool Call()
            {
                foreach (var node in GetNodes())
                {
                    if (!node.Call())
                    {
                        return false;
                    }
                }
                return true;
            }
        }

        public abstract class BT_base : MonoBehaviour
        {
            public abstract void Init();
            public abstract void StartBT();
            public abstract void StopBT();
            public abstract IEnumerator ProcessBT();
        }
    }
   
}
