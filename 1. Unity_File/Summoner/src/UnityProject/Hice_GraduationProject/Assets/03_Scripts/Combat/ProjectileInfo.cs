/*
 * 작성자 : 백성진 
 * 
 * 원거리 유닛이 사용하는 투사체의 정보를 담은 스크립트 입니다.
 * 
 *
 */ 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileInfo : MonoBehaviour
{
    [SerializeField]
    // 이 투사체가 가질 데미지
    private float damage;

    [SerializeField]
    // 이 투사체의 속도
    private float speed;

    [SerializeField]
    // 투사체를 발사한게 적이면, true, 그 외 false
    private bool projectileOwner;

    [SerializeField]
    // 이 투사체를 맞았을 때의 이펙트
    private BaseNpc.VisualEffectDel hitEffects;

    private void Start()
    {
        // 투사체 발사한 NPC의 정보 입력
        if (!projectileOwner)
        {
            gameObject.layer = LayerMask.NameToLayer("MinionProjectile");
        }
        else
        {
            gameObject.layer = LayerMask.NameToLayer("EnemyProjectile");
        }
        GetComponent<Rigidbody>().AddForce(transform.forward * speed);
    }

    public void SetProjectileDamage(float amount)
    {
        damage = amount;
    }

    public void SetProjectileEffect(BaseNpc.VisualEffectDel effect)
    {
        hitEffects += effect;
    }

    public void SetProjectileOwner(bool isMinion)
    {
        projectileOwner = isMinion;
    }

    public float GetProjectileDamage()
    {
        return damage;
    }

    public void PlayVisualHitEffect(Vector3 pos, Transform hit)
    {
        hitEffects(pos).transform.parent = hit.transform;
        Debug.Log(pos + " 에서 히트이펙트 시행됨");
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.transform.CompareTag("Enemy") && gameObject.layer == LayerMask.NameToLayer("MinionProjectile"))
        {

            // 데미지 계산 및 히트 이펙트 호출
            PlayVisualHitEffect(transform.position, this.transform);
            collision.transform.GetComponent<BaseNpc>().ApplyDamage(GetProjectileDamage());
            Debug.Log("미니언의 투사체를 적이 맞음");
            Destroy(gameObject);
            return;
        }
        else if(collision.transform.CompareTag("Player") && gameObject.layer == LayerMask.NameToLayer("EnemyProjectile"))
        {
            PlayVisualHitEffect(transform.position, this.transform);
            PlayerController.instance.ApplyDamage(GetProjectileDamage());
            Debug.Log("적의 투사체를 플레이어가 맞음");
            Destroy(gameObject);
            return;
        }

        // 적이 쏜걸적이 적이 맞은경우 그냥 종료
        if(collision.transform.CompareTag("Enemy") && gameObject.layer == LayerMask.NameToLayer("EnemyProjectile"))
        {
            Debug.Log("적의 투사체를 적이 맞음");
            return;
        }
        // 미니언이 쏜걸 미니언이 맞은경우
        if(collision.transform.CompareTag("Minion") && gameObject.layer == LayerMask.NameToLayer("MinionProjectile"))
        {
            Debug.Log("적의 투사체를 미니언이 맞음");
            Destroy(gameObject);
            return;
        }

        Destroy(gameObject);
    }
}
