package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.google.gson.*;
import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;
@Service
public class ArtisanTimelineService {
	@Autowired private ArtisanTimelineDao dao;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	//리스트
		public Map<String, Object> listArtisanTimeline(int pageno, String artisanId) {
			int timelineCnt = dao.getArtisanTimelineCnt(artisanId);
			Pagination pagination = PagingUtil.setPageMaker(pageno, timelineCnt);
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println(dao.artisanInfo(artisanId));
			map.put("artisan", dao.artisanInfo(artisanId));
			map.put("pagination", pagination);
			map.put("list", dao.listArtisanTimeline(pagination.getStartArticleNum(),pagination.getEndArticleNum(),artisanId));
			return map;
		}
		//글작성
		
		public Boolean insertArtisanTimeline(ArtisanTimeline artisanTimeline, MultipartFile pic) throws IOException {
			
			if (pic.getOriginalFilename().equals("")) {	// 첨부파일이 비어있을 경우
				artisanTimeline.setOriginalFileName("");
				artisanTimeline.setSavedFileName("");
			} else {	// 첨부파일 넣기
				System.out.println("서비스 도착"+pic.getOriginalFilename());
				String originalFileName = pic.getOriginalFilename();
				String savedFileName = System.currentTimeMillis() + "-" + pic.getOriginalFilename();
				
				System.out.println("서비스 파일네임"+savedFileName);
				File target = new File(uploadPath, savedFileName);
				FileCopyUtils.copy(pic.getBytes(), target);

				artisanTimeline.setOriginalFileName(originalFileName);
				artisanTimeline.setSavedFileName(savedFileName);
				
			}
			dao.insertArtisanTimeline(artisanTimeline);
			
			return true;
		}
		/*//글수정
		public Boolean updateArtisanTimeline(ArtisanTimeline artisanTimeline, MultipartFile pic) {
			return dao.updateArtisanTimeline(artisanTimeline)==1? true : false;
		}*/
		//글삭제
		public void deleteArtisanTimeline(int artisanTimelineIdx) {
			dao.deleteArtisanTimeline(artisanTimelineIdx);
		}
		//추천
		public void RecommendArtisanTimeline(int artisanTimelineIdx) {
			dao.RecommendArtisanTimeline(artisanTimelineIdx);
			
		}
		//즐겨찾기 추가, 카운트 증가
		public int insertArtisanBookmarkForMember(String id, String artisanId) {
			return dao.insertArtisanBookmark(id,artisanId);
		}
		
		public String getTimelineOriginalFileName(int artisanTimelineIdx) {
			return dao.getTimelineOriginalFileName(artisanTimelineIdx);
		}
		public Map<String, String> getArtisanInfoOriginalFileName(String artisanId) {
			return dao.getArtisanInfoOriginalFileName(artisanId);
		}
		/*public Map<String, Object> updateArtisanTimelineForm(int artisanTimelineIdx) {
			ArtisanTimeline artisanTimeline = dao.updateArtisanTimelineForm(artisanTimelineIdx);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("artisanTimeline", artisanTimeline);
			return map;
		}*/
		
		// 작가 즐겨찾기 여부 확인
		public ArtisanBookmark isFollow(String id, String artisanId) {
			return dao.isFollow(id,artisanId);
		}
	

}
