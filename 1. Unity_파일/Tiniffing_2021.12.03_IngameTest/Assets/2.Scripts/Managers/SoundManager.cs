using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System; // string�� enum���� �ٲٱ� ���� �߰� (try catch �������� ����)
using DG.Tweening; // DOTween ���

public class SoundManager : MonoBehaviour
{

    // ���� �Ŵ����� �ı��� �����ʴ� �����̾�� �ϰ� (���� ���ӿ�����Ʈ�� ���� �ٲ��ٰ� �ı��� �Ǹ� �ȵȴ� ) 
    // ���� ���ӿ�����Ʈ�� ���� �Ŵ����� ���ϰ��̴� . 
    // �Ҹ��� ���� �Ϸ��� ����Ŀ ������ �ϴ� ����Ƽ���� �����ϴ� ����� �ҽ�(AudioSource)�� ����ؾ��ϴµ� �װ� ���ӿ�����Ʈ���� �ٱ⶧���̴�


    // key ���� string�� �ƴ� Enum���� �ϴ� ������ enum�� �ڵ��ϼ� ����� �̿��Ͽ� ��Ÿ �ȳ����Ϸ���
    private static Dictionary<BgmType, AudioClip> bgmClipDic = new Dictionary<BgmType, AudioClip>();
    private static Dictionary<SfxType, AudioClip> sfxClipDic = new Dictionary<SfxType, AudioClip>();

    //����Ŀ ����
    private static AudioSource bgmSource;
    private static AudioSource sfxSource;

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)] //Awake���� ���� �Ҹ��� ������ �޾���
    private static void Init()
    {
        GameObject obj = new GameObject("SoundManager"); // Scene�� �̸� ����� ������Ʈ �������°��� �ƴ϶� �׶��׶� �������
        obj.AddComponent<SoundManager>(); // SoundManager ��ũ��Ʈ �޾���

        GameObject bgmObj = new GameObject("BGM");
        bgmSource = bgmObj.AddComponent<AudioSource>();
        bgmSource.playOnAwake = false; // AudioSource.playOnAwake => game ���۰� ���ÿ� ��������� �����ϴ� ����
        bgmSource.loop = true; // �ݺ��� on

        bgmSource.volume = PlayerPrefs.GetFloat("BGMVolume", 1);
        // GetFloat(key, ����Ʈ return�� ); �ش� key ���� ã�Ƽ� �޾ƿðǵ� ���� �ش� key �� ������ 1�� ����Ʈ�� �����ϰڴ�

        //PlayerPrefs => ���� DB ( int float string ���� ������ ���ų� �����Ҽ��ִ� SetFloat GetFloat)

        bgmObj.transform.SetParent(obj.transform); // obj�� �ڽ����� bgmObj�� �����Ŵ�

        // SoundManager �پ��ִ� ���ӿ�����Ʈ�� obj�� �ı� ���� �ʰ� �ڵ带 ©�Ŵ� . �� �ڽ����� bgmObj�� �־������ �ڵ� ������ �� �ʿ���� ���� �ı����� �ʴ´�

        GameObject sfxObj = new GameObject("SFX");
        sfxSource = sfxObj.AddComponent<AudioSource>();
        sfxSource.playOnAwake = false; // AudioSource.playOnAwake => game ���۰� ���ÿ� ��������� �����ϴ� ����
        sfxSource.volume = PlayerPrefs.GetFloat("SFXVolume", 1);
        sfxObj.transform.SetParent(obj.transform); // obj�� �ڽ����� sfxObj�� �����Ŵ�

        //ȿ������ ���� ���Ұ���( ����Ʈ���� false�� ���� �����ʿ���� )


        DontDestroyOnLoad(obj); // �Ϻη� �ı���Ű�� �ʴ��̻� �� ���ְ� �ϴ� �Լ� (scene�� �ٲ���)

        // DontDestroyOnLoad��� ���� �׻� �����ϰ� �� ���� DontDestroyOnLoad��� �Լ��� �ִ�.
        // �׸��� �� �� �ȿ� SoundManager ��ũ��Ʈ�� ���� SoundManager������Ʈ�� �����Ѵ� (��ũ��Ʈ���� obj�����μ� Ȱ���ϰ� ����) 

        AudioClip[] bgmClips = Resources.LoadAll<AudioClip>("Sounds/BGM");
        // Sounds������ BGM�����ȿ� �ִ� �༮���� AudioClip �ڷ������� �迭�� �ε��� 0������ �������� �־��ش� (�ڵ�ȭ �ż��� ����)

        for (int i = 0; i < bgmClips.Length; i++) //Dictionary�� �־��ֱ� ���� for��
        {
            try // try���� ���� �߻��� catch���� ó��
            {
                BgmType bgmType = (BgmType)Enum.Parse(typeof(BgmType), bgmClips[i].name);
                // �տ� (BgmType) ���ΰŴ�  Parse�� Object���·� ������ ���ֱ� ������ �� Object�� ����(�ڷ���)�� ��������� �ϱ� ������ ĳ���� �������� ���ΰ�

                //  Parse(�� ��ȯ�� ���� , string) 
                // �ٵ� �ڿ� Ÿ���� ������µ� �̷��� ���� ��¥ ��ȿ������ .. �׷��� �ܿ�����

                // enum �� ���� = enum �� Obj; �� �����ߴµ� ��� �ڷ����� �ֻ����� Object �����̱⶧���� Object�� ������ �� �� �ִ�.

                bgmClipDic.Add(bgmType, bgmClips[i]); // Dic(Enum, AudioClip)
            }
            catch
            {
                // ������ ����� ���� �Ʒ� BgmType�� �ش� enum��( ������ ���� bgmType) ���� ��쿡 ����Ƿ� �α� ��´�
                //( Dic�� ���� ���·� �� ��ȯ����µ� ���� �� �庻���� ������ �ȵ� )

                Debug.LogError("Need BgmType enum : " + bgmClips[i].name);
            }
        }


        AudioClip[] sfxClips = Resources.LoadAll<AudioClip>("Sounds/SFX");

        for (int i = 0; i < sfxClips.Length; i++) //Dictionary�� �־��ֱ� ���� for��
        {
            try // try���� ���� �߻��� catch���� ó��
            {
                SfxType sfxType = (SfxType)Enum.Parse(typeof(SfxType), sfxClips[i].name);
                // �տ� (SfxType) ���ΰŴ�  Parse�� Object���·� ������ ���ֱ� ������ �� Object�� ����(�ڷ���)�� ��������� �ϱ� ������ ĳ���� �������� ���ΰ�

                //  Parse(�� ��ȯ�� ���� , string) 
                // �ٵ� �ڿ� Ÿ���� ������µ� �̷��� ���� ��¥ ��ȿ������ .. �׷��� �ܿ�����

                // enum �� ���� = enum �� Obj; �� �����ߴµ� ��� �ڷ����� �ֻ����� Object �����̱⶧���� Object�� ������ �� �� �ִ�.

                sfxClipDic.Add(sfxType, sfxClips[i]); // Dic(Enum, AudioClip)
            }
            catch
            {
                // ������ ����� ���� �Ʒ� SfxType�� �ش� enum��( ������ ���� sfxType) ���� ��쿡 ����Ƿ� �α� ��´�
                //( Dic�� ���� ���·� �� ��ȯ����µ� ���� �� �庻���� ������ �ȵ� )

                Debug.LogError("Need SfxType enum : " + sfxClips[i].name);
            }
        }
    }

    public static void PlaySFX(SfxType type)
    {
        sfxSource.PlayOneShot(sfxClipDic[type]); // sfxSource ����Ŀ���� Dictionary�� �ִ� �ش� Ÿ�Կ� �´� ����� Ŭ���� Ʋ���ش�
    }

    public static void PlayBGM(BgmType type, float fadeTime = 0)
    {
        if (bgmSource.clip != null) // ������� �������ҽ��� Ŭ�� �� bgm������ ������( �̹� ����ǰ� �־��� BGM�� �־��ٴ� �� )
        {
            if (fadeTime == 0) // fadeTime�� �������� ���� �� 
            {
                bgmSource.clip = bgmClipDic[type];
                bgmSource.Play();
            }
            else // fadeTime != 0   , fadeTime �� ������ ��
            {
                bgmSource.DOFade(0, fadeTime).OnComplete(() => // ���� bgm �� ������ 0�� �Ǵ� �ð��� fadeTime �ɸ���
                { 
                    bgmSource.clip = bgmClipDic[type]; // bgm �� clip �� ���ϴ� bgm ���� �ٲ��ְ�
                    bgmSource.Play(); // play
                    bgmSource.DOFade(PlayerPrefs.GetFloat("BGMVolume", 1), fadeTime); // fadeTime ��ŭ �ð� �ɷ��� ������ ����ũ��� �ٲٱ�
                    // ������ ���� �ٽ� ������ �������� ������ �Ǵ� �ð����� fadetime�� �ɸ��� .
                    // PlayerPrefs.GetInt("NAME", 1); => NAME �̶�� ������ ����� �� ���� �������� ������ default�� 1�� ��ȯ�Ѵ�



                    // �׷��Ƿ� �� �ɸ��� �ð��� 2*fadeTime
                });
            }
        }
        else //���� �÷������� bgm�� ������
        {
            bgmSource.clip = bgmClipDic[type]; // clip�� ���ϴ� bgm �ְ�
            bgmSource.Play(); // play

            if (fadeTime > 0) // fadeTime �� ������ �� (0 �� �ƴҽ�)
            {
                // ���� ������ ���⶧���� ���� ������ 0���� �ٿ��ִ� �۾��� �ʿ䰡 ����
                bgmSource.volume = 0; // 0���� ���� ���� Ű��Ŵ�
                bgmSource.DOFade(PlayerPrefs.GetFloat("BGMVolume", 1), fadeTime); 
                // ������ ���� ũ�⸸ŭ fadeTime �ɷ��� Ű�� (������ ���� ũ�� ���� ������ 1�� ����Ʈ)
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

