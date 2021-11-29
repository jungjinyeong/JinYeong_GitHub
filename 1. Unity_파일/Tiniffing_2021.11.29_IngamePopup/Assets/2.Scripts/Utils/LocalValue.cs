using UnityEngine;


public class LocalValue
{
    public static int Map_H { get; set; } = 0;
    public static int Click_Chapter_H { get; set; } = 0;
    public static int Click_Stage_H { get; set; } = 0;
    public static int Remain_Second { get; set; }
    public static int Get_StarCoin { get; set; } 
    public static int Now_StarCount { get; set; }   
    public static int Get_Gold { get; set; }

    //FakeLoading 완료
    public static bool isFakeLoadingFinished = false;

    // 마지막 스테이지 클리어
    public static bool isToBeUpdatedButtonClick = false;

    // 시나리오 스크립트 종료
    public static bool isScenarioFinished = false;

    // 인 게임 종료했다는 표시
    public static bool isStageFinished = false;

    // 티니핑 획득 여부
    public static bool isTeeniepingMindGet = false;

    // 인 게임 팝업 처리 관련 변수들
    public static bool isNextStageButtonClick = false; // in game popup에서 다음 스테이지 가기 눌렀을 때 필요한 것
    public static bool isStageClear = false;  // in Game에서 clear를 
    public static bool isRetryButtonClick = false;
    public static bool isLatestFinalStage = false;

    //LobbyManager 관련
    public static bool isStartButtonClick = false;

}