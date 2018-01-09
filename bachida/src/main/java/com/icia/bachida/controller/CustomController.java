package com.icia.bachida.controller;


import java.security.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;

@Controller
@RequestMapping("/custom")
public class CustomController {
	@Autowired
	private CustomService service;
	@Autowired
	private Gson gson;
	
	@GetMapping("/list")
	public String getCustomRequestList(Model model, @RequestParam(defaultValue="1") int pageno) {
		model.addAttribute("map",gson.toJson(service.getCustomRequestList(pageno)));
		model.addAttribute("viewName","custom/list.jsp");
		return "index";
	}

	@PreAuthorize("#writer == principal.username or hasRole('ROLE_MANAGER')")
	@GetMapping("/view")
	public String getCustomRequest(int customIdx, Model model , Principal principal , String writer) {
		model.addAttribute("map", gson.toJson(service.getCustomRequest(customIdx)));
		model.addAttribute("name",gson.toJson(principal.getName()));
		model.addAttribute("viewName","custom/view.jsp");
		return "index";
	}

	// 제작요청글작성 폼이동
	@GetMapping("/write")
	public String writeCustomRequest(Model model) {
		model.addAttribute("viewName","custom/write.jsp");
		return "index";
	}
	// 작성
	@PostMapping("/write")				
	public String writeCustomRequest(Custom custom, @RequestParam(required = false) MultipartFile file, Principal principal) {
		custom.setId(principal.getName());  
		service.writeCustomRequest(custom,file);
		return "redirect:/custom/list";  
	}

	// 입찰등록 ajax
	@PostMapping("/write_bid")
	public ResponseEntity<Map<String,Object>> writeBid(Bid bid,@RequestParam(required = false) MultipartFile[] files,Principal principal ){
		bid.setArtisanId(principal.getName()); // 로그인한 작가 아이디 set
		service.writeBid(bid,files);
		Map<String, Object> bidList = service.getBidList(bid.getCustomIdx());
		// 새로운 입찰리스트 전송;
		return new ResponseEntity<Map<String,Object>>(bidList,HttpStatus.OK);
	}
	
	
	// 작가 홈 입찰 리스트
	
	//요청수정 (수량, 가격, 내용, 제목)
	@GetMapping("/update_custom")
	public String updateCustom(int customIdx,Model model) {
		model.addAttribute("map", gson.toJson(service.getCustomRequest(customIdx)));
		model.addAttribute("viewName","custom/update.jsp");
		return "index";
	}
	
	@PostMapping("/update_custom")
	public String updateCustom(Custom custom,RedirectAttributes ra) {
		System.out.println(custom);
		service.updateCustom(custom);
		ra.addAttribute("customIdx",custom.getCustomIdx());
		ra.addAttribute("writer",custom.getId());
		return "redirect:/custom/view";
	}
	
	@PostMapping("/delete_custom")
	public ResponseEntity<Boolean> deleteCustom(int customIdx, Principal principal) { 	
		boolean result = service.deleteCustom(customIdx,principal.getName());
		if(result)
			return new ResponseEntity<Boolean>(result, HttpStatus.OK);
		else
			return new ResponseEntity<Boolean>(result, HttpStatus.NOT_FOUND);
	}
	
	// 낙찰  
	@PostMapping("/bid_successful")
	public ResponseEntity<Boolean> bid_successful(int bidIdx,Principal principal){
		boolean result = service.bid_successful(bidIdx,principal.getName());
		if(result)
			return new ResponseEntity<Boolean>(result,HttpStatus.OK);
		else
			return new ResponseEntity<Boolean>(result,HttpStatus.NOT_FOUND);
	}
	
	//요청글 상태에 따른 리스트
	@GetMapping("/state")
	public ResponseEntity<Map<String, Object>> changeStateList( @RequestParam(defaultValue="1") int pageno, String state){
		return new ResponseEntity<Map<String,Object>>(service.getChangeStateList(pageno,state),HttpStatus.OK);
	}
}
