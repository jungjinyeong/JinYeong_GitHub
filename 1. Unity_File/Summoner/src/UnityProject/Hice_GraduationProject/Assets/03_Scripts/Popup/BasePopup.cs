using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BasePopup : MonoBehaviour
{
    public virtual void Init(int id = -1)
    {
        Pop();
    }

    public void Pop(bool isOverlay = true ) // popupㅇㅣ 여러개 떴을때 그 전 팝업을 띄어놓은 상태로 할지 안할지 //default는 트루로 할거임
    {
        PopupContainer.Pop(this, isOverlay); //depth 를 따로 설정해 줄 필요가 없다
    }

    public virtual void OnRefresh ()
    {

    }

    public virtual void Close()
    {
        Debug.Log("Close");
        PopupContainer.Close();
        Destroy(gameObject);
    }
}
