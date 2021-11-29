using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
public class InGameEffectSpreadController : MonoBehaviour
{
    [SerializeField] private GameObject InGameCanvas;
    [SerializeField] private RectTransform shadowRect;
    
    private Table.TiniffingSpotTable teeniepingData;
    private Coroutine coShadow;
    private Sequence shadowSequence;
    public void Init(Table.TiniffingSpotTable teeniepingData)
    {
        this.teeniepingData = teeniepingData;

        if (teeniepingData.effect_mode == "cloud")
        {
            OnEffectSpread();
        }
        else
        {
            shadowRect.gameObject.SetActive(true);

            if (coShadow == null)
                coShadow = StartCoroutine("ShadowCor");
        }
    }
    IEnumerator ShadowCor()
    {
        while (true)
        {
            TweenEffect_Shadow();
            yield return new WaitForSeconds(8.00001f);
        }
    }
    /*private void TweenEffect_Shadow()
    {
        shadowRect.DOAnchorPosX(-350, 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                shadowRect.DOAnchorPosY(-200, 1.5f).SetEase(Ease.Linear).OnComplete(() =>
                {
                    shadowRect.DOAnchorPosX(400, 2f).SetEase(Ease.Linear).OnComplete(() =>
                    {
                        shadowRect.DOAnchorPosY(300, 1.2f).SetEase(Ease.Linear).OnComplete(() =>
                        {
                            shadowRect.DOAnchorPosX(0, 1f).SetEase(Ease.Linear);
                        });
                    });
                });
             });
    }*/
    public void TweenEffect_Shadow()
    {
        shadowSequence = DOTween.Sequence().SetAutoKill(false)
        .OnStart(() =>
        {
            shadowRect.DOAnchorPosX(-265, 2f).SetEase(Ease.OutQuad);
            shadowRect.DOAnchorPosY(37, 2f).SetEase(Ease.InQuad).OnComplete(() =>
            {
                shadowRect.DOAnchorPosX(0, 2f).SetEase(Ease.InQuad);
                shadowRect.DOAnchorPosY(-90, 2f).SetEase(Ease.OutQuad).OnComplete(() =>
                {
                    shadowRect.DOAnchorPosX(265, 2f).SetEase(Ease.OutQuad);
                    shadowRect.DOAnchorPosY(37, 2f).SetEase(Ease.InQuad).OnComplete(() =>
                    {
                        shadowRect.DOAnchorPosX(0, 2f).SetEase(Ease.InQuad);
                        shadowRect.DOAnchorPosY(180, 2f).SetEase(Ease.OutQuad);
                    });
                });
            });
        });
    }
    private  void OnEffectSpread()
    {
        int rnd;
        int chapter_no= LocalValue.Click_Chapter_H;

         if (chapter_no<=3)
          rnd = UnityEngine.Random.Range(6, 8);
         else if(chapter_no <=6)
          rnd = UnityEngine.Random.Range(8, 11);
         else if (chapter_no <= 10)
             rnd = UnityEngine.Random.Range(11, 14);
         else 
             rnd = UnityEngine.Random.Range(15, 20);
 
        
        RectTransform canvasRect = InGameCanvas.GetComponent<RectTransform>();

        int xPos = 50;
        float yPos;

        for (int i = 1; i<=rnd; i++)
        {
       
            xPos *= -i;
            yPos = UnityEngine.Random.Range(-165, 165);


            if (xPos > 500)
            {
                xPos = UnityEngine.Random.Range(200, 500);
            }
            else if (xPos < -500)
            {
                xPos = UnityEngine.Random.Range(-500, -200);
            }

            if (yPos > 130)
            {
                yPos = UnityEngine.Random.Range(150, 230);
            }
            else if (yPos < -130)
            {
                yPos = UnityEngine.Random.Range(-230, -150);
            }
            GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/" + teeniepingData.effect_mode), canvasRect);
          //  GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/InGameEffect/cloud"), canvasRect);
            RectTransform cloneRect =cloneObj.GetComponent<RectTransform>();
            cloneRect.anchoredPosition = new Vector2(xPos, yPos);
        }
    }
}
