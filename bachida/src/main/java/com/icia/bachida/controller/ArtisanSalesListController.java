package com.icia.bachida.controller;

import java.io.*;
import java.security.*;
import java.util.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.util.*;
import org.springframework.web.bind.annotation.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Controller
@RequestMapping("/artisan/sale")
public class ArtisanSalesListController {
	@Autowired
	private ArtisanSalesListSerive service;
	@Autowired
	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;

	// 판매 리스트 : 전체, (차후 - 인기순, 가격별, 판매 아이템별 리스트 작성)
	@GetMapping("/sales_list")
	public String getSalesList(Model model, @RequestParam(defaultValue = "1") int pageno, String artisanId) {// principal
		//System.out.println("컨트롤러 : " + principal.getName());
		System.out.println("컨트롤러 아이디"+artisanId);
		model.addAttribute("artisanProduct", gson.toJson(service.getSalesList(artisanId, pageno)));
		model.addAttribute("viewName", "artisan/SalseList.jsp");
		return "artisanHome";
	}
	
	
	
	// 파일업로드 view
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName, int productIdx) throws IOException {
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
		String originalFileName = service.getOriginalFileName(productIdx, fileName);
		System.out.println(originalFileName);
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
	

}
