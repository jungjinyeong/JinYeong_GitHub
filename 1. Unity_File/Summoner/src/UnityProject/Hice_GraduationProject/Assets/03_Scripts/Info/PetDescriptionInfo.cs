using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PetDescriptionInfo : MonoBehaviour
{

    public Text attackPower;
    public Text attackSpeed;
    public Text attackRange;
    public Text moveSpeed;
    public Text saphireText;
    public Text petDescriptionText;
    public Text petNameText;
    public Text nowLevelText;
    public Text afterLevelText;

    public Text nextAttackPower;
    public Text nextAttackRange;
    public Text nextAttackSpeed;
    public Text nextMoveSpeed;

    public Text saphire;

    public GameObject canUpgradeTouchBlock;
    private int petId;


    private int need_saphire;
    private int player_saphire;
    private int player_level;
    private string release_level;


    public Text selectText;
    public GameObject selectIconObj;
    public GameObject unSelectIconObj;

    public GameObject selectTouchBlock;

    private bool canUpgrade;

    public void Init(int petId)
    {
        //OnNeedSaphireButtonClick() 에 사용할것
        this.petId = petId;
        var playerData = DataService.Instance.GetData<Table.SaveTable>(0);


        player_level = playerData.player_level;
        player_saphire = playerData.saphire;

        // 텍스트 값 세팅위한 작업
        var petData = DataService.Instance.GetData<Table.PetTable>(petId);
        var playerPetData = DataService.Instance.GetData<Table.PlayerPetTable>(petId);

        release_level = petData.release_level; // 이건 온니드사파이어버튼클릭함수에서 사용할거임
        Debug.Log("petData id : " + petData.id);
        need_saphire = petData.need_saphire + playerPetData.level * petData.inc_need_saphire;

        //text 값 세팅 (연산 포함)
        petNameText.text = DataService.Instance.GetText(petData.name_text_id);
        petDescriptionText.text = DataService.Instance.GetText(petData.desc_text_id);


        nowLevelText.text = "Lv."+playerPetData.level.ToString();
        afterLevelText.text = "Lv." + (playerPetData.level + 1).ToString();

        //Lv 0 일떄 값 세팅
        if (playerPetData.level == 0)
        {
            attackPower.text = "Attack Power : 0";
            attackRange.text = "Attack Range : 0";
            attackSpeed.text = "Attack Speed : 0";
            moveSpeed.text = "Move Speed : 0";

            nextAttackPower.text = "Attack Power : " + petData.attack_power.ToString();
            nextAttackRange.text = "Attack Range : " + petData.attack_range.ToString();
            nextAttackSpeed.text = "Attack Speed : " + petData.attack_speed.ToString();
            nextMoveSpeed.text = "Move Speed : " + petData.move_speed.ToString();

        }

        else
        {
            attackPower.text = "Attack Power : " + (petData.attack_power + playerPetData.level * petData.inc_attack_power).ToString();
            attackRange.text = "Attack Range : " + (petData.attack_range + playerPetData.level * petData.inc_attack_range).ToString();
            attackSpeed.text = "Attack Speed : " + (petData.attack_speed + playerPetData.level * petData.inc_attack_speed).ToString();
            moveSpeed.text = "Move Speed : " + (petData.move_speed + playerPetData.level * petData.inc_move_speed).ToString();

            nextAttackPower.text = "Attack Power : " + (petData.attack_power + (playerPetData.level + 1) * petData.inc_attack_power).ToString();
            nextAttackRange.text = "Attack Range : " + (petData.attack_range + (playerPetData.level + 1) * petData.inc_attack_range).ToString();
            nextAttackSpeed.text = "Attack Speed : " + (petData.attack_speed + (playerPetData.level + 1) * petData.inc_attack_speed).ToString();
            nextMoveSpeed.text = "Move Speed : " + (petData.move_speed + (playerPetData.level + 1) * petData.inc_move_speed).ToString();


        }
        saphireText.text = need_saphire.ToString();


        string[] releaseLevelArray = release_level.Split(':'); 
        List<int> releaseLevelList = new List<int>();
        for(int i = 0; i<releaseLevelArray.Length ;i++)
        {
            releaseLevelList.Add(int.Parse(releaseLevelArray[i])); // int type으로 릴리즈 레벨을 리스트에 담음
        }
        int count = 0;
        for(int i = 0; i<releaseLevelList.Count;i++)
        {
            if (player_level >= releaseLevelList[i])
                count++;
        }

        if (count > playerPetData.level && player_saphire>=need_saphire)
            canUpgrade = true; //upgrade 가능 불린 값
        else
        {
            canUpgrade = false;
        }


        // 선택 , 선택해제 텍스트 설정

        if(playerPetData.use==1) // 지금 이 펫이 선택상태라면
        {
            // 눌렀을시 아래와 같이 변경됨을 보여줘야함
            selectText.text = DataService.Instance.GetText(73);
            selectIconObj.SetActive(false);
            unSelectIconObj.SetActive(true);
            selectTouchBlock.SetActive(false);
        }
        else // 펫이 선택되어있지 않은 상태라면
        {
            // 눌렀을 때 어떻게 될지를 보여야되니 반대로 코드 짜야
            selectText.text = DataService.Instance.GetText(72);
            selectIconObj.SetActive(true);
            unSelectIconObj.SetActive(false);
            SelectTouchBlock();
        }

        CanUpgradeTouchBlock(canUpgrade); // 터치블락 on / off 


    }


    public void SelectTouchBlock()
    {
        // 플레이어 펫을 샀을경우 가능함
        var playerPetData = DataService.Instance.GetData<Table.PlayerPetTable>(petId);

        if (playerPetData.own == 1)
            selectTouchBlock.SetActive(false);
        else
            selectTouchBlock.SetActive(true);

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        var levelData = DataService.Instance.GetData<Table.LevelTable>(saveData.player_level); // leveltable의 id는 level과 동일
        int canUseCount = levelData.can_use_pet_count;
        var selectPetDataList = DataService.Instance.GetDataList<Table.PlayerPetTable>().FindAll(x => x.use == 1);
        if (selectPetDataList != null && selectPetDataList.Count == canUseCount)
        {
            selectTouchBlock.SetActive(true);
        }

    }

    public void CanUpgradeTouchBlock(bool canUpgrade)
    {
        if (canUpgrade == true)
            canUpgradeTouchBlock.SetActive(false);
        else
            canUpgradeTouchBlock.SetActive(true);
    }

    public void OnNeedSaphireButtonClick() //needSaphire 버튼 눌렸을때 동작할 함수
    {
        Debug.Log("btn click");
        if (canUpgrade)
            PetManager.instance.ShowBuyPetSkillConfirmPopup(petId);

    }
    public void OnSelectButtonClick()
    {
        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        var levelData = DataService.Instance.GetData<Table.LevelTable>(saveData.player_level); // leveltable의 id는 level과 동일

        var selectPetDataList = DataService.Instance.GetDataList<Table.PlayerPetTable>().FindAll(x => x.use == 1);

        var playerPetData = DataService.Instance.GetData<Table.PlayerPetTable>(petId);


        if (playerPetData.use == 1) // 이미 선택 되어 있다면 => 해제 
        {

            playerPetData.use = 0;
            DataService.Instance.UpdateData(playerPetData);
            PetManager.instance.RefreshAll();
        }

        else // 선택이 안 되어있는 녀석이었다면 
        {
            if (selectPetDataList == null || selectPetDataList.Count < levelData.can_use_pet_count)
            {

                playerPetData.use = 1;
                DataService.Instance.UpdateData(playerPetData);

                PetManager.instance.RefreshAll();//  manager에서 Refresh()도 호출하기 때문에 굳이 넣을 필요없음

                return; // 함수 종료
            }

        }



    }
    public void Refresh()
    {
        Init(petId);
    }

}
