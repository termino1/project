package com.icia.bachida.controller;


import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.google.gson.*;
import com.icia.bachida.service.*;

@Controller
@RequestMapping("/artisan/sales")
public class SalesMangementController {
	@Autowired private SalesManagementService service;
	@Autowired Gson gson;

	/*@GetMapping({"/","/indexArtisan"})
	public String home(Model model) {
		model.addAttribute("viewName","indexArtisan.jsp");
		return "indexArtisan";
	}*/
	//리스트 (매출액, 공제액, 총매출액 )
	@GetMapping("/figures_list")
	public String listSalesManagement(@RequestParam(defaultValue="1") int pageno, Model model, String artisanId) {
		/*String temp = gson.toJson(service.listSalesManagement(pageno));
		System.err.println(temp);*/
		//artisanId = "sanggongin";
		model.addAttribute("map",gson.toJson(service.listSalesManagement(pageno,artisanId)));
		model.addAttribute("viewName", "artisan/listSalesManagement.jsp");
		return "artisanHome";
	}
	
	/*@GetMapping("sa")*/
	
	
}
