using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Portal : MonoBehaviour
{
    public Room room;

    private void Start()
    {
        room = transform.parent.GetComponent<Room>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag != "Player")
            return;
        if (room.roomManager.isGameFinished)
        {
            room.roomManager.MoveToLobby();
            return;
        }
        // GameManager에 플레이어와 소환수를 n번방으로 이동시키라는 요청.
        GameManager.instance.MovePlayerAndMinionToRoom(room.roomManager.GetRoomStartingPosition());
        room.roomManager.SetActiveNextRoomEnemies();
        // detroy this portal when trigger is entered
        Destroy(gameObject);
    }
}
