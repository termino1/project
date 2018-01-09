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
@RequestMapping("/product")
public class UProductController {
	@Autowired
	private UProductService service;
	@Autowired
	private Gson gson;

	// 상품리스트
	@GetMapping("/{mainCategoryIdx}/{metaCategoryIdx}")
	public String getProductList(Model model, @PathVariable int mainCategoryIdx, @PathVariable int metaCategoryIdx,@RequestParam(defaultValue="1") int pageno,Principal principal) { // principal
		String id="";
		if(principal != null) {
			 id = principal.getName();
		}else
			id = "guest";
		model.addAttribute("product", gson.toJson(service.getProductList(mainCategoryIdx, metaCategoryIdx, id,pageno)));
		model.addAttribute("viewName", "product/list_product.jsp");
		return "index";
	}
	@GetMapping("/{mainCategoryIdx}/{metaCategoryIdx}/{num}")
	public String getProductList(Model model, @PathVariable int mainCategoryIdx, @PathVariable int metaCategoryIdx,@RequestParam(defaultValue="1") int pageno,Principal principal,@PathVariable int num) { // principal
		String id="";
		if(principal != null) {
			 id = principal.getName();
		}else
			id = "guest";
		model.addAttribute("product", gson.toJson(service.getProductList(mainCategoryIdx, metaCategoryIdx, id,pageno,num)));
		model.addAttribute("viewName", "product/list_product.jsp");
		return "index";
	}

	// 상품보기
	@GetMapping("/getProduct/{productIdx}")
	public String getProduct(Model model, @PathVariable int productIdx,Principal principal) {// principal
		String id="";
		if(principal != null) {
			 id = principal.getName();
		}else
			id = "guest";
		model.addAttribute("productView", gson.toJson(service.getProduct(productIdx, id)));
		model.addAttribute("principal", gson.toJson(id));
		model.addAttribute("viewName", "product/view_product.jsp");
		return "index";
	}

	// 즐겨찾는 상품 목록
	@GetMapping("/choose_product")
	public String chooseProduct(Model model,Principal principal) {
		String id="";
		if(principal != null) {
			 id = principal.getName();
		}else {
			return "redirect:/user/login";
		}
		model.addAttribute("chooseProduct", gson.toJson(service.chooseProduct(principal.getName())));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "product/chooseProduct.jsp");
		return "index";
	}

	// 상품찜하기 취소
	@PostMapping("/deleteChooseProduct")
	public ResponseEntity<Map<String, Object>> deleteChooseProduct(int productIdx, Principal principal) {
		String id = principal.getName();
		return new ResponseEntity<Map<String, Object>>(service.deleteChooseProduct(productIdx, id), HttpStatus.OK);
	}

	// 즐겨찾는상품 추가
	@PostMapping("/choose_add")
	public ResponseEntity<Map<String, Object>> insertChooseProduct(ProductBookmark bookmark ,Principal principal) {
		System.out.println(bookmark);
		bookmark.setId(principal.getName());
		return new ResponseEntity<Map<String, Object>>(service.insertChooseProduct(bookmark), HttpStatus.OK);
	}

	// 바로주문 - 주문하기 이동
	@GetMapping("/orderProductMove")
	public String orderProduct(Model model,Principal principal, CartProduct cartProduct) {
		String id = principal.getName();
		System.out.println(cartProduct+"===--+---");
		model.addAttribute("orderOne", gson.toJson(service.orderProductMove(id,cartProduct)));
		model.addAttribute("viewName", "product/orderProduct.jsp");
		return "index";
	}

	// 바로주문-주문하기
	@PostMapping("/orderProductWrite") 
	public String orderProductWrite (Principal principal,OrderProduct orderproduct,Order order) { 
		System.out.println(order);
		String id = principal.getName();
		service.orderProductWrite(id,orderproduct,order); 
		return "redirect:/";
	}
	// 장바구니 주문이동
		@GetMapping("/cart_order")
		public String cartOrder(Principal principal,@RequestParam(value="cartProductIdx") List<Integer> cartProductIdx,Model model) {
			String id = principal.getName();
			model.addAttribute("orderList", gson.toJson(service.CartOrderMove(id,cartProductIdx)));
			model.addAttribute("viewName", "product/cartOrder.jsp");
			return "index";
			
	}
	// 장바구니- 주문
	@PostMapping("/cartOrderWrite") 
	public String cartOrderWrite (Principal principal,OrderProduct orderproduct,Order order,@RequestParam(value="cartProductIdx") List<Integer> cartProductIdx) { 
		String id = principal.getName();
		service.cartOrderWrite(id, orderproduct, order, cartProductIdx);
		return	"redirect:/";
	}	
	// 장바구니 보기
	@GetMapping("/view_cart")
	public String cartProductList(Model model,Principal principal, Integer cartIdx,Integer cartProductIdx) {
		String id="";
		if(principal != null) {
			 id = principal.getName();
		}else {
			return "redirect:/user/login";
		}
		model.addAttribute("cartlist", gson.toJson(service.cartProductList(id,cartIdx,cartProductIdx)));
		model.addAttribute("viewName", "product/cart.jsp");
		return "index";
	}

	// 장바구니 담기   -> 성공하면 장바구니이동? Y -> cartIdx??
	/*@PostMapping("/put_cart")
	public String putCart(Principal principal,Cart cart,CartProduct cartproduct,Integer cartProductIdx) {// principal
		String id = principal.getName();
		cart.setId(principal.getName());
		System.out.println(id + "55555555555555555555555");
		service.putCart(id,cart,cartproduct,cartProductIdx);
		return "redirect:/product/getProduct/"+ cartproduct.getProductIdx();
	}*/
	@PostMapping("/put_cart")
	public ResponseEntity<Integer> putCart(Principal principal,Cart cart,CartProduct cartproduct,Integer cartProductIdx) {// principal
		String id = principal.getName();
		cart.setId(principal.getName());
		System.out.println(id + "55555555555555555555555");
		int result = service.putCart(id,cart,cartproduct,cartProductIdx);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	// 장바구니 삭제
	@PostMapping("/delete_cart")
	public ResponseEntity<Void> deleteCart(@RequestParam(value="checkboxArray[]") List<Integer> idxList) {
		System.out.println(idxList +"controller============");
		return new ResponseEntity<Void>(service.deleteCart(idxList), HttpStatus.OK);
	}
	// 캐쉬충전
	@PostMapping("/cashCharge")
	public ResponseEntity<Void> cashCharge(int cash,Principal principal){
		String id= principal.getName();
		service.cashCharge(id, cash);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
}
