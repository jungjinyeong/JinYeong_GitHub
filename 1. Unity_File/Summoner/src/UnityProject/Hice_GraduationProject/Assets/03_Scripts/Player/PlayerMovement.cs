using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PlayerMovement : MonoBehaviour
{
    float moveSpeed= 3.0f;

    public static PlayerMovement Instance
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<PlayerMovement>();
                if (instance == null)
                {
                    var instanceContainer = new GameObject("PlayerMovement");
                    instance = instanceContainer.AddComponent<PlayerMovement>();
                }

            }
            return instance;
        }

    }
    private static PlayerMovement instance;

    Rigidbody rb;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
       
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if (Joystick.Instance.joyVector.x != 0 || Joystick.Instance.joyVector.y != 0)
        {

            rb.velocity = new Vector3(Joystick.Instance.joyVector.x, rb.velocity.y, Joystick.Instance.joyVector.y) * moveSpeed;
            rb.rotation = Quaternion.LookRotation(new Vector3(Joystick.Instance.joyVector.x, 0, Joystick.Instance.joyVector.y));

            // 플레이어 애니메이터 재생
            GetComponent<Animator>().SetBool("Move", true);

            // 플레이어 움직임 여부 기록
            PlayerController.instance.SetPlayerMoving(true);
        }
        else
        {
            rb.velocity = new Vector3(0, 0, 0);

            // 플레이어 애니메이터 재생
            GetComponent<Animator>().SetBool("Move", false);

            // 플레이어 움직임 여부 기록
            PlayerController.instance.SetPlayerMoving(false);
        }
    }
}
