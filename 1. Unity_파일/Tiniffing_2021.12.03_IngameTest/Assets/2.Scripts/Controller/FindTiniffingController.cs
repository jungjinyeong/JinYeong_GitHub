using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
public class FindTiniffingController : MonoBehaviour
{
    [SerializeField] private GameObject hintEffectObj;
    [SerializeField] private GameObject checkObj;
    [SerializeField] private GameObject touchBlockObj;
    [SerializeField] private GameObject findEffectObj;

    //Display

    [SerializeField]  RectTransform teeniepingImageRectTr;
    [SerializeField]  Image teeniepingImage;

    Sequence teeniepingMovementSequence;

    public void OnFindButtonClick()
    {
        checkObj.gameObject.SetActive(true);
        checkObj.transform.DOScale(new Vector2(1.2f, 1.2f), 0.1f).OnComplete(() =>
        {
            findEffectObj.SetActive(true);
            checkObj.transform.DOScale(new Vector2(0.5f, 0.5f), 0.1f).OnComplete(() =>
            {
                checkObj.transform.DOScale(new Vector2(1, 1), 0.1f);
            });
        });
        // 두번클릭했을때 예외처리 => touchblock 활성화 
        touchBlockObj.SetActive(true);
        HintEffectOff(); // 힌트 이펙트 꺼주기 (원래 꺼져있든 켜져있든 그냥 무조건 실행)
        // 티니핑 찾을때 마다 벨 이미지 바뀜
        InGameManager.instance.OnCubeImageChange();
        InGameManager.instance.RemoveHintPoleHashSet(gameObject.name); // 힌트봉 해쉬셋에서 제거
        //게임메니저에 티니핑 하나 찾을때마다 처리할 체킹 이름을 넘김
        GameManager.instance.IngameClearCheck(gameObject.name); // 티니핑 뿌려줄때 오브젝트 이름을 리소스 이름으로 바꾸어주었기 때문에 object이름 넘김  
    }

    public void HintEffectOn()
    {
        hintEffectObj.SetActive(true);
    }
    public void HintEffectOff()
    {
        hintEffectObj.SetActive(false);
    }
    public void MovementRandomPick()
    {
        int rnd = UnityEngine.Random.Range(1, 10); // 그림에 몇개나올지 선택할 개수
        switch (rnd)
        {
            case 1:
                TeeniepingMovement1_DOScale();
                break;
            case 2:
                TeeniepingMovement2_DOScale();
                break;
            case 3:
                TeeniepingMovement3_DOScale();
                break;
            case 4:
                TeeniepingMovement4_DOFade();
                break;
            case 5:
                TeeniepingMovement5_DOFade();
                break;
            case 6:
                TeeniepingMovement6_DOFade();
                break;
            case 7:
                TeeniepingMovement7_DORotate();
                break;
            case 8:
                TeeniepingMovement8_DORotate();
                break;
            case 9:
                TeeniepingMovement9_DORotate();
                break;
                
            default:
                break;
        }
    }
  
    private void TeeniepingMovement1_DOScale()
    {
        
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImageRectTr.DOScale(new Vector2(1.1f, 1.1f), 0.2f).SetLoops(6, LoopType.Yoyo)).SetDelay(2).OnComplete(() =>
        {
            teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
    private void TeeniepingMovement2_DOScale()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImageRectTr.DOScale(new Vector2(1.15f, 1.15f), 0.25f).SetLoops(8, LoopType.Yoyo)).SetDelay(4).OnComplete(() =>
        {
            teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
    private void TeeniepingMovement3_DOScale()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImageRectTr.DOScale(new Vector2(1.2f, 1.2f), 0.3f).SetLoops(6, LoopType.Yoyo)).SetDelay(5).OnComplete(() =>
        {
            teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
 
    private void TeeniepingMovement4_DOFade()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImage.DOFade((50f / 255f), 0.4f).SetEase(Ease.Linear).SetLoops(2, LoopType.Yoyo)).SetDelay(2).OnComplete(() =>
        {
            teeniepingImage.DOFade(1, 1f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
    private void TeeniepingMovement5_DOFade()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImage.DOFade((100f / 255f), 0.4f).SetEase(Ease.Linear).SetLoops(4, LoopType.Yoyo)).SetDelay(3).OnComplete(() =>
        {
            teeniepingImage.DOFade(1, 0.7f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
    private void TeeniepingMovement6_DOFade()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Prepend(teeniepingImage.DOFade((100f / 255f), 0.4f).SetEase(Ease.Linear).SetLoops(8, LoopType.Yoyo)).SetDelay(5).OnComplete(() =>
        {
            teeniepingImage.DOFade(1, 0.4f).SetEase(Ease.Linear).OnComplete(() =>
            {
                teeniepingMovementSequence.Restart();
            });
        });
    }
    private void TeeniepingMovement7_DORotate()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Join(teeniepingImageRectTr.DOScale(new Vector2(1.08f, 1.08f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0.1f, teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, -5f), 0.1f))
        .Insert(0.1f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 5f), 0.1f))
        .Insert(0.2f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 0f), 0.1f))
        .InsertCallback(0.3f, () => TeeinepingMovement7_DORotateRestart()).SetDelay(2);
    }
    private void TeeinepingMovement7_DORotateRestart()
    {
        Debug.Log("TeeinepingMovement_7_DoRotate_Restart");
        teeniepingMovementSequence.Restart();
    }
    private void TeeniepingMovement8_DORotate()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Join(teeniepingImageRectTr.DOScale(new Vector2(1.08f, 1.08f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0.1f, teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, -5f), 0.1f))
        .Insert(0.1f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 5f), 0.1f))
        .Insert(0.2f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 0f), 0.1f))
        .InsertCallback(0.3f, () => TeeniepingMovement8_DORotateRestart()).SetDelay(4);
    }
    private void TeeniepingMovement8_DORotateRestart()
    {
        Debug.Log("TeeinepingMovement_8_DoRotate_Restart");
        teeniepingMovementSequence.Restart();
    }
    private void TeeniepingMovement9_DORotate()
    {
        teeniepingMovementSequence = DOTween.Sequence()
        .SetAutoKill(false)
        .Join(teeniepingImageRectTr.DOScale(new Vector2(1.08f, 1.08f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0.1f, teeniepingImageRectTr.DOScale(new Vector2(1f, 1f), 0.1f)).SetEase(Ease.Linear)
        .Insert(0f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, -5f), 0.1f))
        .Insert(0.1f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 5f), 0.1f))
        .Insert(0.2f, teeniepingImageRectTr.DORotate(new Vector3(0, 0, 0f), 0.1f))
        .InsertCallback(0.3f, () => TeeniepingMovement9_DORotateRestart()).SetDelay(6);
    }
    private void TeeniepingMovement9_DORotateRestart()
    {
        Debug.Log("TeeinepingMovement_9_DoRotate_Restart");
        teeniepingMovementSequence.Restart();
    }
}
