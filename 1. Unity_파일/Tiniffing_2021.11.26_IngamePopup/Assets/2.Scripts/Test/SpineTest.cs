using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
public class SpineTest : MonoBehaviour
{
    [SerializeField] private SkeletonAnimation skeletonAnimation;

    [SerializeField] [SpineSkin] private string spineSkin;

    [SerializeField] SkeletonDataAsset data1, data2;


    private void Update()
    {
        if (skeletonAnimation == null)
        {
            skeletonAnimation = GetComponent<SkeletonAnimation>();
        }

        if (Input.GetKeyUp(KeyCode.Q))
        {
            skeletonAnimation.skeletonDataAsset = data1;
            skeletonAnimation.Initialize(true);
            Debug.LogError("_____1");
        }

        if (Input.GetKeyUp(KeyCode.W))
        {
            skeletonAnimation.skeletonDataAsset = data2;
            skeletonAnimation.Initialize(true);

            Debug.LogError("_____2");
        }
    }

    public void test()
    {
        var test = GetComponent<SkeletonAnimation>();
        //test.skeletonDataAsset


       // SkeletonAnimation skeletonAnimation = GetComponent<SkeletonAnimation>(); // SkeletonAnimation �����ͳ�Ʈ ��������

        //Skin newSkin = new Skin("custom skin"); // ���ο� ��Ų����
        //var baseSkin = skeletonAnimation.Skeleton.Data.FindSkin(spineSkin); // ������ �ִ� ��Ų ��������
        //newSkin.AddAttachments(baseSkin);

        //newSkin.AddAttachments(baseSkin);
    }
    public void Btn1()
    {
        skeletonAnimation.AnimationName = "Idle1";
    }    
    public void Btn2()
    {
        skeletonAnimation.AnimationName = "Clear";
    }    
    public void Btn3()
    {
        skeletonAnimation.AnimationName = "Jump";
    }
}
