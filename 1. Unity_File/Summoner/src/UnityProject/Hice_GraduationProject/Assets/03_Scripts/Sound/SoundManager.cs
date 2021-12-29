/*
 * 사운드 매니저 클래스 입니다.
 * 
 * 배경음 및 그 외 사운드의 재생, 음량 등을 관리합니다.
 * 
 */ 
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class SoundManager : MonoBehaviour
{
    public static SoundManager instance = null;

    // 옵션에서 관리용도의 마스터 볼륨
    public float masterVolumeSFX = 1f;
    public float masterVolumeBGM = 1f;

    // BGM
    [SerializeField]
    private AudioClip[] bgmClips;
    
    // skill
    [SerializeField]
    private AudioClip[] skillEffectClips;

    // 기타 효과음
    [SerializeField]
    private AudioClip[] etcClips;

    // 배경음악 사운드 딕셔너리 {파일이름, 클립}
    private Dictionary<string, AudioClip> bgmClipDic;

    // 스킬이펙트 사운드 딕셔너리 {파일이름, 클립}
    private Dictionary<string, AudioClip> skillEffectClipDic;

    // 사운드 플레이어
    private AudioSource skillEffectPlayer;
    private AudioSource bgmPlayer;
    //private AudioSource etcPlayer;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Destroy(gameObject);
        }
        DontDestroyOnLoad(gameObject);
    }

    private void OnEnable()
    {
        // 오디오 소스 할당
        bgmPlayer = transform.GetChild(0).GetComponent<AudioSource>();
        skillEffectPlayer = GetComponent<AudioSource>();
        
        RegisterAudioClips();

        var saveData = DataService.Instance.GetData<Table.SaveTable>(0);
        masterVolumeBGM = saveData.bgm;
        masterVolumeSFX = saveData.sfx;
        SetCustomVolume();

    }

    void Start()
    {
        
    }

    // 오디오클립 등록 함수
    private void RegisterAudioClips()
    {
        // 딕셔너리 할당
        skillEffectClipDic = new Dictionary<string, AudioClip>();
        bgmClipDic = new Dictionary<string, AudioClip>();

        //outGameClips = Resources.LoadAll<AudioClip>("Audio/OutGame");
        //inGameClips = Resources.LoadAll<AudioClip>("Audio/InGame");
        foreach (var item in bgmClips)
        {
            bgmClipDic.Add(item.name, item);
        }

        foreach (var item in skillEffectClips)
        {
            skillEffectClipDic.Add(item.name, item);
        }
       
    }

    // 마스터 볼륨으로 사운드 볼륨 설정
    public void SetCustomVolume()
    {
        skillEffectPlayer.volume = masterVolumeSFX;
        bgmPlayer.volume = masterVolumeBGM;
    }

    // 스킬 이펙트 사운드 1회 재생
    public void PlayOneShotSkillEffectSFX(string clipName, float volume = 1f)
    {
        if (skillEffectClipDic.ContainsKey(clipName) == false)
        {
            Debug.LogError(clipName + " 이라는 사운드는 없습니다. 재생 불가능 합니다.");
            return;
        }
        skillEffectPlayer.PlayOneShot(skillEffectClipDic[clipName], volume * masterVolumeSFX);
    }

    // bgm 재생
    public void PlayBGM(string clipName)
    {
        if (bgmClipDic.ContainsKey(clipName) == false)
        {
            Debug.LogError(clipName + " 이라는 사운드는 없습니다. 재생 불가능 합니다.");
            return;
        }
        bgmPlayer.clip = bgmClipDic[clipName];
        bgmPlayer.loop = true;
        bgmPlayer.Play();
    }

    // bgm 멈춤
    public void StopBGM()
    {
        if (bgmPlayer.clip != null)
            bgmPlayer.Stop();
    }

    // bgm 다시재생
    public void RePlayBGM()
    {
        if (bgmPlayer.clip != null)
            bgmPlayer.Play();
    }

    /*
     // sfx n회 재생.
    public void IterateEffectSound(string skillNum, float volume = 1f)
    {
        string soundTitle = effectDic[int.Parse(skillNum)]["Title"].ToString();
        int iterCount = (int)effectDic[int.Parse(skillNum)]["Iteration"];
        StartCoroutine(PlaySFX(soundTitle, volume, iterCount));
    }
    
    private IEnumerator PlaySFX(string clipName, float volume = 1f, int iter = 1)
    {
        for(int i = 0; i < iter; i++)
        {
            PlaySound(clipName, volume);
            yield return new WaitForSeconds(0.15f);
        }
    }

    */
}
