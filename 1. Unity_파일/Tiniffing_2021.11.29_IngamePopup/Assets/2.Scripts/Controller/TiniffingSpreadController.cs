using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

public class TiniffingSpreadController : MonoBehaviour
{
    [SerializeField]
    private GameObject inGameParentCanvas;

    private Image tiniffingImg;

    private RectTransform tiniffingRectTr;


    // 티니핑을 뿌려줄건데 이름도 바꿀거임!  gameObject.name 이용
    public List<string> SpreadTiniffing(List<int> tin_list, int stage_no) // 랜덤으로 선택당한 티니핑 리소스 이름 리스트 받아오기
    {
       // int map_check = PlayerPrefs.GetInt("map_check_h");
         int map_check = LocalValue.Map_H;

        //int stage_no = PlayerPrefs.GetInt("stage_no");

        Transform inGameCanvasTr = inGameParentCanvas.GetComponent<Transform>();

        if (inGameCanvasTr.childCount !=0)
        { 
            // 0번째 차일드는 GameImage이므로 넘어감 , 1번째는 Danger 백그라운드임
            for(int i= 2; i< inGameCanvasTr.childCount; i++)
            {
                //inGameCanvasTr.GetChild(i).gameObject 는 InGameCanvas 의 자식 접근
                Destroy(inGameCanvasTr.GetChild(i).gameObject);
            }

        }    

        var hideTiniffingSpotTableData = DataService.Instance.GetDataList<Table.TiniffingSpotTable>().Find(x => x.stage_no == stage_no && x.map_check == map_check);


        //캔버스로 부터 RectTransform 받아오는 코드
        tiniffingRectTr = inGameParentCanvas.GetComponent<RectTransform>();


        List<string> selectedTiniffingList = new List<string>();

        //Map에 관련된 스크립트가 먼저 호출되었을것이고 그러면 map_check 정보가 있을것
        for (int i = 0; i < tin_list.Count; i++)
        {

            // 티니핑 프리팹을 복제해줄 거임 , 위치는 Canvas 자식으로 위치 시킴
          //  RectTransform cloneRect = Instantiate(Resources.Load<RectTransform>("Prefabs/Tiniffing/TiniffingPrefab"), tiniffingRectTr);

            GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/Tiniffing/TiniffingPrefab"),tiniffingRectTr);

            RectTransform cloneRect = cloneObj.GetComponent<RectTransform>();

           // transform.GetChild(1).gameObject

            // 복제한 녀석의 Image 를 받아옴
            tiniffingImg = cloneObj.transform.GetChild(0).GetComponent<Image>();


            // tin_list에는 랜덤으로 선택된 티니핑의 스팟 넘버가 저장되어있음 
            // 스위치로 일일이 checking 해서 데이터 넣어주면 됨
            switch (tin_list[i])
            {
                case 1:
                    cloneObj.name = hideTiniffingSpotTableData.spot1_name; // 티니핑 찾았을떄 이름을 넘겨주기위해서 생성시 sprite 이름과 object 이름을 통일시킴
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot1_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot1_x, hideTiniffingSpotTableData.spot1_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot1_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();
                    break;
                case 2:
                    cloneObj.name = hideTiniffingSpotTableData.spot2_name; // 티니핑 찾았을떄 이름을 넘겨주기위해서 생성시 sprite 이름과 object 이름을 통일시킴
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot2_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot2_x, hideTiniffingSpotTableData.spot2_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot2_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 3:
                    cloneObj.name = hideTiniffingSpotTableData.spot3_name; // 티니핑 찾았을떄 이름을 넘겨주기위해서 생성시 sprite 이름과 object 이름을 통일시킴
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot3_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot3_x, hideTiniffingSpotTableData.spot3_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot3_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 4:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot4_x, hideTiniffingSpotTableData.spot4_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot4_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot4_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot4_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 5:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot5_x, hideTiniffingSpotTableData.spot5_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot5_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot5_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot5_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 6:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot6_x, hideTiniffingSpotTableData.spot6_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot6_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot6_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot6_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 7:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot7_x, hideTiniffingSpotTableData.spot7_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot7_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot7_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot7_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 8:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot8_x, hideTiniffingSpotTableData.spot8_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot8_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot8_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot8_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 9:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot9_x, hideTiniffingSpotTableData.spot9_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot9_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot9_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot9_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 10:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot10_x, hideTiniffingSpotTableData.spot10_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot10_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot10_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot10_name); // 티니핑 찾았을때 체킹에 필요한 리스트
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                default:
                    break;
            }

        }
        return selectedTiniffingList; // 선택된 티니핑의 이름을 담은 리스트

    }


}
