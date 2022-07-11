package com.dustmq.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dustmq.mapper.AdminMapper;
import com.dustmq.model.AttachImageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TaskTest {
	
	@Autowired
	private AdminMapper adminMapper;
	
	// 어제의 날짜를 문자열로 얻는 메서드
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 공유할 인스턴스 객체 생성
		Calendar cal = Calendar.getInstance();	
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		// File.separator는 해당 파일객체를 문자열로 바꿔줌
		return str.replace("-", File.separator);
		
	}
	
	@Test
	public void taskTest() {
		
		// 2-1. DB에 저장된 어제자 이미지 정보를 fileList에 할당
		List<AttachImageVO> fileList = adminMapper.checkFileList();
		
		// 의도된 대로 데이터를 DB의 이미지 데이터를 가져와서 Path 객체로 반환이 되어있는지 확인
		System.out.println("fileList : DB에서 가져온 이미지 데이터 ");
		fileList.forEach(list -> System.out.println(list));
		System.out.println("==========================================");
		
		// DB에 저장된 리스트와 디렉토리에 저장된 리스트를 비교하여 누락된 파일을 찾기위해서는  
		// 자료형을 같게 해주어야 동일한 파일인지 판단 가능, 해서 리스트의 파일 정보들을 Path객체로 변환
		List<Path> checkFilePath = new ArrayList<Path>();	// DB 이미지 리스트
		
		fileList.forEach(vo -> {
			
				// paths의 get()는 정적 메서드이고 path객체를 반환해줌
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				checkFilePath.add(path);
		});
		
		System.out.println("checkFilePath : DB데이터 Path 화 ");
		checkFilePath.forEach(list -> System.out.println(list));
		System.out.println("=======================================================");
		
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		System.out.println("checkFilePath(썸네일 이미지 정보 추가 후) : ");
		checkFilePath.forEach(list -> System.out.println(list));
		System.out.println("========================================");
	
				// 2-2. 체크할 대상의 이미지 파일이 저장된 디렉토리를 File객체로 생성 후 targetDir 에 대입
				File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
				System.out.println("targetDir : " + targetDir);
				
				// 디렉토리에 저장되어 있는 파일들을 File객체로 생성하여 요소를 가지는 배열을 반환 후 targetFile에 대입
				File[] targetFile = targetDir.listFiles();
			
				// 디렉토리에 저장되어 있는 파일의 정보들이 요소로 있는지 확인
				System.out.println("targetFile : ");
				for(File file : targetFile) {
					System.out.println(file);
				}
				System.out.println("========================================");
	
				// 2-3. File객체를 요소로 가지는 List타입의 removeFIleList를 선언 후 디렉토리 파일 리스트인 targetFile 배열 객체를 활용해 List타입으로 변환된 객채를 생성 후 대입
				List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));
				
				System.out.println("removeFileList(필터 전) : ");		
				removeFileList.forEach(file -> {
					System.out.println(file);
				});		
				System.out.println("========================================");		
				
				for(File file : targetFile){
					// DB의 이미지 정보와 디렉토리에 있는 이미지의 정보를 비교
					checkFilePath.forEach(checkFile ->{
						if(file.toPath().equals(checkFile)) 
							removeFileList.remove(file);	
					});
				}
				
				System.out.println("removeFileList(필터 후) : ");
				removeFileList.forEach(file -> {
					System.out.println(file);
				});
				System.out.println("========================================");
				
				// 파일 삭제
				for(File file : removeFileList) {
					
						System.out.println("삭제 : " + file);
						file.delete();
				}
				
	}
}
