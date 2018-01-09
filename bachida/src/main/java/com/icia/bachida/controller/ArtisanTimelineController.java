package com.icia.bachida.controller;

import java.io.*;
import java.security.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.google.gson.*;
import com.google.gson.reflect.*;
import com.icia.bachida.service.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Controller
@RequestMapping("/artisantimeline")
public class ArtisanTimelineController {
	@Autowired private ArtisanTimelineService service;
	@Autowired private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	// 타임라인 list
		@GetMapping("/timeline_list")
		public String listArtisanTimeline(@RequestParam(defaultValue = "1") int pageno, Model model ,Principal principal, String artisanId ,HttpSession session) {
			// 버튼 등에서 넘어올때 작가 id 같이 넘기기
			String id="";
			if(principal !=null)
				id=principal.getName();
			else
				id="guest";
			
			model.addAttribute("isFollow", gson.toJson(service.isFollow(id,artisanId)));
			//System.out.println("서비스 타임라인:" + artisanTimeline);
			model.addAttribute("map", gson.toJson(service.listArtisanTimeline(pageno, artisanId)));
			model.addAttribute("name",gson.toJson(id));
			model.addAttribute("artisanId",gson.toJson(artisanId));	// artisanName 으로 보내야??
			model.addAttribute("viewName", "artisan/listArtisanTimeline.jsp");
			session.setAttribute("name", gson.toJson(id));
			session.setAttribute("map", gson.toJson(service.listArtisanTimeline(pageno, artisanId)));
			return "artisanHome";
		}

		// 타임라인 작성 폼
		@GetMapping("/timeline_insert")
		public String insertArtisanTimeline(Model model) {
			model.addAttribute("viewName", "artisan/insertArtisanTimeline.jsp");
			return "artisanHome";
		}

		// 타임라인 작성
		@PostMapping("/timeline_insert")
		public String insertArtisanTimeline(ArtisanTimeline artisanTimeline, @RequestParam(required=false) MultipartFile pic, RedirectAttributes ra,Principal principal) throws IOException {
			//작가 아이디
			artisanTimeline.setArtisanId(principal.getName());
			
			//insert
			boolean result = service.insertArtisanTimeline(artisanTimeline,pic);
			ra.addFlashAttribute("isSuccess", result);
			
			return "redirect:/artisantimeline/timeline_list?artisanId=" + principal.getName();
		}
		
		/*//타임라인 수정 폼
		@GetMapping("/timeline_update")
		public String updateArtisanTimelineForm(Model model, int artisanTimelineIdx ) {
			System.out.println(artisanTimelineIdx);
			model.addAttribute("viewTimeline",gson.toJson(service.updateArtisanTimelineForm(artisanTimelineIdx)));
			model.addAttribute("viewName","artisan/updateArtisanTimeline.jsp");
			return "index";
		}
		
		// 타임라인 수정
		@PostMapping("/timeline_update")
		public String updateArtisanTimeline(ArtisanTimeline artisanTimeline,@RequestParam(required = false) MultipartFile pic, RedirectAttributes ra)throws IOException {
			System.out.println("artisanTimeline:" + artisanTimeline);
			Boolean result = service.updateArtisanTimeline(artisanTimeline,pic);
			ra.addFlashAttribute("isSuccess", result);
			return "redirect:/";
		}*/

		// 타임라인 삭제
		@PostMapping("/timeline_delete")
		public ResponseEntity<Void> deleteArtisanTimeline(int artisanTimelineIdx) {
			System.out.println(artisanTimelineIdx);
			service.deleteArtisanTimeline(artisanTimelineIdx);
			return new ResponseEntity<Void>(HttpStatus.OK);
		}

		// 타임라인 추천
		@PostMapping("/recommed_timeline")
		public ResponseEntity<Void> insertRecommendArtisanTimeline(int artisanTimelineIdx) {
			System.out.println(artisanTimelineIdx);
			service.RecommendArtisanTimeline(artisanTimelineIdx);
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		

		// 작가 즐겨찾기
		@PostMapping("/add_artisan")
		public ResponseEntity<Integer> insertArtisanBookmarkForMember(Principal principal,String artisanId) {
			
			//System.out.println(artisanId);
			return new ResponseEntity<Integer>(service.insertArtisanBookmarkForMember(principal.getName(),artisanId),HttpStatus.OK);
		}

		// 타임라인 파일업로드 view
		@GetMapping("/displayFile/{fileName}/{artisanTimelineIdx}")
		public ResponseEntity<byte[]> TimelinedisplayFile(@PathVariable String fileName,@PathVariable int artisanTimelineIdx) throws IOException {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
			String originalFileName = service.getTimelineOriginalFileName(artisanTimelineIdx);
			System.out.println("타임라인 컨트롤러 업로드 "+originalFileName);
			
			ResponseEntity<byte[]> entity = null;
			InputStream in = null;
			File dest = null;
			try {
				File src = new File(uploadPath, fileName);
				dest = new File(uploadPath, originalFileName);
				FileCopyUtils.copy(src, dest);
				MediaType mType = MediaUtils.getMediaType(formatName);
				HttpHeaders headers = new HttpHeaders();
				if (mType != null)
					headers.setContentType(mType);
				else {
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment;filename=" + dest.getName());
				}
				in = new FileInputStream(dest);
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			} catch (IOException e) {
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			} finally {
				in.close();
				if (dest.exists())
					dest.delete();
			}
			return entity;
		}
		//작가 정보 viewFile
		@GetMapping("/artisanDisplayFile/{artisanId}")
		public ResponseEntity<byte[]> ArtisanInfodisplayFile(@PathVariable String artisanId) throws IOException {
			System.out.println("1    "+artisanId);
			Map<String, String> map = service.getArtisanInfoOriginalFileName(artisanId);
			System.out.println("2     "+map);
			String savedFileName = map.get("SAVEDFILENAME");
			String originalFileName = map.get("ORIGINALFILENAME");
			System.out.println("\n"+savedFileName+"\n"+originalFileName);
			String formatName = savedFileName.substring(savedFileName.lastIndexOf(".") + 1).toUpperCase();
			System.out.println(formatName);
			
			ResponseEntity<byte[]> entity = null;
			InputStream in = null;
			File dest = null;
			try {
				File src = new File(uploadPath, savedFileName);
				dest = new File(uploadPath, originalFileName);
				FileCopyUtils.copy(src, dest);
				
				System.out.println(src+"    "+dest);
				MediaType mType = MediaUtils.getMediaType(formatName);
				
				System.out.println(mType);
				
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
	
}
