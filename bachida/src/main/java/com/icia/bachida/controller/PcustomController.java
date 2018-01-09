package com.icia.bachida.controller;

import java.awt.image.*;
import java.io.*;
import java.nio.file.*;
import java.security.*;
import java.util.*;

import javax.imageio.*;
import javax.servlet.http.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.mvc.support.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

import net.coobird.thumbnailator.*;

// 1:1커스텀
@Controller
@RequestMapping("/pcustom")
public class PcustomController {

	@Autowired
	private PcustomService service;
	@Autowired
	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	// 글쓰기 작성 폼 보여주기
	@GetMapping("/insert_pcustom")
	public String insertPcustom(Model model) {
		model.addAttribute("viewName", "pcustom/insertPcustom.jsp");
		return "artisanHome";
	}

	// 글쓰기
	@PostMapping("/insert_pcustom")
	public String insertPcustom(Pcustom pcustom, @RequestParam(required=false) MultipartFile file, Principal principal, String artisanId) throws IOException {
		// 접속자 아이디
		//System.out.println(artisan.getArtisanId());
		pcustom.setId(principal.getName());
		// 작가아이디 가져오기
		
		System.out.println(pcustom);
		
		//pcustom.setArtisanId(artisan.getArtisanId());
		service.insertPcustom(pcustom, file);
		// 작가홈으로 리턴
		return "redirect:/artisantimeline/timeline_list/?artisanId=" + artisanId;
	}
	
	// 글수정 폼 보여주기
	@PostMapping("/update_pcustom/{pcustomIdx}")
	public String updatePcustom(Model model ,@PathVariable int pcustomIdx, Principal principal) {
		// 글 내용 가져오기
		model.addAttribute("update", gson.toJson(service.readPcustom(pcustomIdx)));
		model.addAttribute("viewName", "pcustom/updatePcustom.jsp");
		return "index";
	}
	// 글수정
	@PostMapping("/update_pcustom")
	public String updatePcustom(Pcustom pcustom, @RequestParam(required=false) MultipartFile file, Principal principal) throws IOException {
		// 파일 수정 안 할 경우
		if(file.getOriginalFilename()=="") {
			service.updatePcustom(pcustom);
		} else {	// 파일 수정 할 경우
			service.updateWithFilePcustom(pcustom, file);
		}
		return "redirect:/pcustom/read_pcustom/" + pcustom.getPcustomIdx();
	}
	/*@PostMapping("/update_pcustom/{pcustomIdx}")
	public String updatePcustom(Model model ,@PathVariable int pcustomIdx, Principal principal, Pcustom pcustom, @RequestParam(required=false) MultipartFile file) throws IOException {
		// 글 내용 가져오기
		model.addAttribute("update", gson.toJson(service.readPcustom(pcustomIdx)));
		model.addAttribute("viewName", "pcustom/updatePcustom.jsp");
		// 파일 수정 안 할 경우
		if(file.getOriginalFilename()=="") {
			service.updatePcustom(pcustom);
		} else {	// 파일 수정 할 경우
			service.updateWithFilePcustom(pcustom, file);
		}
		return "redirect:/pcustom/list_pcustom";
	}*/
	
	// 글삭제, 댓글도 같이 삭제
	@PostMapping("/delete_pcustom")
	public String deletePcustom(Principal principal, Pcustom pcustom) {
		String id = pcustom.getId();
		int pcustomIdx = pcustom.getPcustomIdx();
		service.deletePcustom(pcustomIdx, id);
		return "redirect:/user/myPcustom";
	}

	// 글목록
/*	@GetMapping("/list_pcustom")
	public String listPcustom(Model model) {
		model.addAttribute("list", gson.toJson(service.listPcustom()));
		model.addAttribute("viewName", "pcustom/listPcustom.jsp");
		return "index";
	}*/
	
	// 글목록(페이징 처리)
	@GetMapping("/list_pcustom")
	public String listPcustom(@RequestParam(defaultValue="1") int pageno, Model model, Principal principal) {
		// 작가아이디 가져오기
		//String artisanId = artisan.getArtisanId();
		model.addAttribute("map", gson.toJson(service.listPcustom(pageno, principal.getName())));
		model.addAttribute("viewName", "pcustom/listPcustom.jsp");
		return "artisanHome";
	}
	// 글목록(검색, 페이징 처리)
	@GetMapping("/search_list_pcustom")
	public String searchListPcustom(String keyword, @RequestParam(defaultValue="1") int pageno, Model model, Principal principal) {
		//System.out.println("\n pageno"+pageno+"\n");
		//System.out.println("\n keyword"+keyword+"\n");
		// 작가아이디 가져오기
		//String artisanId = artisan.getArtisanId();
		model.addAttribute("map", gson.toJson(service.searchListPcustom(pageno, keyword, principal.getName())));
		model.addAttribute("viewName", "pcustom/listPcustom.jsp");
		return "artisanHome";
	}

	// 글보기, 댓글도 같이보기
	@GetMapping("/read_pcustom/{pcustomIdx}")
	public String readPcustom(@PathVariable int pcustomIdx, Model model, Principal principal) {
		// 접속자아이디
		model.addAttribute("id", gson.toJson(principal.getName()));
		// 글보기
		model.addAttribute("read", gson.toJson(service.readPcustom(pcustomIdx)));	
		// 댓글보기
		model.addAttribute("readPcustomOpinion", gson.toJson(service.listPcustomOpinion(pcustomIdx)));
		// 가능한 버튼만 보이기
		// 견적서 유무 확인
		model.addAttribute("isPcustomEstimate", service.isPcustomEstimate(pcustomIdx));
		// 1:1커스텀 요청 여부 확인
		model.addAttribute("isRequestPcustom", service.isRequestPcustom(pcustomIdx));
		// 1:1커스텀 거부 여부 확인
		model.addAttribute("isByePcustom", service.isByePcustom(pcustomIdx));
		// 계약금 결제 유무 확인
		model.addAttribute("isDownPaymentPcustom", service.isDownPaymentPcustom(pcustomIdx));
		// 잔금 결제 유무 확인
		model.addAttribute("isFinallyPaymentPcustom", service.isFinallyPaymentPcustom(pcustomIdx));
		// 배송완료 유무 확인
		model.addAttribute("isDeliveryCompletedPcustom", service.isDeliveryCompletedPcustom(pcustomIdx));
		model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		return "artisanHome";
	}
	
/*	// 글보기, 댓글도 같이보기 페이징....
	@GetMapping("/read_pcustom/{pcustomIdx}")
	public String readPcustom(@PathVariable int pcustomIdx, Model model, @RequestParam(defaultValue="1") int pageno) {
		// 글보기
		model.addAttribute("read", gson.toJson(service.readPcustom(pcustomIdx)));	
		// 댓글보기
		model.addAttribute("listPcustomOpinion", gson.toJson(service.listPcustomOpinion(pcustomIdx, pageno)));
		
		// 가능한 버튼만 보이기
		// 견적서 유무 확인
		model.addAttribute("isPcustomEstimate", service.isPcustomEstimate(pcustomIdx));
		// 1:1커스텀 요청 여부 확인
		model.addAttribute("isRequestPcustom", service.isRequestPcustom(pcustomIdx));
		// 1:1커스텀 거부 여부 확인
		model.addAttribute("isByePcustom", service.isByePcustom(pcustomIdx));
		// 계약금 결제 유무 확인
		model.addAttribute("isDownPaymentPcustom", service.isDownPaymentPcustom(pcustomIdx));
		// 잔금 결제 유무 확인
		model.addAttribute("isFinallyPaymentPcustom", service.isFinallyPaymentPcustom(pcustomIdx));
		// 배송완료 유무 확인
		model.addAttribute("isDeliveryCompletedPcustom", service.isDeliveryCompletedPcustom(pcustomIdx));
		model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		return "index";
	}*/
	
	// 글보기
/*	@GetMapping("/read_pcustom/{pcustomIdx}")
	public String readPcustom(@PathVariable int pcustomIdx, Model model) {
		model.addAttribute("read", gson.toJson(service.readPcustom(pcustomIdx)));
		model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		return "index";
	}*/
	
	// 글 첨부파일 보기 또는 다운로드
	@GetMapping("/displayFileMain/{fileName}/{pcustomIdx}")
	public ResponseEntity<byte[]> displayFileMain(@PathVariable String fileName, @PathVariable int pcustomIdx) throws IOException {
		// 파라미터로 브라우저에서 전송받기를 원하는 파일 이름 받기
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
		String originalFileName = service.getPcustomOriginalFileName(pcustomIdx);
		
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		File dest = null;
		
		try {
			File src = new File(uploadPath, fileName);
			dest = new File(uploadPath, originalFileName);
			
			FileCopyUtils.copy(src, dest);
			
			// 이미지 타입이라면 파일 이름에서 확장자를 추출
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();
			
			if(mType!=null)
				headers.setContentType(mType);
			else {
				// 이미지가 아니라면 자동으로 다운로드
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Dispostion", "attachment;filename=" + dest.getName());
			}
			
			in = new FileInputStream(dest);
			// 실제로 데이터를 읽어옴
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (IOException e) {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
			if(dest.exists())
				dest.delete();
		}
		// 결과는 실제 파일의 데이터
		return entity;
	}
	
	// 댓글 쓰고 보기(1:1커스텀 의견조율)
/*	@PostMapping("/insert_pcustom_opinion")
	public ResponseEntity<List<PcustomOpinion>> insertAndReadPcustomOpinion(Model model, PcustomOpinion pcustomOpinion, @RequestParam(required=false) MultipartFile file, RedirectAttributes ra) throws IOException {
		pcustomOpinion.setId("DAY6");
		//List<PcustomOpinion> listPcustomOpinion = service.insertAndReadPcustomOpinion(pcustomOpinion, file);
		model.addAttribute("reply", gson.toJson(service.insertAndReadPcustomOpinion(pcustomOpinion, file)));
		return new ResponseEntity<List<PcustomOpinion>>(service.insertAndReadPcustomOpinion(pcustomOpinion, file), HttpStatus.OK);
	}*/
	/*
	@PostMapping("/insert_pcustom_opinion/{pcustomIdx}")
	public String insertAndReadPcustomOpinion(PcustomOpinion pcustomOpinion, Model model, @PathVariable int pcustomIdx, @RequestParam(required=false) MultipartFile file, RedirectAttributes ra) {
		pcustomOpinion.setId("DAY6");
		try {
			List<PcustomOpinion> listPcustomOpinion = service.insertAndReadPcustomOpinion(pcustomOpinion, file);
			model.addAttribute("reply", gson.toJson(listPcustomOpinion));
			model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "index";
	}
*/
	// 댓글 쓰고 보기(1:1커스텀 의견조율)
/*	@PostMapping("/insert_pcustom_opinion")
	public ResponseEntity<List<PcustomOpinion>> insertAndReadPcustomOpinion(PcustomOpinion pcustomOpinion, @RequestParam(required=false) MultipartFile file) throws IOException {
		pcustomOpinion.setId("DAY6");
		service.insertAndReadPcustomOpinion(pcustomOpinion, file);
		return new ResponseEntity<List<PcustomOpinion>>(service.insertAndReadPcustomOpinion(pcustomOpinion, file), HttpStatus.OK);
	}
*/

	// 댓글 쓰기 ajax
	@PostMapping("/insert_pcustom_opinion")
	public ResponseEntity<List<PcustomOpinion>> insertPcustomOpinion(PcustomOpinion pcustomOpinion, @RequestParam(required=false) MultipartFile file, Principal principal) throws IOException {
		//System.out.println(pcustomOpinion);
		//System.out.println(file);
		//pcustomOpinion.setId("DAY6");
		pcustomOpinion.setId(principal.getName());
		service.insertPcustomOpinion(pcustomOpinion, file);
		List<PcustomOpinion> listPcustomOpinion = service.listPcustomOpinion(pcustomOpinion.getPcustomIdx());
		return new ResponseEntity<List<PcustomOpinion>>(listPcustomOpinion, HttpStatus.OK);
	}
	
	// 댓글 목록
	@GetMapping("/list_pcustom_opinion/{pcustomIdx}")
	public String listPcustomOpinion(Model model, @PathVariable int pcustomIdx) {
		model.addAttribute("listPcustomOpinion", gson.toJson(service.listPcustomOpinion(pcustomIdx)));
		model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		return "artisanHome";
	}
	
/*	// 댓글 쓰기 ajax(페이징)
	@PostMapping("/insert_pcustom_opinion")
	public ResponseEntity<PcustomOpinion> insertPcustomOpinion(PcustomOpinion pcustomOpinion, @RequestParam(required=false) MultipartFile file) throws IOException {
		//System.out.println(pcustomOpinion);
		//System.out.println(file);
		pcustomOpinion.setId("DAY6");
		service.insertPcustomOpinion(pcustomOpinion, file);
		PcustomOpinion readPcustomOpinion = service.readPcustomOpinion(pcustomOpinion.getPcustomIdx());
		return new ResponseEntity<PcustomOpinion>(readPcustomOpinion, HttpStatus.OK);
	}
	
	// 댓글 목록(페이징)
	@GetMapping("/list_pcustom_opinion/{pcustomIdx}")
	public String listPcustomOpinion(Model model, @PathVariable int pcustomIdx, @RequestParam(defaultValue="1") int pageno) {
		model.addAttribute("listPcustomOpinion", gson.toJson(service.listPcustomOpinion(pcustomIdx, pageno)));
		model.addAttribute("viewName", "pcustom/readPcustom.jsp");
		return "index";
	}*/
	
	// 댓글 첨부파일 보기 또는 다운로드
	@GetMapping("/displayFileServe/{fileName}/{pcustomOpinionIdx}")
	public ResponseEntity<byte[]> displayFileServe(@PathVariable String fileName, @PathVariable int pcustomOpinionIdx) throws IOException {
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
		String originalFileName = service.getPcustomOpinionOriginalFileName(pcustomOpinionIdx);
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		File dest = null;
		try {
			File src = new File(uploadPath, fileName);
			dest = new File(uploadPath, originalFileName);
			FileCopyUtils.copy(src, dest);
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			if(mType!=null)
				headers.setContentType(mType);
			else {
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Dispostion", "attachment;filename=" + dest.getName());
			}
			in = new FileInputStream(dest);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (IOException e) {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
			if(dest.exists())
				dest.delete();
		}
		return entity;
	}
	
	// 1:1커스텀 수락. 작가가
	@PostMapping("/ok_pcustom/{pcustomIdx}")
	public String okPcustom(@PathVariable int pcustomIdx, String artisanId, Principal principal) {
		//String artisanId = principal.getName();
		service.okPcustom(pcustomIdx, artisanId);
		return "redirect:/pcustom/read_pcustom/" + pcustomIdx;
	}
	
	// 1:1커스텀 거절. 작가가
	@PostMapping("/bye_pcustom/{pcustomIdx}")
	public String byePcustom(@PathVariable int pcustomIdx, String artisanId, Principal principal) {
		//String artisanId = principal.getName();
		service.byePcustom(pcustomIdx, artisanId);
		return "redirect:/pcustom/list_pcustom";
	}
	
	// 견적서 작성 폼 보여주기. 작가가..
	@PostMapping("/insert_pcustom_estimate_go")
	public String insertPcustomEstimate(Model model, Pcustom pcustom, Principal principal) {
		model.addAttribute("pcustom", gson.toJson(pcustom));
		model.addAttribute("viewName", "pcustom/insertEstimatePcustom.jsp");
		return "artisanHome";
	}
	
	// 견적서 작성. 작가가
	@PostMapping("/insert_pcustom_estimate")
	public String insertPcustomEstimate(ProductionOrder productionOrder) {
		service.insertPcustomEstimate(productionOrder);
		// 글보기로 리다이렉트
		return "redirect:/pcustom/read_pcustom/"+productionOrder.getPcustomIdx();
	}
	
/*	// 견적서 에이작스 해보자..
	@GetMapping("/insert_pcustom_estimate_go")
	public String insertPcustomEstimate(Model model, Pcustom pcustom) {
		model.addAttribute("pcustom", gson.toJson(pcustom));
		model.addAttribute("viewName", "pcustom/insertEstimatePcustom.jsp");
		return "index";
	}
	// 견적서 작성 해보자.
		@PostMapping("/insert_pcustom_estimate")
		public void insertPcustomEstimate(ProductionOrder productionOrder) {
			service.insertPcustomEstimate(productionOrder);
			new ResponseEntity<Void>(HttpStatus.OK);
		}
	*/
	// 견적서 확인
	@PostMapping("/read_pcustom_estimate/{pcustomIdx}")
	public String readPcustomEstimate(@PathVariable int pcustomIdx, Model model, ProductionOrder productionOrder, Principal principal) {
		// 접속자 아이디
		model.addAttribute("id", gson.toJson(principal.getName()));
		// 견적서 읽기
		model.addAttribute("estimate", gson.toJson(service.readPcustomEstimate(pcustomIdx, productionOrder)));
		// 계약금 결제 유무 확인
		model.addAttribute("isDownPaymentPcustom", service.isDownPaymentPcustom(pcustomIdx));
		// 잔금 결제 유무 확인
		model.addAttribute("isFinallyPaymentPcustom", service.isFinallyPaymentPcustom(pcustomIdx));
		//System.out.println("isDownPaymentPcustom:" + service.isDownPaymentPcustom(pcustomIdx));
		//System.out.println("isFinallyPaymentPcustom:" + service.isFinallyPaymentPcustom(pcustomIdx));
		// 배송완료 유무 확인
		model.addAttribute("isDeliveryCompletedPcustom", service.isDeliveryCompletedPcustom(pcustomIdx));
		model.addAttribute("viewName", "pcustom/readEstimatePcustom.jsp");
		return "artisanHome";
	}
	
	// 견적서 수정 폼 보여주기
	@PostMapping("/update_pcustom_estimate_go/{pcustomIdx}")
	public String updatePcustomEstimate(Model model, @PathVariable int pcustomIdx, ProductionOrder productionOrder, Principal principal) {
		model.addAttribute("id", gson.toJson(principal.getName()));
		model.addAttribute("estimate", gson.toJson(service.readPcustomEstimate(pcustomIdx, productionOrder)));
		model.addAttribute("viewName", "pcustom/updateEstimatePcustom.jsp");
		return "artisanHome";
	}
	
	// 견적서 수정
	@PostMapping("/update_pcustom_estimate")
	public String updatePcustomEstimate(ProductionOrder productionOrder, Principal principal) {
		System.out.println(productionOrder);
		service.updatePcustomEstimate(productionOrder);
		return "redirect:/pcustom/read_pcustom/" + productionOrder.getPcustomIdx();
	}
	
	// 계약금 결제 폼 보여주기
	@PostMapping("/down_payment_pcustom_go/{pcustomIdx}")
	public String downPaymentPcustom(Model model, @PathVariable int pcustomIdx, ProductionOrder productionOrder, Principal principal) {
		// 접속자 아이디
		model.addAttribute("id", gson.toJson(principal.getName()));
		// 견적서 읽어오기
		model.addAttribute("estimate", gson.toJson(service.readPcustomEstimate(pcustomIdx, productionOrder)));	
		// 구매자 캐쉬 정보 가져오기(아이디, 캐쉬)
		model.addAttribute("cash", gson.toJson(service.getCashByMember(productionOrder.getId())));
		model.addAttribute("viewName", "pcustom/downPaymentPcustom.jsp");
		return "artisanHome";
	}
	
	// 계약금 결제
	@PostMapping("/down_payment_pcustom")
	public String downPaymentPcustom(ProductionOrder productionOrder, User user, int downPayment, Principal principal) {
		//System.out.println(productionOrder+"\n"+user+"\n"+downPayment);
		// 구매자 캐쉬 업데이트(캐쉬 차감, 캐쉬 내역 삽입)
		service.updateCash(user.getId(), downPayment);
		// 작가 캐쉬 없데이트(캐쉬 입금, 캐쉬 내역 삽입)
		service.updateArtisanCash(productionOrder.getArtisanId(), downPayment);
		//System.out.println("\n"+productionOrder.getArtisanId()+"\n");
		// productionOrder테이블 업데이트(주문상태, 주소)
		service.downPaymentPcustom(productionOrder);	
		return "redirect:/pcustom/read_pcustom/" + productionOrder.getPcustomIdx();
	}
		
	// 잔금 결제 폼 보여주기
	@PostMapping("/finally_payment_pcustom_go/{pcustomIdx}")
	public String finallyPaymentPcustom(Model model, @PathVariable int pcustomIdx, ProductionOrder productionOrder, Principal principal) {
		// 접속자 아이디
		model.addAttribute("id", gson.toJson(principal.getName()));
		model.addAttribute("estimate", gson.toJson(service.readPcustomEstimate(pcustomIdx, productionOrder)));
		model.addAttribute("cash", gson.toJson(service.getCashByMember(productionOrder.getId())));
		model.addAttribute("viewName", "pcustom/finallyPaymentPcustom.jsp");
		return "artisanHome";
	}
		
	// 잔금 결제
	@PostMapping("/finally_payment_pcustom")
	public String finallyPaymentPcustom(ProductionOrder productionOrder, User user,int finallyPayment, Principal principal) {
		// 구매자 캐쉬 업데이트(캐쉬 차감, 캐쉬 내역 삽입)
		service.updateCash(user.getId(), finallyPayment);
		// 작가 캐쉬 없데이트(캐쉬 입금, 캐쉬 내역 삽입)
		service.updateArtisanCash(productionOrder.getArtisanId(), finallyPayment);
		// productionOrder테이블 업데이트(주문상태)
		service.finallyPaymentPcustom(productionOrder);
		return "redirect:/pcustom/read_pcustom/" + productionOrder.getPcustomIdx();
	}
	
	// 배송완료 폼 보여주기
	@PostMapping("/delivery_completed_pcustom_go/{pcustomIdx}")
	public String deliveryCompletedPcustom(Model model, @PathVariable int pcustomIdx, ProductionOrder productionOrder, Principal principal) {
		// 접속자 아이디
		model.addAttribute("id", gson.toJson(principal.getName()));
		model.addAttribute("estimate", gson.toJson(service.readPcustomEstimate(pcustomIdx, productionOrder)));
		model.addAttribute("viewName", "pcustom/deliveryCompletedPcustom.jsp");
		return "artisanHome";
	}
	
	// 배송완료
	@PostMapping("/delivery_completed_pcustom")
	public String deliveryCompletedPcustom(ProductionOrder productionOrder, Principal principal) {
		//productionOrder.setArtisanId(principal.getName());
		// productionOrder테이블 업데이트(택배이름, 운송장번호, 주문상태)
		service.deliveryCompletedPcustom(productionOrder);
		return "redirect:/pcustom/read_pcustom/" + productionOrder.getPcustomIdx();
	}
	
	
	
	// 메인홈 검색바(작품 검색)
		@GetMapping("/search_list_pcustom1")
		public String searchListProduct(String keyword1, @RequestParam(defaultValue="1") int pageno, Model model,Principal principal, Product product) {
			//System.out.println("\n pageno"+pageno+"\n");
			//System.out.println("\n keyword"+keyword+"\n");
			String id="";
			if(principal != null) {
				 id = principal.getName();
			}else {
				id = "guest";
			}
			//System.out.println("간달츠!!!");
			model.addAttribute("product", gson.toJson(service.searchListProduct(pageno, keyword1)));
			//model.addAttribute("product", gson.toJson(service.getProduct(product.getProductIdx(), id)));
			model.addAttribute("viewName", "product/search_list_product.jsp");
			return "index";
		}
		// 상품리스트
		/*@GetMapping("/{mainCategoryIdx}/{metaCategoryIdx}")
		public String getProductList(Model model, @PathVariable int mainCategoryIdx, @PathVariable int metaCategoryIdx,@RequestParam(defaultValue="1") int pageno,Principal principal) { // principal
			String id="";
			if(principal != null) {
				 id = principal.getName();
			}else
				id = "guest";
			model.addAttribute("product", gson.toJson(service.getProductList(mainCategoryIdx, metaCategoryIdx, id,pageno)));
			model.addAttribute("viewName", "product/list_product.jsp");
			return "index";
		}*/
		
}
	
