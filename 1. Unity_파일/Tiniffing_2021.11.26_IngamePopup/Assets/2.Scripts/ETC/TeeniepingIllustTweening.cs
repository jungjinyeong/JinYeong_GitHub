using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class TeeniepingIllustTweening : MonoBehaviour
{
    [SerializeField] RectTransform illust3Rect;
    [SerializeField] RectTransform illust4Rect;
    [SerializeField] RectTransform illust6Rect;
    [SerializeField] RectTransform illust7Rect;
    [SerializeField] RectTransform illust8Rect;

    void Start()
    {
        illust3();
        illust4();
        illust6();
        illust7();
        illust8();
    }
    private void illust3()
    {
        illust3Rect.DOAnchorPosY(5, 0.95f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    private void illust4()
    {
        illust4Rect.DOAnchorPosY(13, 1f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    private void illust6()
    {
        illust6Rect.DOAnchorPosY(-135, 0.85f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    private void illust7()
    {
        illust7Rect.DOAnchorPosY(-165, 0.75f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    private void illust8()
    {
        illust8Rect.DOAnchorPosY(-147, 0.78f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
}
