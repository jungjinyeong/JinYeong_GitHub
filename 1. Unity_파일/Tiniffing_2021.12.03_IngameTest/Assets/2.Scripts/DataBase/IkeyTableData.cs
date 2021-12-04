using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IKeyTableData   // �׳� ���̺� ������ , ���� �ʿ��Ѱ� ������ ���� �׷��� ü�������� ��������
{
    int GetTableId(); // �Լ� ���� �س��� Table ����� ������
}

// c#�� �������̽� ���� ����� ���������� Ŭ���� ���߻���� �Ұ����ϴ� . �׷��� ���̺�����Ҷ� ��ġ��ӽ�Ű������ �������̽��� ����ѵ��ϴ�
public interface IInsertableTableData   // Ʃ���� �߰��� �� �ִ� ���̺��� ��� ����ϴ� �������̽�
{
    void SetTableId(int id);
    int Max // insert �� ... id�� �߰��Ҷ� MAX �� + 1 �� �߰����ֱ�����
    {
        get; set;
    }
}