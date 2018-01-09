package com.icia.bachida.controller;

import java.security.*;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;

@Controller
public class CustomizeController {
	@Autowired
	private CustomizeService service;
	@Autowired
	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	@GetMapping("/customize/bid_list")
	public String BidList(Model model, @RequestParam(defaultValue="1") int pageno,Principal principal) {	// principal
		String id = principal.getName();
		model.addAttribute("map", gson.toJson(service.getBidList(id,pageno)));
		model.addAttribute("viewName", "customize/bidList.jsp");
		return "artisanHome";
	}
	
	@GetMapping("/customize/custom_order")
	public String customOrder(int bidIdx, Model model,Principal principal, String artisanId ,HttpSession session) {
		model.addAttribute("map", gson.toJson(service.getProductionOrder(bidIdx,principal.getName())));
		model.addAttribute("name",gson.toJson(principal.getName()));
		model.addAttribute("viewName", "customize/custom_order.jsp");
		session.setAttribute("map", gson.toJson(service.getArtisanInfo(artisanId)));
		session.setAttribute("name", gson.toJson(principal.getName()));
		return "artisanHome";
	}
	
	@PostMapping("/customize/write_opinion")
	public ResponseEntity<List<CustomOpinion>> writeOpinion(CustomOpinion opinion, @RequestParam(required = false) MultipartFile file ,Principal principal){
		opinion.setId(principal.getName());
		service.writeOpinion(opinion, file);
		List<CustomOpinion> opinionList = service.getOpinionList(opinion.getBidIdx());
		return new ResponseEntity<List<CustomOpinion>>(opinionList,HttpStatus.OK);
	}
	
	
	// 제작주문 작성
	@PostMapping("/customize/write_productionOrder")
	public ResponseEntity<Boolean> writeProductionOrder(ProductionOrder order){
		boolean result = service.writeProductionOrder(order);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
	// 제작주문 주소 업데이트
	@PostMapping("/customize/write_address_productionOrder")
	public ResponseEntity<Boolean> writeAddress(String address, int productionOrderIdx){
		boolean result = service.writeAddress(address,productionOrderIdx);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
	// 유저 캐쉬정보 가져오기
	@GetMapping("/customize/user_cash")
	public ResponseEntity<String> getUsersCash(Principal principal){
		String id = principal.getName();
		String cash = service.getUsersCash(id);
		return new ResponseEntity<String>(cash,HttpStatus.OK);
	}
	// 결제, 캐쉬내역 insert, 주문상태 update
	@PostMapping("/customize/deposit_payment")
	public ResponseEntity<Boolean> depositPayment(int cash,int productionOrderIdx, Principal principal){
		String id = principal.getName();
		boolean result = service.depositAndOrderStateUpdate(id,cash,productionOrderIdx);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	//제작완료 udpate
	@PostMapping("/customize/complete_production")
	public ResponseEntity<Boolean> updateCompleteProductionState(int productionOrderIdx){
		boolean result = service.updateCompleteProductionState(productionOrderIdx);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
	// 잔금결제, 캐쉬내역 insert, 주문상태 update [결제완료]
	@PostMapping("/customize/balance_payment")
	public ResponseEntity<Boolean> balancePaymentAndUpdate(Principal principal , int balance,int productionOrderIdx, int totalPrice,String artisanId){
		String id = principal.getName();
		boolean result = service.balancePaymentAndUpdate(id, balance, productionOrderIdx, totalPrice, artisanId);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
	// 택배, 배송 상태 update
	@PostMapping("/customize/parcel_update")
	public ResponseEntity<Boolean> updateDeliveryState(int productionOrderIdx, int parcelIdx, String parcelName){
		boolean result = service.updateDeliveryState(productionOrderIdx,parcelIdx,parcelName);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}

	// 주문서 수정
	@PostMapping("/customize/update_productionOrder")
	public ResponseEntity<Boolean> updateProductionOrder(ProductionOrder order){
		boolean result = service.updateProductionOrder(order);
		return new ResponseEntity<Boolean>(result,HttpStatus.OK);
	}
	
}
