using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AiSpawnManiger : MonoBehaviour
{
    //현재 enemy 생성 수를 표현
    public int enemyCount = 0;
    //enemy 생성 최대 제한
    public int maxCount = 5;

    public float spawnTime =3f;
    public float curTime = 0f;

    //생성 위치 값을 담을 배열 생성
    public Transform[] spawnPoints;
    public GameObject enemy; //prefab


    private void Start()
    { 

    }

    private void Update()
    {
        //&&(and)는 두 조건이 참일 때 생성
        if(curTime >= spawnTime && enemyCount < maxCount)
        {
            SpawnEnemy();
        }
        //이전 프레임의 완료시간까지 반환하기 위함
        curTime += Time.deltaTime;
    }

    //몬스터 생성 부분을 메서드로 만들기
    public void SpawnEnemy()
    {
        //Instantiate를 이용해서 spawnPoints 위치에 생성
        Instantiate(enemy, spawnPoints[0]);
        enemyCount++;
        curTime = 0;
    }
}
