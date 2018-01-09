package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class AdminDao {
	@Autowired
	private SqlSessionTemplate tpl;
	//전체회원보기
	public List<User> getAllUser(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.getAllUser",map);
	}
	public int getUserCnt() {
		return tpl.selectOne("adminMapper.getUserCnt");
	}
	
	//회원보기
	public User getUser(String id) {
		return tpl.selectOne("adminMapper.getUser",id);
	}
	
	//회원차단하기
	public void updateUserForBlock(String id) {
		tpl.update("adminMapper.updateUserForBlock",id);
	}
	
	//전체 작가신청내역
	public int getApplyCnt() {
		return tpl.selectOne("adminMapper.getApplyCnt");
	}
	public List<ArtisanApply> allApplyList(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map =new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.allApplyList",map);
	}
	
	//작가신청허가
	public void permitApply(int artisanApplyIdx) {
		tpl.update("adminMapper.permitApply",artisanApplyIdx);
	}
	public void insertAuthorityForManager(String id) {
		tpl.insert("adminMapper.insertAuthorityForManager",id);
	}
	public void insertArtisan(String id) {
		tpl.insert("adminMapper.insertArtisan", id);
	}
	
	//작가신청반려
	public void returnApply(int artisanApplyIdx) {
		tpl.update("adminMapper.returnApply",artisanApplyIdx);
	}
	
	//전체신고내역
	public int getReportCnt() {
		return tpl.selectOne("adminMapper.getReportCnt");
	}
	public List<Report> allReportList(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map =new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.allReportList",map);
	}
	
	//신고글보기
	public Report getReportByReportIdx(int reportIdx) {
		return tpl.selectOne("adminMapper.getReportByReportIdx",reportIdx);
	}
	
	//신고글회원경고
	public void updateReportForWarning(int reportIdx) {
		tpl.update("adminMapper.updateReportForWarning",reportIdx);
	}
	public void insertRestrictForWarn(String reportId,int reportIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportId", reportId);
		map.put("reportIdx", reportIdx);
		tpl.insert("adminMapper.insertRestrictForWarn",map);
	}
	public void updateUserForWarning(String reportId) {
		tpl.update("adminMapper.updateUserForWarning",reportId);
	}
	public int getWarningCnt(String reportId) {
		return tpl.selectOne("adminMapper.getWarningCnt",reportId);
	}
	public void updateUserForWarningInit(String reportId) {
		tpl.update("adminMapper.updateUserForWarningInit",reportId);
	}
	
	//신고글회원차단
	public void updateReportForBlock(int reportIdx) {
		tpl.update("adminMapper.updateReportForBlock",reportIdx);
	}
	public void insertRestrictForBlock(String reportId,int reportIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportId", reportId);
		map.put("reportIdx", reportIdx);
		tpl.insert("adminMapper.insertRestrictForBlock", map);
	}
	
	//차단회원내역
	public int getBlockUserCnt() {
		return tpl.selectOne("adminMapper.getBlockUserCnt");
	}
	public List<User> getBlockUser(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map =new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.getBlockUser",map);
	}
	
	//차단해제
	public void updateUserForClearBlock(String id) {
		tpl.update("adminMapper.updateUserForClearBlock", id);
	}
	
	//주문내역목록
	public int getOrderProductCnt() {
		return tpl.selectOne("adminMapper.getOrderProductCnt");
	}
	public List<OrderProduct> getAllOrderProduct(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map =new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.getAllOrderProduct",map);
	}
	public int sumOrderPrice() {
		return tpl.selectOne("adminMapper.sumOrderPrice");
	}
	
	
	//전체상품평
	public int getCommentCnt() {
		return tpl.selectOne("adminMapper.getCommentCnt");
	}
	public Object getAllComment(int startArticleNum, int endArticleNum) {
		Map<String, Integer> map =new HashMap<String, Integer>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tpl.selectList("adminMapper.getAllComment",map);
	}
	
	
	
	
}
