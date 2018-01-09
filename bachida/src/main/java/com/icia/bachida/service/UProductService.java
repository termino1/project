package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Service
public class UProductService {
	@Autowired
	private UProductDao dao;
	/*상품목록*/
	public Map<String, Object> getProductList(int mainCategoryIdx,int metaCategoryIdx,String id,int pageno){
		int articleCnt = dao.getProductCnt(mainCategoryIdx, metaCategoryIdx);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productCnt", dao.getProductCnt(mainCategoryIdx,metaCategoryIdx));
		map.put("mainCategoryIdx", dao.getMainCategory(mainCategoryIdx));
		map.put("metaCategoryIdx", dao.getMetaCategory(mainCategoryIdx));
		map.put("activeMetaCategory", dao.activeMetaCategory(mainCategoryIdx,metaCategoryIdx));
		map.put("productList", dao.getProductList(mainCategoryIdx,metaCategoryIdx,pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		map.put("bestProduct", dao.bestProduct(mainCategoryIdx,metaCategoryIdx));
		map.put("activeBookmark", dao.activeBookmark(id));
		map.put("selectOption", 1);
		map.put("pagination", pagination);
		
		return map;
	}
	public Map<String, Object> getProductList(int mainCategoryIdx,int metaCategoryIdx,String id,int pageno,int num){
		System.out.println("\n"+"num : "+num+"\n");
		int articleCnt = dao.getProductCnt(mainCategoryIdx, metaCategoryIdx);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num==2) {
			String condition = "productPrice";
			String sort = "asc";
			map.put("productList", dao.getProductList(mainCategoryIdx,metaCategoryIdx,pagination.getStartArticleNum(), pagination.getEndArticleNum(),condition,sort));
		}
		if(num==3) {
			String condition = "productPrice";
			String sort = "desc";
			map.put("productList", dao.getProductList(mainCategoryIdx,metaCategoryIdx,pagination.getStartArticleNum(), pagination.getEndArticleNum(),condition,sort));
		}
		if(num==4) {
			String condition = "recommend";
			String sort = "desc";
			map.put("productList", dao.getProductList(mainCategoryIdx,metaCategoryIdx,pagination.getStartArticleNum(), pagination.getEndArticleNum(),condition,sort));
		}
		map.put("productCnt", dao.getProductCnt(mainCategoryIdx,metaCategoryIdx));
		map.put("mainCategoryIdx", dao.getMainCategory(mainCategoryIdx));
		map.put("metaCategoryIdx", dao.getMetaCategory(mainCategoryIdx));
		map.put("activeMetaCategory", dao.activeMetaCategory(mainCategoryIdx,metaCategoryIdx));
		map.put("bestProduct", dao.bestProduct(mainCategoryIdx,metaCategoryIdx));
		map.put("activeBookmark", dao.activeBookmark(id));
		map.put("selectOption", num);
		map.put("pagination", pagination);
		
		return map;
	}
	/*상품상세*/
	public Map<String, Object> getProduct(int productIdx,String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("getProduct", dao.getProduct(productIdx));
		map.put("getOption", dao.getOption(productIdx));
		map.put("getArtisan", dao.getArtisan(productIdx));
		map.put("getAttachs", dao.getAttachs(productIdx));
		map.put("productComment", dao.productComment(productIdx));
		map.put("productMore", dao.productMore(dao.getProduct(productIdx).getArtisanId()));
		map.put("activeBookmarkOne", dao.activeBookmarkOne(id,productIdx));
		/*작가 즐겨찾기 여부*/
		System.out.println("실행!!!!!!!!!!!!!!!!!!!");
		map.put("isFollow", dao.isFollow(id, dao.getProduct(productIdx).getArtisanId()));
		System.out.println("================================="+dao.isFollow(id, dao.getProduct(productIdx).getArtisanId()));
		return map;
	}
	/*즐겨찾기상품목록*/
	public Map<String, Object> chooseProduct(String id){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bookmark", dao.chooseList(id));
		map.put("product", dao.chooseProductInfo(id));
		return map;
	}
	/*상품찜 취소*/
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> deleteChooseProduct(int productIdx, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deleteChooseProduct", dao.deleteChooseProduct(productIdx, id));
		map.put("decreaseProductChooseCnt", dao.decreaseProductChooseCnt(productIdx));
		return map;
	}
	/* 즐겨찾기 상품추가 */ 
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> insertChooseProduct(ProductBookmark bookmark){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("increaseProductChooseCnt", dao.increaseProductChooseCnt(bookmark.getProductIdx()));
		map.put("decreaseProductChooseCnt", dao.insertChooseProduct(bookmark)==1? true:false);
		return map;
	}
	
	/*장바구니목록*/
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> cartProductList(String id,Integer cartIdx, Integer cartProductIdx){
		Map<String, Object> map = new HashMap<String, Object>();
		if(dao.cart(id)==null) {
			Cart cart = new Cart();
			cart.setId(id);
			cart.setTotalPrice(0);
			dao.insertCart(cart);
			cartIdx = dao.cart(id).getCartIdx();
			System.out.println(cartIdx +"-------------------------------------------");
		}else {
			cartIdx = dao.cart(id).getCartIdx();
		}
		List<CartProduct> cpin = dao.cartProductIdxNo(cartIdx);
		List<CartProduct> CartProductList = new ArrayList<CartProduct>();
		CartProduct OptionProduct = new CartProduct();
		CartProduct noOptionProduct = new CartProduct();
		List<Product> product = new ArrayList<Product>();
		for (int j = 0; j < cpin.size(); j++) {
			int result = dao.isOption(cpin.get(j).getCartProductIdx());
			System.out.println(result);
			if(result!=0) {
				OptionProduct = dao.cart_Product(cpin.get(j).getCartProductIdx());
					Product p = dao.productList_cart(OptionProduct.getProductIdx());
					CartProductList.add(OptionProduct);
					product.add(p);
			}else {
				noOptionProduct = dao.noOptionProduct(cpin.get(j).getCartProductIdx());
					Product p = dao.productList_cart(noOptionProduct.getProductIdx());
					CartProductList.add(noOptionProduct);
					product.add(p);
			}
		}
		map.put("CartProduct", CartProductList);
		map.put("product", product);
		return map;

	}
	/*장바구니담기*/
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("#cart.id == principal.username")
	public int putCart(String id,Cart cart, CartProduct cartproduct,Integer cartProductIdx) {
		int totalPrice = cartproduct.getPrice();
		cart.setTotalPrice(totalPrice);
		System.out.println(cart);
		if(dao.cart(id)==null) {
			dao.insertCart(cart);
		}
		cartproduct.setCartIdx(dao.cart(id).getCartIdx());
		dao.insertCartProduct(cartproduct);
		System.out.println(cartproduct);
		List<CartOption> optionList = cartproduct.getCartOptions();
		int result = 0;
		if(optionList!=null) {
			for(CartOption co:optionList) {
				System.out.println(co);
				 result = dao.insertCartOption(co,cartproduct.getCartProductIdx());
			}
		}else
			result = 1;
		System.out.println(cartProductIdx);
		//dao.insertCartOption((CartOption) optionList,cartProductIdx);
		System.out.println(cartproduct);
		return result;
	}
	/*바로주문-주문하기 이동*/
	public Map<String, Object> orderProductMove(String id, CartProduct cartProduct) {
		Map<String, Object> map = new HashMap<String, Object>();
		Product p = dao.getProduct(cartProduct.getProductIdx());
		User u = dao.buyer(id);
		OrderProduct orderProduct = new OrderProduct();
		orderProduct.setProductName(p.getProductName());
		orderProduct.setQuantity(cartProduct.getQuantity());
		orderProduct.setOrderName(u.getName());
		orderProduct.setOrderTel(u.getTel());
		orderProduct.setOrderEmail(u.getEmail());
		orderProduct.setPrice(cartProduct.getPrice());
		orderProduct.setProductIdx(cartProduct.getProductIdx());
		map.put("artisan", p.getArtisanId());
		map.put("productPrice", p.getProductPrice());
		map.put("orderProduct", orderProduct);
		map.put("payment", u.getCash());
		if(cartProduct.getCartOptions()!=null) {
			List<CartOption> cartOptions = cartProduct.getCartOptions();
			map.put("options",cartOptions);
			}
		return map;
	}
	/*장바구니 주문이동*/
	public Map<String, Object> CartOrderMove(String id, List<Integer> cartProductIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(cartProductIdx +"service============");
		List<OrderProduct> orderProducts = new ArrayList<OrderProduct>();
		User user = dao.buyer(id);
		for (int i = 0; i < cartProductIdx.size(); i++) {
			if(dao.isOption(cartProductIdx.get(i))==0) { // 옵션이 없을때
				CartProduct c = dao.noOptionProduct(cartProductIdx.get(i));
				OrderProduct op = new OrderProduct();
				Product p = dao.getProduct(c.getProductIdx());
				op.setOrderProductIdx(c.getCartProductIdx());
				op.setProductName(p.getProductName());
				op.setQuantity(c.getQuantity());
				op.setOrderName(user.getName());
				op.setOrderTel(user.getTel());
				op.setOrderEmail(user.getEmail());
				op.setPrice(c.getPrice());
				op.setProductIdx(c.getProductIdx());
				op.setArtisanId(p.getArtisanId());
				orderProducts.add(op);
			}else { // 옵션이 있을때
				CartProduct c = dao.cart_Product(cartProductIdx.get(i));
				OrderProduct op = new OrderProduct();
				Product p = dao.getProduct(c.getProductIdx());
				op.setOrderProductIdx(c.getCartProductIdx());
				op.setProductName(p.getProductName());
				op.setQuantity(c.getQuantity());
				op.setOrderName(user.getName());
				op.setOrderTel(user.getTel());
				op.setOrderEmail(user.getEmail());
				op.setPrice(c.getPrice());
				op.setProductIdx(c.getProductIdx());
				op.setArtisanId(p.getArtisanId());
				List<OrderOption> oo = new ArrayList<OrderOption>(); 
				for (int j = 0; j < c.getCartOptions().size(); j++) {
					OrderOption o = new OrderOption();
					o.setOptionContent(c.getCartOptions().get(j).getOptionContent());
					o.setCost(c.getCartOptions().get(j).getCost());
					o.setOptionQuantity(c.getCartOptions().get(j).getOptionQuantity());
					oo.add(o);
				}
				op.setOptions(oo);
				orderProducts.add(op);
			}
		}
		System.out.println(orderProducts);
		map.put("orderList", orderProducts);
		map.put("payment", user.getCash());
		return map;
	}
	/*바로주문*/
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("isAuthenticated()")
	public Boolean orderProductWrite(String id,OrderProduct orderproduct, Order order) {
		int ordersIdx = dao.getOrdersIdx();
		int orderProductIdx = dao.getOrderProductIdx();
		order.setOrdersIdx(ordersIdx);
		orderproduct.setOrderProductIdx(orderProductIdx);
		order.setId(id);
		dao.insertOrder(order); // insert된 order
		orderproduct.setOrdersIdx(ordersIdx);
		dao.insertProductOrderOne(orderproduct);
		List<OrderOption> option= orderproduct.getOptions();
		if(option!=null) {
			for (int i = 0; i < option.size(); i++) {
				option.get(i).setOrderProductIdx(orderProductIdx);
				dao.insertProductOrderOption(option.get(i));
			}
		}
		System.out.println(option);
		/*캐쉬차감*/
		dao.updateCash(id, order.getTotalPrice());
		dao.insertCash(id, order.getTotalPrice());
		dao.updateArtisanCash(orderproduct.getArtisanId(), (int)(order.getTotalPrice()*0.95));
		dao.insertArtisanCash(orderproduct.getArtisanId(), (int)(order.getTotalPrice()*0.95));
		return true;
	}
	/* 장바구니-주문 */
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("isAuthenticated()")
	public Boolean cartOrderWrite(String id,OrderProduct orderproduct, Order order,List<Integer> cartProductIdx) {
		order.setId(id);
		int ordersIdx = dao.getOrdersIdx();
		order.setOrdersIdx(ordersIdx);
		order.setId(id);
		order.setOrderQuantity(cartProductIdx.size());
		order.setTotalPrice(order.getTotalPrice());
		order.setAddress(order.getAddress());
		order.setOrderQuantity(order.getOrderQuantity());
		dao.insertOrder(order);
		for (int i = 0; i < cartProductIdx.size(); i++) {
			if(dao.isOption(cartProductIdx.get(i))==0) {
				int orderProductIdx = dao.getOrderProductIdx();
				CartProduct c = dao.noOptionProduct(cartProductIdx.get(i));
				OrderProduct op = new OrderProduct();
				Product p = dao.getProduct(c.getProductIdx());
				op.setOrderProductIdx(orderProductIdx);
				op.setProductName(p.getProductName());
				op.setQuantity(c.getQuantity());
				op.setOrderName(orderproduct.getOrderName());
				op.setOrderTel(orderproduct.getOrderTel());
				op.setOrderEmail(orderproduct.getOrderEmail());
				op.setAddress(orderproduct.getAddress());
				op.setOrdersIdx(ordersIdx);
				op.setPrice(c.getPrice());
				op.setProductIdx(c.getProductIdx());
				op.setArtisanId(p.getArtisanId());
				dao.insertProductOrderOne(op);
				/*캐쉬차감*/
				dao.updateCash(id, c.getPrice());
				dao.insertCash(id, c.getPrice());
				dao.updateArtisanCash(p.getArtisanId(), (int)(c.getPrice()*0.95));
				dao.insertArtisanCash(p.getArtisanId(), (int)(c.getPrice()*0.95));
				System.out.println((int)(c.getPrice()*0.95)+": 333333333333333333333333333999999999");
				
				System.out.println(op + "99999999999999999999");
				
			}else {
				int orderProductIdx = dao.getOrderProductIdx();
				CartProduct c = dao.cart_Product(cartProductIdx.get(i));
				OrderProduct op = new OrderProduct();
				Product p = dao.getProduct(c.getProductIdx());
				op.setOrderProductIdx(orderProductIdx);
				op.setProductName(p.getProductName());
				op.setQuantity(c.getQuantity());
				op.setOrderName(orderproduct.getOrderName());
				op.setOrderTel(orderproduct.getOrderTel());
				op.setOrderEmail(orderproduct.getOrderEmail());
				op.setAddress(orderproduct.getAddress());
				op.setOrdersIdx(ordersIdx);
				op.setPrice(c.getPrice());
				op.setProductIdx(c.getProductIdx());
				op.setArtisanId(p.getArtisanId());
				dao.insertProductOrderOne(op);
				/*캐쉬차감*/
				dao.updateCash(id, c.getPrice());
				dao.insertCash(id, c.getPrice());
				dao.updateArtisanCash(p.getArtisanId(), (int)(c.getPrice()*0.95));
				dao.insertArtisanCash(p.getArtisanId(), (int)(c.getPrice()*0.95));
				System.out.println((int)(c.getPrice()*0.95)+": 333333333333333333333333333999999999");
				for (int j = 0; j < c.getCartOptions().size(); j++) {
					OrderOption o = new OrderOption();
					o.setOrderProductIdx(orderProductIdx);
					o.setOptionContent(c.getCartOptions().get(j).getOptionContent());
					o.setCost(c.getCartOptions().get(j).getCost());
					o.setOptionQuantity(c.getCartOptions().get(j).getOptionQuantity());
					dao.insertProductOrderOption(o);
				}
				System.out.println(op + "777777777777777777");
			}
		}
		/*장바구니비우기*/
		for (int i = 0; i < cartProductIdx.size(); i++) {
			dao.cartProductDelete(cartProductIdx.get(i));
			dao.cartOptionDelete(cartProductIdx.get(i));
		}
		System.out.println("장바구니삭제 : 66666666666666666666666666");
		
		return true;
	}
	/*장바구니삭제*/
	@Transactional
	@PreAuthorize("isAuthenticated()")
	public Void deleteCart(List<Integer> idxList) {
		for (int i = 0; i < idxList.size(); i++) {
			dao.cartProductDelete(idxList.get(i));
			dao.cartOptionDelete(idxList.get(i));
		}
		return null;
	}
	// 구매자 캐쉬 정보 가져오기(아이디, 캐쉬)
	@PreAuthorize("#id == principal.username")
	public int getCashByMember(String id) {
		return dao.getCashByMember(id);
	}

	/*// 구매자 캐쉬 업데이트
	@PreAuthorize("#id == principal.username")
	@Transactional(rollbackFor=Exception.class)	// 트랜잭션
	public void updateCash(String id, int payment) {
		// 구매자 캐쉬 차감
		dao.updateCash(id, payment);
		// 구매자 캐쉬내역 삽입
		dao.insertCash(id, payment);
	}

	// 작가 캐쉬 업데이트
	@Transactional(rollbackFor=Exception.class)
	public void updateArtisanCash(String artisanId, int payment) {
		// 작가 캐쉬 입금
		System.out.println(payment + "3333333333333333333333333333333333");
		payment=(int) (payment*0.95);
		System.out.println(payment + "3333333333333333333333333333333333");
		dao.updateArtisanCash(artisanId, payment);
		// 작가 캐쉬내역 삽입
		dao.insertArtisanCash(artisanId, payment);
	}*/
	// 캐쉬 충전
	@Transactional(rollbackFor = Exception.class)
	public void cashCharge(String id, int cash) {
		dao.cashCharge(id, cash);
		dao.insertCashCharge(id, cash);
	}

}


