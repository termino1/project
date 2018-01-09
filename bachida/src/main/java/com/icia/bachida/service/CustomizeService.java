package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.mapper.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;
@Service
public class CustomizeService {
	@Autowired
	private CustomizeDao dao;
	@Autowired
	private CustomMapper mapper;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> getBidList(String id, int pageno) {
		// 해당아이디로 입찰한 내역 검색 (요청번호로 요청글까지 검색)
		int articleCnt = dao.getBidCount(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, articleCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Bid> bidList = dao.getBidList(id,pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<Custom> customList = new ArrayList<Custom>();
		List<ProductionOrder> productionOrder = new ArrayList<ProductionOrder>();
		List<Bid> allBidList = dao.getAllBidList(id);
		
		for(Bid b:allBidList) {
			 Custom custom = mapper.getCustomRequest(b.getCustomIdx());
			 customList.add(custom);
			 ProductionOrder order = dao.getProductionOrder(b.getBidIdx());
			 productionOrder.add(order);
		}
		map.put("allBidList", allBidList);
		map.put("pagination", pagination);
		map.put("bidList", bidList);
		map.put("customList", customList);
		map.put("productionOrder", productionOrder);
		return map;
		
	}
	
	@PreAuthorize("#id == principal.username")
	public Map<String,Object> getProductionOrder(int bidIdx, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 의견조율 리스트 , 주문제작
		ProductionOrder order = dao.getProductionOrder(bidIdx);
		List<CustomOpinion> opinionList = dao.getCustomOpinionList(bidIdx);
		Bid bid = dao.getBid(bidIdx);	
		
		Artisan artisan = dao.getArtisan(bid.getArtisanId());
		List<BidAttach> attachList = dao.getBidAttach(bidIdx);
		Custom custom = mapper.getCustomRequest(bid.getCustomIdx());
		
		map.put("order", order);
		map.put("opinionList", opinionList);
		map.put("bid", bid);
		map.put("attach", attachList);
		map.put("custom", custom);
		map.put("artisan", artisan);
		return map;
	}
	
	@PreAuthorize("#opinion.id == principal.username")
	public void writeOpinion(CustomOpinion opinion, MultipartFile file) {
		if (file.getOriginalFilename().equals("")) {
			opinion.setOriginalFileName("");
			opinion.setSavedFileName("");
		}else {
			String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
			opinion.setOriginalFileName(file.getOriginalFilename());
			opinion.setSavedFileName(savedFileName);
			File f = new File(uploadPath, savedFileName);
			try {
				FileCopyUtils.copy(file.getBytes(), f);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		dao.insertCustomOpinion(opinion);
	}
	
	public List<CustomOpinion> getOpinionList(int bidIdx) {
		List<CustomOpinion> opinionList = dao.getCustomOpinionList(bidIdx);
		return opinionList;
	}
	@PreAuthorize("#order.artisanId == principal.username")
	public boolean writeProductionOrder(ProductionOrder order) {
		return dao.insertProductOrder(order)==1? true:false;
	}
	
	public boolean writeAddress(String address, int productionOrderIdx) {
		return dao.updateAddress(address,productionOrderIdx)==1? true:false;
	}
	@PreAuthorize("#id == principal.username")
	public String getUsersCash(String id) {
		String cash = dao.getUsersCash(id);
		return cash;
	}
	// member 캐쉬 업데이트, 캐쉬내역 insert, 주문상태 '제작' 업데이트
	@PreAuthorize("#id == principal.username")
	@Transactional
	public boolean depositAndOrderStateUpdate(String id, int cash,int productionOrderIdx) {
		int insertResult = 0;
		int updateResult = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cash", cash);
		if(dao.depositPayment(map)==1) {		// update 성공
			insertResult = dao.insertDepositCash(map);
			updateResult = dao.updateProductionOrderState(productionOrderIdx);
		}
		return insertResult==1 && updateResult==1 ? true:false;
	}
	// 상태업데이트 : 제작완료
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	public boolean updateCompleteProductionState(int productionOrderIdx) {
		return dao.updateCompleteProductionState(productionOrderIdx)==1? true : false;
	}
	// member 캐쉬 업데이트, 캐쉬내역 insert, 주문상태 '결제완료' 업데이트
	@PreAuthorize("#id == principal.username")
	@Transactional
	public boolean balancePaymentAndUpdate(String id, int balance, int productionOrderIdx, int totalPrice, String artisanId) {
		int insertResult = 0;
		int updateResult = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("cash", balance);
		if(dao.depositPayment(map)==1) {		
			insertResult = dao.insertBalanceCash(map);
			updateResult = dao.updateCompletePaymentState(productionOrderIdx);
		}
		
		if(insertResult==1 && updateResult==1) {
			if(dao.updateAddTotalCashForArtisan(artisanId,totalPrice)==1)
				insertResult = dao.insertTotalCashForArtisan(artisanId,totalPrice,productionOrderIdx);
		}
		
		return insertResult==1 && updateResult==1 ? true:false;
	}
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	public boolean updateDeliveryState(int productionOrderIdx, int parcelIdx, String parcelName) {
		return dao.updateDeliveryState(productionOrderIdx,parcelIdx,parcelName)==1? true:false;
	}
	@PreAuthorize("#order.artisanId == principal.username")
	public boolean updateProductionOrder(ProductionOrder order) {
		return dao.updateProductionOrder(order)==1? true:false;
	}

	public Map<String, Object> getArtisanInfo(String artisanId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisan", dao.artisanInfo(artisanId));
		return map;
	}

}
