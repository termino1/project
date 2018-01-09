package com.icia.bachida.controller;


import java.io.*;
import java.security.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;


@Controller
@RequestMapping("/bookmarkArtisan")
public class ArtisanBookmarkController {
	@Autowired ArtisanBookmarkService service;
	@Autowired Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
		// 즐겨찾는 작가 목록
		@PreAuthorize("isAuthenticated()")
		@GetMapping("/bookmark_list")
		public String listArtisanBookmark(Model model,@RequestParam(defaultValue = "1") int pageno,ArtisanBookmark bookmark,Principal principal) {
			model.addAttribute("map", gson.toJson(service.listArtisanBookmark(principal.getName(),pageno,bookmark)));
			model.addAttribute("viewName", "mypage.jsp");
			model.addAttribute("mypage", "member/listBookmark.jsp");
			return "index";
		}	

		/*// 즐겨찾는 작가 추가
		@PostMapping("/add_boomark")
		public ResponseEntity<Map<String, Object>> insertArtisanBookmark(ArtisanBookmark bookmark) {
			System.out.println(bookmark);
			return new ResponseEntity<Map<String, Object>>(service.insertArtisanBookmark(bookmark), HttpStatus.OK);
		}*/
		
		//삭제 
		@PostMapping("/delete_bookmark")
		public ResponseEntity<Integer> deleteArtisanBookmark(int artisanBookmarkIdx) {
			System.out.println(artisanBookmarkIdx);
			return new ResponseEntity<Integer>(service.deleteArtisanBookmark(artisanBookmarkIdx),HttpStatus.OK);
		}
		
}
