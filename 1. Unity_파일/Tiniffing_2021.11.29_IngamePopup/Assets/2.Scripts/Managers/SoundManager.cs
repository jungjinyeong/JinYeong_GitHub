using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System; // string을 enum으로 바꾸기 위해 추가 (try catch 구문에서 쓸거)
using DG.Tweening; // DOTween 사용

public class SoundManager : MonoBehaviour
{

    // 사운드 매니저는 파괴가 되지않는 조건이어야 하고 (사운드 게임오브젝트가 씬이 바꼈다고 파괴가 되면 안된다 ) 
    // 사운드 게임오브젝트에 사운드 매니저를 붙일것이다 . 
    // 소리를 내게 하려면 스피커 역할을 하는 유니티에서 제공하는 오디오 소스(AudioSource)를 사용해야하는데 그게 게임오브젝트에만 붙기때문이다


    // key 값을 string이 아닌 Enum으로 하는 이유는 enum의 자동완성 기능을 이용하여 오타 안나게하려고
    private static Dictionary<BgmType, AudioClip> bgmClipDic = new Dictionary<BgmType, AudioClip>();
    private static Dictionary<SfxType, AudioClip> sfxClipDic = new Dictionary<SfxType, AudioClip>();

    //스피커 변수
    private static AudioSource bgmSource;
    private static AudioSource sfxSource;

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)] //Awake보다 먼저 불리게 조건을 달아줌
    private static void Init()
    {
        GameObject obj = new GameObject("SoundManager"); // Scene에 미리 오디오 오브젝트 만들어놓는것이 아니라 그때그때 만들거임
        obj.AddComponent<SoundManager>(); // SoundManager 스크립트 달아줌

        GameObject bgmObj = new GameObject("BGM");
        bgmSource = bgmObj.AddComponent<AudioSource>();
        bgmSource.playOnAwake = false; // AudioSource.playOnAwake => game 시작과 동시에 재생될지를 결정하는 변수
        bgmSource.loop = true; // 반복은 on

        bgmSource.volume = PlayerPrefs.GetFloat("BGMVolume", 1);
        // GetFloat(key, 디폴트 return값 ); 해당 key 값을 찾아서 받아올건데 만약 해당 key 가 없으면 1을 디폴트로 리턴하겠다

        //PlayerPrefs => 작은 DB ( int float string 값을 가지고 오거나 저장할수있다 SetFloat GetFloat)

        bgmObj.transform.SetParent(obj.transform); // obj의 자식으로 bgmObj를 넣을거다

        // SoundManager 붙어있는 게임오브젝트인 obj를 파괴 되지 않게 코드를 짤거다 . 그 자식으로 bgmObj를 넣어놓으면 코드 여러줄 할 필요없이 같이 파괴되지 않는다

        GameObject sfxObj = new GameObject("SFX");
        sfxSource = sfxObj.AddComponent<AudioSource>();
        sfxSource.playOnAwake = false; // AudioSource.playOnAwake => game 시작과 동시에 재생될지를 결정하는 변수
        sfxSource.volume = PlayerPrefs.GetFloat("SFXVolume", 1);
        sfxObj.transform.SetParent(obj.transform); // obj의 자식으로 sfxObj를 넣을거다

        //효과음은 루프 안할거임( 디폴트값이 false라서 따로 적을필요없음 )


        DontDestroyOnLoad(obj); // 일부로 파괴시키지 않는이상 못 없애게 하는 함수 (scene이 바껴도)

        // DontDestroyOnLoad라는 씬이 항상 존재하고 그 씬에 DontDestroyOnLoad라는 함수가 있다.
        // 그리고 그 씬 안에 SoundManager 스크립트를 가진 SoundManager오브젝트가 존재한다 (스크립트에선 obj변수로서 활동하고 있음) 

        AudioClip[] bgmClips = Resources.LoadAll<AudioClip>("Sounds/BGM");
        // Sounds폴더의 BGM폴더안에 있는 녀석들을 AudioClip 자료형으로 배열에 인덱스 0번부터 차곡차곡 넣어준다 (자동화 신세계 ㄷㄷ)

        for (int i = 0; i < bgmClips.Length; i++) //Dictionary에 넣어주기 위한 for문
        {
            try // try에서 에러 발생시 catch에서 처리
            {
                BgmType bgmType = (BgmType)Enum.Parse(typeof(BgmType), bgmClips[i].name);
                // 앞에 (BgmType) 붙인거는  Parse가 Object형태로 리턴을 해주기 때문에 그 Object의 성격(자료형)을 결정해줘야 하기 떄문에 캐스팅 개념으로 붙인거

                //  Parse(형 변환할 형태 , string) 
                // 근데 뒤에 타입을 정해줬는데 이렇게 또함 진짜 비효율적임 .. 그래서 외워야함

                // enum 형 변수 = enum 형 Obj; 로 선언했는데 모든 자료형의 최상위가 Object 형태이기때문에 Object는 뭐든지 될 수 있다.

                bgmClipDic.Add(bgmType, bgmClips[i]); // Dic(Enum, AudioClip)
            }
            catch
            {
                // 에러가 생기는 경우는 아래 BgmType에 해당 enum이( 위에서 만든 bgmType) 없는 경우에 생기므로 로그 찍는다
                //( Dic에 넣을 형태로 다 변환해줬는데 정작 그 장본인이 없으면 안됨 )

                Debug.LogError("Need BgmType enum : " + bgmClips[i].name);
            }
        }


        AudioClip[] sfxClips = Resources.LoadAll<AudioClip>("Sounds/SFX");

        for (int i = 0; i < sfxClips.Length; i++) //Dictionary에 넣어주기 위한 for문
        {
            try // try에서 에러 발생시 catch에서 처리
            {
                SfxType sfxType = (SfxType)Enum.Parse(typeof(SfxType), sfxClips[i].name);
                // 앞에 (SfxType) 붙인거는  Parse가 Object형태로 리턴을 해주기 때문에 그 Object의 성격(자료형)을 결정해줘야 하기 떄문에 캐스팅 개념으로 붙인거

                //  Parse(형 변환할 형태 , string) 
                // 근데 뒤에 타입을 정해줬는데 이렇게 또함 진짜 비효율적임 .. 그래서 외워야함

                // enum 형 변수 = enum 형 Obj; 로 선언했는데 모든 자료형의 최상위가 Object 형태이기때문에 Object는 뭐든지 될 수 있다.

                sfxClipDic.Add(sfxType, sfxClips[i]); // Dic(Enum, AudioClip)
            }
            catch
            {
                // 에러가 생기는 경우는 아래 SfxType에 해당 enum이( 위에서 만든 sfxType) 없는 경우에 생기므로 로그 찍는다
                //( Dic에 넣을 형태로 다 변환해줬는데 정작 그 장본인이 없으면 안됨 )

                Debug.LogError("Need SfxType enum : " + sfxClips[i].name);
            }
        }
    }

    public static void PlaySFX(SfxType type)
    {
        sfxSource.PlayOneShot(sfxClipDic[type]); // sfxSource 스피커에서 Dictionary에 있는 해당 타입에 맞는 오디오 클립을 틀어준다
    }

    public static void PlayBGM(BgmType type, float fadeTime = 0)
    {
        if (bgmSource.clip != null) // 오디오에 비지엠소스의 클립 즉 bgm파일이 있으면( 이미 재생되고 있었던 BGM이 있었다는 거 )
        {
            if (fadeTime == 0) // fadeTime이 존재하지 않을 시 
            {
                bgmSource.clip = bgmClipDic[type];
                bgmSource.Play();
            }
            else // fadeTime != 0   , fadeTime 이 존재할 시
            {
                bgmSource.DOFade(0, fadeTime).OnComplete(() => // 기존 bgm 의 볼륨이 0이 되는 시간이 fadeTime 걸리고
                { 
                    bgmSource.clip = bgmClipDic[type]; // bgm 의 clip 을 원하는 bgm 으로 바꿔주고
                    bgmSource.Play(); // play
                    bgmSource.DOFade(PlayerPrefs.GetFloat("BGMVolume", 1), fadeTime); // fadeTime 만큼 시간 걸려서 설정된 볼륨크기로 바꾸기
                    // 꺼지고 난뒤 다시 완전히 설정값의 볼륨이 되는 시간까지 fadetime이 걸린다 .
                    // PlayerPrefs.GetInt("NAME", 1); => NAME 이라는 변수가 존재시 그 값을 가져오고 없을시 default로 1을 반환한다



                    // 그러므로 총 걸리는 시간은 2*fadeTime
                });
            }
        }
        else //현재 플레이중인 bgm이 없을때
        {
            bgmSource.clip = bgmClipDic[type]; // clip에 원하는 bgm 넣고
            bgmSource.Play(); // play

            if (fadeTime > 0) // fadeTime 이 존재할 시 (0 이 아닐시)
            {
                // 기존 볼륨이 없기때문에 기존 볼륨을 0으로 줄여주는 작업은 필요가 없다
                bgmSource.volume = 0; // 0에서 부터 점점 키울거다
                bgmSource.DOFade(PlayerPrefs.GetFloat("BGMVolume", 1), fadeTime); 
                // 설정된 볼륨 크기만큼 fadeTime 걸려서 키움 (설정된 볼륨 크기 값이 없으면 1로 디폴트)
            }
        }
    }

    public static void SetBGMVolume(float volume)
    {
        bgmSource.volume = volume;
    }

    public static void SetSFXVolume(float volume)
    {
        sfxSource.volume = volume;
    }
}

public enum BgmType
{
    LobbyBGM,
}
public enum SfxType
{
    
}

