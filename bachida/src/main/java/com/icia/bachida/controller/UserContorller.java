package com.icia.bachida.controller;

import java.io.*;
import java.security.*;
import java.util.*;

import javax.mail.*;
import javax.servlet.http.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.security.web.authentication.logout.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;
import com.icia.bachida.vo.Message;



@Controller
@RequestMapping("/user")
public class UserContorller {
	@Autowired
	private UserService service;
	@Autowired
	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	//로그인 페이지 이동
	@PreAuthorize("isAnonymous()")
	@GetMapping("/login")
	public String login(Model model,HttpServletRequest request) {
		String referrer = request.getHeader("Referer");
	    request.getSession().setAttribute("prevPage", referrer);
		model.addAttribute("viewName", "user/login.jsp");
		return "index";
	}
	
	// 회원가입페이지 이동
	@PreAuthorize("isAnonymous()")
	@GetMapping("/join")
	public String join(Model model) {
		model.addAttribute("viewName", "user/join.jsp");
		return "index";
	}

	// 회원가입
	@PostMapping("/join")
	public String join(User user, @RequestParam(required = false) String[] interest, Model model) {
		List<Interest> interests = new ArrayList<Interest>();
		List<Authority> auths = new ArrayList<Authority>();
		auths.add(new Authority("ROLE_USER"));
		System.out.println(interest==null);
		if (interest != null) {
			for (int i = 0; i < interest.length; i++)
				interests.add(new Interest(Integer.parseInt(interest[i])));
			user.setInterests(interests);
		}
		user.setAuthorities(auths);
		
		service.JoinUser(user);
		return "redirect:/";
	}

	// 아이디중복확인
	@PostMapping("/idCheck")
	public ResponseEntity<Boolean> idCheck(String id) {
		boolean result = service.idCheck(id);
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 아이디패스워드찾기 페이지이동
	@PreAuthorize("isAnonymous()")
	@GetMapping("/idPwdFind")
	public String idPwdFind(Model model) {
		model.addAttribute("viewName", "user/idPwdFind.jsp");
		return "index";
	}
	
	// 아이디찾기
	@PostMapping("/idFind")
	public ResponseEntity<String> idFind(String name, String email){
		System.out.println(name+" "+email);
		return new ResponseEntity<String>(service.findId(name, email), HttpStatus.OK);
	}
	
	// 비밀번호찾기(이메일인증전)
	@PostMapping("/pwdFind")
	public ResponseEntity<String> pwdFind(String id, String email) throws MessagingException{
		return new ResponseEntity<String>(service.sendEmailForPwdFind(id, email),HttpStatus.OK);
	}
	
	//비밀번호 페이지이동
	@PostMapping("/completeConfirmation")
	public String completeConfirmation(String id,Model model) {
		model.addAttribute("id", gson.toJson(id));
		model.addAttribute("viewName", "user/pwdChange.jsp");
		return "index";
	}
	
	// 비밀번호수정
	@PostMapping("/pwdChange")
	public ResponseEntity<Boolean> pwdChange(String id,String pwd){
		return new ResponseEntity<Boolean>(service.changePassword(id, pwd),HttpStatus.OK);
	}
	
	// 회원정보얻어오기(회원정보수정)
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/updateUser")
	public String updateUser(Model model,Principal principal) {
		String id = principal.getName();
		model.addAttribute("mypage_user", gson.toJson(service.getUserForUpdate(id)));
		System.out.println(service.getUserForUpdate(id));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/updateUser.jsp");
		return "index";
	}
	
	//회원정보수정
	@PostMapping("/updateUser")
	public ResponseEntity<Boolean> updateUser(User user,@RequestParam(required=false) String newPassword,@RequestParam(required = false) String[] interest) {
		System.out.println(newPassword);
		List<Interest> list = new ArrayList<Interest>();
		if (interest != null) {
			for (int i = 0; i < interest.length; i++) {
				list.add(new Interest(Integer.parseInt(interest[i])));
			}
		}
		user.setInterests(list);
		return new ResponseEntity<Boolean>(service.updateUser(user, newPassword),HttpStatus.OK);
	}
	
	//작가신청페이지 이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/artisanApply")
	public String artisanApply(Model model) {
		return "user/writeApply";
	}
	
	//작가신청글쓰기 principal
	@PostMapping("/artisanApply")
	public ResponseEntity<Boolean> artisanApply(ArtisanApply artisanApply,MultipartFile[] files,Principal principal) throws IOException {
		String id = principal.getName();
		return new ResponseEntity<Boolean>(service.writeArtisanApply(artisanApply, files, id), HttpStatus.OK);
	}
	
	//작가신청 내역보기 principal
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/applyList")
	public String applyList(@RequestParam(defaultValue="1")int pageno ,Model model,Principal principal) {
		String id=principal.getName();
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/listMyApply.jsp");
		model.addAttribute("list", gson.toJson(service.getApplyListById(id,pageno)));
		return "index";
	}
	
	//작가신청보기
	@GetMapping("/applyView/{artisanApplyIdx}")
	public String applyView(@PathVariable int artisanApplyIdx ,Model model) {
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/viewApply.jsp");
		model.addAttribute("apply", gson.toJson(service.getApplyByIdx(artisanApplyIdx)));
		return "index";
	}
	
	//사진파일띄우기
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFileServe(String savedFileName,String originalFileName) throws IOException {
		String formatName = savedFileName.substring(savedFileName.lastIndexOf(".") + 1).toUpperCase();
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		File dest = null;
		try {
			File src = new File(uploadPath, savedFileName);
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
	@GetMapping("/displayFile/{productIdx}")
	public ResponseEntity<byte[]> displayFileServe(@PathVariable int productIdx) throws IOException{
		Map<String, String> map = service.getFileNameByProductidx(productIdx);
		String savedFileName = map.get("SAVEDFILENAME");
		String originalFileName = map.get("ORIGINALFILENAME");
		String formatName = savedFileName.substring(savedFileName.lastIndexOf(".") + 1).toUpperCase();
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		File dest = null;
		try {
			File src = new File(uploadPath, savedFileName);
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
	
	//신고작성페이지이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/writeReport/{reportId}")
	public String writeReport(@PathVariable String reportId,Model model) {
		model.addAttribute("reportId", gson.toJson(reportId));
		return "user/writeReport";
	}
	//신고하기
	@PostMapping("/writeReport")
	public ResponseEntity<Boolean> writeReport(Report report, MultipartFile file,Principal principal) throws IOException{
		report.setId(principal.getName());
		service.writeReport(report,file);
		return new ResponseEntity<Boolean>(true,HttpStatus.OK);
	}
	
	//내신고내역 보기
	@GetMapping("/listReport")
	public String listMyReport(@RequestParam(defaultValue="1")int pageno,Model model,Principal principal) {
		String id = principal.getName();
		model.addAttribute("list", gson.toJson(service.getMyReportList(id,pageno)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/listMyReport.jsp");
		return "index";
	}
	
	//회원탈퇴 페이지이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/resign")
	public String resign(Model model){
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/resign.jsp");
		return "index";
	}
	//이메일전송(회원탈퇴)
	@PostMapping("/resign")
	public ResponseEntity<String> resign(User user) throws MessagingException{
		return new ResponseEntity<String>(service.sendEmailForResign(user), HttpStatus.OK);
	}
	
	//회원탈퇴
	@PostMapping("/resignUser")
	public String resignuser(String id, SecurityContextLogoutHandler handler , HttpServletRequest request, HttpServletResponse response, Authentication auth) {
		service.resignUser(id);
		handler.logout(request, response, auth);
		return "redirect:/";
	}
	
	//메세지리스트 principal
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/receiveMsgList")
	public String recieveMsgList(@RequestParam(defaultValue="1")int pageno,Model model,Principal principal) {
		String id=principal.getName();
		model.addAttribute("list", gson.toJson(service.receiveMsgList(id,pageno)));
		return "user/listReceiveMsg";
	}
	@GetMapping("/sendMsgList")
	public String sendMsgList(@RequestParam(defaultValue="1")int pageno,Model model,Principal principal) {
		String id=principal.getName();
		model.addAttribute("list", gson.toJson(service.sendMsgList(id,pageno)));
		return "user/listSendMsg";
	}
	
	//메세지보기
	@GetMapping("/recieveMsgView/{messageIdx}")
	public String msgReceiveView(Model model,@PathVariable int messageIdx,Principal principal) {
		model.addAttribute("message", gson.toJson(service.getMessage(messageIdx,principal.getName())));
		return "user/viewReceiveMsg";
	}
	@GetMapping("/sendMsgView/{messageIdx}")
	public String msgSendView(Model model,@PathVariable int messageIdx,Principal principal) {
		model.addAttribute("message", gson.toJson(service.getMessage(messageIdx,principal.getName())));
		return "user/viewSendMsg";
	}
	
	//메세지삭제(받은쪽지함)
	/*@GetMapping("/msgDelete")
	public String msgDeleteForSendData(int[] messageIdx) {
		System.out.println(messageIdx.length);
		return "redirect:/user/recieveMsgList";
	}
	@PostMapping("/msgDelete")
	public String msgDelete(int[] messageIdx) {
		System.out.println(messageIdx.length);
		return "redirect:/user/sendMsgList";
	}*/
	
	//메세지작성폼이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/msgWriteForm")
	public String msgWriteForm(String receiver,Model model) {
		model.addAttribute("receiver", gson.toJson(receiver));
		return "user/writeMsg";
	}
	//메세지작성 principal
	@PostMapping("/msgWrite")
	public ResponseEntity<Void> msgWrite(Message msg,Model model,Principal principal) {
		System.out.println(msg);
		msg.setSender(principal.getName()); //이부분에 principal삽입
		service.WriteMessage(msg);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//캐쉬충전페이지이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/cashCharge")
	public String cashCharge(Model model) {
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/chargeCash.jsp");
		return "index";
	}
	
	//캐쉬충전하기 principal
	@PostMapping("/cashCharge")
	public ResponseEntity<Void> cashCharge(int cash,Principal principal){
		String id= principal.getName();
		service.cashCharge(id, cash);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//캐쉬내역보기 principal
	@GetMapping("/cashList")
	public String cashList(Model model, Principal principal) {
		String id=principal.getName();
		//model.addAttribute("user",service.getUserCash(id));
		model.addAttribute("map", gson.toJson(service.getCashList(id)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/listCash.jsp");
		return "index";
	}
	
	//주문내역
	@GetMapping("/myOrderList")
	public String myOrderlist(Model model,Principal principal) {
		String id=principal.getName();
		model.addAttribute("order", gson.toJson(service.MyOrderList(id)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/myOrderList.jsp");
		return "index";
	}
	
	//주문상세보기
	@GetMapping("/orderView/{orderIdx}")
	public String orderView(Model model, @PathVariable int orderIdx) {
		model.addAttribute("orderDetail", gson.toJson(service.getOrderDetail(orderIdx)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/orderView.jsp");
		return "index";
	}
	
	//상품배송완료 처리하기
	@PostMapping("/DeliveryComplete")
	public ResponseEntity<Void> deliveryComplete(int orderProductIdx){
		service.DeliveryComplete(orderProductIdx);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//상품평쓰기 페이지이동
	@GetMapping("/writeComment")
	public String writeComment(OrderProduct op, Model model) {
		model.addAttribute("orderProduct", gson.toJson(op));
		model.addAttribute("product", gson.toJson(service.getProductForCommnet(op.getProductIdx())));
		return "user/writeComment";
	}
	
	//상품평쓰기 principal
	@PostMapping("/writeComment")
	public ResponseEntity<Void> writeComment(ProductComment comment,@RequestParam(required=false) MultipartFile file,int orderProductIdx, Model model,Principal principal) throws IOException {
		comment.setId(principal.getName());
		System.out.println(file.getOriginalFilename());
		service.WriteComment(comment,file,orderProductIdx);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	//나의 제작요청내역 principal
	@GetMapping("/myCustom")
	public String myCustom(@RequestParam(defaultValue="1") int pageno,Model model,Principal principal) {
		model.addAttribute("map", gson.toJson(service.getMyCustom(principal.getName(), pageno)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/myCustom.jsp");
		return "index";
	}
	
	//나의 1:1제작요청내역
	@GetMapping("/myPcustom")
	public String mypCustom(@RequestParam(defaultValue="1") int pageno,Model model,Principal principal) {
		model.addAttribute("map", gson.toJson(service.getMyPcustom(principal.getName(), pageno)));
		model.addAttribute("viewName", "mypage.jsp");
		model.addAttribute("mypage", "user/mypCustom.jsp");
		return "index";
	}
}
