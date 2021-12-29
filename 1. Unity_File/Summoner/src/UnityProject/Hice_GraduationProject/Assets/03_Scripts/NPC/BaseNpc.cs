/*
 * 작성자 : 백성진
 * 
 * 모든 아군 소환수/ 적 등의 NPC가 공통적으로 상속받는 클래스
 *
 */
 
using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Assertions;


public abstract class BaseNpc : MonoBehaviour
{
    [Header("NPC 인덱스")]

    // NPC 고유 인덱스. 에디터에서 지정.
    [SerializeField]
    private int npcIndex = -1;

    [Header("NPC 데이터 수치")]

    // NPC 이름
    [SerializeField]
    private string npcName;

    // NPC가 소환수인지, 적인지 구분
    [SerializeField]
    private bool isOpponent;

    // NPC 체력
    [SerializeField]
    private float npcHp;

    // NPC 이동속도
    [SerializeField]
    private float npcMovementSpeed;

    // NPC 공격속도
    [SerializeField]
    private float npcAttackSpeed;

    // NPC 공격력
    [SerializeField]
    private float npcAttackDamage;

    // NPC가 주는 사파이어
    [SerializeField]
    private float npcSaphire;

    // NPC가 주는 골드
    [SerializeField]
    private float npcGold;

    // NPC 방어력
    [SerializeField]
    private float npcArmor;

    // NPC 공격 사정거리
    [SerializeField]
    private float npcAttackRange;

    // 자동 이동을 위한 에이전트
    private NavMeshAgent agent;

    private Room belongedRoom;

    // NPC 의 스킬 대리자
    // 공격 데미지 대리자
    public delegate void DamageEffectDel(ref float amount);
    private DamageEffectDel damageEffect;

    // 스킬 비주얼 이펙트 대리자
    public delegate GameObject VisualEffectDel(Vector3 pos);
    // 이 NPC의 공격을 맞은 상대의 위치에서 발생하는 시각효과
    private VisualEffectDel hitVisualEffect;
    // 이 NPC가 공격할때 본인의 위치에서 발생하는 시각효과
    private VisualEffectDel attackVisualEffect;
   
    // 원거리 투사체
    public GameObject projectileObject;
    // 원거리 공격 예약이 되었는지 판단하는 변수
    public int isAttackReserved = 0;
    // 원거리 공격수의 경우, 실제 투사체를 던지기 전 n초의 딜레이가 있어야 한다.
    public float delaySeconds = 1f;
    // 원거리 공격 시작시 n초 뒤에 변수 해제
    public void ToggleReservedAttack(int idx, bool immediately = false)
    {
        StartCoroutine(ToggleReservedAttackCor(idx, immediately));
    }
    private IEnumerator ToggleReservedAttackCor(int idx, bool immediately = false)
    {
        yield return new WaitForSeconds(immediately ? 0f : delaySeconds);
        isAttackReserved = idx;
    }

    // NPC 상태
    public NpcStatus Status { get; private set; }

    public string NpcName { get { return npcName; } }
    public bool IsOpponent { get { return isOpponent; } }
    public float NpcHp { get { return npcHp; } set { npcHp = value; } }
    public float NpcMovementSpeed { get { return npcMovementSpeed; } set { npcMovementSpeed = value; } }
    public float NpcAttackSpeed { get { return npcAttackSpeed; } set { npcAttackSpeed = value; } }
    public float NpcAttackDamage { get { return npcAttackDamage; } set { npcAttackDamage = value; } }
    public float NpcSaphire { get { return npcSaphire; } }
    public float NpcArmor { get { return npcArmor; } }
    public float NpcAttackRange { get { return npcAttackRange; } set { npcAttackRange = value; } }

    public NavMeshAgent Agent { get { return agent; } }

    public float NpcGold { get { return npcGold; } }

    [SerializeField]
    private NpcStatus _status;
    
    private void Awake()
    {
        //ReadNpcFiguresFromCsv();
        LoadNpcFigures();
        InitNpcStatus();
    }

    private void Start()
    {
        if(gameObject.tag == "Enemy")
        {
            belongedRoom = transform.parent.GetComponent<Room>();
            // the npc must be belonged to any of the room;
            Assert.IsNotNull(belongedRoom);
        }
        isAttackReserved = 0;
        delaySeconds = 1f;
    }

    // SQLite로부터 설정된 수치를 가져오는 함수
    private void LoadNpcFigures()
    {
        const float DEFAULT_FLOAT = 100.0f;
        if(gameObject.tag == "Enemy")
        {
            var data = DataService.Instance.GetData<Table.EnemyTable>(npcIndex);
            Assert.IsNotNull(data);
            npcName = data.enemy_name;
            npcHp = data.hp;
            isOpponent = true;
            npcMovementSpeed = data.move_speed;
            npcAttackSpeed = data.attack_speed;
            npcAttackDamage = data.attack_power;
            npcAttackRange = data.attack_range;
            npcSaphire = data.saphire;
            npcGold = data.gold;
        }
        else
        {
            var data = DataService.Instance.GetData<Table.PetTable>(npcIndex);
            Assert.IsNotNull(data);
            npcName = data.pet_name;
            npcHp = DEFAULT_FLOAT;
            isOpponent = false;
            npcMovementSpeed = data.move_speed;
            npcAttackSpeed = data.attack_speed;
            npcAttackDamage = data.attack_power;
            npcAttackRange = data.attack_range;
            npcSaphire = DEFAULT_FLOAT;
            npcGold = DEFAULT_FLOAT;
        }

    }

    // CSV로부터 설정된 수치를 가져오는 함수
    private bool ReadNpcFiguresFromCsv()
    {
        List<Dictionary<string, object>> npcFigures = CsvReader.Read("CSV/NpcFigures");

        if(npcFigures == null)
        {
            return false;
        }

        npcName = (string)npcFigures[npcIndex]["Name"];
        isOpponent = (int)npcFigures[npcIndex]["IsOpponent"] == 0 ? false : true;
        npcHp = (float)npcFigures[npcIndex]["Hp"];
        npcMovementSpeed = (float)npcFigures[npcIndex]["MovementSpeed"];
        npcAttackSpeed = (float)npcFigures[npcIndex]["AttackSpeed"];
        npcAttackDamage = (float)npcFigures[npcIndex]["AttackDamage"];
        npcSaphire = (float)npcFigures[npcIndex]["Exp"];
        npcArmor = (float)npcFigures[npcIndex]["Armor"];
        npcAttackRange = (float)npcFigures[npcIndex]["AttackRange"];
        return true;
    }

    // NPC 상태 초기화
    private void InitNpcStatus()
    {
        // NPC 상태 생성
        Status = new NpcStatus();
        Status = NpcStatus.Default;

        // NavMesh Agent 등록
        agent = GetComponent<NavMeshAgent>();
        // NavMesh Agent의 속도 지정
        agent.speed = NpcMovementSpeed;
    }

    // NPC 공격(체력) 반영 함수
    public void ApplyDamage(float amount)
    {
        npcHp -= amount;
        InGameUI.instance.ApplyChangedHealthPoint(gameObject, npcHp);
        if (NpcHp <= 0f)
        {
            belongedRoom.RemoveEnemy(gameObject);
        }
    }

    // NPC 상태 변경
    public void ChangeNpcStatus(NpcStatus to)
    {
        Status = to;
    }

    // delayedSec초 후 NPC 상태 변경 코루틴 지시
    public void ChangeDelayedNpcStatus(NpcStatus to, float delayedSec)
    {
        StartCoroutine(ChangeStatusCor(to, delayedSec));
    }

    // delayedSec초 후 NPC 상태 변경 코루틴
    private IEnumerator ChangeStatusCor(NpcStatus to, float waitSec)
    {
        yield return new WaitForSeconds(waitSec);

        if(gameObject.name == "SummonedRanger_Mystic")
            Debug.Log("상태변화");

        if(Status != NpcStatus.Dead)
            ChangeNpcStatus(to);
    }

    protected abstract void InitNpcSettings();  // base가 아닌, 각 Npc에 필요한 초기 세팅함수.
    protected abstract void PlayNpcAnimationByStatus(); // 각 Npc의 애니메이션 재생 함수.

    
    private void Update()
    {
        // 디버그시에만 사용
        _status = Status;
    }


    // 대리자에 공격 스킬 효과 등록
    public void AddDamageEffect(DamageEffectDel effectFunc)
    {
        damageEffect += effectFunc;
    }

    // 대리자에 공격 스킬 효과 해제
    public void RemoveDamageEffect(DamageEffectDel effectFunc)
    {
        damageEffect -= effectFunc;
    }

    // 대리자에 히트 시각 효과 등록
    public void AddHitVisualEffect(VisualEffectDel visualFunc)
    {
        hitVisualEffect += visualFunc;
    }

    // 대리자에 히트 시각 효과 해제
    public void RemoveHitVisualEffect(VisualEffectDel visualFunc)
    {
        hitVisualEffect -= visualFunc;
    }

    // 히트 이펙트 출력
    public void PlayHitVisualEffect()
    {
        if (hitVisualEffect == null)
            return;
        hitVisualEffect(Vector3.zero).transform.parent = transform;
    }

    public void PlayHitVisualEffect(Vector3 pos, Transform tr)
    {
        if (hitVisualEffect == null)
            return;
        hitVisualEffect(pos).transform.parent = tr;
    }

    // 스킬 히트 대리자 반환 함수
    public VisualEffectDel GetVisualHitEffects()
    {
        return hitVisualEffect;
    }

    // 대리자에 공격 시각효과 등록
    public void AddAttackVisualEffect(VisualEffectDel visualFunc)
    {
        attackVisualEffect += visualFunc;
    }

    // 대리자에 공격 시각효과 해제
    public void RemoveAttackVisualEffect(VisualEffectDel visualFunc)
    {
        attackVisualEffect -= visualFunc;
    }

    // 공격 시각효과 실행
    public void PlayAttackVisualEffect()
    {
        if(attackVisualEffect == null)
        {
            return;
        }
        attackVisualEffect(Vector3.zero).transform.parent = transform;
    }


    // 데미지 계산 함수, 지금은 공격력 그대로 데미지 적용이지만 방어력 등 적용 가능
    public float CalculateDamage(float basicDamageAmount)
    {
        float totalDamage = basicDamageAmount;
        // NPC/player 에 반영할 시전자 NPC의 데미지의 총 합을 계산한다.  
        damageEffect(ref totalDamage);
        // hitVisualEffect();
        return totalDamage;
    }


    private void OnCollisionEnter(Collision collision)
    {
        if (collision.transform.CompareTag("Projectile"))
        {
            //Debug.Log(gameObject.name);
            //// 데미지 계산 및 히트 이펙트 호출
            //collision.transform.GetComponent<ProjectileInfo>().PlayVisualHitEffect(transform.position, this.transform);
            //ApplyDamage(collision.transform.GetComponent<ProjectileInfo>().GetProjectileDamage());

            //Destroy(collision.gameObject);
        }
    }
}

// NPC의 상태 열거형
public enum NpcStatus
{
    Default,
    Idle, 
    Moving, 
    Attacking, 
    Dead
}