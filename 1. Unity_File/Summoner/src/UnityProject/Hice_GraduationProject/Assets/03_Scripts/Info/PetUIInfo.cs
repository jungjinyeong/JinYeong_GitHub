using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PetUIInfo : MonoBehaviour
{

    public Image iconImage;
    public Text levelText; // text 요소가 있는 게임 오브젝트를 넣은 것이므로 타입은 텍스트지만 사용할땐 .text 로 써야함
    public Image backgroundImage;
    public int petId;

    public GameObject grayAlpha;

    public GameObject selectObj;

    public void Init (int petId)
    {
        this.petId = petId;
        var petData = DataService.Instance.GetData<Table.PetTable>(petId); // 펫 데이터들 유아이 정보 뿌려주기위해 받아옴

        switch (petData.grade) //0 , 1, 2 ,3, 4
        {
            case 0:
                backgroundImage.color = new Color32(219, 182, 132, 255);
                break;
            case 1:
                backgroundImage.color = new Color32(0, 255, 114, 255); // 에메랄드로
                break;
            case 2:
                backgroundImage.color = new Color32(69, 125, 255, 255); //하늘색
                break;
            case 3:
                backgroundImage.color = new Color32(218, 59, 255, 255); // 이거말고 다른클래스 써서 퍼플로 바꿔
                break;
            case 4:
                backgroundImage.color = new Color32(255, 45, 0, 255); // 색깔보고 조정
                break;

            default:
                break;
        }

        Refresh();
    }

    public void Refresh() // 갱신용 + 초기화용
    {
        var petData = DataService.Instance.GetData<Table.PetTable>(petId); // 펫 데이터들 유아이 정보 뿌려주기위해 받아옴
        var playerPetData = DataService.Instance.GetData<Table.PlayerPetTable>(petId); //own 아니면 흑백 처리하기 위해 가져옴

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);




        if (playerPetData.level == 5)
            levelText.text = "Lv.Max";
        else
            levelText.text = "Lv." + playerPetData.level.ToString();

        iconImage.sprite = Resources.Load<Sprite>("Images/Pet/" + petData.pet_name);

        string release_level = petData.release_level;

        /*
        string[] releaseLevelArray = release_level.Split(':');
        List<int> releaseLevelList = new List<int>();
        for (int i = 0; i < releaseLevelArray.Length; i++)
        {
            releaseLevelList.Add(int.Parse(releaseLevelArray[i])); // int type으로 릴리즈 레벨을 리스트에 담음
        }

        if (releaseLevelList[0] > saveData.player_level) // 흑백처리
            grayAlpha.SetActive(true);
        else
            grayAlpha.SetActive(false);
        */

        if (playerPetData.own == 1)
        {
            grayAlpha.SetActive(false);
        }
        else
        {
            grayAlpha.SetActive(true);
        }


        var selectPetDataList = DataService.Instance.GetDataList<Table.PlayerPetTable>().FindAll(x => x.use == 1); //사용중인 애들 받아옴

        if (selectPetDataList == null)
            selectObj.SetActive(false);
        else
        {
            for (int i = 0; i < selectPetDataList.Count; i++)
            {
                if (selectPetDataList[i].id == petId)
                {
                    selectObj.SetActive(true);
                    return;
                }
            }
            selectObj.SetActive(false);
        }
    }
    public void OnPetUIButtonClick()
    {
        PetManager.instance.ShowPetDescriptionInfo(petId);
    }

 
}
