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

    //FakeLoading �Ϸ�
    public static bool isFakeLoadingFinished = false;

    // ������ �������� Ŭ����
    public static bool isToBeUpdatedButtonClick = false;

    // �ó����� ��ũ��Ʈ ����
    public static bool isScenarioFinished = false;

    // �� ���� �����ߴٴ� ǥ��
    public static bool isStageFinished = false;

    // Ƽ���� ȹ�� ����
    public static bool isTeeniepingMindGet = false;

    // �� ���� �˾� ó�� ���� ������
    public static bool isNextStageButtonClick = false; // in game popup���� ���� �������� ���� ������ �� �ʿ��� ��
    public static bool isStageClear = false;  // in Game���� clear�� 
    public static bool isRetryButtonClick = false;
    public static bool isLatestFinalStage = false;

    //LobbyManager ����
    public static bool isStartButtonClick = false;

}