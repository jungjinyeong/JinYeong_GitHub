using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO; //file �����
using System; // Type

using SqlCipher4Unity3D; // SQLiteConnection�� ��������
using System.Linq; // ToList���
using System.Reflection;// MethodInfo

public class DataService
{

    private static DataService instance;
    public static DataService Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new DataService();
            }
            return instance;

        }
    }
    private SQLiteConnection connection;
    public string databaseName = "TiniffingDB.db";//�ι�������  ��� ���� �۾� + �� �̸����� ��Ʈ���ֿ��¿��� ã��(�ؿ��� ����)
    public string pureDatabaseName = "PureTiniffingDB.db";//ù��° ���� ��Ʈ���ֿ��� ����

    private Dictionary<Type, Dictionary<int, IKeyTableData>> tableDic;
    // Type�� tabletype  �ڿ� dic�� �����͸� ã�ư� 
    // ��� ���̺��� ���������� ��ӹް� �ִ� �������̽��� IKeyTableData�̱� ������  value�� �ְ�  key �� int�ΰ���  ��ó�� ������ ���̺� ���鋚 id�÷��� int�ε� primarykey�̱⶧���̴�.

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)] // ������ ���۵ɋ� Awake���� ������ �� �ѹ��� �Ҹ��� �༮
    //AfterSceneLoad��Awake���ٴ� ������ Start���ٴ� ������ �ѹ� �θ����� ��
    static void InitDataService()
    {
        DataService.Instance.InitDB(); //�빮�� Instance �ؾ� instance�� ����ϱ� �빮�ڷ� ����.
        //static�Լ��� static�� �༮�� �θ����ִ� �׷��� ���Ͱ��� Instance�� �����ϴ°��̴�.
        DataService.Instance.InitDataForPlay();
    }
    public void InitDataForPlay()
    {
        if (connection == null) // �ϴ� ���ġ�� ��
        {
            connection = new SQLiteConnection(databaseName, "", true); // connection�� �ȵǾ�������  ������ִµ�  ��ο� ��й�ȣ(��Ʈ������) �ʿ�
            // �������� Tick���� �Ұ�������
        }

        //DataService.Instance.InitData();

        tableDic = new Dictionary<Type, Dictionary<int, IKeyTableData>>();

        for (int i = 0; i < Table.readOnlyTableTypeArray.Length; i++)
        {
            tableDic.Add(Table.readOnlyTableTypeArray[i], new Dictionary<int, IKeyTableData>()); //ù��° Dictionary�� Type�ְ� �Ʒ� LoadData�κп��� ���� Dicó��
        }

        for (int i = 0; i < Table.writableTableTypeArray.Length; i++)
        {
            tableDic.Add(Table.writableTableTypeArray[i], new Dictionary<int, IKeyTableData>());
        }
        MethodInfo loadDataMethod = this.GetType().GetMethod("LoadData", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
        // GetMethod��� �Լ��� ������ Ÿ������ �޾ƿ;ߵǼ� Ÿ������ �����Ѵ�.
        // �� ��ũ��Ʈ���� gettype���� type �޾ƿ´��� getmethod ���
        //MethodInfo�� string���� �޾ƿ� "LoadData" ��� �Լ��� �����´�.
        // BindingFlags �� �޾ƿ� �Լ���  instance�� public nonpublic ����� ������ �޾ƿ��ڴ�.
        // LoadData�� ���ʸ� �Լ��� type���� �����ؾߵǼ� ������ ���� ���ϴϱ� LoadData<T>() �̵������� ���� ���ϴϱ� 
        // LoadData<Table.writableTableTypeArray[0]>(); �̷������� ������ �ȵȴ�.  Table.writableTableTypeArray[0] �갡 �������̶� Type���������� Type(�ڷ���)�� �ƴ϶�
        // �׷��� �̷��� ���ŷӴ�.

        foreach (var type in tableDic.Keys) // in �ڿ��� ����  tableDic.Keys ��ŭ �����ڴ�.
        {
            MethodInfo loadDataGenericMethod = loadDataMethod.MakeGenericMethod(type);
            loadDataGenericMethod.Invoke(this, new object[] { }); // Invoke �� ���� �Լ��� �����Ű�� �Լ��̴�. 
            //this �� �� ��ũ��Ʈ���� �����Ű�ڴٴ� ���̰� �ڿ���  new object[]{} �� LoadData<T>()������ �޴� ������ ��� �ʿ���⶧���� ���� �������̴�.
            // null�� �־ �� , ���� �Ѹ���


        }
        // var�� type ��  tableDic.Keys[i]�̴�.
    }

    // LoadData
    public void LoadData<T>() where T : IKeyTableData, new() //where  ���ʸ��� ���Ǵٴ°���  ���⼭�� IKeyTableData�� ��ӹް��־���ϴ°��� ������
    { // �����ÿ� new() ���·� ������ �� �ִ� �ֵ鸸  T�� Ÿ������ �� �� �ִ� 
        var tableData = connection.Table<T>().ToList();// connection.Table<T>().ToList() ���� �޾ƿ� �ڷ������� var�� �νĵȴ�.
        // ���κ��� �޾ƿ� ��� ���̺��� ����Ʈȭ�ؼ� tableData�� �ִ´�, ���⼭ Table ���ʸ��Լ��� sqlite���� ������ �Լ�

        for (int i = 0; i < tableData.Count; i++) //tableData�� list list�� �氳�� list�̸�.count
        {
            tableDic[typeof(T)].Add(tableData[i].GetTableId(), tableData[i]);  //typeof()�� ������ ������ִ� ������ �ϱ⿡ T�� Ÿ���̶� �̷��� ����ȭ�Ѵ�.
            // �����͸� �־��ִ� �ڵ�
        }

        T table = new T();
        IInsertableTableData insertable = table as IInsertableTableData; //�����͸� �߰��� �� �ִ� ���̺�
        if (insertable != null)
        {
            if (tableDic[typeof(T)].Count > 0) //Max+1 �� ���̺��� ����� ������  MAx�� ���ϱ�
            {
                insertable.Max = tableDic[typeof(T)].Keys.Max();
            }
            else
            {
                insertable.Max = -1; // �����Ͱ� ����aa
            }
        }
    }


    //�ش� ���̺��� id ��° ���� �����͸� ����
    public T GetData<T>(int id) where T : IKeyTableData // return ���� T   GetData�� ���ʸ� �Լ��̱⿡ <T> ���̰�  where T: IKeyTableData    �� T �� Ÿ���ε� IKeyTableData�� ��ӹ��� �༮�� �� �ϳ��̴�. 
    {
        Type type = typeof(T); // T�� Ÿ���̶� T�� �������·� ����� �� �ֵ��� ����ȭ �ϴ°���

        Dictionary<int, IKeyTableData> dataDic = tableDic[type];
        // tableDic[type]�� ������ table[key] �� �־ ���� Dictionary<int,IKeyTableData>�� ���̹Ƿ� 
        // Ÿ���� ���� �����ش�. �̰�����  type������ �����͸� ���̺�κ��� �� �޾ƿ´�.
        // ���⼭�� type�� ���̺� Ŭ���� �̹Ƿ� �ᱹ ���� �ڵ�� �츮�� ���ϴ� ���̺��� ������ ��ųʸ� ���·� �����ϴ°��� �ǹ� 
        if (dataDic.ContainsKey(id))  // ���̺�κ��� id�� ������
        {
            return (T)dataDic[id];  // �̳༮�� �����ϴµ�  IKeyTableData �̰���   ���ϰ� ���߷��� (T)�� �ٿ� ĳ�������ش�. , ���̺� Ŭ������ ����
        }
        Debug.Log("Error : No data " + type.ToString() + id);
        return default(T);  // ������ ���������ʰ� �� ���̺� ���� , 
    }


    // �ش� ���̺��� ��� �����͸� ����Ʈ�� ����
    public List<T> GetDataList<T>() where T : IKeyTableData
    {
        Type type = typeof(T);

        /*�Ʒ� ����
        ��ųʸ��� key, value �� �Ǿ��ִ� . tableDic�� ������ <key, <key,value>> �����̴� , tableDic.ContainsKey(type) �� �ϸ�
         <type, <key,value>> ���°� �ǰ� type �� Ű�� ������ �ִ� �༮�� tableDic �� �ִ°��� �����  bool �� �������ش�
        */
        if (tableDic.ContainsKey(type))
        {
            return tableDic[type].Values.Cast<T>().ToList();
        }
        /* ���� return �ڵ� .  tableDic[type].Values �����ϸ�  �츮�� ���ϴ� ���̺� ���� <int , IKeyTableData> �� �ǹ��ϴµ� �� �༮�� ��� Ÿ���� T��
        ġȯ�ؼ� ����Ʈ�� �ھƹ����� �Ŵϱ�  �Ƹ�  List�� [i] �� �Ӽ��� ���°� <int, IKeyTableData> ���·� 0���� ~ �� ���� ������
        */
        Debug.Log("GetDataList Error : No table " + type.ToString());
        return default(List<T>);  //���ϴ� ���̺������� DB�� ������ �� ����Ʈ ����
    }

    //�ش� Table ������Ʈ(����)
    public int UpdateData<T>(T table) where T : IKeyTableData
    {
        Type type = typeof(T);
        tableDic[type][table.GetTableId()] = table; // �ܺο��� update �� table �����͸� Dictionary�� ����ȭ 
        // ��������� IKeyTableData�� �ٲ��ش�.
        // �Ѱܹ��� table Ʃ���� id�� ������ ���� �츮�� ��� ������ ���� ���� tableDic�� [table��][id��] = table(Ʃ��) �� �ִ´�
        // ������ ? => tableDic ��ųʸ��� �츮�� ��� ������ ������ �ٸ� ��ũ��Ʈ���� �ս��� ����ϱ� ���� ���� ��ųʸ���, �׸��� �����ε� ��� ���Ŵϱ� �ֽ����� �ݿ�

        // �Ʒ� �ڵ带 ���� db���� �������� �����Ų�� , ���� tableDic�� �Ἥ ���� �ʿ���� . �Ѱܹ��� table ���� �״�� Update�Լ��� ������ �ȴ�
        return connection.Update(table); // connection�� SqlLite Ŭ���� ��ü��  table �������� Update �ϵ��� �ϴ� �ڵ� 
    }

    public int InsertData<T>(T table) where T : IKeyTableData, IInsertableTableData
    {
        table.Max++;
        int nextId = table.Max;
        table.SetTableId(nextId);
        connection.Insert(table);
        Type type = typeof(T);
        tableDic[type].Add(nextId, table);
        return nextId;
    }
    public void DeleteData<T>(int id) where T : IKeyTableData
    {
        Type type = typeof(T);
        tableDic[type].Remove(id);
        connection.Delete<T>(id);
    }

    public void UpdateDataAll<T>(List<T> tableList) where T : IKeyTableData
    {
        Type type = typeof(T);
        for (int i = 0; i < tableList.Count; i++)
        {
            tableDic[type][tableList[i].GetTableId()] = tableList[i];
        }
        connection.UpdateAll(tableList);
    }
    public void DeleteDataAll<T>(List<T> tableList) where T : IKeyTableData
    {
        Type type = typeof(T);
        for (int i = 0; i < tableList.Count; i++)
        {
            tableDic[type].Remove(tableList[i].GetTableId());
        }
        connection.DeleteAll(tableList);
    }

    public string GetText(int textId)
    {
        switch (Application.systemLanguage)
        {
            case SystemLanguage.Korean:
                return GetData<Table.TextTable>(textId).kor;

            default: //����
                return GetData<Table.TextTable>(textId).eng;

        }
    }


    public void InitDB()
    {
        string streamingAssetsPath = string.Empty; // string.Empty == "" �� ����.

        // �÷������� �����ΰ� �ٸ���. 
#if UNITY_EDITOR 
        //string.Format��  "" + ""   �� string�� �̾���϶� �������� ����Ƿ�  �������� ������ �ʵ��� ���ڿ��� �������ִ� �������ϴ� �༮�̴�.

        streamingAssetsPath = string.Format("Assets/StreamingAssets/{0}", databaseName); // + �������ϴ°� ����.
        // databaseName�� �̸������� ���� ���� �۾��Ҷ��� �ʿ��ؼ� �� ���ĺ��ʹ� databaseName�� ��η� �������ؼ�  �Ʒ��Ͱ��� ���� �ٲ۴�.
        //streamingAsset �� �б�ۿ� �������ϱ⶧���� �̰��� �����ؼ� �����ִ� ��ο� �д� .
        databaseName = string.Format("Assets/{0}", databaseName); // ������ ����� �����  ��θ� ������۾�
        pureDatabaseName = string.Format("Assets/{0}", pureDatabaseName);



#elif UNITY_ANDROID
        streamingAssetsPath = string.Format("jar:file://{0}!/assets/{1}", Application.dataPath, databaseName);//Application.dataPath �ȵ���̵忡�� StreamingAsset�ؿ� �ִ� ������ ���
       
        databaseName = string.Format("{0}/{1}", Application.persistentDataPath, databaseName);

        pureDatabaseName = string.Format("{0}/{1}", Application.persistentDataPath, pureDatabaseName);
#elif UNITY_IOS
          streamingAssetsPath = string.Format("{0}/Raw/{1}", Application.dataPath, databaseName);
        
        databaseName = string.Format("{0}/{1}", Application.persistentDataPath, databaseName);

        pureDatabaseName = string.Format("{0}/{1}", Application.persistentDataPath, pureDatabaseName);
#endif
        if (File.Exists(databaseName) == false) // ������ �������� �ʴ´ٸ� -> ���ʽ���
        {
#if UNITY_EDITOR || UNITY_IOS
            File.Copy(streamingAssetsPath, databaseName);
            File.Copy(streamingAssetsPath, pureDatabaseName);


#elif UNITY_ANDROID
            WWW loadDB = new WWW(streamingAssetsPath);
            while (loadDB.isDone == false) // loadDB�� ������ ���� ������.
            {  } // load�� ���������� ��ٸ��� ���̶� �ȿ� ���� ���� �ʿ䰡 ����.
            File.WriteAllBytes(databaseName, loadDB.bytes);
            File.WriteAllBytes(pureDatabaseName, loadDB.bytes);
            loadDB.Dispose();
            loadDB = null;

#endif
        }
    }
}

