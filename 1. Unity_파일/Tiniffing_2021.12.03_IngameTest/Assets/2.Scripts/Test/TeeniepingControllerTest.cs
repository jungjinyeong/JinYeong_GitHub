using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TeeniepingControllerTest : MonoBehaviour
{
    InGameSceneTest inGameSceneTest;

    public void OnTeeniepingClick()
    {
        inGameSceneTest.IngameClearCheck(gameObject);
        inGameSceneTest.DoKillFun(gameObject.GetComponent<RectTransform>());
    }
}
