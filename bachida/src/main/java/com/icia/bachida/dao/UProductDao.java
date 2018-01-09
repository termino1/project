package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class UProductDao {
	@Autowired
	private SqlSessionTemplate tpl;
	/*메인카테고리*/
	public MainCategory getMainCategory(int mainCategoryIdx){
		return tpl.selectOne("UproductMapper.getMainCategory",mainCategoryIdx);
	}
	/*메타카테고리*/
	public List<MetaCategory> getMetaCategory(int mainCategoryIdx){
		return tpl.selectList("UproductMapper.getMetaCategory",mainCategoryIdx);
	}
	/*activeMetaCategory*/
	public MetaCategory activeMetaCategory(int mainCategoryIdx,int metaCategoryIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mainCategoryIdx", mainCategoryIdx);
		map.put("metaCategoryIdx", metaCategoryIdx);
		return tpl.selectOne("UproductMapper.activeMetaCategory",map);
	}
	/*상품목록*/
	public List<Product> getProductList(int mainCategoryIdx,int metaCategoryIdx, int startArticleNum,int endArticleNum){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("mainCategoryIdx", mainCategoryIdx);
		map.put("metaCategoryIdx", metaCategoryIdx);
		return tpl.selectList("UproductMapper.productList",map);
	}
	public List<Product> getProductList(int mainCategoryIdx,int metaCategoryIdx, int startArticleNum,int endArticleNum,String condition ,String sort){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("condition", condition);
		map.put("sort", sort);
		map.put("mainCategoryIdx", mainCategoryIdx);
		map.put("metaCategoryIdx", metaCategoryIdx);
		return tpl.selectList("UproductMapper.productListOrderby",map);
	}
	/*상품첨부유무*/
	public Product productList_cart(Integer productIdx){
		return tpl.selectOne("UproductMapper.productList_cart",productIdx);
	}
	
	/*상품목록-내가 찜한 상품목록*/
	public List<Integer> activeBookmark (String id){
		return tpl.selectList("UproductMapper.activeBookmark",id);
	}
	/* 찜한상품 한개 */
	public int activeBookmarkOne(String id, int productIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productIdx", productIdx);
		map.put("id", id);
		return tpl.selectOne("UproductMapper.activeBookmarkOne",map);
	}
	/* 카테고리별 상품카운트 */
	public int getProductCnt(int mainCategoryIdx,int metaCategoryIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mainCategoryIdx", mainCategoryIdx);
		map.put("metaCategoryIdx", metaCategoryIdx);
		return tpl.selectOne("UproductMapper.getProductCnt", map);
	}
	/*베스트상품*/
	public List<Integer> bestProduct(int mainCategoryIdx,int metaCategoryIdx){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mainCategoryIdx", mainCategoryIdx);
		map.put("metaCategoryIdx", metaCategoryIdx);
		return tpl.selectList("UproductMapper.bestProduct",map);
	}
	
	/*상품상세 -첨부이미지*/
	public List<ProductAttach> getAttachs(int productIdx){
		return tpl.selectList("UproductMapper.getAttachs",productIdx);
	}
	/*상품상세정보*/
	public Product getProduct(int productIdx){
		return tpl.selectOne("UproductMapper.getProduct",productIdx);
	}
	/*작가정보*/
	public Artisan getArtisan(int productIdx){
		return tpl.selectOne("UproductMapper.getArtisan",productIdx);
	}
	/*상품평*/
	public  List<ProductComment> productComment(int productIdx){
		return tpl.selectList("UproductMapper.productComment",productIdx);
	}
	/*상품더보기*/
	public List<Product> productMore(String artisanId){
		return tpl.selectList("UproductMapper.productMore", artisanId);
	}
	/*상품옵션*/
	public List<Option> getOption(int productIdx){
		return tpl.selectList("UproductMapper.getOption",productIdx);
	}
	
	/*즐겨찾기상품list*/
	public List<ProductBookmark> chooseList(String id){
		return tpl.selectList("UproductMapper.chooseList",id);
	}
	public List<Product> chooseProductInfo(String id) {
		return tpl.selectList("UproductMapper.chooseProductInfo",id);
	}
	
	/*즐겨찾기상품추가*/
	public int insertChooseProduct(ProductBookmark bookmark) {
		return tpl.insert("UproductMapper.insertChooseProduct",bookmark);
	}
	/*즐겨찾기상품삭제*/
	public int deleteChooseProduct(int productIdx, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productIdx", productIdx);
		map.put("id", id);
		return tpl.delete("UproductMapper.deleteChooseProduct",map);
	}
	/*즐겨찾기상품 카운트 증가*/
	public int increaseProductChooseCnt(int productIdx) {
		return tpl.update("UproductMapper.increaseProductChooseCnt",productIdx);
	}
	/*즐겨찾기상품 카운트 감소*/
	public int decreaseProductChooseCnt(int productIdx) {
		return tpl.update("UproductMapper.decreaseProductChooseCnt",productIdx);
	}
	
	/*장바구니*/
	public CartProduct cart_Product(Integer cartProductIdx){
		return tpl.selectOne("UproductMapper.cart_Product",cartProductIdx);
	}
	public List<CartProduct> CartProductList(Integer cartIdx){
		return tpl.selectList("UproductMapper.CartProductList",cartIdx);
	}
	public CartProduct noOptionProduct(Integer cartProductIdx){
		return tpl.selectOne("UproductMapper.noOptionProduct",cartProductIdx);
	}
	/*장바구니옵션유무*/
	public int isOption (int cartProductIdx) {
		return tpl.selectOne("UproductMapper.isOption",cartProductIdx); 
	}
	/*장바구니상품번호*/
	public List<CartProduct> cartProductIdxNo(int cartIdx){
		return tpl.selectList("UproductMapper.cartProductIdxNo",cartIdx);
	}
	/*장바구니 유무*/
	public Cart cart(String id) {
		return tpl.selectOne("UproductMapper.cart",id);
	}
	
	/*장바구니담기*/
	
	public int insertCart(Cart cart) {
		return tpl.insert("UproductMapper.insertCart",cart);
	}
	public int insertCartProduct(CartProduct cartProduct) {
		return tpl.insert("UproductMapper.insertCartProduct",cartProduct);
	}
	public int insertCartOption(CartOption optionList, Integer cartProductIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("optionContent", optionList.getOptionContent());
		map.put("cost", optionList.getCost());
		map.put("optionQuantity", optionList.getOptionQuantity());
		map.put("cartProductIdx", cartProductIdx);
		return tpl.insert("UproductMapper.insertCartOption",map);
	}
	/*장바구니 삭제*/
	public int cartProductDelete(int cartProductIdx) {
		return tpl.delete("UproductMapper.cartProductDelete",cartProductIdx);
	}
	public int cartOptionDelete(int cartProductIdx) {
		return tpl.delete("UproductMapper.cartOptionDelete",cartProductIdx);
	}
	
	/*바로주문*/
	/*주문옵션*/
	public void insertOrder(Order order) {
		tpl.insert("UproductMapper.insertOrder",order);
	}
	public int insertProductOrderOption(OrderOption option) {
		return tpl.insert("UproductMapper.insertProductOrderOption",option);
	}
	/*주문서작성*/
	public int insertProductOrderOne(OrderProduct orderproduct) {
		return tpl.insert("UproductMapper.insertProductOrderOne",orderproduct);
	}
	/*주문자정보*/
	public User buyer(String id) {
		return tpl.selectOne("UproductMapper.buyer",id);
	}
	
	public int getOrdersIdx() {
		return tpl.selectOne("UproductMapper.getOrdersIdx");
	}
	public int getOrderProductIdx() {
		return tpl.selectOne("UproductMapper.getOrderProductIdx");
	}
	// 구매자 캐쉬 정보 가져오기(아이디, 캐쉬)
		public int getCashByMember(String id) {
			return tpl.selectOne("UproductMapper.getCashByMember", id);
		}
		
	// 구매자 캐쉬 차감
	public void updateCash(String id, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", payment);
		tpl.update("UproductMapper.updateCash", map);
	}
		
	// 구매자 캐쉬 내역 삽입
	public void insertCash(String id, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", payment);
		tpl.insert("UproductMapper.insertCash", map);
	}
	// 구매자 캐쉬 충전
	public void cashCharge(String id, int cash) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", cash);
		tpl.update("UproductMapper.cashCharge", map);
	}
	
	// 구매자 캐쉬 내역 삽입
	public void insertCashCharge(String id, int cash) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", cash);
		tpl.insert("UproductMapper.insertCashCharge", map);
	}
		
	// 작가 캐쉬 입금
	public void updateArtisanCash(String artisanId, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("payment", payment);
		tpl.update("UproductMapper.updateArtisanCash", map);
	}
		
	// 작가 캐쉬 내역 삽입
	public void insertArtisanCash(String artisanId, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("payment", payment);
		tpl.insert("UproductMapper.insertArtisanCash", map);
	}
	// 작가 즐겨찾기 여부
	public ArtisanBookmark isFollow(String id, String artisanId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("artisanId", artisanId);
		return tpl.selectOne("artisanTimelineMapper.isFollow",map);
	}
		
}
