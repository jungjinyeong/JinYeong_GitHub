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
                // GameObject�� �̸��� ObjectPoolContainer��� ���´� .
                instance = objectPoolContainerObj.AddComponent<ObjectPoolContainer>();
                // ���� ���� GameObject��  ObjectPoolContainer ��ũ��Ʈ�� �ܴ� . 
            }
            return instance;
        }

    }

    // ������ �༮�� Key(�̸����� �����Ұ��̴� ), ��Ȱ���� �༮�� �̸� ������ ����� ���� List
    Dictionary<string, List<GameObject>> objectPoolDic = new Dictionary<string, List<GameObject>>();

    // ������Ʈ�� �̸� �����ϴ� �Լ�
    public void CreateObjectPool(string poolingName, GameObject poolingObj, int createCount)
    {
        if (objectPoolDic.ContainsKey(poolingName) == false) // poolingName�� �̸����� key�� �����Ǿ������ʴٸ�
        {
            //List������ �Ҵ��Ͽ� obj���� �̸� ���� �־�д� .
            List<GameObject> poolingList = new List<GameObject>();
            GameObject obj;

            for (int i = 0; i < createCount; i++)
            {
                obj = Instantiate(poolingObj, this.transform); // ���ӿ�����Ʈ ObjectPoolContainer��  �ڽ����� clone �� �����ȴ�. ( ȭ�� ������ ����)
                obj.name = poolingName;
                poolingList.Add(obj); // ����Ʈ�� ��´� .           
            }

            // ��ųʸ��� ��´� returnObj
            // ��ųʸ��� Ű�� �ߺ��ؼ� �� �� ����  
            objectPoolDic.Add(poolingName, poolingList);
        }

        else if (objectPoolDic.ContainsKey(poolingName) == true) //�̹� poolingName�� �̸����� key�� �����Ǿ��ִٸ�
        {
            // ������ List�� ������ �߰����ش� 
            List<GameObject> poolingList;
            GameObject obj;
            poolingList = objectPoolDic[poolingName]; //�̹� �����ϴ� ����Ʈ�� ã�Ƽ� ���۷����� �Ѱ��ش� 

            for (int i = 0; i < createCount; i++)
            {
                obj = Instantiate(poolingObj, this.transform);
                obj.name = poolingName;
                poolingList.Add(obj);
                //reference �Ѱܹ޾Ƽ� �ش� ���۷����� add �ȴ�
            }
            // ��ųʸ��� Ű�� �ߺ��ؼ� �������� . �̹� poolingName�� key �� �� ��ųʸ��� �����ϰ� �� Ű�� value���� ����Ʈ��
            // �������·� ���� �־��⶧���� �� �� �������̴� . 
            // objectPoolDic.Add(poolingName,poolingList); �� ���� �ȵȴ� 
        }
    }

    public GameObject Pop(string poolingName)
    {
        // ����ó����
        if (objectPoolDic.ContainsKey(poolingName) == false) // obj ������ �����ʾҴٸ�
        {
            Debug.LogError("Not ready pooling object :" + poolingName);
            return new GameObject(); // �̷��� �� ���� ����  
        }
        if (objectPoolDic[poolingName].Count == 1) // ����Ʈ�� ������ 1���̸�
        {
            Debug.LogWarning("Make more pooling object" + poolingName);
            GameObject obj = Instantiate(objectPoolDic[poolingName][0], this.transform);
            obj.name = poolingName;
            // instantiate�� object������� ����Ƽ���� �⺻������ �̸��� (clone)�� �ٿ��� �����Ѵ�. �׷��� ���߿� return�� �ؼ� ��Ȱ���Ҷ� �ش��̸���(key��) 
            //ã�� ���ϹǷ�  �ٽ��ѹ� obj�̸��� �־��ִ°�
            objectPoolDic[poolingName].Add(obj);
        }
        GameObject returnObj = objectPoolDic[poolingName][0];
        objectPoolDic[poolingName].RemoveAt(0); //�ε��� ���Ž� RemoveAt���
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
 



