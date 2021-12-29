using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkillImagePosition : MonoBehaviour
{
    public Transform playerTr;


    void Update()
    {
        Vector3 pos
         = new Vector3(playerTr.position.x,playerTr.position.y+2,playerTr.position.z);
        this.transform.position = pos;
    }
}
