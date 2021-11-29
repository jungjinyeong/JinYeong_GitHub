using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;

public class InGameMapInfo : MonoBehaviour
{
    [SerializeField] private Image inGameMapImg;
    private int map_check_h;
    public void MapChange(int stage_no) // spottable 아이디 넘겨받음
    {   
        map_check_h = LocalValue.Map_H;
        Debug.Log(" in InGameMapInfo's map_check _h :" + map_check_h);
        Debug.Log(" stagno :" + stage_no);
        var hideTiniffingSpotTableData = DataService.Instance.GetDataList<Table.TiniffingSpotTable>().Find(x => x.stage_no == stage_no && x.map_check == map_check_h);
        Debug.Log("Image name : " + hideTiniffingSpotTableData.map_name.ToString());
        inGameMapImg.sprite = Resources.Load<Sprite>("Images/Map/Hidden/" + hideTiniffingSpotTableData.map_name);
    }
    public void OnBackgroundClick()
    {       
        InGameManager.instance.OnMissTouch();
        Debug.Log("Miss Touch !! ");
    }
}
