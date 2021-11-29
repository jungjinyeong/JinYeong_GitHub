using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CanvasInitialize : MonoBehaviour
{
    [SerializeField] private Canvas canvas;
    private Camera uiCamera;
    private void Awake()
    {
        AttachUICamera();
    }

    private void AttachUICamera()
    {
        GameObject cameraObj = GameObject.Find("UICamera");
        uiCamera = cameraObj.GetComponent<Camera>();

        canvas.worldCamera = uiCamera;
    }
}
