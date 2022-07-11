package com.dustmq.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

// ���� �ڹٷ� DB ����

public class JDBCTest {
	
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(
				Connection con = DriverManager.getConnection(
                // Oracle19 ������ ��� => "jdbc:oracle:thin:@localhost:1521:orcl"
                // Oracle11 ������ ��� => "jdbc:oracle:thin:@localhost:1521:XE"
						
						"jdbc:oracle:thin:@localhost:1521:XE",	// url
						"kh1stteam",							// id
						"1234")){								// pwd
			System.out.println(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
		
	}

}
// JDBC �������
// JDBC Driver LOAD -> Connection ��ü ���� -> Statement ��ü ���� -> Query ���� -> Result ��ü�κ��� ������ ����(���� ���� ��� ���)
//-> Result ��ü Close -> Statement ��ü Close -> Connection ��ü Close

// Connection : DB ���� ��ü
// Statement or PreparedStatment : SQL�� ���� ��ü
// ResultSet : select�� ����� ������ ��ü

// Connection Pool
// Ŀ�ؼ� Ǯ�� �������� Connection ��ü�� �̸� ���� pool�� �����صӴϴ�. ���α׷����� ��û�� ���� Connection ��ü�� �����ְ�,
// �ش� ��ü�� �ӹ��� �Ϸ�Ǿ����� �ٽ� �ݳ� �޾Ƽ� pool�� ������ �ϴ� ���α׷��� ���