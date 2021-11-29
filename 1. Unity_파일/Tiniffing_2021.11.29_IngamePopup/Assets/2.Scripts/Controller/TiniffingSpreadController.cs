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


    // Ƽ������ �ѷ��ٰǵ� �̸��� �ٲܰ���!  gameObject.name �̿�
    public List<string> SpreadTiniffing(List<int> tin_list, int stage_no) // �������� ���ô��� Ƽ���� ���ҽ� �̸� ����Ʈ �޾ƿ���
    {
       // int map_check = PlayerPrefs.GetInt("map_check_h");
         int map_check = LocalValue.Map_H;

        //int stage_no = PlayerPrefs.GetInt("stage_no");

        Transform inGameCanvasTr = inGameParentCanvas.GetComponent<Transform>();

        if (inGameCanvasTr.childCount !=0)
        { 
            // 0��° ���ϵ�� GameImage�̹Ƿ� �Ѿ , 1��°�� Danger ��׶�����
            for(int i= 2; i< inGameCanvasTr.childCount; i++)
            {
                //inGameCanvasTr.GetChild(i).gameObject �� InGameCanvas �� �ڽ� ����
                Destroy(inGameCanvasTr.GetChild(i).gameObject);
            }

        }    

        var hideTiniffingSpotTableData = DataService.Instance.GetDataList<Table.TiniffingSpotTable>().Find(x => x.stage_no == stage_no && x.map_check == map_check);


        //ĵ������ ���� RectTransform �޾ƿ��� �ڵ�
        tiniffingRectTr = inGameParentCanvas.GetComponent<RectTransform>();


        List<string> selectedTiniffingList = new List<string>();

        //Map�� ���õ� ��ũ��Ʈ�� ���� ȣ��Ǿ������̰� �׷��� map_check ������ ������
        for (int i = 0; i < tin_list.Count; i++)
        {

            // Ƽ���� �������� �������� ���� , ��ġ�� Canvas �ڽ����� ��ġ ��Ŵ
          //  RectTransform cloneRect = Instantiate(Resources.Load<RectTransform>("Prefabs/Tiniffing/TiniffingPrefab"), tiniffingRectTr);

            GameObject cloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/Tiniffing/TiniffingPrefab"),tiniffingRectTr);

            RectTransform cloneRect = cloneObj.GetComponent<RectTransform>();

           // transform.GetChild(1).gameObject

            // ������ �༮�� Image �� �޾ƿ�
            tiniffingImg = cloneObj.transform.GetChild(0).GetComponent<Image>();


            // tin_list���� �������� ���õ� Ƽ������ ���� �ѹ��� ����Ǿ����� 
            // ����ġ�� ������ checking �ؼ� ������ �־��ָ� ��
            switch (tin_list[i])
            {
                case 1:
                    cloneObj.name = hideTiniffingSpotTableData.spot1_name; // Ƽ���� ã������ �̸��� �Ѱ��ֱ����ؼ� ������ sprite �̸��� object �̸��� ���Ͻ�Ŵ
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot1_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot1_x, hideTiniffingSpotTableData.spot1_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot1_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();
                    break;
                case 2:
                    cloneObj.name = hideTiniffingSpotTableData.spot2_name; // Ƽ���� ã������ �̸��� �Ѱ��ֱ����ؼ� ������ sprite �̸��� object �̸��� ���Ͻ�Ŵ
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot2_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot2_x, hideTiniffingSpotTableData.spot2_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot2_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 3:
                    cloneObj.name = hideTiniffingSpotTableData.spot3_name; // Ƽ���� ã������ �̸��� �Ѱ��ֱ����ؼ� ������ sprite �̸��� object �̸��� ���Ͻ�Ŵ
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot3_name);
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot3_x, hideTiniffingSpotTableData.spot3_y);
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot3_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 4:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot4_x, hideTiniffingSpotTableData.spot4_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot4_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot4_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot4_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 5:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot5_x, hideTiniffingSpotTableData.spot5_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot5_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot5_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot5_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 6:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot6_x, hideTiniffingSpotTableData.spot6_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot6_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot6_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot6_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 7:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot7_x, hideTiniffingSpotTableData.spot7_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot7_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot7_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot7_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 8:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot8_x, hideTiniffingSpotTableData.spot8_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot8_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot8_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot8_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 9:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot9_x, hideTiniffingSpotTableData.spot9_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot9_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot9_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot9_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                case 10:
                    cloneRect.anchoredPosition = new Vector2(hideTiniffingSpotTableData.spot10_x, hideTiniffingSpotTableData.spot10_y);
                    tiniffingImg.sprite = Resources.Load<Sprite>("Images/Tiniffing/Hidden/" + hideTiniffingSpotTableData.spot10_name);
                    cloneObj.name = hideTiniffingSpotTableData.spot10_name;
                    selectedTiniffingList.Add(hideTiniffingSpotTableData.spot10_name); // Ƽ���� ã������ üŷ�� �ʿ��� ����Ʈ
                    cloneObj.GetComponent<FindTiniffingController>().MovementRandomPick();

                    break;
                default:
                    break;
            }

        }
        return selectedTiniffingList; // ���õ� Ƽ������ �̸��� ���� ����Ʈ

    }


}
