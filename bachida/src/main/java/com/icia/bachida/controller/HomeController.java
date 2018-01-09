package com.icia.bachida.controller;

import java.security.*;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;

@Controller
public class HomeController {
	@Autowired
	private ProductService service;
	@Autowired
	private MainService mainservice;
	@Autowired
	private UserService userService;
	@Autowired
	private Gson gson;
	
	@GetMapping("/")
	public String index(Model model,Principal principal,HttpSession session) {
		String userInfo="";
		if(principal != null) {
			User user = userService.getUserInfo(principal.getName());
			userInfo = gson.toJson(user);
			List<Interest> interests = user.getInterests();
			model.addAttribute("recommendList", gson.toJson(mainservice.getRecommendProductlist(interests)));
			model.addAttribute("activeBookmark",  gson.toJson(mainservice.activeBookmark(principal.getName())));
		}else {
			userInfo = gson.toJson("guest");
			model.addAttribute("recommendList", "없음");
			model.addAttribute("activeBookmark", "없음");
		}
		model.addAttribute("viewName","main.jsp");
		//model.addAttribute("mainList", service.getMainCategoryName());
		//model.addAttribute("metaList", service.getMetaCategoryName());
		model.addAttribute("user", userInfo);
		session.setAttribute("user", userInfo);
		model.addAttribute("recentList", gson.toJson(mainservice.getRecentProductList()));
		model.addAttribute("popularList", gson.toJson(mainservice.getPopularProductList()));
		model.addAttribute("mainList", service.getMainCategoryName());
		
		return "index";
	}
	
	@PostMapping("/userInfo")
	public ResponseEntity<User> userInfo(Principal principal){
		User user = new User();
		if(principal != null) {
			user = userService.getUserInfo(principal.getName());
		}else {
			user.setId("guest");
		}
		return new ResponseEntity<User>(user,HttpStatus.OK);
	}
	
	@GetMapping("/init")
	public ResponseEntity<Map<String,String>> init(){
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mainList", service.getMainCategoryName());
		map.put("metaList", service.getMetaCategoryName());
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
	@GetMapping("/artisanHome/check")
	public Boolean artisanCheck(Principal principal,String artisanId) {
		if(principal.getName()==artisanId)
			return true;
		else
			return false;
	}
	
	@GetMapping("/mypage")
	public String mypage(Model model,Principal principal) {
		model.addAttribute("name", gson.toJson(principal.getName()));
		model.addAttribute("map", gson.toJson(userService.myPageMain(principal.getName())));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "mypageMain.jsp");
		return "index";
	}
	
	@PostMapping("/getUnreadMessage")
	public ResponseEntity<Integer> getMessageCnt(String id){
		int result = mainservice.getMessageCnt(id);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
