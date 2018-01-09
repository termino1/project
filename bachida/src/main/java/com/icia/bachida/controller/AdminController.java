package com.icia.bachida.controller;

import javax.jws.WebParam.*;

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
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private ArtisanInfoService infoService;
	@Autowired
	private UserService userService;
	@Autowired
	private Gson gson;
	
	//회원전체내역
	@GetMapping("/userList")
	public String userList(@RequestParam(defaultValue="1")int pageno, Model model) {
		model.addAttribute("map", gson.toJson(adminService.getAlluser(pageno)));
		model.addAttribute("viewName", "admin/userList.jsp");
		return "adminHome";
	}
	
	//회원정보보기
	@PostMapping("/userView")
	public String userView(String id,Model model) {
		model.addAttribute("viewName", "admin/userView.jsp");
		model.addAttribute("user", gson.toJson(adminService.getUser(id)));
		return "adminHome";
	}
	
	//회원차단하기
	@PostMapping("/blockUser")
	public ResponseEntity<Void> blockUser(String id){
		adminService.blockUser(id);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//작가신청글내역
	@GetMapping("/applyList")
	public String applyList(@RequestParam(defaultValue="1")int pageno, Model model) {
		model.addAttribute("map", gson.toJson(adminService.allApplyList(pageno)));
		model.addAttribute("viewName", "admin/applyList.jsp");
		return "adminHome";
	}
	
	//작가신청보기
	@GetMapping("/applyView")
	public String applyView(int artisanApplyIdx,Model model) {
		model.addAttribute("apply", gson.toJson(userService.getApplyByIdx(artisanApplyIdx)));
		model.addAttribute("viewName", "admin/applyView.jsp");
		return "adminHome";
	}
	
	//작가신청허가 apply
	@PostMapping("/permitApply")
	public ResponseEntity<Void> permitApply(ArtisanApply apply){
		adminService.permitApply(apply);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//작가신청반려
	@PostMapping("/returnApply")
	public ResponseEntity<Void> returnApply(int artisanApplyIdx){
		adminService.returnApply(artisanApplyIdx);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//신고글목록
	@GetMapping("/reportList")
	public String repostList(@RequestParam(defaultValue="1")int pageno,Model model) {
		model.addAttribute("map", gson.toJson(adminService.allReportList(pageno)));
		model.addAttribute("viewName", "admin/reportList.jsp");
		return "adminHome";
	}
	
	//신고글보기
	@GetMapping("/reportView")
	public String reportView(int reportIdx,Model model) {
		model.addAttribute("report", gson.toJson(adminService.getReportByReportIdx(reportIdx)));
		model.addAttribute("viewName", "admin/reportView.jsp");
		return "adminHome";
	}
	
	//신고글회원 경고
	@PostMapping("/reportWarning")
	public ResponseEntity<Void> reportWarning(Report report){
		adminService.reportWarning(report);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//신고글회원 차단
	@PostMapping("/reportBlock")
	public ResponseEntity<Void> reportBlock(Report report){
		adminService.reportBlock(report);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//차단회원내역
	@GetMapping("/blockUserList")
	public String reportUserList(@RequestParam(defaultValue="1")int pageno,Model model) {
		model.addAttribute("map", gson.toJson(adminService.blockUserList(pageno)));
		model.addAttribute("viewName", "admin/userList.jsp");
		return "adminHome";
	}
	
	//회원차단해제
	@PostMapping("/clearblockUser")
	public ResponseEntity<Void> clearblockUser(String id){
		adminService.clearblockUser(id);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//주문내역
	@GetMapping("/orderProductList")
	public String orderProductList(@RequestParam(defaultValue="1")int pageno,Model model) {
		model.addAttribute("map", gson.toJson(adminService.getAllOrderProduct(pageno)));
		model.addAttribute("viewName", "admin/orderProductList.jsp");
		return "adminHome";
	}
	
	//상품평관리
	@GetMapping("/productCommentList")
	public String productCommentList(@RequestParam(defaultValue="1")int pageno,Model model) {
		model.addAttribute("map", gson.toJson(adminService.getAllComment(pageno)));
		model.addAttribute("viewName", "admin/productCommentList.jsp");
		return "adminHome";
	}
	
	@GetMapping("/artisanInfo")
	public ResponseEntity<Artisan> artisanInfo(String id){
		return new ResponseEntity<Artisan>(infoService.getArtisanInfo(id),HttpStatus.OK);
	}
}
