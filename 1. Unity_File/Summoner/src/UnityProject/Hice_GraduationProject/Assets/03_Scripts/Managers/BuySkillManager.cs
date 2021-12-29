using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class BuySkillManager : MonoBehaviour
{

    public static BuySkillManager instance;

  
    public Image skillImg;
    public GameObject effectObj;
    public List<Sprite> buySkillSpriteList;
    public GameObject buyImgObj;
    private Vector3 imgAngle;


    private void Awake()
    {
        instance = this;
     }
    private void Start()
    {
        imgAngle = buyImgObj.transform.eulerAngles;
    }
    private void Update()
    {
        buyImgObj.transform.eulerAngles = imgAngle;
    }
    public void ShowBuySkill() 
    {
        if (buySkillSpriteList.Count == 0)
            return;
        StartCoroutine("CoroutineShow");
    }

    public void StopBuySkillDirection()
    {
        StopCoroutine("CoroutineShow");
        buySkillSpriteList = new List<Sprite>();
    }
    IEnumerator CoroutineShow()
    {
        for(int i = 0; i<buySkillSpriteList.Count;i++)
        {
            // i=0 일때는 아직 setActive가 false ( obj가 꺼져있)때문에 alpha값을 올려도 안보임
            buyImgObj.SetActive(true); // 여기서 켜줬고 이 이후로 부터는 계속 켜져있을거임 alpha값만 조절할 거임
    
            skillImg.DOFade(1, 0); //알파값을 바로 0->1로

            skillImg.sprite = buySkillSpriteList[i];

            skillImg.DOFade(0, 2f); // 2초에 알파값을 페이드로 줘서 1->0으로 
            Debug.Log(buySkillSpriteList[i].name + "접근");
           

            yield return new WaitForSeconds(2f);

        }
        Debug.Log("여기 오니?");
        buyImgObj.SetActive(false);
        yield return null;
    }
    private void OnDestroy()
    {
        instance = null;
    }
}
