/*
 * 17/12/04 내 신고내역보기 누락(처리)
 * 17/12/07 selectList들 페이징쿼리 처리 필요
 */
package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.dto.*;
import com.icia.bachida.vo.*;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	//회원가입(daoTest o)
	//회원테이블에 회원정보삽입
	public void insertUser(User user) {
		tpl.insert("userMapper.insertUser", user);
	}
	//권한테이블에 권한정보삽입
	public void insertAuthority(String id,List<Authority> list) {
		for(Authority a : list) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("authority", a.getAuthority());
			tpl.insert("userMapper.insertAuthority", map);
		}
	}
	//관심테이블에 관심정보삽입
	public void insertInterest(String id, List<Interest> list) {
		for(Interest i: list) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("mainCategoryIdx", i.getMainCategoryIdx());
			tpl.insert("userMapper.insertInterest",map);
		}
	}
	
	
	//아이디중복확인(daoTest o)
	/*
	14:08:59.504 [main] INFO  jdbc.resultsettable - |---|
	14:08:59.505 [main] INFO  jdbc.resultsettable - |ID |
	14:08:59.505 [main] INFO  jdbc.resultsettable - |---|
	14:08:59.505 [main] INFO  jdbc.resultsettable - |---|
	sysout결과는 나옴
	 */
	public String idCheck(String id) {
		return tpl.selectOne("userMapper.idCheck",id);
	}
	
	
	//아이디찾기(daoTest o)
	public String findId(String name,String email) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("email", email);
		return tpl.selectOne("userMapper.findId",map);
	}
	
	
	//비밀번호 찾기
	//회원정보찾기(아이디와 이메일을 받아 회원정보가 맞는지 check)
	//daoTest o
	public String checkUser(String id, String email) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("email", email);
		return tpl.selectOne("userMapper.checkUser",map);
	}
	//비밀번호변경(회원정보수정과 같이 사용)
	//daoTest o
	public int changePassword(String id, String encodedPassword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("password", encodedPassword);
		return tpl.update("userMapper.changePassword", map);
	}
	
	
	// 수정할 회원정보 가져오기
	// daoTest o
	public User getUserForUpdate(String id) {
		return tpl.selectOne("userMapper.getUserForUpdate", id);
	}
	
	
	//회원정보수정
	//수정페이지의 비밀번호검증를 위한 패스워드 추출
	public String getPassword(String id) {
		return tpl.selectOne("userMapper.getPassword",id);
	}
	//member테이블변경
	//daoTest o
	public int updateUser(User user) {
		return tpl.update("userMapper.updateUser",user);
	}
	
	
	//작가등록신청
	//신청번호얻어오기
	public int getNewArtisanApplyIdx() {
		return tpl.selectOne("userMapper.getNewArtisanApplyIdx");
	}
	//작가신청테이블삽입
	public void insertArtisanApply(ArtisanApply apply){
		tpl.insert("userMapper.insertArtisanApply",apply);
	}
	//작가저장테이블삽입
	public void insertApplyAttach(int artisanApplyIdx, List<ApplyAttach> list) {
		for(ApplyAttach a:list) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("artisanApplyIdx", artisanApplyIdx);
			map.put("savedFileName", a.getSavedFileName());
			map.put("originalFileName", a.getOriginalFileName());
			tpl.insert("userMapper.insertApplyAttach",map);
		}
	}
	
	
	//내 작가신청 목록
	public int getApplyCntById(String id) {
		return tpl.selectOne("userMapper.getApplyCntById", id);
	}
	public List<ArtisanApply> getApplyListById(String id, int startArticleNum, int endArticleNum){
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.getApplyListById",map);
	}
	
	
	//작가신청보기
	public ArtisanApply getApplyByIdx(int artisanApplyIdx) {
		return tpl.selectOne("userMapper.getApplyByIdx", artisanApplyIdx);
	}
	
	
	//회원 신고글 작성
	//daoTest o
	public void insertReport(Report report) {
		tpl.insert("userMapper.insertReport", report);
	}
	
	
	//내 신고내역 보기
	//daoTest o
	public int getReportCntById(String id) {
		return tpl.selectOne("userMapper.getReportCntById", id);
	}
	public List<Report> getMyReportList(String id, int startArticleNum, int endArticleNum) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.getMyReportList",map);
	}

	
	//회원탈퇴
	//회원테이블의 정보 삭제
	//daoTest o
	public int deleteUser(String id) {
		return tpl.delete("userMapper.deleteUser",id);
	}
	//권한정보삭제
	//daoTest o
	public void deleteAuthority(String id) {
		tpl.delete("userMapper.deleteAuthority",id);
	}
	//관심정보삭제
	//daoTest o
	public void deleteInterest(String id) {
		tpl.delete("userMapper.deleteInterest",id);
	}
	//상품즐겨찾기삭제
	public void deleteProductBookmark(String id) {
		tpl.delete("userMapper.deleteProductBookmark",id);
	}
	//작가즐겨찾기삭제
	public void deleteArtisanBookmark(String id) {
		tpl.delete("userMapper.deleteArtisanBookmark",id);
	}
	//제작요청삭제
	public void deleteCustom(String id) {
		tpl.delete("userMapper.deleteCustom",id);
	}
	//1:1제작요청삭제
	public void deletePcustom(String id) {
		tpl.delete("userMapper.deletePcustom",id);
	}
	//문의내역삭제
	public void deleteQna(String id) {
		tpl.delete("userMapper.deleteQna",id);
	}
	//제재내역삭제
	public void deleteRestriction(String id) {
		tpl.delete("userMapper.deleteRestriction",id);
	}
	//신고내역삭제
	public void deleteReport(String id) {
		tpl.delete("userMapper.deleteReport",id);
	}
	//캐쉬내역삭제
	public void deleteCash(String id) {
		tpl.delete("userMapper.deleteCash",id);
	}
	
	
	//메세지목록
	//daoTest o
	public int getReceiveMsgCnt(String id) {
		return tpl.selectOne("userMapper.getReceiveMsgCnt", id);
	}
	public int getSendMsgCnt(String id) {
		return tpl.selectOne("userMapper.getSendMsgCnt", id);
	}
	public List<Message> receiveMsgList(String id, int startArticleNum, int endArticleNum){
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.receiveMsgList",map);
	}
	public List<Message> sendMsgList(String id, int startArticleNum, int endArticleNum) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.sendMsgList",map);
	}
	
	
	//메세지보기
	//메세지정보가져오기
	//daoTest o
	public Message getMessage(int messageIdx) {
		return tpl.selectOne("userMapper.getMessage",messageIdx);
	}
	//메세지확인정보 업데이트
	//daoTest o
	public void updateMessage(int messageIdx) { 
		tpl.update("userMapper.updateMessage",messageIdx);
	}
	
	
	//메세지보내기
	//daoTest o
	public int insertMessage(Message msg) {
		return tpl.insert("userMapper.insertMessage", msg);
	}
	
	//캐쉬충전
	//회원정보에 캐쉬적립
	//daoTest o
	public void updateCash(String id, int cash) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cash", cash);
		tpl.update("userMapper.updateCash", map);
	}
	//캐쉬내역에 등록
	//daoTest o
	public void insertCash(String id, int cash) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cash", cash);
		tpl.insert("userMapper.insertCash",map);
	}
	
	
	//캐쉬내역목록
	//daoTest o
	public List<Cash> getCashList(String id){
		return tpl.selectList("userMapper.getCashList", id);
	}
	//유저의 잔여 캐쉬 불러오기
	public int getUserCash(String id) {
		return tpl.selectOne("userMapper.getUserCash",id);
	}


	//주문내역 목록
	/*
		주문번호, 상품명 , 주문상품갯수-1, 총결제금액, 주문일자, 상품사진
		주문테이블 : 주문번호, 아이디, 총금액, 주소, 상품갯수
		주문상품테이블 : 주문상품번호, 수량, 주문상태, 택배이름, 운송장번호, 주문일자
						주문자, 주문자연락처, 주문자이메일, 금액, 주문번호, 상품번호
		오또카징....
		사진은 ajax로 요청?.......이것도 무리(아냐!)
		사진은 따로 상품번호를 넘겨 얻어오기!
	 */
	// daoTest o
	public List<Map<String, String>> getOrderListById(String id){
		return tpl.selectList("userMapper.getOrderListById",id);
	}
	
	//주문상세보기
	//주문상품불러오기(옵션o) resultMap
	// daoTest o
	public List<OrderProductAndOption> getOrderProduct(int ordersIdx){
		return tpl.selectList("userMapper.getOrderProduct",ordersIdx);
	}
	//주문번호를통해주문불러오기
	// daoTest o
	public Order getOrderByOrdersIdx(int orderIdx) {
		return tpl.selectOne("userMapper.getOrderByOrdersIdx",orderIdx);
	}
	
	//상품평에서 상품정보불러오기
	public Product getProductForCommnet(int productIdx) {
		return tpl.selectOne("userMapper.getProductForCommnet",productIdx);
	}
	//상품평쓰기
	// daoTest o
	public void insertComment(ProductComment comment) {
		tpl.insert("userMapper.insertComment",comment);
	}
	//상품평작성여부 변경
	public void updateCommentCheck(int orderProductIdx) {
		tpl.update("userMapper.updateCommentCheck",orderProductIdx);
	}
	
	
	//주문상품 배송완료 처리하기
	// daoTest o
	public void updateOrderProductForDelivery(int orderProductIdx) {
		tpl.update("userMapper.updateOrderProductForDelivery",orderProductIdx);
	}
	
	
	//제작요청내역
	// daoTest o
	public List<Custom> getCustomListById(String id,int startArticleNum, int endArticleNum){
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.getCustomListById", map);
	}
	//제작요청수 불러오기
	public int getCustomCntById(String id) {
		return tpl.selectOne("userMapper.getCustomCntById", id);
	}
	
	
	//1:1제작요청내역
	// daoTest o
	public List<Pcustom> getPcustomListById(String id,int startArticleNum, int endArticleNum){
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("id", id);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("userMapper.getPcustomListById",map);
	}
	public int getPcustomCntById(String id) {
		return tpl.selectOne("userMapper.getPcustomCntById", id);
	}
	
	
	//상품파일네임불러오기
	public Map<String, String> getFileNameByProductidx(int productIdx) {
		return tpl.selectOne("userMapper.getFileNameByProductidx",productIdx);
	}
	//회원정보
	public User getUserInfo(String id) {
		return tpl.selectOne("userMapper.getUserInfo", id);
	}
	//관심정보없는 회원정보
	public User getUserInfoWithoutInterest(String id) {
		return tpl.selectOne("userMapper.getUserInfoWithoutInterest", id);
	}
	
	public List<Map<String, String>> getrecentlyOrderById(String id) {
		return tpl.selectList("userMapper.getrecentlyOrderById",id);
	}
	// 주문제작 마이페이지 주문서 상태보기를 위한....
	public Bid getBidIdx(int customIdx) {
		return tpl.selectOne("userMapper.getBidIdx",customIdx);
	}
	public ProductionOrder getProductionOrder(int bidIdx) {
		return tpl.selectOne("userMapper.getProductionOrder",bidIdx);
	}
	
	
	
}
