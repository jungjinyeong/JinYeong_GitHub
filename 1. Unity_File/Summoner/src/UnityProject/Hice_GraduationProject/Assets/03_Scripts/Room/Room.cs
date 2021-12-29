/*
 * 작성자 : 백성진
 * Room 1, Room 2, ... 에 부착되는 스크립트
 * 
 * 각 방에 부착되어, 그 방의 NPC를 제어한다.
 * 또한, 모든 NPC 제거시 포탈을 여는 등의 기능을 담당한다. 
 * 
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Room : MonoBehaviour
{
    public List<GameObject> enemies;
    public GameObject portal;
    public RoomManager roomManager;

    void Start()
    {
     
    }

    // 이 방의 모든 적이 사망했을 경우, 다음 방으로 이동을 위한 포탈 생성
    public void OnAllEnemiesDead()
    {
        CreatePortal();
        roomManager.EnableNextRoom();
        GameManager.instance.StopAllMinionsMoving();
    }

    private void CreatePortal()
    {
        // Create portal to move to next room
        var pt = Instantiate(portal);
        Vector3 scale = new Vector3(5f, 5f, 5f);
        if(roomManager.GetRoomIndex() >= roomManager.maxRoomCount)
        {
            scale = new Vector3(15f, 15f, 15f);
        }
        pt.transform.localScale = scale;
        pt.transform.parent = gameObject.transform;
        pt.transform.localPosition = new Vector3(0, 0.1f, 9.5f);
        SoundManager.instance.PlayOneShotSkillEffectSFX("Healing 14");
    }

    // 매개변수로 들어온 게임오브젝트를 리스트에서 삭제
    public void RemoveEnemy(GameObject removedEnemy)
    {
        if (enemies.Contains(removedEnemy))
        {
            enemies.Remove(removedEnemy);
            if (enemies.Count == 0)
            {
                // Trigger event that leading to next room
                OnAllEnemiesDead();
            }
        }
    }

    // 아직 RoomManager의 방 번호가 이 방이 아닌 경우, (즉, 현재 플레이어는 다른 방에 있는 경우) 이 방 안의 NPC를 비활성화 한다.
    private void ChangeNpcActivity(bool active)
    {
        foreach (var item in enemies)
        {
            // active가 true이면, NPC를 활성화
            item.SetActive(active);
        }
    }

    public void SetRoomPlayable()
    { 
        transform.Find("StageNumber").GetComponent<TextMesh>().text = roomManager.GetRoomIndex().ToString();
        ChangeNpcActivity(true);
        // 이 방 안에 적이 없다면(매점 등의 이유로), 다음 방 활성화
        if(enemies.Count == 0)
        {
            OnAllEnemiesDead();
        }
    }

}
