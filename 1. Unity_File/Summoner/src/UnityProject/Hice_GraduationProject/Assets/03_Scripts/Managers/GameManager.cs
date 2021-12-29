/*
 * 작성자 : 백성진
 * 게임매니저 스크립트
 * 싱글턴 패턴 
 * - 로비 씬에서 부터, 유저가 선택한 소환수/아이템 등
 * - 플레이 할 스테이지 번호 등을 받아오기 위함
 * 
 */ 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions;
using UnityEngine.VFX;

public enum StageAge
{
    NONE,
    PRIMITIVE_AGE,
    MIDDLE_AGE,
    MODERN_AGE,
    FUTURE_AGE
}

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

    public FollowCamera mainCamera;

    // 플레이어가 수행할 스테이지 
    private StageAge stageAge;

    [SerializeField]
    // 플레이어가 선택한 소환수 리스트
    private List<GameObject> minions;

    // 플레이어 캐릭터
    private GameObject player;

    public bool isPlayerMovedToNextRoom;

    public List<GameObject> minionDictionary;

    private void Awake()
    {
        if(instance == null)
        {
            instance = this;
        }
        else if(instance != null)
        {
            Destroy(gameObject);
        }
    }

    private void OnEnable()
    {
        stageAge = new StageAge();
        stageAge = StageAge.NONE;
        minions = new List<GameObject>();

        // 임시
        LoadUserChosenMinion();

        isPlayerMovedToNextRoom = true;
    }



    public bool LoadStageInfo()
    {
        // @TODO 이 함수 내부에서 db에 접근하여 플레이어가 수행해야 할 스테이지의 정보를 받는다.
        // 구현 필요, 우선 테스트를 위한 임시 코드 작성

        // db에 스테이지가 정수로 되어있다고 가정,
        int stageIndex = 1; // 1은 원시시대
        switch (stageIndex)
        {
            case 0:
                return false;
            case 1:
                stageAge = StageAge.PRIMITIVE_AGE;
                break;
            default:
                break;
        }

        return true;
    }

    // 플레이어가 선택한 소환수 정보를 불러와 변수에 저장하는 함수
    public bool LoadUserChosenMinion()
    {

        // @TODO 이 함수 내부에서 db에 접근하여 플레이어가 선택한 NPC 정보를 받아온다.
        // 구현 필요, 우선 테스트를 위한 임시 코드 작성

        // 소환수들을 JSON 형식으로 받아온다고 가정
        // JSON 파싱 후 리스트 형식으로 그 정보를 변환
        // prefab 등으로 된 소환수를 리스트에 삽입


        // 임시로 태그로 플레이어와 소환수 로드
        player = GameObject.FindGameObjectWithTag("Player");

        
        // 선택(check)되어있는 미니언들 로드
        var dbMinions = DataService.Instance.GetDataList<Table.PlayerPetTable>().FindAll(x => x.use == 1);
        if(dbMinions.Count == 0)
        {
            return false;
        }

        float offset = 1.5f;
        float standard = dbMinions.Count;
        foreach(var item in dbMinions)
        {
            // item에 맞는 애들 생성 후 리스트에 삽입
            GameObject minionPrefab = Instantiate(minionDictionary[item.id], new Vector3(-standard + offset, 0, -6.5f), Quaternion.identity);
            minions.Add(minionPrefab);
            offset += 1.5f;
        }
        /*
        List<int> ids = new List<int>();
        ids.Add(1);
        ids.Add(2);
        ids.Add(9);
        ids.Add(10);
        ids.Add(12);
        float offset = 1.5f;
        float standard = ids.Count;
        foreach (var item in ids)
        {
            // item에 맞는 애들 생성 후 리스트에 삽입
            GameObject minionPrefab = Instantiate(minionDictionary[item], new Vector3(-standard + offset, 0, -6.5f), Quaternion.identity);
            
            minions.Add(minionPrefab);
            offset += 1.5f;
        }
        */
        /*
        var tmpenemy = GameObject.FindGameObjectsWithTag("Minion");
        for(int i=0;i< tmpenemy.Length;i++)
        {
            minions.Add(tmpenemy[i]);
        }
        */
        return true;
    }

    // 스테이지 중/후 변경된 플레이어 데이터를 db에 저장
    public bool SaveStageResult()
    {
        return true;
    }

    // 플레이어와 소환수를 특정 방으로 이동시킨다.
    public void MovePlayerAndMinionToRoom(Vector3 position)
    {
        isPlayerMovedToNextRoom = true;
        MovePlayerToRoom(position);
        // 소환수들은 position 기준으로 일정 간격으로 배치한다

        float offset = 0.5f;    // 임의의 간격
        Vector3 standardPosition = position;
        standardPosition.x -= minions.Count / 2;
        for (int i = 0; i < minions.Count; i++)
        {
            standardPosition.x += offset * i;
            MoveMinionsToRoom(minions[i], standardPosition);
        }

        // 카메라 좌표 또한 새로운 방의 위치로 이동시킨다.
        mainCamera.SetCameraPosX(position.x);
    }

    public void MovePlayerToRoom(Vector3 position)
    {
        player.transform.position = position;
    }

    public void MoveMinionsToRoom(GameObject minion, Vector3 position)
    {
        minion.GetComponent<BaseNpc>().Agent.Warp(position);
        minion.transform.position = position;
        minion.GetComponent<BaseNpc>().isAttackReserved = 0;
        LineRenderer lr = minion.GetComponent<LineRenderer>();
        if (lr != null)
        {
            lr.enabled = false;
        }
    }

    public void StopAllMinionsMoving()
    {
        foreach(var minion in minions)
        {
            minion.GetComponent<BaseNpc>().Agent.isStopped = true;
        }
    }

    public void SetActiveLineRenderer(bool isActive)
    {
        foreach(var minion in minions)
        {
            LineRenderer lr = minion.GetComponent<LineRenderer>();
            if(lr != null)
            {
                lr.enabled = isActive;
            }
        }
    }

    public void ApplyBoughtSkillEffect(int boughtSkillIndex)
    {
        switch (boughtSkillIndex) 
        {
            case 0:
                /* 예시*/
                foreach (var minion in minions)
                {
                    minion.GetComponent<BaseNpc>().AddDamageEffect(SkillEffects.FireAttack);
                    minion.GetComponent<BaseNpc>().AddAttackVisualEffect(SkillEffects.AttackThunderProperty);
                    minion.GetComponent<BaseNpc>().AddHitVisualEffect(SkillEffects.HitThunderProperty);
                }
                
                 
                 
                break;
            case 1: break;
            case 2: 
                foreach(var minion in minions)
                {
                    var prevSpeed = minion.GetComponent<BaseNpc>().NpcAttackSpeed;
                    minion.GetComponent<BaseNpc>().NpcAttackSpeed += prevSpeed * 0.2f;
                }
                break;
            case 3:
                foreach (var minion in minions)
                {
                    var prevRange = minion.GetComponent<BaseNpc>().NpcAttackRange;
                    minion.GetComponent<BaseNpc>().NpcAttackRange += prevRange * 0.2f;
                }
                break;
            case 4: break;
            case 5: break;
            case 6:
                // when bought skill burn
                foreach (var minion in minions)
                {
                    minion.GetComponent<BaseNpc>().AddDamageEffect(SkillEffects.FireAttack);
                    minion.GetComponent<BaseNpc>().AddHitVisualEffect(SkillEffects.HitFireProperty);
                }
                break;
            case 7: break;
            case 8: break;
            case 9: break;
            case 10:
                // hp 올리는 스킬의 레벨이 몇인지 확인 후, LevelTable에서 hp 증가시켜야 하는 양을 구한 후 미니언에게 더한다.
                var level = DataService.Instance.GetData<Table.PlayerIngameShopSkillLevelTable>(boughtSkillIndex).level;
                var hpIncreaseOffset = DataService.Instance.GetData<Table.LevelTable>(level).hp;
                foreach (var minion in minions)
                {
                    var prevHp = minion.GetComponent<BaseNpc>().NpcHp;
                    minion.GetComponent<BaseNpc>().NpcHp += hpIncreaseOffset;
                }
                break;
            case 11: break;
            case 12: break;
            case 13: break;
            case 14: break;
            case 15: break;
            default: break;
        }
    }
}
