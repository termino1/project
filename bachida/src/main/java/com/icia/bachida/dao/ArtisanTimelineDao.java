package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;
@Repository
public class ArtisanTimelineDao {
	@Autowired private SqlSessionTemplate tpl;
	//타임라인 갯 수
		public int getArtisanTimelineCnt(String artisanId) {
			return tpl.selectOne("artisanTimelineMapper.getArtisanTimelineCnt",artisanId);
		}
		//리스트
		public List<ArtisanTimeline> listArtisanTimeline(int startArticleNum, int endArticleNum, String artisanId) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startArticleNum", startArticleNum);
			map.put("endArticleNum", endArticleNum);
			map.put("artisanId", artisanId);
			return tpl.selectList("artisanTimelineMapper.listArtisanTimeline",map);
		}
		//타임라인 작성
		public void insertArtisanTimeline(ArtisanTimeline artisanTimeline) {
			tpl.insert("artisanTimelineMapper.insertArtisanTimeline",artisanTimeline);
		}
		/*//수정
		public int updateArtisanTimeline(ArtisanTimeline artisanTimeline) {
			return tpl.update("artisanMapper.updateArtisanTimeline", artisanTimeline);
		}*/
		//삭제
		public int deleteArtisanTimeline(int artisanTimelineIdx) {
			return tpl.delete("artisanTimelineMapper.deleteArtisanTimeline",artisanTimelineIdx);
		}
		//타임라인 추천수
		public int RecommendArtisanTimeline(int artisanTimelineIdx) {
			return tpl.update("artisanTimelineMapper.RecommendArtisanTimeline",artisanTimelineIdx);
		}
		//작가 북마크 추가
		public int insertArtisanBookmark(String id, String artisanId) {
			ArtisanBookmark bookmark = new ArtisanBookmark();
			bookmark.setArtisanId(artisanId);
			bookmark.setId(id);
			return tpl.insert("artisanTimelineMapper.insertArtisanBookmark",bookmark);
		}
		public Artisan artisanInfo(String artisanId) {
			return tpl.selectOne("artisanTimelineMapper.artisanInfo",artisanId);
		}
		public String getTimelineOriginalFileName(int artisanTimelineIdx) {
			
			return tpl.selectOne("artisanTimelineMapper.getTimelineOriginalFileName",artisanTimelineIdx);
		}
		public Map<String, String> getArtisanInfoOriginalFileName(String artisanId) {
			return tpl.selectOne("artisanTimelineMapper.getArtisanInfoOriginalFileName",artisanId);
		}
		// 작가 즐겨찾기 여부
		public ArtisanBookmark isFollow(String id, String artisanId) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("artisanId", artisanId);
			return tpl.selectOne("artisanTimelineMapper.isFollow",map);
		}
		
		/*public ArtisanTimeline updateArtisanTimelineForm(int artisanTimelineIdx) {
			return tpl.selectOne("artisanMapper.updateArtisanTimelineForm",artisanTimelineIdx);
		}*/

}
