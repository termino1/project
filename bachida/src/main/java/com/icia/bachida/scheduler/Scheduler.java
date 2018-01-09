package com.icia.bachida.scheduler;

import java.text.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.scheduling.annotation.*;

import com.icia.bachida.mapper.*;
import com.icia.bachida.vo.*;
@Configuration
@EnableScheduling
public class Scheduler {
	@Autowired
	private CustomMapper mapper;
	
	// 마감기간 지난 글 유찰 처리
	@Scheduled(cron="0 25 11 * * ?")
	public void updateCustomState() {
		// 오늘날짜
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String todayStr = df.format(date);		// String 형식//
		
		String state = "요청";
		List<Custom> allList = mapper.getAllRequestCustom(state);
		for(int i=0; i<allList.size(); i++) {
			String closingDateStr = allList.get(i).getClosingDate();
			try {
				Date closingDate = df.parse(closingDateStr);
				Date today = df.parse(todayStr);
				long calDate = today.getTime() - closingDate.getTime();
				long calDateDays = calDate/(24*60*60*1000);
				// calDateDays 가 2부터 ( 하루(1)는 괜찮!) 상태 변경하기
				if(calDateDays>=2) {
					mapper.updateCustomStateFailure(allList.get(i).getCustomIdx());
					mapper.updateBidState(allList.get(i).getCustomIdx());
				}
				
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			
		}
		
	}
	
	
}
