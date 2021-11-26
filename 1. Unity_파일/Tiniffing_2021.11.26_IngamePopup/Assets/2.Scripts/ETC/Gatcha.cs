using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
public class Gatcha
{
 
    private static Gatcha instance;

    public static Gatcha Instance
    {
        get
        {
            if (instance == null)
                instance = new Gatcha(); // 모노상속 안받고 이 스크립트는 오브젝트의 컴포넌트로 들어가는것이 아니기에 new

            return instance;
        }
    }
    //List로 해보기, !!! map_id 저거 바꿔야댐!!!
    public List<int> ChooseTinGatcha(Table.TiniffingSpotTable tiniffingSpotTableData) // 맵과 스테이지가 몇인지 알아야 해당 티니핑스팟테이블 정보를 받아옴
    {
        
        List<int> tinGatchaList = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }; // 일단 가능한 모든 스팟 번호의 리스트

        int rnd = UnityEngine.Random.Range(tiniffingSpotTableData.min_answer, (tiniffingSpotTableData.max_answer+1)); // 그림에 몇개나올지 선택할 개수
                                                                                                                      //  using 으로  system  과 UnityEngine 을 같이 사용시 Random을 그냥 못씀!!  Random 앞에 UnityEngine 붙여줘야함

        Debug.Log("rnd  : " + rnd.ToString());
        
        int remove_no; // 제거할 번호

       
        for (int i = 0; i < 10 - rnd; i++) // list 는 인덱스 0부터 시작임
        {
            // remove_no 는 배열의 인덱스 
            remove_no = UnityEngine.Random.Range(0, tinGatchaList.Count);
            // range 의 마지막을 list 의 카운트로 잡아야함. 안그러면 매번 리무브시 인덱스수가 바뀐것을 처리못함
       
            tinGatchaList.RemoveAt(remove_no); // 배열의 index를 지우는거임 
        }



        return tinGatchaList; // 랜덤으로 뽑힐 티니핑의 번호가 담긴 리스트 
    }

    


    /*
     어짜피 티니핑 정보 한 줄 불러 들어서 spot1부터 차례로 넣을거니깐
     딕셔너리 int 에 값넣을때 i+1  로 넣기!! (for문의 i가 0부터 시작한다고 가정할때)
    
      아래는 딕셔너리로 랜덤 티니핑을 선택해서 넘겨주는 함수
    /*
    public Dictionary<int,string> ChooseTinGatcha(int map_id, int stage_group) // 맵과 스테이지가 몇인지 알아야 해당 티니핑스팟테이블 정보를 받아옴
    {
        var data = DataService.Instance.GetData<Table.TiniffingSpotTable>(map_id);
        Dictionary<int, string> tinGatchaList = new Dictionary<int,string>() ; // 일단 가능한 모든 번호의 리스트

        int rnd = UnityEngine.Random.Range(2, 4); // 그림에 몇개나올지 선택할 개수
        //  using 으로  system  과 UnityEngine 을 같이 사용시 Random을 그냥 못씀!!  Random 앞에 UnityEngine 붙여줘야함
        int remove_no; // 제거할 번호
        for (int i = 0; i < 6 - rnd; i++)
        {
            remove_no = UnityEngine.Random.Range(0, tinGatchaList.Count);
            // range 의 마지막을 list 의 카운트로 잡아야함. 안그러면 매번 리무브시 인덱스수가 바뀐것을 처리못함
      //      tinGatchaList.RemoveAt(remove_no);
        }

        return tinGatchaList; // 랜덤으로 뽑힐 티니핑의 번호가 담긴 리스트 
    }
    */

    // 아래는 맵 랜덤선택 가차인데 필요없음
    /*
     public List<int> ChooseMapGatcha() // 중복방지를 위해서 한번에 뽑을거 다 뽑음
      {
          var mapDataList = DataService.Instance.GetDataList<Table.MapTable>();

          int mapCount = mapDataList.Count;

          int remove_no;

          List<int> mapGatchaList = new List<int>();

          for (int i = 0; i < mapCount; i++)
          {
              mapGatchaList.Add(i);
          }
          for (int i = mapDataList.Count-1; i > 1; i--) // 인덱스가 0부터임을 고려했을때
              // 카운트가 7개면 실제로  id는 0 부터 6까지일것이고 그중 선택을 2개한다하면  i가 1 위까지 선택해서 제거하는게 맞음
          {
              remove_no = UnityEngine.Random.Range(0, mapCount);
              mapGatchaList.RemoveAt(remove_no);//랜덤으로 나온 인덱스 제거
          }

          // 리스트에 담기는것은 맵의 아이디이자 번호임 => 이것으로 티니핑 id 찾아가면 됨

          return mapGatchaList;
      }*/
}


