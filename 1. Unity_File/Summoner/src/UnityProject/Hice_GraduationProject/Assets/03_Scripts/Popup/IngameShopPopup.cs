using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IngameShopPopup : BasePopup
{

    public SkillUIInfo defaultSkillUIInfo;
    public Transform gridTr; // grid 의 자식으로 defaultSkillUIInfo를 복제할 것이다 
    public GameObject petButtonHighlightObj;
    public GameObject summonerButtonHighlightObj;


    List<GameObject> cloneSkillUIInfoObjList = new List<GameObject>();

     public override void Init(int id = -1)
    {
        base.Init(id);
        BuySkillManager.instance.StopBuySkillDirection();
        OnPetTapClick(); // 팝업 띄우는 순간 디폴트로 소환수 스킬창 보겠다

    }

    public override void OnRefresh()
    {
        defaultSkillUIInfo.OnRefresh();
        for (int i = 0; i < cloneSkillUIInfoObjList.Count; i++)
        {
            cloneSkillUIInfoObjList[i].GetComponent<SkillUIInfo>().OnRefresh();
        }
    }

    void ShowSkill (string type)
    {
        for (int i = 0; i < cloneSkillUIInfoObjList.Count; i++)
            Destroy(cloneSkillUIInfoObjList[i]); //게임 오브젝트만 없앤 것 일뿐이고 리스트가 초기화 된 건 아님

        cloneSkillUIInfoObjList = new List<GameObject>(); //리스트 초기화
 
        var skillDataList = DataService.Instance.GetDataList<Table.IngameShopSkillTable>().FindAll(x => x.skill_type == type);
        for(int i = 0; i<skillDataList.Count ;i++)
        {
            if(i==0) // 이미 만들어 놓은 틀에 정보를 덮어 담는다
            {
                defaultSkillUIInfo.Init(skillDataList[i].id);
            }
            else // 틀이 하나 밖에 없으므로 복제를 한 후에 정보를 넣는다
            {
                GameObject cloneObj = Instantiate(defaultSkillUIInfo.gameObject, gridTr);  // (복제할 대상 , 달아줄 부모) //복사단계
                cloneSkillUIInfoObjList.Add(cloneObj);
                SkillUIInfo skillUIInfo = cloneObj.GetComponent<SkillUIInfo>(); // 복제한 녀석의 컴포넌트 가져오는 단계
                skillUIInfo.Init(skillDataList[i].id); // 복제한 녀석이 가지는 Id 값 넘겨주기
            }
        }
    }

    public void OnPetTapClick()
    {
        petButtonHighlightObj.SetActive(true);
        summonerButtonHighlightObj.SetActive(false);
        ShowSkill("Pet"); 
    }
    public void OnSummonerTapClick()
    {

        petButtonHighlightObj.SetActive(false);
        summonerButtonHighlightObj.SetActive(true);
        ShowSkill("Summoner");
    }
    public override void Close()
    {
        base.Close();
        BuySkillManager.instance.ShowBuySkill();
    }

}
