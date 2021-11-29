using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO; //file 입출력
using System; // Type

using SqlCipher4Unity3D; // SQLiteConnection을 쓰기위함
using System.Linq; // ToList사용
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
    public string databaseName = "TiniffingDB.db";//두번쨰복사  얘로 실제 작업 + 얘 이름으로 스트리밍에셋에서 찾음(밑에서 구현)
    public string pureDatabaseName = "PureTiniffingDB.db";//첫번째 복사 스트리밍에셋 복사

    private Dictionary<Type, Dictionary<int, IKeyTableData>> tableDic;
    // Type은 tabletype  뒤에 dic은 데이터를 찾아감 
    // 모든 테이블이 공통적으로 상속받고 있는 인터페이스가 IKeyTableData이기 때문에  value로 넣고  key 가 int인것은  맨처음 데이터 테이블 만들떄 id컬럼이 int로된 primarykey이기때문이다.

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)] // 게임이 시작될떄 Awake보다 빠르게 단 한번만 불리는 녀석
    //AfterSceneLoad는Awake보다는 느리고 Start보다는 빠르게 한번 부르도록 함
    static void InitDataService()
    {
        DataService.Instance.InitDB(); //대문자 Instance 해야 instance가 생기니깐 대문자로 쓴다.
        //static함수는 static인 녀석만 부를수있다 그래서 위와같이 Instance로 접근하는것이다.
        DataService.Instance.InitDataForPlay();
    }
    public void InitDataForPlay()
    {
        if (connection == null) // 일단 비번치고 들어감
        {
            connection = new SQLiteConnection(databaseName, "", true); // connection이 안되어있으면  만들어주는데  경로와 비밀번호(스트링으로) 필요
            // 마지막은 Tick으로 할건지유무
        }

        //DataService.Instance.InitData();

        tableDic = new Dictionary<Type, Dictionary<int, IKeyTableData>>();

        for (int i = 0; i < Table.readOnlyTableTypeArray.Length; i++)
        {
            tableDic.Add(Table.readOnlyTableTypeArray[i], new Dictionary<int, IKeyTableData>()); //첫번째 Dictionary에 Type넣고 아래 LoadData부분에서 남은 Dic처리
        }

        for (int i = 0; i < Table.writableTableTypeArray.Length; i++)
        {
            tableDic.Add(Table.writableTableTypeArray[i], new Dictionary<int, IKeyTableData>());
        }
        MethodInfo loadDataMethod = this.GetType().GetMethod("LoadData", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
        // GetMethod라는 함수를 쓰려면 타입으로 받아와야되서 타입으로 접근한다.
        // 이 스크립트에서 gettype으로 type 받아온다음 getmethod 사용
        //MethodInfo는 string으로 받아온 "LoadData" 라는 함수를 가져온다.
        // BindingFlags 는 받아온 함수에  instance나 public nonpublic 등등이 있으면 받아오겠다.
        // LoadData가 제너릭 함수라서 type으로 접근해야되서 변수로 접근 못하니깐 LoadData<T>() 이딴식으로 접근 못하니깐 
        // LoadData<Table.writableTableTypeArray[0]>(); 이런식으로 접근이 안된다.  Table.writableTableTypeArray[0] 얘가 변수값이라서 Type변수이지만 Type(자료형)이 아니라서
        // 그래서 이렇게 번거롭다.

        foreach (var type in tableDic.Keys) // in 뒤에가 범위  tableDic.Keys 만큼 돌리겠다.
        {
            MethodInfo loadDataGenericMethod = loadDataMethod.MakeGenericMethod(type);
            loadDataGenericMethod.Invoke(this, new object[] { }); // Invoke 는 앞의 함수를 실행시키는 함수이다. 
            //this 는 이 스크립트에서 실행시키겠다는 뜻이고 뒤에는  new object[]{} 는 LoadData<T>()에서는 받는 변수가 없어서 필요없기때문에 빈값을 넣은것이다.
            // null로 넣어도 됨 , 저거 겉멋임


        }
        // var의 type 이  tableDic.Keys[i]이다.
    }

    // LoadData
    public void LoadData<T>() where T : IKeyTableData, new() //where  제너릭에 조건다는거임  여기서는 IKeyTableData를 상속받고있어야하는것이 조건임
    { // 생성시에 new() 형태로 생성할 수 있는 애들만  T의 타입으로 올 수 있다 
        var tableData = connection.Table<T>().ToList();// connection.Table<T>().ToList() 으로 받아온 자료형으로 var가 인식된다.
        // 디비로부터 받아온 모든 테이블을 리스트화해서 tableData에 넣는다, 여기서 Table 제너릭함수는 sqlite에서 제공한 함수

        for (int i = 0; i < tableData.Count; i++) //tableData는 list list의 방개수 list이름.count
        {
            tableDic[typeof(T)].Add(tableData[i].GetTableId(), tableData[i]);  //typeof()는 변수로 만들어주는 역할을 하기에 T는 타입이라서 이렇게 변수화한다.
            // 데이터를 넣어주는 코드
        }

        T table = new T();
        IInsertableTableData insertable = table as IInsertableTableData; //데이터를 추가할 수 있는 테이블
        if (insertable != null)
        {
            if (tableDic[typeof(T)].Count > 0) //Max+1 로 테이블을 만들어 놔야함  MAx값 구하기
            {
                insertable.Max = tableDic[typeof(T)].Keys.Max();
            }
            else
            {
                insertable.Max = -1; // 데이터가 없음aa
            }
        }
    }


    //해당 테이블의 id 번째 줄의 데이터를 리턴
    public T GetData<T>(int id) where T : IKeyTableData // return 형태 T   GetData는 제너릭 함수이기에 <T> 붙이고  where T: IKeyTableData    는 T 는 타입인데 IKeyTableData를 상속받은 녀석들 중 하나이다. 
    {
        Type type = typeof(T); // T는 타입이라서 T를 변수형태로 사용할 수 있도록 변수화 하는과정

        Dictionary<int, IKeyTableData> dataDic = tableDic[type];
        // tableDic[type]은 위에서 table[key] 를 넣어서 얻은 Dictionary<int,IKeyTableData>의 값이므로 
        // 타입을 같이 맞춰준다. 이것으로  type형태의 데이터를 테이블로부터 다 받아온다.
        // 여기서의 type은 테이블 클래스 이므로 결국 위의 코드는 우리가 원하는 테이블의 정보를 딕셔너리 형태로 저장하는것을 의미 
        if (dataDic.ContainsKey(id))  // 테이블로부터 id가 있으면
        {
            return (T)dataDic[id];  // 이녀석을 리턴하는데  IKeyTableData 이것을   리턴값 맞추려고 (T)를 붙여 캐스팅해준다. , 테이블 클래스를 리턴
        }
        Debug.Log("Error : No data " + type.ToString() + id);
        return default(T);  // 없으면 에러뜨지않게 빈 테이블 리턴 , 
    }


    // 해당 테이블의 모든 데이터를 리스트로 리턴
    public List<T> GetDataList<T>() where T : IKeyTableData
    {
        Type type = typeof(T);

        /*아래 설명
        딕셔너리는 key, value 로 되어있다 . tableDic의 구조는 <key, <key,value>> 형태이다 , tableDic.ContainsKey(type) 을 하면
         <type, <key,value>> 형태가 되고 type 을 키로 가지고 있는 녀석이 tableDic 에 있는가의 결과를  bool 로 리턴해준다
        */
        if (tableDic.ContainsKey(type))
        {
            return tableDic[type].Values.Cast<T>().ToList();
        }
        /* 위의 return 코드 .  tableDic[type].Values 까지하면  우리가 원하는 테이블에 대한 <int , IKeyTableData> 를 의미하는데 이 녀석의 모든 타입을 T로
        치환해서 리스트에 박아버리는 거니깐  아마  List의 [i] 의 속성의 형태가 <int, IKeyTableData> 형태로 0부터 ~ 끝 까지 있을듯
        */
        Debug.Log("GetDataList Error : No table " + type.ToString());
        return default(List<T>);  //원하는 테이블정보가 DB에 없을시 빈 리스트 리턴
    }

    //해당 Table 업데이트(수정)
    public int UpdateData<T>(T table) where T : IKeyTableData
    {
        Type type = typeof(T);
        tableDic[type][table.GetTableId()] = table; // 외부에서 update 할 table 데이터를 Dictionary에 동기화 
        // 결과적으로 IKeyTableData를 바꿔준다.
        // 넘겨받은 table 튜플의 id값 정보를 통해 우리가 디비 정보를 고대로 따온 tableDic에 [table명][id값] = table(튜플) 을 넣는다
        // 이유는 ? => tableDic 딕셔너리는 우리가 디비 정보를 복사해 다른 스크립트에서 손쉽게 사용하기 위해 만든 딕셔너리다, 그리고 앞으로도 계속 쓸거니깐 최신정보 반영

        // 아래 코드를 통해 db에도 변동값을 적용시킨다 , 굳이 tableDic을 써서 넣을 필요없다 . 넘겨받은 table 변수 그대로 Update함수에 넣으면 된다
        return connection.Update(table); // connection은 SqlLite 클래스 객체고  table 내용으로 Update 하도록 하는 코드 
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

            default: //영어
                return GetData<Table.TextTable>(textId).eng;

        }
    }


    public void InitDB()
    {
        string streamingAssetsPath = string.Empty; // string.Empty == "" 랑 같다.

        // 플랫폼마다 저장경로가 다르다. 
#if UNITY_EDITOR 
        //string.Format은  "" + ""   두 string을 이어붙일때 가비지가 생기므로  가비지가 생기지 않도록 문자열을 조합해주는 역할을하는 녀석이다.

        streamingAssetsPath = string.Format("Assets/StreamingAssets/{0}", databaseName); // + 는자제하는게 좋다.
        // databaseName의 이름을쓰는 것은 위의 작업할때만 필요해서 이 이후부터는 databaseName을 경로로 쓰기위해서  아래와같이 값을 바꾼다.
        //streamingAsset 은 읽기밖에 하지못하기때문에 이것을 복사해서 쓸수있는 경로에 둔다 .
        databaseName = string.Format("Assets/{0}", databaseName); // 앞으로 복사될 장소의  경로를 만드는작업
        pureDatabaseName = string.Format("Assets/{0}", pureDatabaseName);



#elif UNITY_ANDROID
        streamingAssetsPath = string.Format("jar:file://{0}!/assets/{1}", Application.dataPath, databaseName);//Application.dataPath 안드로이드에서 StreamingAsset밑에 있는 파일의 경로
       
        databaseName = string.Format("{0}/{1}", Application.persistentDataPath, databaseName);

        pureDatabaseName = string.Format("{0}/{1}", Application.persistentDataPath, pureDatabaseName);
#elif UNITY_IOS
          streamingAssetsPath = string.Format("{0}/Raw/{1}", Application.dataPath, databaseName);
        
        databaseName = string.Format("{0}/{1}", Application.persistentDataPath, databaseName);

        pureDatabaseName = string.Format("{0}/{1}", Application.persistentDataPath, pureDatabaseName);
#endif
        if (File.Exists(databaseName) == false) // 파일이 존재하지 않는다면 -> 최초실행
        {
#if UNITY_EDITOR || UNITY_IOS
            File.Copy(streamingAssetsPath, databaseName);
            File.Copy(streamingAssetsPath, pureDatabaseName);


#elif UNITY_ANDROID
            WWW loadDB = new WWW(streamingAssetsPath);
            while (loadDB.isDone == false) // loadDB가 끝날때 까지 돌린다.
            {  } // load가 끝날때까지 기다리는 용이라 안에 뭐가 있을 필요가 없다.
            File.WriteAllBytes(databaseName, loadDB.bytes);
            File.WriteAllBytes(pureDatabaseName, loadDB.bytes);
            loadDB.Dispose();
            loadDB = null;

#endif
        }
    }
}

