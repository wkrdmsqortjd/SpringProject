package com.dustmq.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

// 순수 자바로 DB 연결

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
                // Oracle19 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:orcl"
                // Oracle11 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:XE"
						
						"jdbc:oracle:thin:@localhost:1521:XE",	// url
						"kh1stteam",							// id
						"1234")){								// pwd
			System.out.println(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
		
	}

}
// JDBC 실행순서
// JDBC Driver LOAD -> Connection 객체 생성 -> Statement 객체 생성 -> Query 실행 -> Result 객체로부터 데이터 추출(쿼리 실행 결과 사용)
//-> Result 객체 Close -> Statement 객체 Close -> Connection 객체 Close

// Connection : DB 연결 객체
// Statement or PreparedStatment : SQL문 실행 객체
// ResultSet : select문 결과를 가지는 객체

// Connection Pool
// 커넥션 풀은 일정량의 Connection 객체를 미리 만들어서 pool에 저장해둡니다. 프로그램에서 요청이 오면 Connection 객체를 빌려주고,
// 해당 객체의 임무가 완료되었으면 다시 반납 받아서 pool에 저장을 하는 프로그래밍 기법