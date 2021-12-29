using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
public class Sapphire : UnityEvent<float>
{ }

public class Gold : UnityEvent<float>
{ }

public class PlayerController : MonoBehaviour
{
    // 싱글턴 디자인 패턴을 위한 인스턴스
    public static PlayerController instance;

    // 옵저버 패턴을 위한 게임 중 얻은 재화(사파이어) 이벤트 
    public Sapphire OnPlayerGetSapphire;

    // 옵저버 패턴을 위한 게임 중 얻은 재화(골드) 이벤트 
    public Gold OnPlayerGetGold;

    public float playerHp;
    public PlayerStatus status;

    // 플레이어가 이번 게임에서 획득한 사파이어의 양
    public float playerSaphire;

    // 플레이어가 이번 게임에서 획득한 골드의 양
    public float playerGold;

    // 플레이어가 움직이고 있는지의 여부
    private bool isPlayerMoving = false;

    public enum PlayerStatus { Idle, Moving, Dead }

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Destroy(gameObject);
        }
        int playerLevel = DataService.Instance.GetData<Table.SaveTable>(0).player_level;
        playerHp = DataService.Instance.GetData<Table.LevelTable>(playerLevel).hp;

        DontDestroyOnLoad(gameObject);
        OnPlayerGetSapphire = new Sapphire();
        OnPlayerGetGold = new Gold();
    }
    public void DestroyPlayer()
    {
       
        Destroy(gameObject);
        instance = null;
    }
    // Start is called before the first frame update
    void Start()
    {
        //AddDamageEffect(A2);
        // AddDamageEffect(A1);

        //Debug.Log(CalculateDamage(3.0f));

        // AddDamageEffect(DefaultAttack);
        status = PlayerStatus.Idle;

        //playerSaphire = 5000f;
        // 사파이어, 골드 초깃값을 0으로 지정
        OnPlayerGetSapphire?.Invoke(0f);
        OnPlayerGetGold?.Invoke(0f);
    }

    // 매개변수 만큼 데미지 적용
    public void ApplyDamage(float totDamage)
    {
        playerHp -= totDamage;
        InGameUI.instance.ApplyChangedHealthPoint(gameObject, playerHp);
        if (playerHp < 0)
        {
            KillPlayer();
        }
    }

    private void KillPlayer()
    {
        GetComponent<Animator>().SetTrigger("Die");
        status = PlayerStatus.Dead;
        PopupContainer.CreatePopup(PopupType.InGameDiePopup).Init();
        //StartCoroutine(MoveToLobby());
    }
    /*
    IEnumerator MoveToLobby()
    {
        yield return new WaitForSeconds(1f);
        SceneManager.LoadScene("Lobby");
    }*/
    public void SpendPoint(int shopPoint)
    {
        // 인게임 내 상점에서는 획득한 '골드'를 소비하도록 변경
        playerGold -= shopPoint;
        OnPlayerGetGold?.Invoke(playerGold);
    }

    // 플레이어가 움직이고 있는지의 여부를 반환
    public bool IsPlayerMoving()
    {
        return isPlayerMoving;
    }

    // 플레이어의 움직임 여부 기록
    public void SetPlayerMoving(bool isMoving)
    {
        isPlayerMoving = isMoving;
    }

    public void IncreaseSapphire(float amount)
    {
        playerSaphire += amount;
        OnPlayerGetSapphire?.Invoke(playerSaphire);
    }

    public void IncreaseGold(float amount)
    {
        playerGold += amount;
        OnPlayerGetGold?.Invoke(playerGold);
    }
}
