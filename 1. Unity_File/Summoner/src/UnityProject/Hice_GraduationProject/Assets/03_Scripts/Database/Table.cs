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
        typeof(PetTable),typeof(IngameShopSkillTable),typeof(TextTable),typeof(EnemyTable), typeof(ItemTable),
        typeof(LevelTable)

    };

    public static Type[] writableTableTypeArray =
    {

        typeof(SaveTable), typeof(InventoryTable),typeof(PlayerIngameShopSkillLevelTable),
        typeof(PlayerManagementTable),typeof(PlayerPetTable)
    };

    #region ReadOnly Table
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class PetTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int name_text_id { get; set; }
        public int desc_text_id { get; set; }
        public string pet_name { get; set; }
        // 나중에 펫 스킬 찍는 로비씬에서 사용할 사진의 이름을 위한 컬럼값(이거 참조해서 리소스파일에 접근해서 동일이름 받아와서 띄울거) 
        public int grade { get; set; }
        public int attack_power { get; set; }
        public int attack_speed { get; set; }
        public int attack_range { get; set; }
        public int move_speed { get; set; }
        public int need_saphire { get; set; }
        public string release_level { get; set; }
        public int max_level { get; set; }
        public int inc_attack_power { get; set; }
        public int inc_attack_range { get; set; }
        public int inc_attack_speed { get; set; }
        public int inc_move_speed { get; set; }
        public int inc_need_saphire { get; set; }
    }


  



    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class IngameShopSkillTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string skill_type { get; set; }
        public string icon_name { get; set; }
        public int name_text_id { get; set; }
        public int desc_text_id { get; set; }
        public int need_point { get; set; }
        public int max_level { get; set; }

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
    public class EnemyTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public string enemy_name { get; set; }
        public int hp { get; set; }
        public int attack_power { get; set; }
        public int attack_range { get; set; }
        public int attack_speed { get; set; }
        public int saphire { get; set; }
        public int gold { get; set; }
        public int move_speed { get; set; }
    }
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class ItemTable : IKeyTableData //extra table
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int name_text_id { get; set; }
        public int desc_text_id { get; set; }
        public string item_name { get; set; }// 마찬가지로 그림 받아오기 위해 존재하는 컬럼
        public int attack_power { get; set; }
        public int attack_range { get; set; }
        public int attack_speed { get; set; }
        public int hp { get; set; }
        public int move_speed { get; set; }

    }


    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class LevelTable : IKeyTableData
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int next_level_need_saphire { get; set; }
        public int can_use_pet_count { get; set; }
        public int hp { get; set; }
    }
    #endregion

    #region Writable Table
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class SaveTable : IKeyTableData //extra table
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int saphire { get; set; }
        public int gold { get; set; }
        public int player_level { get; set; }
        public int stage { get; set; }
        public float bgm { get; set; }
        public float sfx { get; set; }

    }
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class PlayerManagementTable : IKeyTableData //extra table
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int player_pet_table_id { get; set; }
        public int player_inventory_table_id { get; set; }

    }

[Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class PlayerPetTable : IKeyTableData //extra table
    {
        // playerManagementTable 에서 use_skill_count 로 사용가능 스킬갯수 받아오면되므로 여기에 따로 필드추가하지 않을거임
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int level { get; set; }
        public int own { get; set; }
        public int use { get; set; }

    }
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class InventoryTable : IKeyTableData, IInsertableTableData
    {
        public int GetTableId() { return id; }
        public void SetTableId(int id) { this.id = id; } // id setting
        public static int max; //  max 값 받아오기, 모든 데이터가 같은 max 값 가지기 위해 static //???
        [Ignore] // 아래의 것은 컬럼이 아니다 무시해라
        public int Max { get { return max; } set { max = value; } }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int item_wand { get; set; }
        public int item_armor { get; set; }
        public int item_hat { get; set; }
        public int item_shoes { get; set; }
    }
    
    [Preserve, Serializable] //serializable : 매칭이 되는 테이블과 연결을 하기 위한 어트리뷰트
    public class PlayerIngameShopSkillLevelTable : IKeyTableData //extra table
    {
        public int GetTableId() { return id; }
        [NotNull, PrimaryKey, Unique]
        public int id { get; set; }
        public int level { get; set; }
     
    }
    #endregion
}