using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SjBT;

public class MonkeyNpc : BaseNpc
{
    // NPC 두뇌 
    public Brain<MonkeyNpc> NpcBrain { get; private set; }

    // NPC 애니메이터
    public Animation NpcAnimation { get; private set; }

    // NPC 상태에 따라 애니메이션 재생하기 위한 딕셔너리
    private Dictionary<NpcStatus, string> animDic;

    [SerializeField]
    // NPC가 기억하고 있는 변화 이전 상태
    private NpcStatus prevStatus;

    // Start is called before the first frame update
    void OnEnable()
    {
        InitNpcSettings();
        InitAnimationTriggers();
    }

    // Update is called once per frame
    void LateUpdate()
    {
        PlayNpcAnimationByStatus();
    }


    protected override void PlayNpcAnimationByStatus()
    {
        // 같은 상태를 또 재생하라는 명령이 들어 온 경우 무시.
        if (prevStatus == Status)
        {
            return;
        }
        prevStatus = Status;
         NpcAnimation.CrossFade(animDic[Status]);
        //NpcAnimation.Play(animDic[Status]);// .CrossFade(animDic[Status]);
    }

    protected override void InitNpcSettings()
    {
        // NPC 두뇌 생성
        NpcBrain = new Brain<MonkeyNpc>(this);

        NpcAnimation = GetComponent<Animation>();

        prevStatus = NpcStatus.Default;

        AddDamageEffect(SkillEffects.DefaultAttack);
        AddDamageEffect(SkillEffects.ThunderAttackSkill);

        AddAttackVisualEffect(SkillEffects.AttackThunderProperty);

        // 스킬 공격시 효과 등록
        AddAttackVisualEffect(SkillEffects.AttackDefaultProperty);
    }

    private void InitAnimationTriggers()
    {
        animDic = new Dictionary<NpcStatus, string>();
        animDic.Add(NpcStatus.Idle, "Idle");
        animDic.Add(NpcStatus.Moving, "Walk");
        animDic.Add(NpcStatus.Attacking, "Attack");
        animDic.Add(NpcStatus.Dead, "Die");
    }
}
