package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;



@Repository
public class ArtisanBookmarkDao {
	
	@Autowired SqlSessionTemplate tpl;
	//북마크 갯수
	public int getBookmarkCnt(String id) {
		return tpl.selectOne("bookmarkMapper.getBookmarkCnt",id);
	}
	
	 //북마크 작가 리스트
	public List<ArtisanBookmark> listArtisanBookmark(int startArticleNum, int endArticleNum, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum",startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("bookmarkMapper.listArtisanBookmark",map);
	}

	
	//북마크 삭제
	public int deleteArtisanBookmark(int artisanBookmarkIdx) {
		return tpl.delete("bookmarkMapper.deleteArtisanBookmark",artisanBookmarkIdx);
	}
	
	/*
	//북마크 추가
	public int insertArtisanBookmark(ArtisanBookmark bookmark) {
		return tpl.insert("bookmarkMapper.insertArtisanBookmark",bookmark);
	}
*/
	

	

	

	

	
	
}
