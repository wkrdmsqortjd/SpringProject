package com.dustmq.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dustmq.mapper.AdminMapper;
import com.dustmq.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class AttachFileCheckTask {

	@Autowired
	private AdminMapper adminMapper;
	
	// 어제의 날짜를 문자열로 나타내기 위한 코드
	private String getFolderYesterDay() {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar cal = Calendar.getInstance();
			
			cal.add(Calendar.DATE, -2);
			
			String str = sdf.format(cal.getTime());
			
			return str.replace("-", File.separator);
		}	
	
	// 이미지 파일(DB 존재 x) 삭제 코드 
	@Scheduled(cron="0 0 05 * * ?")	// 하루에 한번 실행
	public void checkFiles() throws Exception {
		
		// log.warn()은 처리 가능한 문제, 향후 시스템 에러의 원인이 될 수 있는 경고성 메세지를 나타냄
		log.warn("File Check Task Run..........");
		log.warn(new Date());
		log.warn("========================================");
		
		// DB에 저장된 파일 리스트
		List<AttachImageVO> fileList = adminMapper.checkFileList();
		
		// 비교 기준 파일 리스트(Path 객체)
		List<Path> checkFilePath = new ArrayList<Path>();
		
		// 원본 이미지
		fileList.forEach(vo -> {	// for( AttachImageVO vo : fileList )
			
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		// 썸넬 이미지
		fileList.forEach(vo -> {
			
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		// 디렉토리 파일 리스트
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		File[] targetFile = targetDir.listFiles();
		
		// 삭제 대상 파일 리스트(분류)
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));
		
		for(File file : targetFile) {
			checkFilePath.forEach(checkFile ->{	// for( Path checkFile : checkFilePath )
				
				if(file.toPath().equals(checkFile)) 
					removeFileList.remove(file);	
			});
		}
		
		// 삭제 대상 파일 제거
		log.warn("file Delete : ");
		for(File file : removeFileList) {
			log.warn(file);
			file.delete();
		}
		
		log.warn("========================================================");
	}
}
