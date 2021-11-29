using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScrollBarSize : MonoBehaviour
{
    // Start is called before the first frame update
    private void OnEnable()
    {
        ScrollBar();
    }
    public void ScrollBar()
    {
        transform.GetComponent<Scrollbar>().size = 0.15f;
    }
}
