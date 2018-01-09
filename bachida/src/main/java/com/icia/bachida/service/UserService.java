package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;
import org.apache.commons.lang3.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.mail.javamail.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.test.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;
import com.icia.bachida.vo.Message;

@Service
public class UserService {
	@Autowired
	private UserDao dao;
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	JavaMailSender mailSender;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;

	/*
	 * 회원가입 - 회원정보,권한정보, 관심정보 insert 다수insert(트랜잭션)
	 */
	@Transactional(rollbackFor = Exception.class)
	public void JoinUser(User user) {
		String id = user.getId();
		String password = encoder.encode(user.getPassword());
		user.setPassword(password);
		List<Authority> auths = user.getAuthorities();
		if(user.getInterests()!=null) {
			List<Interest> interest = user.getInterests();
			dao.insertInterest(id, interest);
		}
		dao.insertUser(user);
		dao.insertAuthority(id, auths);
	}

	/*
	 * 아이디중복확인 - ajax처리 boolean반환
	 */
	public boolean idCheck(String id) {
		return dao.idCheck(id) != null ? true : false;
	}

	/*
	 * 아이디 찾기 - ajax 있다면 아이디를 그대로 반환
	 */
	public String findId(String name, String email) {
		return dao.findId(name, email);
	}

	/*
	 * 비밀번호 찾기 - ajax 처리. 아이디가 있으면 이메일인증을 보내야?
	 */
	// 이메일 발송(인증)
	public String sendEmailForPwdFind(String id, String email) throws MessagingException {
		if (dao.checkUser(id, email) == null) {
			return null;
		} else {
			String key = RandomStringUtils.randomAlphanumeric(10);
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
			String text = "인증번호는 " + key + "입니다";
			messageHelper.setFrom("byhdd0811@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("바치다 인증번호 입니다");
			messageHelper.setText(text, true);
			mailSender.send(msg);
			return key;
		}
	}

	// 비밀번호 수정
	public boolean changePassword(String id, String pwd) {
		String password = encoder.encode(pwd);
		return dao.changePassword(id, password) == 1 ? true : false;
	}

	/*
	 * 수정할 회원정보 가져오기 ㅡㅡ principal필요
	 * 
	 */
	public User getUserForUpdate(String id) {
		return dao.getUserForUpdate(id);
	}

	/*
	 * /회원정보수정 - 다른비밀번호를 입력하면 false반환 새로운 패스워드를 입력하지 않을땐 비밀번호를 변경하지 않고 회원정보 변경 -
	 * 관심정보에 따른 다른내용이 있으면 insert(수정할 list에서 중복제거하면 됨) 없어지면 delete(기존의 list에서 중복제거하면
	 * 됨) ㄴㅇㄻㄹㅇㅁㄴㅇㄻ principal필요 망할 리스트를 돌려가면서 지우면 list의 인덱스가 또 변경됨(1,2,3,4,5)라고 할때
	 * 0번방을 지우면 데이터 2가 0번방이 되기 때문에 다음 회전에선 데이터 3을 읽어들임
	 */
	@PreAuthorize("#user.id==principal.username")
	@Transactional(rollbackFor = Exception.class)
	public boolean updateUser(User user, String pwd) {
		// Stirng id = principal.getName();
		String id = user.getId();
		String password = dao.getPassword(id);
		if (!encoder.matches(user.getPassword(), password)) {
			return false;
		} else {
			if (pwd == "") {
				user.setPassword(password);
			} else if(pwd != "") {
				user.setPassword(encoder.encode(pwd));
			}
			dao.deleteInterest(id);
			dao.insertInterest(id, user.getInterests());
			return dao.updateUser(user) == 1 ? true : false;
		}
	}

	/*
	 * 작가신청글쓰기 다중파일 principal
	 */
	@Transactional(rollbackFor = Exception.class)
	public boolean writeArtisanApply(ArtisanApply apply, MultipartFile[] files, String id) throws IOException {
		List<ApplyAttach> list = new ArrayList<ApplyAttach>();
		int artisanApplyIdx = dao.getNewArtisanApplyIdx();
		apply.setId(id);
		apply.setArtisanApplyIdx(artisanApplyIdx);
		dao.insertArtisanApply(apply);
		for (MultipartFile file : files) {
			if (file.getOriginalFilename().equals(""))
				continue;
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			ApplyAttach attach = new ApplyAttach();
			attach.setOriginalFileName(file.getOriginalFilename());
			attach.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			FileCopyUtils.copy(file.getBytes(), f);
			list.add(attach);
		}
		System.out.println(list);
		if (list.size() != 0) {
			dao.insertApplyAttach(artisanApplyIdx, list);
		}
		return true;
	}

	/*
	 * 작가신청내역보기 principal
	 */
	public Map<String, Object> getApplyListById(String id,int pageno) {
		int articleCnt = dao.getApplyCntById(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.getApplyListById(id, pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}

	/*
	 * 작가신청보기
	 */
	@PostAuthorize("returnObject.id==principal.username or hasRole('ROLE_ADMIN')")
	public ArtisanApply getApplyByIdx(int artisanApplyIdx) {
		return dao.getApplyByIdx(artisanApplyIdx);
	}

	/*
	 * 회원신고글 작성
	 */
	public void writeReport(Report report, MultipartFile file) throws IOException {
		if (file.getOriginalFilename().equals("")) {
			report.setOriginalFileName("");
			report.setSavedFileName("");
		} else {
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			report.setOriginalFileName(file.getOriginalFilename());
			report.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			FileCopyUtils.copy(file.getBytes(), f);
		}
		dao.insertReport(report);
	}

	/*
	 * 내 신고내역 보기 principal
	 */
	public Map<String, Object> getMyReportList(String id,int pageno) {
		int articleCnt = dao.getReportCntById(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.getMyReportList(id, pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}

	// 회원탈퇴 이메일전송
	@PreAuthorize("#user.id == principal.username")
	public String sendEmailForResign(User user) throws MessagingException {
		String password = dao.getPassword(user.getId());
		if (!encoder.matches(user.getPassword(), password)) {
			return null;
		} else {
			String key = RandomStringUtils.randomAlphanumeric(10);
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
			String text = "인증번호는 " + key + "입니다";
			messageHelper.setFrom("byhdd0811@gmail.com");
			messageHelper.setTo(user.getEmail());
			messageHelper.setSubject("바치다 인증번호 입니다");
			messageHelper.setText(text, true);
			mailSender.send(msg);
			return key;
		}
	}

	/*
	 * 회원탈퇴 이메일 발송이 끝난뒤! 회원정보와 관심정보, 권한정보를 모두 삭제
	 */
	@Transactional(rollbackFor = Exception.class)
	public boolean resignUser(String id) {
		dao.deleteAuthority(id);
		dao.deleteInterest(id);
		dao.deleteProductBookmark(id);
		dao.deleteArtisanBookmark(id);
		dao.deleteCustom(id);
		dao.deletePcustom(id);
		dao.deleteQna(id);
		dao.deleteRestriction(id);
		dao.deleteReport(id);
		dao.deleteCash(id);
		return dao.deleteUser(id) == 1 ? true : false;
	}

	/*
	 * 메세지 목록 받아오기 principal
	 */
	public Map<String, Object> receiveMsgList(String id,int pageno) {
		int articleCnt = dao.getReceiveMsgCnt(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.receiveMsgList(id,pagination.getStartArticleNum(),pagination.getEndArticleNum()));
		return map;
	}

	public Map<String, Object> sendMsgList(String id,int pageno) {
		int articleCnt = dao.getSendMsgCnt(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.sendMsgList(id,pagination.getStartArticleNum(),pagination.getEndArticleNum()));
		return map;
	}

	/*
	 * 메세지 보기 메세지의 확인상태를 바꾸고 메세지 얻어오기
	 */
	@PostAuthorize("(returnObject.sender==principal.username) or (returnObject.receiver==principal.username)")
	@Transactional(rollbackFor = Exception.class)
	public Message getMessage(int messageIdx,String id) {
		
		Message msg = dao.getMessage(messageIdx);
		if(id.equals(msg.getReceiver())) {
			dao.updateMessage(messageIdx);
		}
		return msg;
	}

	/*
	 * 메세지 보내기
	 */
	public boolean WriteMessage(Message msg) {
		return dao.insertMessage(msg) == 1 ? true : false;
	}

	/*
	 * 캐쉬충전하기 회원정보에 캐쉬정보를 update후 캐쉬내역에 등록
	 */
	@Transactional(rollbackFor = Exception.class)
	public void cashCharge(String id, int cash) {
		dao.updateCash(id, cash);
		dao.insertCash(id, cash);
	}

	/*
	 * 캐쉬내역목록 principal 유저의 현재 캐쉬상황도 return
	 */
	public Map<String, Object> getCashList(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", dao.getCashList(id));
		map.put("userCash", dao.getUserCash(id));
		return map;
	}

	/*
	 * 주문내역목록
	 */
	public List<Map<String, String>> MyOrderList(String id) {
		return dao.getOrderListById(id);
	}

	/*
	 * 주문상세보기
	 * 메소드안에서 불러온 객체로 @Postauthorize가능?
	 */
	public Map<String, Object> getOrderDetail(int orderIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderProduct", dao.getOrderProduct(orderIdx));
		map.put("order", dao.getOrderByOrdersIdx(orderIdx));
		return map;
	}

	// 상품평쓰기페이지에서 상품정보불러오기
	public Product getProductForCommnet(int productIdx) {
		return dao.getProductForCommnet(productIdx);
	}

	/*
	 * 상품평쓰기
	 */
	@Transactional(rollbackFor = Exception.class)
	public void WriteComment(ProductComment comment, MultipartFile file, int orderProductIdx) throws IOException {
		if (file.getOriginalFilename().equals("")) {
			comment.setOriginalFileName("");
			comment.setSavedFileName("");
		} else {
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			comment.setOriginalFileName(file.getOriginalFilename());
			comment.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			FileCopyUtils.copy(file.getBytes(), f);
		}
		dao.updateCommentCheck(orderProductIdx);
		dao.insertComment(comment);
	}

	/*
	 * 배송완료처리하기
	 */
	public void DeliveryComplete(int orderProductIdx) {
		dao.updateOrderProductForDelivery(orderProductIdx);
	}

	/*
	 * 제작요청내역
	 */
	public Map<String, Object> getMyCustom(String id, int pageno) {
		int articleCnt = dao.getCustomCntById(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		List<Custom> customList = dao.getCustomListById(id, pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<Bid> bidList = new ArrayList<Bid>();
		
		List<ProductionOrder> productionOrder = new ArrayList<ProductionOrder>();
		for(Custom custom:customList) {
			Bid bid = dao.getBidIdx(custom.getCustomIdx());
			if(bid!=null) {
				bidList.add(bid);
				ProductionOrder order = dao.getProductionOrder(bid.getBidIdx());
				 productionOrder.add(order);
			}
		}
		map.put("pagination", pagination);
		map.put("list",customList);
		map.put("productionOrder", productionOrder);
		map.put("bidList", bidList);
		return map;
	}

	/*
	 * 1:1제작요청내역
	 */
	public Map<String, Object> getMyPcustom(String id, int pageno) {
		int articleCnt = dao.getPcustomCntById(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", dao.getPcustomListById(id, pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}

	// 파일네임 불러오기
	public Map<String, String> getFileNameByProductidx(int productIdx) {
		return dao.getFileNameByProductidx(productIdx);
	}

	//회원보기
	public User getUserInfo(String id) {
		User user = dao.getUserInfo(id);
		if(user==null) {
			user = dao.getUserInfoWithoutInterest(id);
		}
		return user;
	}
	
	
	public Map<String, Object> myPageMain(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", dao.getrecentlyOrderById(id));
		map.put("userInfo", adminDao.getUser(id));
		return map;
	}
}
