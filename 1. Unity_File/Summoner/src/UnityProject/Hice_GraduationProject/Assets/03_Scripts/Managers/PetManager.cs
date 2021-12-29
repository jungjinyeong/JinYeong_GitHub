using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Linq;


public class PetManager : MonoBehaviour //데이터만 뿌려주는 역할
{

    public static PetManager instance;

    public Transform gridParentTr; // 복제한 후 들어갈 위치
    public PetUIInfo defaultPetUIInfo; //복제할 놈

    public PetDescriptionInfo defaultPetDescriptionInfo; // desc 부분 복제할 obj

    public RectTransform petDescInfoRecTr;

    private int showingDescPetId=-1;

    List<PetUIInfo> petUIInfoList = new List<PetUIInfo>();

    private void Awake()
    {
        instance = this;

        var petDataList = DataService.Instance.GetDataList<Table.PetTable>().OrderBy(x => x.grade).ToList();
        // import system.linq 하고  람다식으로 그래이드 기준으로 오름차순 정렬!
        // ***OrderBy() 사용시 리턴값이 달라지므로 .ToList()로 다시 리스트화 시킴 ***
        // 내림차순 원하면 OrderBy() 대신 OrderByDescending()


        for (int i=0;i<petDataList.Count;i++)
        {
            if(i==0) //기존거 변경으로 사용
            {
                defaultPetUIInfo.Init(petDataList[i].id);
                petUIInfoList.Add(defaultPetUIInfo);
            }
            else//복제
            {
                GameObject petUIObj = Instantiate(defaultPetUIInfo.gameObject, gridParentTr);
                PetUIInfo petUIInfo = petUIObj.GetComponent<PetUIInfo>();
                petUIInfoList.Add(petUIInfo);
                petUIInfo.Init(petDataList[i].id);
            }
        }
    }



    public void ShowPetDescriptionInfo(int petId)
    {
        defaultPetDescriptionInfo.Init(petId);
        if (showingDescPetId == -1)
        {
            showingDescPetId = petId;
            petDescInfoRecTr.DOKill();
            petDescInfoRecTr.DOAnchorPosY(0, 0.5f).SetEase(Ease.OutQuad); //부드럽게 멈춤

        }
       

    }

    public void HidePetDescInfo()
    {
        showingDescPetId = -1;
        petDescInfoRecTr.DOKill();
        petDescInfoRecTr.DOAnchorPosY(-200, 0.5f).SetEase(Ease.OutQuad); //부드럽게 멈춤
    }
    public void ShowBuyPetSkillConfirmPopup(int petid)
    {
        Debug.Log("showBuyPetSkillConfirm  PetManager");
        PopupContainer.CreatePopup(PopupType.PetSkillConfirmPopup).Init(petid);
    }
    public void RefreshAll()
    {
        for(int i =0;i<petUIInfoList.Count;i++)
        {
            petUIInfoList[i].Refresh();
        }
        defaultPetDescriptionInfo.Refresh();
        LobbyManager.instance.RefreshAll();
    }
    private void OnDestroy()
    {
        instance = null; 
    }

}
