using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class FakeLoadingBar : MonoBehaviour
{
    [SerializeField] CanvasGroup canvasGroup;

    [SerializeField] private Slider loadingBarSlider;

    [SerializeField] private Text loadingText;

    [SerializeField] private GameObject runnerEffectObj;

    //  [SerializeField] private RectTransform sliderRectTr;

    private bool isLoadingCompelete;
    private float sliderMax;
    public void Init()
    {
        LocalValue.isFakeLoadingFinished = false; // √ ±‚»≠
        sliderMax = 500f;
        loadingBarSlider.value = 0f;
        loadingText.text = "0%";
        StartCoroutine(LoadingCor());
    }
    IEnumerator LoadingCor()
    {
        yield return StartCoroutine(Fade(true));
        float percent=0f;

        while (loadingBarSlider.value < 1f)
        {
            yield return new WaitForFixedUpdate();
            percent += Time.unscaledDeltaTime; //0.02 
            if(loadingBarSlider.value < 0.7f)
            {
                loadingBarSlider.value += percent / sliderMax;
            }
            else if(loadingBarSlider.value < 0.9f)
            {
                loadingBarSlider.value += 0.002f;
            }
            else
            {
                loadingBarSlider.value += 0.004f;              
            }

            loadingText.text = string.Format("{0}%",  ((int)(loadingBarSlider.value * 100)).ToString());
        }
        loadingBarSlider.value=1;
        yield return StartCoroutine(Fade(false));
    }
    private IEnumerator Fade(bool isFadeIn)
    {
            if (isFadeIn)
            {
                canvasGroup.DOFade(1f, 0.5f);
                yield return YieldInstructionCache.WaitForSeconds(0.5f);
            }
            else
            {
                canvasGroup.DOFade(0f, 0.5f);
            runnerEffectObj.SetActive(false);
            LocalValue.isFakeLoadingFinished = true;
            yield return YieldInstructionCache.WaitForSeconds(0.5f);
            } 

        if (!isFadeIn)
        {
            Destroy(gameObject);
        }

    }

}
