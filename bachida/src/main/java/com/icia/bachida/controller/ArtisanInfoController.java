package com.icia.bachida.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;


@Controller
public class ArtisanInfoController {
	@Autowired
	private ArtisanInfoService service;
	@Autowired
	private Gson gson;
	
	@GetMapping("/artisan/infoUpdate")
	public String artisanInfoUpdate(String artisanId, Model model) {
		model.addAttribute("artisan", gson.toJson(service.getArtisanInfo(artisanId)));
		model.addAttribute("viewName", "artisan_2/artisanInfo.jsp");
		return "artisanHome";
	}
	
	@PostMapping("/artisan/infoUpdate")
	public String artisanInfoUpdate(Artisan artisan, @RequestParam(required = false) MultipartFile file,RedirectAttributes ra) {
		service.artisanInfoUpdate(artisan,file);
		ra.addAttribute("artisanId",artisan.getArtisanId());
		return "redirect:/artisantimeline/timeline_list";
	}
	
	// 작가명 중복확인
	@PostMapping("/artisan/nameCheck")
	public ResponseEntity<Boolean> nameCheck(String artisanName) {
		boolean result = service.nameCheck(artisanName);
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
}
