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
                instance = new Gatcha(); // ����� �ȹް� �� ��ũ��Ʈ�� ������Ʈ�� ������Ʈ�� ���°��� �ƴϱ⿡ new

            return instance;
        }
    }
    //List�� �غ���, !!! map_id ���� �ٲ�ߴ�!!!
    public List<int> ChooseTinGatcha(Table.TiniffingSpotTable tiniffingSpotTableData) // �ʰ� ���������� ������ �˾ƾ� �ش� Ƽ���ν������̺� ������ �޾ƿ�
    {
        
        List<int> tinGatchaList = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }; // �ϴ� ������ ��� ���� ��ȣ�� ����Ʈ

        int rnd = UnityEngine.Random.Range(tiniffingSpotTableData.min_answer, (tiniffingSpotTableData.max_answer+1)); // �׸��� ������� ������ ����
                                                                                                                      //  using ����  system  �� UnityEngine �� ���� ���� Random�� �׳� ����!!  Random �տ� UnityEngine �ٿ������

        Debug.Log("rnd  : " + rnd.ToString());
        
        int remove_no; // ������ ��ȣ

       
        for (int i = 0; i < 10 - rnd; i++) // list �� �ε��� 0���� ������
        {
            // remove_no �� �迭�� �ε��� 
            remove_no = UnityEngine.Random.Range(0, tinGatchaList.Count);
            // range �� �������� list �� ī��Ʈ�� ��ƾ���. �ȱ׷��� �Ź� ������� �ε������� �ٲ���� ó������
       
            tinGatchaList.RemoveAt(remove_no); // �迭�� index�� ����°��� 
        }



        return tinGatchaList; // �������� ���� Ƽ������ ��ȣ�� ��� ����Ʈ 
    }

    


    /*
     ��¥�� Ƽ���� ���� �� �� �ҷ� �� spot1���� ���ʷ� �����Ŵϱ�
     ��ųʸ� int �� �������� i+1  �� �ֱ�!! (for���� i�� 0���� �����Ѵٰ� �����Ҷ�)
    
      �Ʒ��� ��ųʸ��� ���� Ƽ������ �����ؼ� �Ѱ��ִ� �Լ�
    /*
    public Dictionary<int,string> ChooseTinGatcha(int map_id, int stage_group) // �ʰ� ���������� ������ �˾ƾ� �ش� Ƽ���ν������̺� ������ �޾ƿ�
    {
        var data = DataService.Instance.GetData<Table.TiniffingSpotTable>(map_id);
        Dictionary<int, string> tinGatchaList = new Dictionary<int,string>() ; // �ϴ� ������ ��� ��ȣ�� ����Ʈ

        int rnd = UnityEngine.Random.Range(2, 4); // �׸��� ������� ������ ����
        //  using ����  system  �� UnityEngine �� ���� ���� Random�� �׳� ����!!  Random �տ� UnityEngine �ٿ������
        int remove_no; // ������ ��ȣ
        for (int i = 0; i < 6 - rnd; i++)
        {
            remove_no = UnityEngine.Random.Range(0, tinGatchaList.Count);
            // range �� �������� list �� ī��Ʈ�� ��ƾ���. �ȱ׷��� �Ź� ������� �ε������� �ٲ���� ó������
      //      tinGatchaList.RemoveAt(remove_no);
        }

        return tinGatchaList; // �������� ���� Ƽ������ ��ȣ�� ��� ����Ʈ 
    }
    */

    // �Ʒ��� �� �������� �����ε� �ʿ����
    /*
     public List<int> ChooseMapGatcha() // �ߺ������� ���ؼ� �ѹ��� ������ �� ����
      {
          var mapDataList = DataService.Instance.GetDataList<Table.MapTable>();

          int mapCount = mapDataList.Count;

          int remove_no;

          List<int> mapGatchaList = new List<int>();

          for (int i = 0; i < mapCount; i++)
          {
              mapGatchaList.Add(i);
          }
          for (int i = mapDataList.Count-1; i > 1; i--) // �ε����� 0�������� ���������
              // ī��Ʈ�� 7���� ������  id�� 0 ���� 6�����ϰ��̰� ���� ������ 2���Ѵ��ϸ�  i�� 1 ������ �����ؼ� �����ϴ°� ����
          {
              remove_no = UnityEngine.Random.Range(0, mapCount);
              mapGatchaList.RemoveAt(remove_no);//�������� ���� �ε��� ����
          }

          // ����Ʈ�� ���°��� ���� ���̵����� ��ȣ�� => �̰����� Ƽ���� id ã�ư��� ��

          return mapGatchaList;
      }*/
}


