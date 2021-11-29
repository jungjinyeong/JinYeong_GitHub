using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CollectionRewardUIInfo : MonoBehaviour
{
    [SerializeField] private Text rewardTitleText;
    [SerializeField] private Text getText;
    [SerializeField] private Text getButtonBlockText;
    [SerializeField] private Text getCountText;
    [SerializeField] private GameObject getButtonBlockObj;
    [SerializeField] private Image rewardImage;

    [SerializeField] private Image needTeeniepingImage1;
    [SerializeField] private Image needTeeniepingImage2;
    [SerializeField] private Image needTeeniepingImage3;
    [SerializeField] private Image needTeeniepingImage4;

    [SerializeField] private Image itemBackground;
    

    [SerializeField] private Image heartFrameImage1;
    [SerializeField] private Image heartFrameImage2;
    [SerializeField] private Image heartFrameImage3;
    [SerializeField] private Image heartFrameImage4;

    [SerializeField] private GameObject rewardItemBlackBackgroundObj;


    [SerializeField] private GameObject needTeeniepingObj3;
    [SerializeField] private GameObject needTeeniepingObj4;


    [SerializeField] private Text needTeenieping1_RoyalpingNameText;
    [SerializeField] private Text needTeenieping1_NomalpingNameText;
    [SerializeField] private Text needTeenieping2_RoyalpingNameText;
    [SerializeField] private Text needTeenieping2_NomalpingNameText;
    [SerializeField] private Text needTeenieping3_RoyalpingNameText;
    [SerializeField] private Text needTeenieping3_NomalpingNameText;
    [SerializeField] private Text needTeenieping4_RoyalpingNameText;
    [SerializeField] private Text needTeenieping4_NomalpingNameText;

    [SerializeField] private GameObject needTeenieping1_RoyalpingFlag;
    [SerializeField] private GameObject needTeenieping1_NomalpingFlag;
    [SerializeField] private GameObject needTeenieping2_RoyalpingFlag;
    [SerializeField] private GameObject needTeenieping2_NomalpingFlag;
    [SerializeField] private GameObject needTeenieping3_RoyalpingFlag;
    [SerializeField] private GameObject needTeenieping3_NomalpingFlag;
    [SerializeField] private GameObject needTeenieping4_RoyalpingFlag;
    [SerializeField] private GameObject needTeenieping4_NomalpingFlag;

    [SerializeField] private GameObject lock1;
    [SerializeField] private GameObject lock2;
    [SerializeField] private GameObject lock3;
    [SerializeField] private GameObject lock4;

    private int id;

    private bool canRecevie = true;

    public void Init(int id)
    {
        this.id = id;
        OnRefresh();
    }
    
    private void TeeniepingRefresh(Table.TeeniepingCollectionRewardTable collectionRewardTable)
    {
        var collectionTableList = DataService.Instance.GetDataList<Table.TiniffingCollectionTable>();

        var needTeeniepingData1 = collectionTableList[collectionRewardTable.need_teenieping1];
        var needTeeniepingData2 = collectionTableList[collectionRewardTable.need_teenieping2];
        var needTeeniepingData3 = collectionTableList[collectionRewardTable.need_teenieping3];
        var needTeeniepingData4 = collectionTableList[collectionRewardTable.need_teenieping4];

        switch (collectionRewardTable.need_teenieping_count)
        {
            case 2:
                needTeeniepingObj3.SetActive(false);
                needTeeniepingObj4.SetActive(false);
                NeedTeeniepingInit1(needTeeniepingData1);
                NeedTeeniepingInit2(needTeeniepingData2);

                break;
            case 3:
                needTeeniepingObj4.SetActive(false);
                NeedTeeniepingInit1(needTeeniepingData1);
                NeedTeeniepingInit2(needTeeniepingData2);
                NeedTeeniepingInit3(needTeeniepingData3);
                break;
            case 4:
                NeedTeeniepingInit1(needTeeniepingData1);
                NeedTeeniepingInit2(needTeeniepingData2);
                NeedTeeniepingInit3(needTeeniepingData3);
                NeedTeeniepingInit4(needTeeniepingData4);
                break;

            default:
                break;
        }
        
    }
    private void NeedTeeniepingInit1(Table.TiniffingCollectionTable needTeeniepingData1)
    {
        needTeeniepingImage1.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + needTeeniepingData1.teenieping_name);
        if (needTeeniepingData1.royal_check == 1)
        {
            needTeenieping1_RoyalpingFlag.SetActive(true);
            needTeenieping1_NomalpingFlag.SetActive(false);
            needTeenieping1_RoyalpingNameText.text = DataService.Instance.GetText(needTeeniepingData1.name_text_id);
            heartFrameImage1.sprite = Resources.Load<Sprite>("Images/Collection/royal_frame");

        }
        else
        {
            needTeenieping1_RoyalpingFlag.SetActive(false);
            needTeenieping1_NomalpingFlag.SetActive(true);
            needTeenieping1_NomalpingNameText.text = DataService.Instance.GetText(needTeeniepingData1.name_text_id);
        }

        if (needTeeniepingData1.get_check == 0)
        {
            canRecevie = false;
            Color blockColor;
            ColorUtility.TryParseHtmlString("#070707", out blockColor);
            blockColor.a = 100 / 255f;

            heartFrameImage1.sprite = Resources.Load<Sprite>("Images/Collection/black_frame");
            lock1.SetActive(true);
            needTeeniepingImage1.color = blockColor;
            needTeenieping1_RoyalpingNameText.text = "?";
            needTeenieping1_NomalpingNameText.text = "?";
        }
    }  
    private void NeedTeeniepingInit2(Table.TiniffingCollectionTable needTeeniepingData2)
    {
        needTeeniepingImage2.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + needTeeniepingData2.teenieping_name);
        if (needTeeniepingData2.royal_check == 1)
        {
            needTeenieping2_RoyalpingFlag.SetActive(true);
            needTeenieping2_NomalpingFlag.SetActive(false);
            needTeenieping2_RoyalpingNameText.text = DataService.Instance.GetText(needTeeniepingData2.name_text_id);
            heartFrameImage2.sprite = Resources.Load<Sprite>("Images/Collection/royal_frame");

        }
        else
        {
            needTeenieping2_RoyalpingFlag.SetActive(false);
            needTeenieping2_NomalpingFlag.SetActive(true);
            needTeenieping2_NomalpingNameText.text = DataService.Instance.GetText(needTeeniepingData2.name_text_id);
        }
        if (needTeeniepingData2.get_check == 0)
        {
            canRecevie = false;
            Color blockColor;
            ColorUtility.TryParseHtmlString("#070707", out blockColor);
            blockColor.a = 100 / 255f;

            lock2.SetActive(true);
            heartFrameImage2.sprite = Resources.Load<Sprite>("Images/Collection/black_frame");
            needTeeniepingImage2.color = blockColor;
            needTeenieping2_RoyalpingNameText.text = "?";
            needTeenieping2_NomalpingNameText.text = "?";
        }
    }    
    private void NeedTeeniepingInit3(Table.TiniffingCollectionTable needTeeniepingData3)
    {
        needTeeniepingImage3.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + needTeeniepingData3.teenieping_name);
        if (needTeeniepingData3.royal_check == 1)
        {
            needTeenieping3_RoyalpingFlag.SetActive(true);
            needTeenieping3_NomalpingFlag.SetActive(false);
            needTeenieping3_RoyalpingNameText.text = DataService.Instance.GetText(needTeeniepingData3.name_text_id);
            heartFrameImage3.sprite = Resources.Load<Sprite>("Images/Collection/royal_frame");

        }
        else
        {
            needTeenieping3_RoyalpingFlag.SetActive(false);
            needTeenieping3_NomalpingFlag.SetActive(true);
            needTeenieping3_NomalpingNameText.text = DataService.Instance.GetText(needTeeniepingData3.name_text_id);
        }
        if (needTeeniepingData3.get_check == 0)
        {
            canRecevie = false;
            Color blockColor;
            ColorUtility.TryParseHtmlString("#070707", out blockColor);
            blockColor.a = 100 / 255f;

            lock3.SetActive(true);
            heartFrameImage3.sprite = Resources.Load<Sprite>("Images/Collection/black_frame");

            needTeeniepingImage3.color = blockColor;
            needTeenieping3_RoyalpingNameText.text = "?";
            needTeenieping3_NomalpingNameText.text = "?";
        }
    }   
    private void NeedTeeniepingInit4(Table.TiniffingCollectionTable needTeeniepingData4)
    {
        needTeeniepingImage4.sprite = Resources.Load<Sprite>("Images/Collection/TeeniepingCollection/" + needTeeniepingData4.teenieping_name);
        if (needTeeniepingData4.royal_check == 1)
        {
            needTeenieping4_RoyalpingFlag.SetActive(true);
            needTeenieping4_NomalpingFlag.SetActive(false);
            needTeenieping4_RoyalpingNameText.text = DataService.Instance.GetText(needTeeniepingData4.name_text_id);
            heartFrameImage4.sprite = Resources.Load<Sprite>("Images/Collection/royal_frame");
        }
        else
        {
            needTeenieping4_RoyalpingFlag.SetActive(false);
            needTeenieping4_NomalpingFlag.SetActive(true);
            needTeenieping4_NomalpingNameText.text = DataService.Instance.GetText(needTeeniepingData4.name_text_id);
        }
        if (needTeeniepingData4.get_check == 0)
        {
            canRecevie = false;
            Color blockColor;
            ColorUtility.TryParseHtmlString("#070707", out blockColor);
            blockColor.a = 100 / 255f;

            lock4.SetActive(true);
            heartFrameImage4.sprite = Resources.Load<Sprite>("Images/Collection/black_frame");

            needTeeniepingImage4.color = blockColor;
            needTeenieping4_RoyalpingNameText.text = "?";
            needTeenieping4_NomalpingNameText.text = "?";
        }
    }
    private void ReceiveButtonActiveController()
    {
        if(!canRecevie)
        {
            OnGetOffButtonActive();
        }
    }
    public void OnGetButtonClick()
    {
        var collectionRewardTable = DataService.Instance.GetData<Table.TeeniepingCollectionRewardTable>(id);
        collectionRewardTable.get_check = 1;
        if (collectionRewardTable.reward_type == 0) // 코스튬
        {
            var characterTable = DataService.Instance.GetDataList<Table.CharacterTable>().Find(x=>x.character_image_name== collectionRewardTable.reward_item);
            characterTable.get = 1;
            DataService.Instance.UpdateData(characterTable);
        }
        else // 아이템
        {
            var getItemData = DataService.Instance.GetDataList<Table.ItemTable>().Find(x => x.item_name == collectionRewardTable.reward_item);
            getItemData.count += collectionRewardTable.reward_count;
            DataService.Instance.UpdateData(getItemData);
        }
        OnGetOffButtonActive();
    }
    private void OnGetOffButtonActive()
    {
        getButtonBlockObj.SetActive(true);
    }
    private void OnRefresh()
    {
        var collectionRewardTable = DataService.Instance.GetData<Table.TeeniepingCollectionRewardTable>(id);

        TeeniepingRefresh(collectionRewardTable);
        ReceiveButtonActiveController();

        rewardTitleText.text = DataService.Instance.GetText(collectionRewardTable.title_text_id);
        getText.text = DataService.Instance.GetText(61);
        getButtonBlockText.text = DataService.Instance.GetText(61);
        getCountText.text = string.Format("x{0}",collectionRewardTable.reward_count);

        if (collectionRewardTable.get_check == 1)
        {
            OnGetOffButtonActive();
            rewardItemBlackBackgroundObj.SetActive(true);
        }
        if (collectionRewardTable.reward_type == 0)
            rewardImage.sprite = Resources.Load<Sprite>("Images/Character/" + collectionRewardTable.reward_item);
        else
        {
            rewardImage.sprite = Resources.Load<Sprite>("Images/InGameUI/" + collectionRewardTable.reward_item);
            itemBackground.sprite = Resources.Load<Sprite>("Images/Collection/item_background");
        }
    }

}
