using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class TextSetting : MonoBehaviour
{
    public int textId;

    private void Awake()
    {
        Text txt = GetComponent<Text>();
        txt.text = DataService.Instance.GetText(textId);
    }
}
