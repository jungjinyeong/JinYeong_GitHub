using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using DG.Tweening;

public class LoadingSceneController : MonoBehaviour
{
    private static LoadingSceneController instance;

    [SerializeField] private Text loadingText;
    [SerializeField] private Slider loadingBarSlider;

    [SerializeField] private GameObject runnerEffectObj;
    [SerializeField] private CanvasGroup canvasGroup; // LoadingUI Prefab  최상위 Parent 가 Canvas임
    // 씬이 전환될 때 캔버스로 덮는 시스템

    private string loadSceneName;

    public static LoadingSceneController Instance
    {
        get
        {
            if (instance == null)
            {
                var obj = FindObjectOfType<LoadingSceneController>();
                if (obj != null)
                    instance = obj;
                else
                    instance = Create();
            }
            return instance;
        }
    }

    private static LoadingSceneController Create()
    {
        GameObject prefab = Resources.Load<GameObject>("Prefabs/LoadingCanvas");
        LoadingSceneController loadPrefab = prefab.GetComponent<LoadingSceneController>();
        return Instantiate(loadPrefab);
    }

    public static event Action OnLoadedScene;

    public static event Action OnFinishedFade;

    private void Awake()
    {
        if (Instance != this)
        {
            Destroy(gameObject);
            return;
        }
        DontDestroyOnLoad(gameObject); // 씬 두개를 오가기 때문에 파괴되지 않아야 함

    }



  //  [SerializeField]
  //  private Image loadingBackgroundImage;

    // Awake -> OnEnable -> SceneManager.sceneLoaded -> Start

    private int click_chapter_no;

    private int click_stage_no;

    // Hide In Game Scene 로드할 때 사용
    public void LoadInGameScene_H(string sceneName, int click_chapter_no, int click_stage_no)
    {
        gameObject.SetActive(true);
        runnerEffectObj.SetActive(true);
        this.click_chapter_no = click_chapter_no;
        this.click_stage_no = click_stage_no;
        SceneManager.sceneLoaded -= OnSceneLoaded;
        SceneManager.sceneLoaded += OnSceneLoaded; // 씬이 로드될때마다 체인을 걸었음, OnSceneLoaded() 를 delegate로 전달
        loadSceneName = sceneName;
        StartCoroutine(LoadSceneProcess());
    }

    // 로비로 갈 때 사용
    public void LoadLobbyScene_H(string sceneName)
    {
        gameObject.SetActive(true);
        runnerEffectObj.SetActive(true);
        SceneManager.sceneLoaded -= OnSceneLoaded;
        SceneManager.sceneLoaded += OnSceneLoaded; // 씬이 로드될때마다 체인을 걸었음, OnSceneLoaded() 를 delegate로 전달
        // 씬이 로드될때 체인이 걸려있는 함수들이 실행됨  
        loadSceneName = sceneName;
        StartCoroutine(LoadSceneProcess());
    }
    private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
    {
        if (loadSceneName == "InGameScene_H")
        {
            HeartTime.Instance.UseHeart();
            TiniffingSpotManager.instance.OnSpread(click_stage_no);
        }
        else if(loadSceneName=="LobbyScene_H")
        {
            LobbyManager.instance.Init();
        }
        if (scene.name == loadSceneName) // 넘겨받은 씬의 이름과 스크립트의 loadSceneName 이 같다면 불러오고자 한 씬을 다 불러온 것
        {
            StartCoroutine(Fade(false));
            //OnLoadedScene?.Invoke();

            // 체인 해제
            //SceneManager.sceneLoaded -= OnSceneLoaded; // 콜백을 하지않으면 씬로딩이 시작될때 등록한 콜백이 중첩되어 문제가 발생함 => ( 해제 안할시 -> 똑같은 함수들이 더블로 실행되는 중첩문제 )
        }
    }
    private IEnumerator LoadSceneProcess()
    {
        loadingText.text = "0%";
        loadingBarSlider.value = 0f;
        yield return StartCoroutine(Fade(true)); // coroutine 안에 또 코루틴을 넣을시 내부 코루틴이 끝날때까지 바깥 코루틴은 대기

        AsyncOperation asyncOperation = SceneManager.LoadSceneAsync(loadSceneName);
        // LoadSceneAsync() 를 통해 원하는 씬의 데이터를 모두 가져왔다고 해도 장면을 바로 활성화 시키고 싶지 않을때 allowSceneActivation  속성 값을 false 로 함
        // allowSeceneActivation 이 true가 되는 순간 장면이 활성화 됨
        asyncOperation.allowSceneActivation = false;
        float timer = 0f;

        while (!asyncOperation.isDone) // scene이 끝나지 않았을때
        {
            yield return null;
            if (asyncOperation.progress < 0.7f) // progress 는 씬전환의 진행도를 0~1로 반환해주는 AsyncOperation의 변수임 // 진행도가 90% 전까지 작업
            {
                //  progressRunner.anchoredPosition = progressRunner.anchoredPosition +new Vector2(op.progress*100, 0);
                loadingText.text = asyncOperation.progress * 100f + "%";
                loadingBarSlider.value = asyncOperation.progress; // 로딩 진행도 표시
            }
            else // 90% 이상이면 페이크 로딩
            {
                timer += Time.unscaledDeltaTime;
                //Time.unscaledDeltaTime : 지난 프레임이 완료되는 데 까지 걸린 시간(timeScale에 의존적)을 나타내며, 단위는 초를 사용 (읽기전용)

                loadingBarSlider.value = Mathf.Lerp(0.7f, 1f, timer); // 프로그레스바를 0.9에서 1로 채우도록 만듦

                //  progressRunner.anchoredPosition = progressRunner.anchoredPosition + new Vector2(op.progress * 100, 0);
                loadingText.text = asyncOperation.progress * 100f + "%";
                if (loadingBarSlider.value >= 1f)
                {
                    // progressRunner.anchoredPosition = progressRunner.anchoredPosition + new Vector2(op.progress * 100, 0);
                    loadingText.text = "100%";
                    asyncOperation.allowSceneActivation = true; // 장면 활성화 => 즉 씬 전환 완료시키기
                    yield break;
                }
            }
        }
    }
    private IEnumerator Fade(bool isFadeIn)
    {
        //float timer = 0f;
        /*  while (timer <= 1f)
          {
              //yield return null;

              timer += Time.unscaledDeltaTime ; // fixedupdate 1fps 
              if (isFadeIn == true)
                  canvasGroup.alpha = Mathf.Lerp(0f, 1f, timer);
              else
                  canvasGroup.alpha = Mathf.Lerp(1f, 0f, timer);
          }*/
        
            if (isFadeIn)
            {
                canvasGroup.DOFade(1f, 0.5f);
                yield return YieldInstructionCache.WaitForSeconds(0.5f);
            }
            else
            {
                canvasGroup.DOFade(0f, 0.5f);
                runnerEffectObj.SetActive(false);
                yield return YieldInstructionCache.WaitForSeconds(0.5f);
            }
        
        if (!isFadeIn)
        {
            gameObject.SetActive(false);

            OnLoadedScene?.Invoke();
        }

        OnFinishedFade?.Invoke();
        //  action?.Invoke  : action callback 이 null 인 지 검사하고  null 이 아닐때만 Invoke를 사용하는 방식 

    }
}
