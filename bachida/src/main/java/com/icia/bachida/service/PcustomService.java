package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.util.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

import net.coobird.thumbnailator.*;

//1:1커스텀
@Service
public class PcustomService {

	@Autowired
	private PcustomDao pcustomDao;
	//private UProductDao dao;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;

	// 글쓰기(글추가)
	@PreAuthorize("isAuthenticated()")	// 인증된 회원만 글쓰기 가능
	public Boolean insertPcustom(Pcustom pcustom, MultipartFile file) throws IOException {
		
		if (file.getOriginalFilename().equals("")) {	// 첨부파일이 비어있을 경우
			pcustom.setOriginalFileName("");
			pcustom.setSavedFileName("");
		} else {	// 첨부파일 넣기
			// System.out.println("서비스 도착"+file.getOriginalFilename());
			String originalFileName = file.getOriginalFilename();
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			// System.out.println("서비스 파일네임"+savedFileName);
			File target = new File(uploadPath, savedFileName);
			FileCopyUtils.copy(file.getBytes(), target);

			pcustom.setOriginalFileName(originalFileName);
			pcustom.setSavedFileName(savedFileName);
			
		}
		pcustomDao.insertPcustom(pcustom);	// 글삽입
		
		return true;
	}

	// 글수정(파일 수정 없는 경우)
	@PreAuthorize("#pcustom.id == principal.username")	// 글쓴이만 수정
	public void updatePcustom(Pcustom pcustom) {
		pcustomDao.updatePcustom(pcustom);
	}
	// 글수정(파일수정 할 경우)
	@PreAuthorize("#pcustom.id == principal.username")
	public Boolean updateWithFilePcustom(Pcustom pcustom, MultipartFile file) throws IOException {
		// 첨부한 사진파일 이름 넣기
		String originalFileName = file.getOriginalFilename();
		String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
		File target = new File(uploadPath, savedFileName);
		FileCopyUtils.copy(file.getBytes(), target);
		pcustom.setOriginalFileName(originalFileName);
		pcustom.setSavedFileName(savedFileName);
		pcustomDao.updateWithFilePcustom(pcustom);
		return true;
	}

	// 글삭제(댓글도 같이 삭제)
	@PreAuthorize("#id == principal.username")
	@Transactional(rollbackFor=Exception.class)
	public void deletePcustom(int pcustomIdx, String id) {
		pcustomDao.deletePcustom(pcustomIdx);
		pcustomDao.deletePcustomOpinion(pcustomIdx);
	}

	// 글목록(페이징 처리)
	@PreAuthorize("isAuthenticated()")
	//@PreAuthorize("#pcustom.id == principal.username")
	public Map<String, Object> listPcustom(int pageno, String artisanId) {
		// 게시판 글 전체 갯수
		int articleCnt = pcustomDao.getPcustomCount(artisanId);

		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", pcustomDao.listPcustom(artisanId, pagination.getStartArticleNum(), pagination.getEndArticleNum()));

		return map;
	}

	// 글목록(검색, 페이징 처리)
	@PreAuthorize("isAuthenticated()")
	//@PreAuthorize("#pcustom.id == principal.username")
	public Map<String, Object> searchListPcustom(int pageno, String keyword, String artisanId) {
		// 검색글 전체 갯수
		int articleCnt = pcustomDao.getSearchPcustomCount(keyword, artisanId);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		// System.err.println(pagination);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("list", pcustomDao.searchListPcustom(artisanId, pagination.getStartArticleNum(), pagination.getEndArticleNum(), keyword));
		return map;
	}

	// 글보기
	@PreAuthorize("isAuthenticated()")
	public Pcustom readPcustom(int pcustomIdx) {
		return pcustomDao.readPcustom(pcustomIdx);
	}

	// 글 첨부파일 원본이름 얻어오기
	public String getPcustomOriginalFileName(int pcustomIdx) {
		return pcustomDao.getPcustomOriginalFileName(pcustomIdx);
	}

	// 댓글 쓰고 보기(1:1커스텀 의견조율)
	/*
	 * public List<PcustomOpinion> insertAndReadPcustomOpinion(PcustomOpinion
	 * pcustomOpinion, MultipartFile file) throws IOException { // 첨부파일 넣기
	 * if(file.getOriginalFilename().equals("")) {
	 * pcustomOpinion.setOriginalFileName("aa");
	 * pcustomOpinion.setSavedFileName("aa");
	 * pcustomDao.insertPcustomOpinion(pcustomOpinion); return
	 * pcustomDao.readPcustomOpinion(pcustomOpinion.getPcustomIdx()); } String
	 * originalFileName = file.getOriginalFilename(); String savedFileName =
	 * System.currentTimeMillis() + "-" + file.getOriginalFilename(); File target =
	 * new File(uploadPath, savedFileName); FileCopyUtils.copy(file.getBytes(),
	 * target); pcustomOpinion.setOriginalFileName(originalFileName);
	 * pcustomOpinion.setSavedFileName(savedFileName);
	 * 
	 * // 댓글 추가하고 pcustomDao.insertPcustomOpinion(pcustomOpinion); // 댓글 읽어오기 return
	 * pcustomDao.readPcustomOpinion(pcustomOpinion.getPcustomIdx()); }
	 */

	// 댓글 쓰기(1:1커스텀 의견조율)
	@PreAuthorize("isAuthenticated()")
	public Boolean insertPcustomOpinion(PcustomOpinion pcustomOpinion, MultipartFile file) throws IOException {
		if (file.getOriginalFilename().equals("")) {
			pcustomOpinion.setOriginalFileName("");
			pcustomOpinion.setSavedFileName("");
		} else {
			String originalFileName = file.getOriginalFilename();
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			File target = new File(uploadPath, savedFileName);
			FileCopyUtils.copy(file.getBytes(), target);
			
			pcustomOpinion.setOriginalFileName(originalFileName);
			pcustomOpinion.setSavedFileName(savedFileName);
		}
		pcustomDao.insertPcustomOpinion(pcustomOpinion);
		return true;
	}

	// 댓글 목록
	public List<PcustomOpinion> listPcustomOpinion(int pcustomIdx) {
		List<PcustomOpinion> list = pcustomDao.listPcustomOpinion(pcustomIdx);
		return list;
	}
	
/*	// 댓글 목록((페이징)
	public Map<String, Object> listPcustomOpinion(int pcustomIdx, int pageno) {
		int articleCnt = pcustomDao.getPcustomOpinionCount(pcustomIdx);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("commentList", pcustomDao.listPcustomOpinion(pagination.getStartArticleNum(), pagination.getEndArticleNum()	, pcustomIdx));
		return map;
	}*/

	// 댓글 보기
	@PreAuthorize("isAuthenticated()")
	public PcustomOpinion readPcustomOpinion(int pcustomOpinionIdx) {
		return pcustomDao.readPcustomOpinion(pcustomOpinionIdx);
	}

	// 댓글 첨부파일 원본이름 얻어오기
	public String getPcustomOpinionOriginalFileName(int pcustomOpinionIdx) {
		return pcustomDao.getPcustomOpinionOriginalFileName(pcustomOpinionIdx);
	}

	// 1:1커스텀 수락
	@PreAuthorize("#artisanId == principal.username")	// 작가만
	public void okPcustom(int pcustomIdx, String artisanId) {
		pcustomDao.okPcustom(pcustomIdx);
	}

	// 1:1커스텀 거절
	@PreAuthorize("#artisanId == principal.username")
	public void byePcustom(int pcustomIdx, String artisanId) {
		pcustomDao.byePcustom(pcustomIdx);
	}

	// 1:1커스텀 요청 여부 확인(요청상태인가)
	public Integer isRequestPcustom(int pcustomIdx) {
		Integer result = pcustomDao.isRequestPcustom(pcustomIdx);
		return result != null ? 1 : 0;
	}

	// 1:1커스텀 거부 여부 확인(거부상태인가)
	public Integer isByePcustom(int pcustomIdx) {
		Integer result = pcustomDao.isByePcustom(pcustomIdx);
		return result != null ? 1 : 0;
	}

	// 견적서 쓰기. 작가가..
	@PreAuthorize("#productionOrder.artisanId == principal.username")
	public void insertPcustomEstimate(ProductionOrder productionOrder) {
		pcustomDao.insertPcustomEstimate(productionOrder);
	}
	
	/*// 견적서.........ajax
	public void insertPcustomEstimate(ProductionOrder productionOrder) {
		pcustomDao.insertPcustomEstimate(productionOrder);
	}
*/
	// 견적서 유무 확인
	public Integer isPcustomEstimate(int pcustomIdx) {
		Integer result = pcustomDao.isPcustomEstimate(pcustomIdx);
		return result != null ? 1 : 0;
	}

	// 견적서 확인
	@PreAuthorize("(#productionOrder.artisanId == principal.username) or (#productionOrder.id == principal.username)")
	public ProductionOrder readPcustomEstimate(int pcustomIdx, ProductionOrder productionOrder) {
		return pcustomDao.readPcustomEstimate(pcustomIdx);
	}

	// 견적서 수정
	@PreAuthorize("#productionOrder.artisanId == principal.username")
	public void updatePcustomEstimate(ProductionOrder productionOrder) {
		pcustomDao.updatePcustomEstimate(productionOrder);
	}

	// 계약금 결제
	@PreAuthorize("#productionOrder.id == principal.username")
	public void downPaymentPcustom(ProductionOrder productionOrder) {
		pcustomDao.downPaymentPcustom(productionOrder);
	}

	// 잔금 결제
	@PreAuthorize("#productionOrder.id == principal.username")
	public void finallyPaymentPcustom(ProductionOrder productionOrder) {
		pcustomDao.finallyPaymentPcustom(productionOrder);
	}

	// 계약금 결제 유무 확인
	public Integer isDownPaymentPcustom(int pcustomIdx) {
		Integer result = pcustomDao.isDownPaymentPcustom(pcustomIdx);
		return result != null ? 1 : 0;
	}

	// 잔금 결제 유무 확인
	public Integer isFinallyPaymentPcustom(int pcustomIdx) {
		Integer result = pcustomDao.isFinallyPaymentPcustom(pcustomIdx);
		return result != null ? 1 : 0;
	}

	// 구매자 캐쉬 정보 가져오기(아이디, 캐쉬)
	@PreAuthorize("#id == principal.username")
	public int getCashByMember(String id) {
		return pcustomDao.getCashByMember(id);
	}

	// 구매자 캐쉬 업데이트
	@PreAuthorize("#id == principal.username")
	@Transactional(rollbackFor=Exception.class)	// 트랜잭션
	public void updateCash(String id, int payment) {
		// 구매자 캐쉬 차감
		pcustomDao.updateCash(id, payment);
		// 구매자 캐쉬내역 삽입
		pcustomDao.insertCash(id, payment);
	}

	// 작가 캐쉬 업데이트
	@Transactional(rollbackFor=Exception.class)
	public void updateArtisanCash(String artisanId, int payment) {
		// 작가 캐쉬 입금
		pcustomDao.updateArtisanCash(artisanId, payment);
		// 작가 캐쉬내역 삽입
		pcustomDao.insertArtisanCash(artisanId, payment);
	}

	// 배송완료처리
	@PreAuthorize("#productionOrder.artisanId == principal.username")
	public void deliveryCompletedPcustom(ProductionOrder productionOrder) {
		pcustomDao.deliveryCompletedPcustom(productionOrder);
	}

	// 배송완료 유무 확인
	public Integer isDeliveryCompletedPcustom(int pcustomIdx) {
		Integer result = pcustomDao.isDeliveryCompletedPcustom(pcustomIdx);
		return result != null ? 1 : 0;
	}

	
	// 메인홈 검색바(작품 검색)
		//@PreAuthorize("isAuthenticated()")
		//@PreAuthorize("#pcustom.id == principal.username")
		public Map<String, Object> searchListProduct(int pageno, String keyword) {
			// 검색글 전체 갯수
			int articleCnt = pcustomDao.getSearchProductCnt(keyword);
			Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
			// System.err.println(pagination);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("pagination1", pagination);
			map.put("list1", pcustomDao.searchListProduct(pagination.getStartArticleNum(), pagination.getEndArticleNum(), keyword));
			return map;
		}
		/*상품상세*/
		/*public Map<String, Object> getProduct(int productIdx,String id) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("getProduct", dao.getProduct(productIdx));
			map.put("getOption", dao.getOption(productIdx));
			map.put("getArtisan", dao.getArtisan(productIdx));
			map.put("getAttachs", dao.getAttachs(productIdx));
			map.put("productComment", dao.productComment(productIdx));
			map.put("productMore", dao.productMore(dao.getProduct(productIdx).getArtisanId()));
			map.put("activeBookmarkOne", dao.activeBookmarkOne(id,productIdx));
			작가 즐겨찾기 여부
			System.out.println("실행!!!!!!!!!!!!!!!!!!!");
			map.put("isFollow", dao.isFollow(id, dao.getProduct(productIdx).getArtisanId()));
			System.out.println("================================="+dao.isFollow(id, dao.getProduct(productIdx).getArtisanId()));
			return map;
		}*/
		
}
