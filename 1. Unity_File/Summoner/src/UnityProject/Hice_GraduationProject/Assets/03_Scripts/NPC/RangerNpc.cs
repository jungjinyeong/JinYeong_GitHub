using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT;

public class RangerNpc : BaseNpc
{
    // NPC 두뇌 
    public Brain<RangerNpc> NpcBrain { get; private set; }

    // NPC 애니메이터
    public Animator NpcAnimator { get; private set; }

    // NPC 상태에 따라 애니메이션 재생하기 위한 딕셔너리
    private Dictionary<NpcStatus, string> animDic;

    [SerializeField]
    // NPC가 기억하고 있는 변화 이전 상태
    private NpcStatus prevStatus;


    // Start is called before the first frame update
    void OnEnable()
    {
        Debug.Log("테스팅");
        InitNpcSettings();
        InitAnimationTriggers();
    }

    // Update is called once per frame
    void LateUpdate()
    {
        PlayNpcAnimationByStatus();

        if (Input.GetKeyDown(KeyCode.Z))
        {
            AddHitVisualEffect(SkillEffects.HitFireProperty);
        }
    }


    protected override void PlayNpcAnimationByStatus()
    {
        // 같은 상태를 또 재생하라는 명령이 들어 온 경우 무시.
        if (prevStatus == Status)
        {
            return;
        }
        foreach (var item in animDic)
        {
            NpcAnimator.SetBool(item.Value, false);
        }
        prevStatus = Status;
        NpcAnimator.SetBool(animDic[Status], true);
    }

    protected override void InitNpcSettings()
    {
        // NPC 두뇌 생성
        NpcBrain = new Brain<RangerNpc>(this);

        NpcAnimator = GetComponent<Animator>();

        prevStatus = NpcStatus.Default;

        // 스킬 적용 효과 등록
        AddDamageEffect(SkillEffects.DefaultAttack);
        //AddDamageEffect(SkillEffects.FireAttack);

        // 스킬 히트 효과 등록
        AddHitVisualEffect(SkillEffects.HitDefaultAttack);

        // 스킬 공격시 효과 등록
        AddAttackVisualEffect(SkillEffects.AttackRangerDefaultProperty);
    }

    private void InitAnimationTriggers()
    {
        animDic = new Dictionary<NpcStatus, string>();
        animDic.Add(NpcStatus.Idle, "Idle");
        animDic.Add(NpcStatus.Moving, "Moving");
        animDic.Add(NpcStatus.Attacking, "Attacking");
        animDic.Add(NpcStatus.Dead, "Dead");
    }
}
