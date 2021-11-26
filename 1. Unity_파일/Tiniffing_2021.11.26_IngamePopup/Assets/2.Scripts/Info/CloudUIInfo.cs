using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class CloudUIInfo : MonoBehaviour
{
    [SerializeField] private GameObject effectObj;
    [SerializeField] private GameObject cloudImageObj;
    private Sequence cloudsSequence;

   
    public void OnCloudButtonClick()
    {
        StartCoroutine(CloudOffCor());
    }
    private IEnumerator CloudOffCor()
    {
        cloudImageObj.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).OnComplete(() =>
        {
            cloudImageObj.transform.DOScale(new Vector2(0.0001f, 0.0001f), 0.3f);
        });
        effectObj.SetActive(true);

        yield return new WaitForSeconds(0.6f);
        gameObject.SetActive(false);

    }
  
}
