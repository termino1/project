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
public class AdminService {
	@Autowired
	private AdminDao dao;
	@Autowired
	private UserDao userDao;
	
	//전체회원보기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> getAlluser(int pageno){
		int articleCnt = dao.getUserCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list",dao.getAllUser(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		map.put("onlyBlockUser", 0);
		return map;
	}
	
	//회원보기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public User getUser(String id) {
		return dao.getUser(id);
	}
	
	//회원차단하기
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void blockUser(String id) {
		dao.updateUserForBlock(id);
		dao.insertRestrictForBlock(id,0);
	}
	
	//작가신청글내역
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> allApplyList(int pageno){
		int articleCnt = dao.getApplyCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.allApplyList(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}
	
	//작가신청허가
	//apply의 상태를 바꾸고 유저의 권한을 삽입, 작가테이블에 id삽입
	@Transactional(rollbackFor = Exception.class)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void permitApply(ArtisanApply apply) {
		Message msg = new Message();
		msg.setMessageContent("작가등록신청이 허가되었습니다. 메인페이지의 작가홈으로 가셔서 작가정보수정에서 작가정보를 입력해주십시오.");
		msg.setReceiver(apply.getId());
		msg.setSender("admin");
		userDao.insertMessage(msg);
		dao.permitApply(apply.getArtisanApplyIdx());
		dao.insertAuthorityForManager(apply.getId());
		dao.insertArtisan(apply.getId());
	}
	
	//작가신청반려
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void returnApply(int artisanApplyIdx) {
		dao.returnApply(artisanApplyIdx);
	}
	
	//신고글목록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> allReportList(int pageno){
		int articleCnt = dao.getReportCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.allReportList(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}
	
	//신고글보기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Report getReportByReportIdx(int reportIdx){
		return dao.getReportByReportIdx(reportIdx);
	}
	
	//신고글 회원 경고
	//신고글상태변경, 제재로그삽입, 제재로그에서 해당아이디 경고3회일시 차단
	@Transactional(rollbackFor = Exception.class)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void reportWarning(Report report) {
		dao.updateReportForWarning(report.getReportIdx());
		dao.insertRestrictForWarn(report.getReportId(),report.getReportIdx());
		dao.updateUserForWarning(report.getReportId());
		if(dao.getWarningCnt(report.getReportId())==3) {
			dao.updateUserForBlock(report.getReportId());
			dao.updateUserForWarningInit(report.getReportId());
		}
	}
	
	//신고글 회원 차단
	@Transactional(rollbackFor=Exception.class)
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void reportBlock(Report report) {
		dao.updateReportForBlock(report.getReportIdx());
		dao.insertRestrictForBlock(report.getReportId(),report.getReportIdx());
		dao.updateUserForBlock(report.getReportId());
	}
	
	//차단회원보기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> blockUserList(int pageno){
		int articleCnt = dao.getBlockUserCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list",dao.getBlockUser(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		map.put("onlyBlockUser", 1);
		return map;
	}
	
	//회원차단해제하기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void clearblockUser(String id) {
		dao.updateUserForClearBlock(id);
	}
	
	//전체주문내역목록
	//orderProduct이용 주문건수 판매완료된 건수
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> getAllOrderProduct(int pageno){
		int articleCnt = dao.getOrderProductCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allOrderCnt", articleCnt);
		map.put("orderPrice", dao.sumOrderPrice());
		map.put("pagination", pagination);
		map.put("list",dao.getAllOrderProduct(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}
	
	//상품평전체목록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public Map<String, Object> getAllComment(int pageno){
		int articleCnt = dao.getCommentCnt();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list",dao.getAllComment(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}
}
