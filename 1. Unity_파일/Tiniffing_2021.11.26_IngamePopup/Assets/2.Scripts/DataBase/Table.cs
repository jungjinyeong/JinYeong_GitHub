using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System; //Type
using UnityEngine.Scripting; //preserve ( 당장 쓰이지 않는 클래스도 빌드를 할 때 반드시 포함 시키는 어트리뷰트 )
using SQLite.Attribute;

public class Table
{
    public static Type[] readOnlyTableTypeArray =
    {
            typeof(TiniffingSpotTable),typeof(TextTable),typeof(BaseTable),typeof(BaseDetailTable),typeof(CharacterRewardTable),typeof(ScriptTable),typeof(ResourceTable)

    };

    public static Type[] writableTableTypeArray =
    {
       typeof(SaveTable),typeof(LobbyTable),typeof(ItemTable),typeof(TiniffingCollectionTable),typeof(TeeniepingCollectionRewardTable),typeof(CharacterTable), typeof(ChapterTable),typeof(TutorialTable),

    };

    #region ReadOnly Table
 
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class TiniffingSpotTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int chapter_id { get; set; }
        public int mode_type { get; set; }
        public string effect_mode { get; set; }
        public int stage_no { get; set; }
        public int map_id { get; set; }
        public int map_check { get; set; }
        public string map_name { get; set; }
     
        public int min_answer { get; set; }
        public int max_answer { get; set; }
        public string spot1_name { get; set; }
        public float spot1_x { get; set; }
        public float spot1_y { get; set; }
        public string spot2_name { get; set; }
        public float spot2_x { get; set; }
        public float spot2_y { get; set; }
        public string spot3_name { get; set; }
        public float spot3_x { get; set; }
        public float spot3_y { get; set; }
        public string spot4_name { get; set; }
        public float spot4_x { get; set; }
        public float spot4_y { get; set; }
        public string spot5_name { get; set; }
        public float spot5_x { get; set; }
        public float spot5_y { get; set; }
        public string spot6_name { get; set; }
        public float spot6_x { get; set; }
        public float spot6_y { get; set; }
        public string spot7_name { get; set; }
        public float spot7_x { get; set; }
        public float spot7_y { get; set; }
        public string spot8_name { get; set; }
        public float spot8_x { get; set; }
        public float spot8_y { get; set; }
        public string spot9_name { get; set; }
        public float spot9_x { get; set; }
        public float spot9_y { get; set; }
       
        public string spot10_name { get; set; }
        public float spot10_x { get; set; }
        public float spot10_y { get; set; }
       

    }

   
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class TextTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string kor { get; set; }
        public string eng { get; set; }

    }

    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class BaseTable : IKeyTableData
    {

        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }

        public int data { get; set; }
    }
    public class BaseDetailTable :IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
      
        public int base_table_id { get; set; }
        public int sequence { get; set; }
        public string data { get; set; }
    }

    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class CharacterRewardTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int type { get; set; }
        public int get_count { get; set; }

    }
    
    public class ScriptTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int mode_type { get; set; }
        public string resources_id { get; set; }
        public string scripts_text_id { get; set; }
        public string characters_name_text_id { get; set; }
    }
    public class ResourceTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string resource_name { get; set; }   
    }
    #endregion
    //====================================================================================================================================
    #region Writable Table
    public class LobbyTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int chapter_no { get; set; }

        public int stage_no { get; set; }

        public int clear { get; set; }
        public int retry { get; set; }
        public int star_count { get; set; }
        public int mode_type { get; set; } // 일반 하드 는 텍스트테이블로 불러오기
        public int script_id { get; set; }
        public string box_image_name { get; set; }
    }
    public class TiniffingCollectionTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string teenieping_name { get; set; }
        public int teenieping_description_resource_id { get; set; }
        public string mind_teenieping_name { get; set; }
        public int name_text_id { get; set; }
        public int get_chapter { get; set; }
        public int get_check { get; set; }
        public int royal_check { get; set; }
        public int mind_count { get; set; }
        public int script_id { get; set; }

        public int title_description_text_id { get; set; }
        public int main_description_text_id { get; set; }
        public int sub_description_text_id { get; set; }
  
    }
    public class TeeniepingCollectionRewardTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string reward_item { get; set; }
        public int reward_type { get; set; }
        public int reward_count { get; set; }
        public int get_check { get; set; }
        public int need_teenieping_count { get; set; }
        public int need_teenieping1 { get; set; }
        public int need_teenieping2 { get; set; }
        public int need_teenieping3 { get; set; }
        public int need_teenieping4 { get; set; }
        public int title_text_id { get; set; }

    }

    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class SaveTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int newbie { get; set; }
        public int chapter_no { get; set; }
        public int stage_no { get; set; }
        public int now_chapter_no { get; set; }
        public string last_time { get; set; }
        public int heart_count { get; set; }
        public int cumulative_cycle_time { get; set; }
        public int gold { get; set; }
        public int star_coin { get; set; }
        public int using_character_id { get; set; }
        public string ad_init_time { get; set; }
        public int game_clear { get; set; }
    }

    public class ItemTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string item_name { get; set; }
        public int count { get; set; }
        public int active { get; set; } // 일반 하드 는 텍스트테이블로 불러오기
        public int ad_check { get; set; } 

        public int name_text_id { get; set; }

        public int description_text_id { get; set; }

    }
    public class CharacterTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
   
        public int get { get; set; }
        public int select { get; set; }
        public string character_image_name { get; set; }
        public string character_spine_name { get; set; }
        public int name_text_id { get; set; }
        public int title_text_id { get; set; }
        public int description_text_id { get; set; }

    }
    public class ChapterTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int chapter_no { get; set; }
        public int clear { get; set; }
        public int script_id { get; set; }
        public int title_text_id { get; set; }
    }
    public class TutorialTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int check1 { get; set; }
        public int check2 { get; set; }
        
    }
    #endregion
}