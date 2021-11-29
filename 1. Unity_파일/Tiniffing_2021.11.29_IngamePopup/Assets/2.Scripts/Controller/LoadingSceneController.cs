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
    [SerializeField] private CanvasGroup canvasGroup; // LoadingUI Prefab  �ֻ��� Parent �� Canvas��
    // ���� ��ȯ�� �� ĵ������ ���� �ý���

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
        DontDestroyOnLoad(gameObject); // �� �ΰ��� ������ ������ �ı����� �ʾƾ� ��

    }



  //  [SerializeField]
  //  private Image loadingBackgroundImage;

    // Awake -> OnEnable -> SceneManager.sceneLoaded -> Start

    private int click_chapter_no;

    private int click_stage_no;

    // Hide In Game Scene �ε��� �� ���
    public void LoadInGameScene_H(string sceneName, int click_chapter_no, int click_stage_no)
    {
        gameObject.SetActive(true);
        runnerEffectObj.SetActive(true);
        this.click_chapter_no = click_chapter_no;
        this.click_stage_no = click_stage_no;
        SceneManager.sceneLoaded -= OnSceneLoaded;
        SceneManager.sceneLoaded += OnSceneLoaded; // ���� �ε�ɶ����� ü���� �ɾ���, OnSceneLoaded() �� delegate�� ����
        loadSceneName = sceneName;
        StartCoroutine(LoadSceneProcess());
    }

    // �κ�� �� �� ���
    public void LoadLobbyScene_H(string sceneName)
    {
        gameObject.SetActive(true);
        runnerEffectObj.SetActive(true);
        SceneManager.sceneLoaded -= OnSceneLoaded;
        SceneManager.sceneLoaded += OnSceneLoaded; // ���� �ε�ɶ����� ü���� �ɾ���, OnSceneLoaded() �� delegate�� ����
        // ���� �ε�ɶ� ü���� �ɷ��ִ� �Լ����� �����  
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
        if (scene.name == loadSceneName) // �Ѱܹ��� ���� �̸��� ��ũ��Ʈ�� loadSceneName �� ���ٸ� �ҷ������� �� ���� �� �ҷ��� ��
        {
            StartCoroutine(Fade(false));
            //OnLoadedScene?.Invoke();

            // ü�� ����
            //SceneManager.sceneLoaded -= OnSceneLoaded; // �ݹ��� ���������� ���ε��� ���۵ɶ� ����� �ݹ��� ��ø�Ǿ� ������ �߻��� => ( ���� ���ҽ� -> �Ȱ��� �Լ����� ����� ����Ǵ� ��ø���� )
        }
    }
    private IEnumerator LoadSceneProcess()
    {
        loadingText.text = "0%";
        loadingBarSlider.value = 0f;
        yield return StartCoroutine(Fade(true)); // coroutine �ȿ� �� �ڷ�ƾ�� ������ ���� �ڷ�ƾ�� ���������� �ٱ� �ڷ�ƾ�� ���

        AsyncOperation asyncOperation = SceneManager.LoadSceneAsync(loadSceneName);
        // LoadSceneAsync() �� ���� ���ϴ� ���� �����͸� ��� �����Դٰ� �ص� ����� �ٷ� Ȱ��ȭ ��Ű�� ���� ������ allowSceneActivation  �Ӽ� ���� false �� ��
        // allowSeceneActivation �� true�� �Ǵ� ���� ����� Ȱ��ȭ ��
        asyncOperation.allowSceneActivation = false;
        float timer = 0f;

        while (!asyncOperation.isDone) // scene�� ������ �ʾ�����
        {
            yield return null;
            if (asyncOperation.progress < 0.7f) // progress �� ����ȯ�� ���൵�� 0~1�� ��ȯ���ִ� AsyncOperation�� ������ // ���൵�� 90% ������ �۾�
            {
                //  progressRunner.anchoredPosition = progressRunner.anchoredPosition +new Vector2(op.progress*100, 0);
                loadingText.text = asyncOperation.progress * 100f + "%";
                loadingBarSlider.value = asyncOperation.progress; // �ε� ���൵ ǥ��
            }
            else // 90% �̻��̸� ����ũ �ε�
            {
                timer += Time.unscaledDeltaTime;
                //Time.unscaledDeltaTime : ���� �������� �Ϸ�Ǵ� �� ���� �ɸ� �ð�(timeScale�� ������)�� ��Ÿ����, ������ �ʸ� ��� (�б�����)

                loadingBarSlider.value = Mathf.Lerp(0.7f, 1f, timer); // ���α׷����ٸ� 0.9���� 1�� ä�쵵�� ����

                //  progressRunner.anchoredPosition = progressRunner.anchoredPosition + new Vector2(op.progress * 100, 0);
                loadingText.text = asyncOperation.progress * 100f + "%";
                if (loadingBarSlider.value >= 1f)
                {
                    // progressRunner.anchoredPosition = progressRunner.anchoredPosition + new Vector2(op.progress * 100, 0);
                    loadingText.text = "100%";
                    asyncOperation.allowSceneActivation = true; // ��� Ȱ��ȭ => �� �� ��ȯ �Ϸ��Ű��
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
        //  action?.Invoke  : action callback �� null �� �� �˻��ϰ�  null �� �ƴҶ��� Invoke�� ����ϴ� ��� 

    }
}
