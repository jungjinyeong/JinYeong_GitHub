using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using DG.Tweening;

public class BasePopup : MonoBehaviour
{
    private Sequence speechBubbleSequence;

    public virtual void Init(int id =-1)
    {
        Pop();
    }
    protected void Pop(bool isOverlay =true)
    {
        PopupContainer.Pop(this, isOverlay);
    }
    protected virtual void PopTweenEffect_Small(RectTransform groupRect)
    {
        groupRect.transform.DOScale(new Vector2(1f, 1f), 0.3f);
    }  
    protected virtual void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        groupRect.transform.DOScale(new Vector2(1f, 1f), 0.4f);
    } 
    protected virtual void PopTweenEffect_Full(RectTransform groupRect)
    {
        groupRect.transform.DOScale(new Vector2(1f, 1f), 0.4f);
    } 
    protected virtual void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        closeButtonRect.DOScale(new Vector2(1.2f, 1.2f), 0.3f).OnComplete(() =>
        {
            closeButtonRect.DOScale(new Vector2(1f, 1f), 0.3f);
        });
    }
    protected virtual void SpeechBubbleDoText(Text speechBubbleText, int textId)
    {
        speechBubbleSequence = DOTween.Sequence()
       .Insert(0.5f, speechBubbleText.DOText(DataService.Instance.GetText(textId), 1f));
    }
    protected virtual void TweenEffect_SideUpBar(RectTransform sideUpGroupRect)
    {
        sideUpGroupRect.DOAnchorPosY(-100, 1f).SetEase(Ease.InQuad).OnComplete(() =>
        {
            sideUpGroupRect.DOAnchorPosY(-65, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                sideUpGroupRect.DOAnchorPosY(-83, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
                {
                    sideUpGroupRect.DOAnchorPosY(-78, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
                    {
                        sideUpGroupRect.DOAnchorPosY(-83, 0.1f).SetEase(Ease.Linear);
                    });
                });
            });
        });
    }
   /* protected virtual void TweenEffect_CloseButton(RectTransform closeButtonRect)
    {
        closeButtonRect.DOAnchorPosY(282, 0.6f).SetEase(Ease.InQuad).OnComplete(() =>
        {
            closeButtonRect.DOAnchorPosY(300, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                closeButtonRect.DOAnchorPosY(282, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
                {
                    closeButtonRect.DOAnchorPosY(287, 0.1f).SetEase(Ease.Linear).OnComplete(() =>
                    {
                        closeButtonRect.DOAnchorPosY(282, 0.1f).SetEase(Ease.Linear);
                    });
                });
            });
        });
    }*/
    public virtual void OnRefresh()
    {

    }
    public virtual void Close()
    {
        PopupContainer.Close();
        Destroy(gameObject);
    }
}
