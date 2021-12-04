using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
public class InGameSceneTest : MonoBehaviour
{
    public GameObject map1Obj;
    public GameObject map2Obj;

    public GameObject mapBackgroundObj1;
    public GameObject mapBackgroundObj2;
    public Image removeBackground1_1;
    public Image removeBackground2_1;
    public Image removeBackground3_1;
    public Image removeBackground4_1;
    public Image removeBackground5_1;
    public Image removeBackground6_1;
    public Image removeBackground1_2;
    public Image removeBackground2_2;
    public Image removeBackground3_2;
    public Image removeBackground4_2;
    public Image removeBackground5_2;
    public Image removeBackground6_2;
    public GameObject teenieping1Obj;
    public GameObject teenieping2Obj;
    public GameObject teenieping3Obj;
    public GameObject teenieping4Obj;
    public GameObject teenieping5Obj;
    public GameObject teenieping6Obj;
    public GameObject teenieping7Obj;
    public GameObject teenieping8Obj;
    public GameObject teenieping9Obj;
    public GameObject teenieping10Obj;
    public GameObject teenieping11Obj;
    public GameObject teenieping12Obj;
    public GameObject teenieping13Obj;
    public GameObject teenieping14Obj;
    public GameObject teenieping15Obj;
    public GameObject teenieping16Obj;
    public GameObject teenieping17Obj;
    public GameObject teenieping18Obj;
    public GameObject teenieping19Obj;
    public GameObject teenieping20Obj;

    public RectTransform teenieping1_Rect;
    public RectTransform teenieping2_Rect;
    public RectTransform teenieping3_Rect;
    public RectTransform teenieping4_Rect;
    public RectTransform teenieping5_Rect;
    public RectTransform teenieping6_Rect;
    public RectTransform teenieping7_Rect;
    public RectTransform teenieping8_Rect;
    public RectTransform teenieping9_Rect;
    public RectTransform teenieping10_Rect;
    public RectTransform teenieping11_Rect;
    public RectTransform teenieping12_Rect;
    public RectTransform teenieping13_Rect;
    public RectTransform teenieping14_Rect;
    public RectTransform teenieping15_Rect;
    public RectTransform teenieping16_Rect;
    public RectTransform teenieping17_Rect;
    public RectTransform teenieping18_Rect;
    public RectTransform teenieping19_Rect;
    public RectTransform teenieping20_Rect;

    
    private Sequence teeniepingAnimaion1_Sequence;
    private Sequence teeniepingAnimaion2_Sequence;
    private Sequence teeniepingAnimaion3_Sequence;
    private Sequence teeniepingAnimaion4_Sequence;
    private Sequence teeniepingAnimaion5_Sequence;
    private Sequence teeniepingAnimaion6_Sequence;
    private Sequence teeniepingAnimaion7_Sequence;
    private Sequence teeniepingAnimaion8_Sequence;
    private Sequence teeniepingAnimaion9_Sequence;
    private Sequence teeniepingAnimaion10_Sequence;

    private HashSet<GameObject> teeniepingHashSet = new HashSet<GameObject>();
    private void Start()
    {
        Init();
    }
    // 리스트에 있는 티니핑 목록을 하나하나 지우면서 그 List의 Count가 0이 되었을 때 클리어!
    public void IngameClearCheck(GameObject findTiniffingObj)
    {
        teeniepingHashSet.Remove(findTiniffingObj); // 찾은 티니핑 리스트에서 지우기
        //하나의 맵 클리어
        if (teeniepingHashSet.Count == 0)
            MapClear();
    }

    private void Init()
    {
        teeniepingHashSet.Add(teenieping1Obj);
        teeniepingHashSet.Add(teenieping2Obj);
        teeniepingHashSet.Add(teenieping3Obj);
        teeniepingHashSet.Add(teenieping4Obj);
        teeniepingHashSet.Add(teenieping5Obj);
        teeniepingHashSet.Add(teenieping6Obj);
        teeniepingHashSet.Add(teenieping7Obj);
        teeniepingHashSet.Add(teenieping8Obj);
        teeniepingHashSet.Add(teenieping9Obj);
        teeniepingHashSet.Add(teenieping10Obj);
        AnimationController1();
    }
    private void MapClear()
    {
        teeniepingHashSet.Clear();
        teeniepingHashSet.Add(teenieping11Obj);
        teeniepingHashSet.Add(teenieping12Obj);
        teeniepingHashSet.Add(teenieping13Obj);
        teeniepingHashSet.Add(teenieping14Obj);
        teeniepingHashSet.Add(teenieping15Obj);
        teeniepingHashSet.Add(teenieping16Obj);
        teeniepingHashSet.Add(teenieping17Obj);
        teeniepingHashSet.Add(teenieping18Obj);
        teeniepingHashSet.Add(teenieping19Obj);
        teeniepingHashSet.Add(teenieping20Obj);
        //세팅
        map1Obj.SetActive(false);
        map2Obj.SetActive(true);
        // 애니메이션 재생
        AnimationController2();
    }
    public void DoKillFun(RectTransform teeniepingRect)
    {
        teeniepingRect.DOKill();
        Debug.Log("Dokill");
    }
    private void AnimationController1()
    {
        Debug.Log("Animation controller1");
        Animation1(teenieping1_Rect);
        Animation2(teenieping2_Rect);
        Animation3(teenieping3_Rect);
        Animation4(teenieping4_Rect);
        Animation5(teenieping5_Rect);
        Animation6(teenieping6_Rect);
        Animation7(teenieping7_Rect);
        Animation8(teenieping8_Rect);
        Animation9(teenieping9_Rect);
        Animation10(teenieping10_Rect);
    }
    private void AnimationController2()
    {
        Debug.Log("Animation controller2");
        Animation1(teenieping11_Rect);
        Animation2(teenieping12_Rect);
        Animation3(teenieping13_Rect);
        Animation4(teenieping14_Rect);
        Animation5(teenieping15_Rect);
        Animation6(teenieping16_Rect);
        Animation7(teenieping17_Rect);
        Animation8(teenieping18_Rect);
        Animation9(teenieping19_Rect);
        Animation10(teenieping20_Rect);
    }
    private void Animation1(RectTransform teeenieping)//위쪽
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusyPos1 = 40f;
        float plusyPos2 = 30f;
        teeniepingAnimaion1_Sequence = DOTween.Sequence()
        .InsertCallback(0f, () => RayCastActiveOff_1())
        .Insert(1f, teeenieping.DOAnchorPosY(defaultY + plusyPos1, 0.5f))
        .Insert(1.5f, teeenieping.DOAnchorPosY(defaultY, 0.3f))
        .Insert(1.8f, teeenieping.DOAnchorPosY(defaultY + plusyPos2, 0.5f))
        //.Insert(1f, teeenieping.DORotate(new Vector3(0, 0, -5f), 0.5f))
        //.Insert(1.5f, teeenieping.DORotate(new Vector3(0, 0, 5f), 0.5f))
        //.Insert(2.0f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .Insert(2.3f, teeenieping.DOAnchorPosY(defaultY, 0.3f))
        .InsertCallback(2.6f, () => RayCastActiveOn_1())
        .InsertCallback(5f, () => TeeniepingAnimaion_1Restart());
    }
    
    private void RayCastActiveOff_1()
    {
        removeBackground1_1.raycastTarget = false;
    }
    private void RayCastActiveOn_1()
    {
        removeBackground1_1.raycastTarget = true;
    }
    private void TeeniepingAnimaion_1Restart()
    {
        teeniepingAnimaion1_Sequence.Restart();
    }
    private void Animation2(RectTransform teeenieping)//오른쪽 빼꼼
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = 32f;
        teeniepingAnimaion2_Sequence = DOTween.Sequence()
        .InsertCallback(0f, () => RayCastActiveOff_2())
        .Insert(3f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(3f, teeenieping.DORotate(new Vector3(0, 0, -7f), 1f))
        .Insert(6f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(6f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(6.5f, () => RayCastActiveOn_2())
        .InsertCallback(9f, () => TeeniepingAnimaion_2Restart());
    }
    private void RayCastActiveOff_2()
    {
        removeBackground2_1.raycastTarget = false;
    }
    private void RayCastActiveOn_2()
    {
        removeBackground2_1.raycastTarget = true;
    }
    private void TeeniepingAnimaion_2Restart()
    {
        teeniepingAnimaion2_Sequence.Restart();
    }
 
    private void Animation3(RectTransform teeenieping)//오른쪽 빼꼼
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = 52f;
        teeniepingAnimaion3_Sequence = DOTween.Sequence()
        .InsertCallback(0f, () => RayCastActiveOff_3())
        .Insert(5f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(5f, teeenieping.DORotate(new Vector3(0, 0, -50f), 1f))
        .Insert(6f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(6f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(6.5f, () => RayCastActiveOn_3())
        .InsertCallback(8f, () => TeeniepingAnimaion_3Restart());
    }
    private void RayCastActiveOff_3()
    {
        removeBackground3_1.raycastTarget = false;
    }
    private void RayCastActiveOn_3()
    {
        removeBackground3_1.raycastTarget = true;
    }
    private void TeeniepingAnimaion_3Restart()
    {
        teeniepingAnimaion3_Sequence.Restart();
    }
    private void Animation4(RectTransform teeenieping)//왼쪽 빼꼼
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = -32f;
        teeniepingAnimaion4_Sequence = DOTween.Sequence()
        .InsertCallback(0f, () => RayCastActiveOff_4())
        .Insert(1f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(1f, teeenieping.DORotate(new Vector3(0, 0, 7f), 1f))
        .Insert(2f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(2f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(2.5f, () => RayCastActiveOn_4())
        .InsertCallback(7f, () => TeeniepingAnimaion_4Restart());
    }
    private void RayCastActiveOff_4()
    {
        removeBackground4_1.raycastTarget = false;
    }
    private void RayCastActiveOn_4()
    {
        removeBackground4_1.raycastTarget = true;
    }
    private void TeeniepingAnimaion_4Restart()
    {
        teeniepingAnimaion4_Sequence.Restart();
    }
    private void Animation5(RectTransform teeenieping)//오른쪽 빼꼼
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = 32f;
        teeniepingAnimaion5_Sequence = DOTween.Sequence()
        .InsertCallback(0f, () => RayCastActiveOff_5())
        .Insert(6f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(6f, teeenieping.DORotate(new Vector3(0, 0, -50f), 1f))
        .Insert(7f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(7f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(7.5f, () => RayCastActiveOn_5())
        .InsertCallback(8f, () => TeeniepingAnimaion_5Restart());
    }
    private void RayCastActiveOff_5()
    {
        removeBackground5_1.raycastTarget = false;
    }
    private void RayCastActiveOn_5()
    {
        removeBackground5_1.raycastTarget = true;
    }
    private void TeeniepingAnimaion_5Restart()
    {
        teeniepingAnimaion5_Sequence.Restart();
    }
    private void Animation6(RectTransform teeenieping)
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = 60f;
        teeniepingAnimaion6_Sequence = DOTween.Sequence()
        .Insert(1f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(1f, teeenieping.DORotate(new Vector3(0, 0, -7f), 1f))
        .Insert(2f, teeenieping.DORotate(new Vector3(0, 0, -2f), 0.5f).SetEase(Ease.Linear).SetLoops(4,LoopType.Yoyo))
        .Insert(5f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(5f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(7f, () => TeeniepingAnimaion_6Restart());
    }
    private void TeeniepingAnimaion_6Restart()
    {
        teeniepingAnimaion6_Sequence.Restart();
    }
    private void Animation7(RectTransform teeenieping)
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusYPos1 = -40f;
        teeniepingAnimaion7_Sequence = DOTween.Sequence()
        .Insert(1f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(5f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .InsertCallback(10f, () => TeeniepingAnimaion_7Restart());
    }
    private void TeeniepingAnimaion_7Restart()
    {
        teeniepingAnimaion7_Sequence.Restart();
    }
    private void Animation8(RectTransform teeenieping)
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos1 = 150f;
        float plusXPos2 = -100f;
        float plusYPos1 = -25f;
        float plusYPos2 = -20f;
        teeniepingAnimaion8_Sequence = DOTween.Sequence()
        .Insert(3f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(4f, teeenieping.DOAnchorPosX(defaultX + plusXPos1, 5f)).SetEase(Ease.Linear)//오른쪽으로 이동
        .Insert(4f, teeenieping.DOAnchorPosY(defaultY + plusYPos2, 0.35f).SetEase(Ease.Linear).SetLoops(12, LoopType.Yoyo))//위 아래 이동
        .Insert(9f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .Insert(13f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(14f, teeenieping.DOAnchorPosX(defaultX + plusXPos2, 7f)).SetEase(Ease.Linear)//왼쪽으로 이동
        .Insert(14f, teeenieping.DOAnchorPosY(defaultY + plusYPos2, 0.35f).SetEase(Ease.Linear).SetLoops(18, LoopType.Yoyo))//반대로 위 아래 이동
        .Insert(20f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .Insert(21f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(22f, teeenieping.DOAnchorPosX(defaultX, 5f)).SetEase(Ease.Linear)//오른쪽으로 이동
        .Insert(22f, teeenieping.DOAnchorPosY(defaultY + plusYPos2, 0.35f).SetEase(Ease.Linear).SetLoops(12, LoopType.Yoyo))//위 아래 이동
        .Insert(26f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .InsertCallback(30f, () => TeeniepingAnimaion_8Restart());
    }
    private void TeeniepingAnimaion_8Restart()
    {
        teeniepingAnimaion8_Sequence.Restart();
    }
    private void Animation9(RectTransform teeenieping)
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos = -90f;
        teeniepingAnimaion9_Sequence = DOTween.Sequence()
        .Insert(1f, teeenieping.DOAnchorPosX(defaultX + plusXPos, 1f))
        .Insert(1f, teeenieping.DORotate(new Vector3(0, 0, 50f), 1f))
        .Insert(2f, teeenieping.DORotate(new Vector3(0, 0, 40f), 0.5f).SetEase(Ease.Linear).SetLoops(4, LoopType.Yoyo))
        .Insert(4.2f, teeenieping.DOAnchorPosX(defaultX, 1f))
        .Insert(4.2f, teeenieping.DORotate(new Vector3(0, 0, 0f), 0.5f))
        .InsertCallback(6.5f, () => TeeniepingAnimaion_9Restart());
    }
    private void TeeniepingAnimaion_9Restart()
    {
        teeniepingAnimaion9_Sequence.Restart();
    }
    private void Animation10(RectTransform teeenieping)
    {
        float defaultX = teeenieping.anchoredPosition.x;
        float defaultY = teeenieping.anchoredPosition.y;
        float plusXPos1 = 240f;
        float plusYPos1 = -25f;
        float plusYPos2 = -20f;
        teeniepingAnimaion10_Sequence = DOTween.Sequence()
        .Insert(1f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(2f, teeenieping.DOAnchorPosX(defaultX + plusXPos1, 5f)).SetEase(Ease.Linear)//오른쪽으로 이동
        .Insert(2f, teeenieping.DOAnchorPosY(defaultY + plusYPos2, 0.35f).SetEase(Ease.Linear).SetLoops(12,LoopType.Yoyo))//위 아래 이동
        .Insert(7f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .Insert(11f, teeenieping.DOAnchorPosY(defaultY + plusYPos1, 1f))//아래로 이동
        .Insert(12f, teeenieping.DOAnchorPosX(defaultX, 5f)).SetEase(Ease.Linear)//왼쪽으로 이동
        .Insert(12f, teeenieping.DOAnchorPosY(defaultY + plusYPos2, 0.35f).SetEase(Ease.Linear).SetLoops(12, LoopType.Yoyo))//반대로 위 아래 이동
        .Insert(17f, teeenieping.DOAnchorPosY(defaultY, 1f))//위로 이동
        .InsertCallback(25f, () => TeeniepingAnimaion_10Restart());
    }
    private void TeeniepingAnimaion_10Restart()
    {
        teeniepingAnimaion10_Sequence.Restart();
    }
}

