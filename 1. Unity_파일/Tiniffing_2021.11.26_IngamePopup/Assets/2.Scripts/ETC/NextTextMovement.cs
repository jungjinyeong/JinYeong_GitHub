using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;

public class NextTextMovement : MonoBehaviour
{
    [SerializeField] private RectTransform nextTextRect;
    void Start()
    {
        Init();
    }
    private void Init()
    {
        TextRefresh();
        NextText_MoveMent();
    }
    private void NextText_MoveMent()
    {
        float nextText_XPos = nextTextRect.anchoredPosition.x;
        float targetPos = nextText_XPos + 4f;
        nextTextRect.DOAnchorPosX(targetPos, 0.6f).SetEase(Ease.Linear).SetLoops(-1, LoopType.Yoyo);
    }
    private void TextRefresh()
    {
        nextTextRect.GetComponent<Text>().text = DataService.Instance.GetText(949);
    }
}
