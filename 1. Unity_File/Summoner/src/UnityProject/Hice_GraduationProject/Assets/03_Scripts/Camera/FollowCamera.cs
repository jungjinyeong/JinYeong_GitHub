/*
 * 작성자 : 백성진
 * 
 * 카메라가 일정한 위치에서 플레이어를 따라다니도록 하는 스크립트 입니다.
 */
 
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCamera : MonoBehaviour
{
    public GameObject player;
    public float cameraMovementSpeed = 4.5f;
    public float offsetY = 55f;
    public float offsetZ = -48f;

    // 카메라 z 범위
    public float fromZ;
    public float toZ;

    private Vector3 cameraPos;

    private GameManager gameManager;

    private void OnEnable()
    {
        if (player == null)
        {
            //player = GameObject.FindGameObjectWithTag("Player").gameObject;
            player = PlayerController.instance.gameObject;
        }
        GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>().orthographicSize = 8.0f;
        gameManager = GameObject.Find("GameManager").GetComponent<GameManager>();
    }
    private void LateUpdate()
    {
        if(player == null)
        {
            return;
        }
        // 카메라의 x좌표는 추후 달라질 수 있음(맵 구성에 따라)
        // cameraPos.x = 0f;
        cameraPos.y = player.transform.position.y + offsetY;
        cameraPos.z = player.transform.position.z + offsetZ;

        if(cameraPos.z >= toZ)
        {
            cameraPos.z = toZ;
        }
        else if(cameraPos.z <= fromZ)
        {
            cameraPos.z = fromZ;
        }

        float lerpOffset;
        if (gameManager.isPlayerMovedToNextRoom)
        {
            gameManager.isPlayerMovedToNextRoom = false;
            lerpOffset = 1f;
        }
        else
        {
            lerpOffset = Time.deltaTime * cameraMovementSpeed;
        }
        transform.position = Vector3.Lerp(transform.position, cameraPos, lerpOffset);
    }

    public void SetCameraPosX(float xPos)
    {
        cameraPos.x = xPos;
    }
}