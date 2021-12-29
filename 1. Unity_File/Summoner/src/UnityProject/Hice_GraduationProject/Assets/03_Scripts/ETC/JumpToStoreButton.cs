using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class JumpToStoreButton : MonoBehaviour
{
    public Button button;
    public int index;
    public RoomManager roomManager;

    // Start is called before the first frame update
    void Start()
    {
        button = GetComponent<Button>();
        index = 0;
    }

    // 무조건 엔피시 다 잡기 전에 누를것!!!!!!!!!!!!!!!!!
    public void PushButton()
    {
        index++;
        if(index == 1)
        {
            roomManager.SetRoomIndex(4);
            button.image.color = Color.red;
        }
        else if(index == 2)
        {
            roomManager.SetRoomIndex(9);
        }
        else
        {
            roomManager.SetRoomIndex(14);
        }
    }
}
