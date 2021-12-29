using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class eff_Attack : MonoBehaviour
{
    private bool AniPlay = false;
    public MeshRenderer Ren01;
    public MeshRenderer Ren02;
    public MeshRenderer Ren03;


	// Use this for initialization
    void Awake()
    {
        Ren01.enabled = false;
        Ren02.enabled = false;
        Ren03.enabled = false;
    }

    void Start()
    {
        StartCoroutine("Attack");
	}

    IEnumerator Attack()
    {
        yield return new WaitForSeconds(0.45f);
        Ren01.enabled = true;
        Ren02.enabled = true;
        Ren03.enabled = true;
        this.GetComponent<Animation>().Play();
        AniPlay = true;
    }


    // Update is called once per frame
    void Update()
    {
        if ((AniPlay == true) && (this.GetComponent<Animation>().isPlaying == false))
        {
            AniPlay = false;
            DestroyImmediate(this.gameObject);
        }
    }
}
