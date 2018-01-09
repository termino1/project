package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.icia.bachida.mapper.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Service
public class CustomService {
	@Autowired
	private CustomMapper mapper;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	@PreAuthorize("isAuthenticated()")
	public Map<String,Object> getCustomRequestList(int pageno) {
		int articleCnt = mapper.getBoardCount();
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pagination", pagination);
		map.put("list", mapper.getCustomRequestList(pagination.getStartArticleNum(), pagination.getEndArticleNum()));
		return map;
	}
	
	
	
	public Map<String, Object> getCustomRequest(int customIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("custom", mapper.getCustomRequest(customIdx));
		// 조회수증가
		mapper.increaseViewCnt(customIdx);
		// 입찰+입찰첨부파일
		List<Bid> list = mapper.getBidList(customIdx);
		List<BidAttach> attachList = new ArrayList<BidAttach>();
		List<List<BidAttach>> allAttachList = new ArrayList<List<BidAttach>>();
		List<Artisan> artisan = new ArrayList<Artisan>();
		for(int i=0; i<list.size(); i++) {
			attachList = mapper.getBidAttachList(list.get(i).getBidIdx());
			allAttachList.add(attachList);
			Artisan a = mapper.getArtisanName(list.get(i).getArtisanId());
			artisan.add(a);
		}
		map.put("bidList", list);
		map.put("attachList", allAttachList);
		map.put("artisan", artisan);
		return map;
	}
	
	
	@PreAuthorize("isAuthenticated()")
	public void writeCustomRequest(Custom custom, MultipartFile file) {
		if (file.getOriginalFilename().equals("")) {
			custom.setOriginalFileName("");
			custom.setSavedFileName("");
		}else {
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			custom.setOriginalFileName(file.getOriginalFilename());
			custom.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			try {
				FileCopyUtils.copy(file.getBytes(), f);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		mapper.insertCustomRequest(custom);
	}
	
	// 입찰글 (작가만 가능)
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	public void writeBid(Bid bid, MultipartFile[] files) {
		mapper.insertBid(bid);
		
		for(MultipartFile file:files) {
			if(file.getOriginalFilename().equals(""))
				break;
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			BidAttach attach = new BidAttach();
			attach.setBidIdx(bid.getBidIdx());
			attach.setOriginalFileName(file.getOriginalFilename());
			attach.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			
			try {
				FileCopyUtils.copy(file.getBytes(), f);
			} catch (IOException e) {
				e.printStackTrace();
			}
			mapper.insertAttach(attach);
		}
	}
	
		
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> getBidList(int customIdx) {
		//입찰리스트
		List<Bid> list = mapper.getBidList(customIdx);

		List<BidAttach> attachList = new ArrayList<BidAttach>();
		List<List<BidAttach>> allAttachList = new ArrayList<List<BidAttach>>();
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i<list.size(); i++) {
			attachList = mapper.getBidAttachList(list.get(i).getBidIdx());
			allAttachList.add(attachList);
		}
		
		map.put("bidList", list);
		map.put("attachList", allAttachList);
		
		return map;
		
		
	}
	@PreAuthorize("#id == principal.username")
	@Transactional
	public boolean bid_successful(int bidIdx,String id) {
		int bidResult = 0;
		Bid bid = mapper.getBid(bidIdx);
		int customResult = mapper.updateCustomState(bid.getCustomIdx());
		
		List<Bid> list = mapper.getBidList(bid.getCustomIdx());
		for(Bid b:list) {
			if(b.getBidIdx()==bidIdx)
				bidResult = mapper.bidSuccessfulUpdate(bidIdx);	// 낙찰업데이트
			else
				mapper.bidStateUpdate(b.getBidIdx());	// 마감
		}
		
		return bidResult==1 && customResult==1? true:false;
		
	}
	@PreAuthorize("#custom.id == principal.username")
	public void updateCustom(Custom custom) {
		mapper.updateCustom(custom);
		
	}
	@PreAuthorize("#id == principal.username")
	public boolean deleteCustom(int customIdx,String id) {
		int result = mapper.deleteCustom(customIdx);
		return result==1? true:false;
	}
	
	@PreAuthorize("isAuthenticated()")
	public Map<String,Object> getChangeStateList(int pageno, String state) {
		int articleCnt = mapper.getBoardCountByState(state);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pagination", pagination);
		map.put("list", mapper.getChangeStateList(pagination.getStartArticleNum(), pagination.getEndArticleNum(),state));
		return map;
	}

}
