/*
 * 최대 방 개수 : maxRoomCount 변수에 저장
 * roomIndex는 1부터 maxRoomCount 까지 순차적으로 증가
 * currentRoomNumber는 이동해야 할 방의 무작위 번호
 * 예를들어, 1~4번째 이동은 1~maxRoomCount번째 방까지 무작위임.
 * 다만 5번째 이동은 바로 5번째 방으로 이동(매점)
 * 6~9번째 이동 또한 무작위, 10번째 이동은 10번째 방으로 이동
 */  

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEngine.SceneManagement;


public class RoomManager : MonoBehaviour
{
    [SerializeField]
    // 현재 이동해야 할 방 번호
    private int currentRoomNumber;
    [SerializeField]
    // 방 번호(1씩 증가)
    private int roomIndex;

    // 이 스테이지 안의 최대 방 개수
    public int maxRoomCount;

    [SerializeField]
    private List<int> roomIndices;

    // 방으로 처음 이동했을 때 플레이어가 시작하는 위치
    public List<Transform> playerStartingLocations;

    public List<Room> rooms;
    public List<GameObject> roomPrefabs;
    public bool isGameFinished;
    public int GetRoomIndex()
    {
        return roomIndex;
    }
    public void SetRoomIndex(int testNumber)
    {
        roomIndex = testNumber;
    }
    void OnEnable()
    {
        maxRoomCount = 15;
        currentRoomNumber = 0;
        roomIndex = 0;
        roomIndices = new List<int>();
        for (int i = 1; i <= maxRoomCount; i++)
        {
            roomIndices.Add(i);
        }
        SetRooms();
        isGameFinished = false;
    }

    private void Start()
    {
        EnableNextRoom();
        SetActiveNextRoomEnemies();
        GameManager.instance.MovePlayerAndMinionToRoom(GetRoomStartingPosition());
    }

    public void SetRooms()
    {
        // 리스트 초기화
        rooms.Clear();
        playerStartingLocations.Clear();
        playerStartingLocations.Add(null);
        rooms.Add(null);
        foreach(var room in roomPrefabs)
        {
            SetRoomInfo(room);
        }
    }

    public void SetRoomInfo(GameObject room)
    {
        room.GetComponent<Room>().roomManager = this;
        playerStartingLocations.Add(room.transform.Find("StartPos").transform);
        rooms.Add(room.GetComponent<Room>());
    }

    public void MoveToLobby()
    {
        PlayerController.instance.DestroyPlayer();
        SceneManager.LoadScene("Lobby");
    }

    public void EnableNextRoom()
    {
        roomIndex++;

        // 마지막 방(최종보스)를 클리어 한 경우 
        if(roomIndex > maxRoomCount)
        {
            isGameFinished = true;
            PopupContainer.CreatePopup(PopupType.InGameScorePopup).Init();
            Debug.Log("스테이지 클리어");
            return;
        }

        // 매점이 있는 방 이라면,
        if(roomIndex % 5 == 0)
        {
            roomIndices.Remove(roomIndex);
            currentRoomNumber = roomIndex;
        }
        // 일반 전투 수행 방 이라면
        else
        {
            while(roomIndices.Count != 0)
            {
                int rn = Random.Range(1, rooms.Count + 1);
                if (rn % 5 != 0 && roomIndices.Contains(rn))
                {
                    currentRoomNumber = rn;
                    roomIndices.Remove(rn);
                    break;
                }     
            }
        }
        Debug.Log(roomIndex + " 번째 방 번호 : " + currentRoomNumber);
        GameManager.instance.SetActiveLineRenderer(false);
    }

    public void SetActiveNextRoomEnemies()
    {
        rooms[currentRoomNumber].SetRoomPlayable();
    }

    public Vector3 GetRoomStartingPosition()
    {
        return playerStartingLocations[currentRoomNumber].position;
    }
}
