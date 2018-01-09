package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;



@Service
public class ArtisanBookmarkService {
	@Autowired ArtisanBookmarkDao dao;
	
	
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> listArtisanBookmark(String id, int pageno, ArtisanBookmark bookmark) {
		int bookmarkCnt = dao.getBookmarkCnt(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, bookmarkCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("bookmark", dao.listArtisanBookmark(id));
		
		map.put("pagination", pagination);
		map.put("bookmarkList", dao.listArtisanBookmark(pagination.getStartArticleNum(),pagination.getEndArticleNum(),id));
		map.put("bookmarkCnt", bookmarkCnt);
		return map;
	}


/*
	public Map<String, Object> insertArtisanBookmark(ArtisanBookmark bookmark) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("insertBookmark", dao.insertArtisanBookmark(bookmark)==1? true:false);
		return map;
	}
*/


	public int deleteArtisanBookmark(int artisanBookmarkIdx) {
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("deleteBookmark", dao.deleteArtisanBookmark(artisanBookmarkIdx, id));
		return null;*/
		return dao.deleteArtisanBookmark(artisanBookmarkIdx);
	}
	
	
	
	
}
