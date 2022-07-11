package com.dustmq.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	
	// ���� �ð��� ����ϴ� sql �� ( ������̼� �̿� )
	@Select("SELECT sysdate FROM dual")
	public String getTime1();
	
	// TimeMapper.xml 를 통해서 sql문 실행
	public String getTime2();
}

// MyBatis�� ���ؼ� SQL���� �����ϱ� ���ؼ� �� ���� ����� �ִµ�,
// ù ��° ����� interface�� @ �� ��� (������ SQL��)
// �� ��° ����� XML ���	(��� ������ SQL��)
// XML ����� ����� ���� '���� ���� ��ġ' �� namespace �Ӽ��� �����Ͽ� �ۼ�
