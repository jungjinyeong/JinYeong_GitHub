using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectPoolContainer : MonoBehaviour
{
    private static ObjectPoolContainer instance;
    public static ObjectPoolContainer Instance
    {
        get
        {
            if (instance == null)
            {
                GameObject objectPoolContainerObj = new GameObject("ObjectPoolContainer");
                // GameObject의 이름을 ObjectPoolContainer라고 짓는다 .
                instance = objectPoolContainerObj.AddComponent<ObjectPoolContainer>();
                // 새로 만든 GameObject에  ObjectPoolContainer 스크립트를 단다 . 
            }
            return instance;
        }

    }

    // 생성할 녀석의 Key(이름으로 설정할것이다 ), 재활용할 녀석을 미리 여러개 만들어 놓은 List
    Dictionary<string, List<GameObject>> objectPoolDic = new Dictionary<string, List<GameObject>>();

    // 오브젝트를 미리 생성하는 함수
    public void CreateObjectPool(string poolingName, GameObject poolingObj, int createCount)
    {
        if (objectPoolDic.ContainsKey(poolingName) == false) // poolingName의 이름으로 key가 생성되어있지않다면
        {
            //List공간을 할당하여 obj들을 미리 만들어서 넣어둔다 .
            List<GameObject> poolingList = new List<GameObject>();
            GameObject obj;

            for (int i = 0; i < createCount; i++)
            {
                obj = Instantiate(poolingObj, this.transform); // 게임오브젝트 ObjectPoolContainer의  자식으로 clone 이 생성된다. ( 화면 지저분 막음)
                obj.name = poolingName;
                poolingList.Add(obj); // 리스트에 담는다 .           
            }

            // 딕셔너리에 담는다 returnObj
            // 딕셔너리에 키가 중복해서 들어갈 수 없다  
            objectPoolDic.Add(poolingName, poolingList);
        }

        else if (objectPoolDic.ContainsKey(poolingName) == true) //이미 poolingName의 이름으로 key가 생성되어있다면
        {
            // 기존의 List에 개수만 추가해준다 
            List<GameObject> poolingList;
            GameObject obj;
            poolingList = objectPoolDic[poolingName]; //이미 존재하는 리스트를 찾아서 레퍼런스만 넘겨준다 

            for (int i = 0; i < createCount; i++)
            {
                obj = Instantiate(poolingObj, this.transform);
                obj.name = poolingName;
                poolingList.Add(obj);
                //reference 넘겨받아서 해당 레퍼런스로 add 된다
            }
            // 딕셔너리에 키가 중복해서 들어갈수없다 . 이미 poolingName의 key 로 된 딕셔너리가 존재하고 그 키의 value값인 리스트에
            // 참조형태로 값을 넣었기때문에 잘 들어가 있을것이다 . 
            // objectPoolDic.Add(poolingName,poolingList); 를 쓰면 안된다 
        }
    }

    public GameObject Pop(string poolingName)
    {
        // 예외처리임
        if (objectPoolDic.ContainsKey(poolingName) == false) // obj 생성이 되지않았다면
        {
            Debug.LogError("Not ready pooling object :" + poolingName);
            return new GameObject(); // 이렇게 된 순간 조짐  
        }
        if (objectPoolDic[poolingName].Count == 1) // 리스트에 남은게 1개이면
        {
            Debug.LogWarning("Make more pooling object" + poolingName);
            GameObject obj = Instantiate(objectPoolDic[poolingName][0], this.transform);
            obj.name = poolingName;
            // instantiate로 object를만들면 유니티에서 기본적으로 이름에 (clone)을 붙여서 생성한다. 그러면 나중에 return을 해서 재활용할때 해당이름을(key값) 
            //찾지 못하므로  다시한번 obj이름을 넣어주는것
            objectPoolDic[poolingName].Add(obj);
        }
        GameObject returnObj = objectPoolDic[poolingName][0];
        objectPoolDic[poolingName].RemoveAt(0); //인덱스 제거시 RemoveAt사용
        return returnObj;

    }
    public void Return(GameObject obj)
    {
        objectPoolDic[obj.name].Add(obj);

    }
    private void OnDestroy()
    {
        instance = null;
    }
}
 



