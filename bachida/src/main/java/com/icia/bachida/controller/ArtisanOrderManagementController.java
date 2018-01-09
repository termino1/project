package com.icia.bachida.controller;

import java.security.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;

@Controller
@RequestMapping("/artisan/orderManagement")
public class ArtisanOrderManagementController {
	@Autowired
	private OrderManagementService service;
	@Autowired
	private Gson gson;

	//리스트 불러오기
	@GetMapping("/list")
	public String getOrderList(Principal principal , Model model, @RequestParam(defaultValue="1") int pageno){ 
		String id = principal.getName();
		System.out.println(id);
		model.addAttribute("map",gson.toJson(service.getOrderList(id, pageno)));
		model.addAttribute("viewName", "artisan_2/orderList.jsp");
		return "artisanHome";
	}
	
	// 제작처리
	@PostMapping("/production_process")
	public ResponseEntity<Boolean> updateProductionProcessing(@RequestParam(value = "checkboxArray[]")List<Integer> checkbox) {
		boolean result = service.updateProductionProcessing(checkbox);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	// 기간별 조회 (리스트)
	@GetMapping("/listByDate")
	public ResponseEntity<Map<String, Object>> getOrderListByDate(Principal principal, @RequestParam(defaultValue="1") int pageno, int searchDate) {
		String id = principal.getName();
		return new ResponseEntity<Map<String,Object>>(service.getOrderListByDate(id,pageno,searchDate),HttpStatus.OK);
	}
	
	// 상태별 조회
	
	@PostMapping("/listByState")
	public ResponseEntity<Map<String , Object>> getOrderListByState(Principal principal, @RequestParam(defaultValue="1") int pageno, String state){// principal
		String id = principal.getName();
		return new ResponseEntity<Map<String,Object>>(service.getOrderListByState(id,pageno,state),HttpStatus.OK);
	}
	
	// 정렬
	@PostMapping("/sort")
	public ResponseEntity<Map<String, Object>> getOrderByList(Principal principal, @RequestParam(defaultValue="1") int pageno, String state, String orderby, String sort){
		String id = principal.getName();
		return new ResponseEntity<Map<String,Object>>(service.getOrderByList(id,pageno,state,orderby,sort),HttpStatus.OK);
	}
	// 배송정보 입력, 상태 변경
	@PostMapping("/delivery_insert")
	public ResponseEntity<Boolean> insertParcelAndUpdateState(Principal principal ,OrderProduct orderProduct,@RequestParam(required=false) String parcelTotal){
		return new ResponseEntity<Boolean>(service.insertParcelAndUpdateState(orderProduct, parcelTotal,principal.getName()),HttpStatus.OK);
	}
	
	// 주문번호별 주문확인하기
	@PostMapping("/listByOrdersIdx")
	public ResponseEntity<Map<String,Object>> getListByOrdersIdx(int ordersIdx){
		return new ResponseEntity<Map<String,Object>>(service.getListByOrdersIdx(ordersIdx), HttpStatus.OK);
	}
	
}
