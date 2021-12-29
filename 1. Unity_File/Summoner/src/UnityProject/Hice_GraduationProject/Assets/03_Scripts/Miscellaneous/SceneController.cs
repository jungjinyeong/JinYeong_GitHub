using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneController : MonoBehaviour
{
    public GameObject portal;
    public GameObject[] enemies;
    
    
    
    // Start is called before the first frame update
    void Start()
    {
        FindEnemies();
        StartCoroutine(CheckHealthPoint());
        if(SceneManager.GetActiveScene().name == "SeongjinWorkScene2")
        {
            SkillPurchased();
        }
    }

    private void SkillPurchased()
    {
        var minions = GameObject.FindGameObjectsWithTag("Minion");
        foreach (var item in minions)
        {
            item.GetComponent<BaseNpc>().AddDamageEffect(SkillEffects.FireAttack);
            item.GetComponent<BaseNpc>().AddHitVisualEffect(SkillEffects.HitFireProperty);
        }
    }

    private void FindEnemies()
    {
        enemies = GameObject.FindGameObjectsWithTag("Enemy");
    }

    private IEnumerator CheckHealthPoint()
    {
        while (true)
        {
            yield return new WaitForSeconds(0.1f);
            
            bool allDead = false;

            foreach(var item in enemies)
            {
                if(item.GetComponent<BaseNpc>().NpcHp > 0f)
                {
                    allDead = true;
                }
            }

            if(allDead == false)
            {
                // SceneManager.LoadScene("TaeheeWorkScene");
                var pt = Instantiate(portal, new Vector3(0, 0.1f, 9.5f), Quaternion.identity);
                Vector3 scale = new Vector3(5f, 5f, 5f);
                pt.transform.localScale = scale;
                SoundManager.instance.PlayOneShotSkillEffectSFX("Healing 14");
                break;
            }
        }
    }

}
