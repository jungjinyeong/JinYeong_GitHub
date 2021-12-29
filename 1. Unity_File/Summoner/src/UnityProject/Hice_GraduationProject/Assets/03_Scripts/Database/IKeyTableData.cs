using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IKeyTableData   // 그냥 테이블 관리용 , 굳이 필요한가 싶지만 뭔가 그래도 체계적으로 관리가능
{
    int GetTableId(); // 함수 선언만 해놓고 Table 만들시 재정의
}

// c#은 인터페이스 다중 상속이 가능하지만 클래스 다중상속은 불가능하다 . 그래서 테이블관리할때 다치상속시키기위해 인터페이스를 사용한듯하다
  public interface IInsertableTableData   // 튜플을 추가할 수 있는 테이블의 경우 사용하는 인터페이스
{
    void SetTableId(int id);
    int Max // insert 용 ... id를 추가할때 MAX 값 + 1 로 추가해주기위
    {
    get;set;
    }
}