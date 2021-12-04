using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Linq;
public class TeeniepingCollectionRewardPopup : BasePopup
{
    
    [SerializeField] private Text titleText;
    [SerializeField] private ScrollRect verticalScorllRect;

    [SerializeField] private RectTransform groupRect;

    public override void Init(int id = -1)
    {
        base.Init(id);
        VerticalScrollViewController();
        OnRefresh();
        PopTweenEffect_Nomal(groupRect);
    }
    protected override void PopTweenEffect_Nomal(RectTransform groupRect)
    {
        base.PopTweenEffect_Nomal(groupRect);
    }
    private void VerticalScrollViewController()
    {
        var teeniepingCollectionRewardTableList = DataService.Instance.GetDataList<Table.TeeniepingCollectionRewardTable>().OrderBy(x => x.get_check).ToList(); // È¹µæ ¾ÈÇÑ³à¼®ÀÌ ¸ÕÀú¿Â´Ù

        for (int i = 0; i< teeniepingCollectionRewardTableList.Count; i++)
        {
            GameObject slotCloneObj = Instantiate(Resources.Load<GameObject>("Prefabs/Tiniffing/" + "CollectionRewardUIInfo"), verticalScorllRect.content);
            slotCloneObj.GetComponent<CollectionRewardUIInfo>().Init(teeniepingCollectionRewardTableList[i].GetTableId()); 
        }
    }
    public override void OnRefresh()
    {
        base.OnRefresh();
        titleText.text = DataService.Instance.GetText(60);
    }
    public override void Close()
    {
        base.Close();
    }
}


