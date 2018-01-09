package com.icia.bachida.controller;

import java.io.*;
import java.security.*;
import java.util.*;

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
import org.springframework.web.servlet.mvc.support.*;

import com.google.gson.*;
import com.icia.bachida.service.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Controller
@RequestMapping("/artisan")
public class ProductController {
	@Autowired
	private ProductService service;
	@Autowired
	private ArtisanInfoService infoService;
	@Autowired
	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;

	/*
	 * 상품관리 area
	 */
	// 작품 리스트 c
	@GetMapping("/product_list")
	public String listProduct(@RequestParam(defaultValue = "1") int pageno, Model model, Principal principal,
			Product product) {
		// 카테고리는 리스트로 받아올꺼임....
		System.out.println("서비스 상품리스트:" + product);
		model.addAttribute("map", gson.toJson(service.listArtisanProductSalse(pageno, principal.getName(), product)));
		model.addAttribute("viewName", "artisan/listArtisanProductSalse.jsp");
		return "artisanHome";
	}

	// 작품 등록 폼 get c
	@GetMapping("/product_insert")
	public String insertProduct(Model model) {
		model.addAttribute("mainCategory", service.getMainCategoryName());
		model.addAttribute("metaCategory", service.getMetaCategoryName());
		model.addAttribute("viewName", "artisan/insertProduct.jsp");
		return "artisanHome";
	}

	// 작품등록 post c
	@PostMapping("/product_insert1")
	public String insertProduct(Product product, @RequestParam(required = false) MultipartFile[] files, Model model,
			Principal principal, HttpServletRequest req, RedirectAttributes ra) throws IOException {
		product.setArtisanId(principal.getName());
		product.setArtisanName(infoService.getArtisanInfo(principal.getName()).getArtisanName());
		// 글 등록, 파일, 카테고리, 옵션 - Product 객체 안에 담음
		System.out.println(product + "상품컨트롤러");
		System.out.println(files + "파일 컨트롤러");
		boolean result = service.insertProduct(product, files);
		ra.addFlashAttribute("isSuccess", result);
		return "redirect:/artisan/product_list";
	}

	// 작품수정 폼, 판매중, 매진 구분 할 것 c(팝업)
	@GetMapping("/product_update")
	public String viewProduct(Model model, int productIdx) {
		System.out.println(productIdx);
		model.addAttribute("viewProduct", gson.toJson(service.viewProduct(productIdx)));
		model.addAttribute("viewName", "artisan/productListUpdate.jsp");
		return "artisan/productListUpdate";
	}

	// 작품수정 , 판매중, 매진 구분 , 사진수정 생략
	@PostMapping("/product_update")
	public String updateProduct(Product product, Model model, HttpServletRequest req, RedirectAttributes ra) {
		System.out.println("product:" + product);
		Boolean result = service.updateProduct(product);
		ra.addFlashAttribute("isSuccess", result);
		return "redirect:/artisan/product_list";
	}

	// 삭제 - 권한 확인을 위해 매개변수를 product로 사용 c- ajax 사용으로 변경됨
	/*
	 * @PostMapping("/product_delete") public ResponseEntity<Boolean>
	 * deleteProduct(Product product, @RequestParam(required=false) String[]
	 * productIdx) { System.out.println(product); System.out.println(productIdx);
	 * List<Product> list = new ArrayList<Product>(); for(int i=0;
	 * i<productIdx.length; i++){ System.out.println(productIdx[i]);
	 * valueArr.size(); System.out.println(valueArr); }
	 * 
	 * boolean result = service.deleteProduct(productIdx); if(result) { return new
	 * ResponseEntity<Boolean>(result, HttpStatus.OK); }else { return new
	 * ResponseEntity<Boolean>(result, HttpStatus.NOT_FOUND); } }
	 */
	// 삭제 체크박스 사용
	@PostMapping("product_delete")
	public ResponseEntity<Boolean> deleteProduct(@RequestParam(value = "checkboxArray[]") List<Integer> checkbox) {
		boolean result = service.deleteProduct(checkbox);
		System.out.println(checkbox + "체크됨??");
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}

	// 파일업로드
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName, int productIdx) throws IOException {
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
		String originalFileName = service.getOriginalFileName(productIdx, fileName);
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
