using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class HpBarUI : MonoBehaviour
{

    private float maxHp;
    private float curHp;

    public Slider bar;
    public Image fill;
    private Transform target;

    private Quaternion initRot;

    // Start is called before the first frame update
    void Start()
    {
        initRot = Quaternion.Euler(0f, -180f, 0f);
        target = transform.parent;
        if(target.CompareTag("Player")){
            curHp = target.GetComponent<PlayerController>().playerHp;
            maxHp = target.GetComponent<PlayerController>().playerHp;
        }
        else
        {
            curHp = target.GetComponent<BaseNpc>().NpcHp;
            maxHp = target.GetComponent<BaseNpc>().NpcHp;
            fill.color = new Color(4/255, 255/255, 74/255, 255/255);
        }
        InGameUI.instance.healthPointEvent.AddListener(ApplyHealthPoint);
    }

    private void ApplyHealthPoint(GameObject target, float targetAmount)
    {
        if(target == transform.parent.gameObject)
        {
            curHp = targetAmount;
            DOTween.To(() => bar.value, x => bar.value = x, curHp / maxHp, 0.5f);
        }
    }


    void LateUpdate()
    {
        transform.rotation = initRot;
    }
}
