package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.controller.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

// 1:1커스텀
@Repository
public class PcustomDao {

	@Autowired
	private SqlSessionTemplate tpl;
	
	// 글쓰기(글추가)
	public void insertPcustom(Pcustom pcustom) {
		tpl.insert("pcustomMapper.insertPcustom", pcustom);
	}
	
	// 글수정(파일 수정 없는 경우)
	public void updatePcustom(Pcustom pcustom) {
		tpl.update("pcustomMapper.updatePcustom", pcustom);
	}
	
	// 글수정(파일수정)
	public void updateWithFilePcustom(Pcustom pcustom) {
		tpl.update("pcustomMapper.updateWithFilePcustom", pcustom);
	}

	// 글삭제
	public void deletePcustom(int pcustomIdx) {
		tpl.delete("pcustomMapper.deletePcustom", pcustomIdx);
	}
	
	// 글목록(페이징 처리)
	public List<Pcustom> listPcustom(String artisanId, int startArticleNum, int endArticleNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("pcustomMapper.listPcustom", map);
	}
	// 글목록(페이징 처리, 검색)
	public List<Pcustom> searchListPcustom(String artisanId, int startArticleNum, int endArticleNum, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("keyword", keyword);
		return tpl.selectList("pcustomMapper.searchListPcustom", map);
	}
	
	// 전체 게시글 갯수. 조건절 작가아이디일 때
	public int getPcustomCount(String artisanId) {
		return tpl.selectOne("pcustomMapper.getPcustomCnt", artisanId);
	}
	
	// 검색글 갯수. 조건절 작가아이디일 때
	public int getSearchPcustomCount(String keyword, String artisanId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("artisanId", artisanId);
		return tpl.selectOne("pcustomMapper.getSearchPcustomCount", map);
	}
	
	// 글보기
	public Pcustom readPcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.readPcustom", pcustomIdx);
	}
	
	// 글 첨부파일 원본이름 얻어오기
	public String getPcustomOriginalFileName(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.getPcustomOriginalFileName", pcustomIdx);
	}
	
	// 댓글쓰기(댓글추가)(1:1커스텀 의견조율)
	public void insertPcustomOpinion(PcustomOpinion pcustomOpinion) {
		tpl.insert("pcustomMapper.insertPcustomOpinion", pcustomOpinion);
	}
	
	// 댓글목록
	public List<PcustomOpinion> listPcustomOpinion(int pcustomIdx) {
		return tpl.selectList("pcustomMapper.listPcustomOpinion", pcustomIdx);
	}
	
	/*// 댓글목록(페이징)
	public List<PcustomOpinion> listPcustomOpinion(int pcustomIdx, int startArticleNum, int endArticleNum) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("pcustomIdx", pcustomIdx);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("pcustomMapper.listPcustomOpinion", pcustomIdx);
	}
	
	// 전체 댓글 갯수
	public int getPcustomOpinionCount(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.getPcustomOpinionCnt", pcustomIdx);
	}
		*/
	// 댓글보기
	public PcustomOpinion readPcustomOpinion(int pcustomOpinionIdx) {
		return tpl.selectOne("pcustomMapper.readPcustomOpinion", pcustomOpinionIdx);
	}
	
	// 댓글 첨부파일 원본이름 얻어오기
	public String getPcustomOpinionOriginalFileName(int pcustomOpinionIdx) {
		return tpl.selectOne("pcustomMapper.getPcustomOpinionOriginalFileName", pcustomOpinionIdx);
	}
	
	// 댓글삭제(글이 삭제될 때)
	public void deletePcustomOpinion(int pcustomIdx) {
		tpl.delete("pcustomMapper.deletePcustomOpinion", pcustomIdx);
	}
	
	// 1:1커스텀 수락
	public void okPcustom(int pcustomIdx) {
		tpl.update("pcustomMapper.okPcustom", pcustomIdx);
	}
	
	// 1:1커스텀 거부
	public void byePcustom(int pcustomIdx) {
		tpl.update("pcustomMapper.byePcustom", pcustomIdx);
	}
	
	// 1:1커스텀 요청 여부 확인(요청상태인가)
	public Integer isRequestPcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isRequestPcustom", pcustomIdx);
	}
	
	// 1:1커스텀 거부 여부 확인(거부상태인가)
	public Integer isByePcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isByePcustom", pcustomIdx);
	}
	
	// 견적서 쓰기. 작가가..
	public void insertPcustomEstimate(ProductionOrder productionOrder) {
		tpl.insert("pcustomMapper.insertPcustomEstimate", productionOrder);
	}
	
	// 견적서 유무 확인
	public Integer isPcustomEstimate(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isPcustomEstimate", pcustomIdx);
	}
	
	// 견적서 확인. 글쓴이가 읽기..
	public ProductionOrder readPcustomEstimate(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.readPcustomEstimate", pcustomIdx);
	}
	
	// 견적서 수정
	public void updatePcustomEstimate(ProductionOrder productionOrder) {
		tpl.update("pcustomMapper.updatePcustomEstimate", productionOrder);
	}
	
	// 계약금 결제
	public void downPaymentPcustom(ProductionOrder productionOrder) {
		tpl.update("pcustomMapper.downPaymentPcustom", productionOrder);
	}
	
	// 잔금 결제
	public void finallyPaymentPcustom(ProductionOrder productionOrder) {
		tpl.update("pcustomMapper.finallyPaymentPcustom", productionOrder);
	}
	
	// 계약금 결제 유무 확인
	public Integer isDownPaymentPcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isDownPaymentPcustom", pcustomIdx);
	}

	// 잔금 결제 유무 확인
	public Integer isFinallyPaymentPcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isFinallyPaymentPcustom", pcustomIdx);
	}
	
	// 구매자 캐쉬 정보 가져오기(아이디, 캐쉬)
	public int getCashByMember(String id) {
		return tpl.selectOne("pcustomMapper.getCashByMember", id);
	}
	
	// 구매자 캐쉬 차감
	public void updateCash(String id, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", payment);
		tpl.update("pcustomMapper.updateCash", map);
	}
	
	// 구매자 캐쉬 내역 삽입
	public void insertCash(String id, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("payment", payment);
		tpl.insert("pcustomMapper.insertCash", map);
	}
	
	// 작가 캐쉬 입금
	public void updateArtisanCash(String artisanId, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("payment", payment);
		tpl.update("pcustomMapper.updateArtisanCash", map);
	}
	
	// 작가 캐쉬 내역 삽입
	public void insertArtisanCash(String artisanId, int payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("payment", payment);
		tpl.insert("pcustomMapper.insertArtisanCash", map);
	}
	
	// 배송완료
	public void deliveryCompletedPcustom(ProductionOrder productionOrder) {
		tpl.update("pcustomMapper.deliveryCompletedPcustom", productionOrder);
	}
	
	// 배송완료 유무 확인
	public Integer isDeliveryCompletedPcustom(int pcustomIdx) {
		return tpl.selectOne("pcustomMapper.isDeliveryCompletedPcustom", pcustomIdx);
	}
	
	
	
	// 메인홈 검색바(작품 검색)
	// 검색글 갯수
	public int getSearchProductCnt(String keyword) {
		return tpl.selectOne("pcustomMapper.getSearchProductCnt", keyword);
	}
	// 검색 목록
	public List<Product> searchListProduct(int startArticleNum, int endArticleNum, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("keyword", keyword);
		return tpl.selectList("pcustomMapper.searchListProduct", map);
	}
	
}
