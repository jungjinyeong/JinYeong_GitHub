/*
 * 스킬 히트/발동시 등장하는 프리팹의 생명주기를 관장하는 스크립트
 */ 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkillEffectController : MonoBehaviour
{
    public float effectLifeTime = 0f;

    // Start is called before the first frame update
    private void Start()
    {
        StartCoroutine(LifeTimer());
    }

    private IEnumerator LifeTimer()
    {
        float time = 0f;
        WaitForSeconds ws = new WaitForSeconds(0.1f);
        while(time <= effectLifeTime)
        {
            time += 0.1f;
            yield return ws;
        }
        Destroy(gameObject);
    }

    
}
