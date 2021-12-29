/*
 * 스킬 데미지/효과 함수 클래스.
 * 각 NPC는 대리자에게 이 클래스의 함수를 등록하고,
 * 실행함수 실행시 중첩된 효과를 반환하도록 한다.
 */ 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkillEffects
{

    // 기본공격
    public static void DefaultAttack(ref float basicDamage)
    {
        basicDamage += 0f;
    }

    // 예시) A2 공격
    public static void A2(ref float basicDamage)
    {
        basicDamage += 3f;
        Debug.Log("A2 called");
    }

    public static void FireAttack(ref float basicDamage)
    {
        basicDamage += 10f;
    }

    // 예시) A1 공격
    public static void ThunderAttackSkill(ref float basicDamage)
    {
        Debug.Log("A1 called");
        basicDamage += 1f;
    }

    // 피격시 전기 시각효과 재생
    public static GameObject HitThunderProperty(Vector3 pos)
    {
        Debug.Log("감전 효과 적용한 거에 맞음");
        return GameObject.Instantiate(Resources.Load<GameObject>("VisualEffect/ThunderProperty"), pos, Quaternion.identity);
    }

    // 기본 히트 이펙트
    public static GameObject HitDefaultAttack(Vector3 pos)
    {
        SoundManager.instance.PlayOneShotSkillEffectSFX("Punch 2_2", 1f);

        GameObject tr = new GameObject();
        return tr;
    }

    // 피격시 화염 시각효과 재생
    public static GameObject HitFireProperty(Vector3 pos)
    {
        SoundManager.instance.PlayOneShotSkillEffectSFX("Fire Spell 19", 1f);

        Debug.Log("화염 효과 적용한 거에 맞음");
        var effect = GameObject.Instantiate(Resources.Load<GameObject>("VisualEffect/FireProperty"), pos, Quaternion.Euler(90f,0f,0f));
        return effect.gameObject;
    }

    // 공격시 시전자의 전기 시각효과 재생
    public static GameObject AttackThunderProperty(Vector3 pos)
    {
        Debug.Log("감전 효과 적용하며 공격");
        GameObject tr = new GameObject();
        return tr;
    }

    // 원거리 공격자의 효과
    public static GameObject AttackRangerDefaultProperty(Vector3 pos)
    {
        SoundManager.instance.PlayOneShotSkillEffectSFX("Metal Weapon Swing 1_1", 1f);
        GameObject go = new GameObject();
        return go;
    }

    // 근접 공격자의 효과
    public static GameObject AttackDefaultProperty(Vector3 pos)
    {
        SoundManager.instance.PlayOneShotSkillEffectSFX("Whoosh 1_1", 1f);
        GameObject go = new GameObject();
        return go;
    }
}
