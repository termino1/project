package com.icia.bachida.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.icia.bachida.vo.*;

public interface CustomMapper {
	@Select("select * from\r\n" + 
			"	(select rownum rnum, c.* from\r\n" + 
			"	(select custom_idx customIdx, title, content, to_char(write_date,'yyyy-MM-dd')writeDate,id, wish_price wishPrice, "
			+ "quantity, state, to_char(closing_date,'yyyy-MM-dd')closingDate, original_file_name originalFileName, "
			+ "saved_file_name savedFileName, view_cnt viewCnt from custom order by custom_idx desc\r\n" + 
			") c where rownum<=#{param2}) where rnum >=#{param1}")
	public List<Custom> getCustomRequestList(int startArticleNum, int endArticleNum);
	
	
	@Select("select custom_idx customIdx, title, content, to_char(write_date,'yyyy-MM-dd')writeDate,"
			+ "id, wish_price wishPrice, quantity, state, to_char(closing_date,'yyyy-MM-dd')closingDate, "
			+ "original_file_name originalFileName, saved_file_name savedFileName, view_cnt viewCnt "
			+ "from custom where custom_idx=#{customIdx}")
	public Custom getCustomRequest(int customIdx);

	
	@Select("select bid_idx bidIdx, content, price, state, custom_idx customIdx, artisan_id artisanId,"
			+ " write_date writeDate from bid where custom_idx=#{customIdx} order by bid_idx")
	public List<Bid> getBidList(int customIdx);
	
	@SelectKey(statement="select custom_seq.nextval from dual",keyProperty="customIdx",resultType=Integer.class,before=true)
	@Insert("insert into custom values(#{customIdx},#{title},#{content},sysdate,#{id},#{wishPrice},#{quantity},'요청',"
			+ "#{closingDate},#{originalFileName},#{savedFileName},0)")
	public void insertCustomRequest(Custom custom);

	@SelectKey(statement="select bid_seq.nextval from dual",keyProperty="bidIdx",resultType=Integer.class,before=true)
	@Insert("insert into bid values(#{bidIdx},#{content},#{price},'입찰',#{customIdx},#{artisanId},sysdate)")
	public void insertBid(Bid bid);

	@Insert("insert into bid_attach values(#{bidIdx},#{savedFileName},#{originalFileName})")
	public void insertAttach(BidAttach attach);
	
	@Select("select bid_idx bidIdx, saved_file_name savedFileName, "
			+ "original_file_name originalFileName from bid_attach where bid_idx=#{bidIdx}")
	public List<BidAttach> getBidAttachList(int bidIdx);
	
	@Update("update custom set view_cnt=view_cnt+1 where custom_idx=#{customIdx}")
	public void increaseViewCnt(int customIdx);
	
	@Update("update bid set state='낙찰' where bid_idx=#{bidIdx}")
	public int bidSuccessfulUpdate(int bidIdx);
	
	@Select("select bid_idx bidIdx, content, price, state, custom_idx customIdx, artisan_id artisanId, to_char(write_date,'yyyy-MM-dd') writeDate from bid where bid_idx=#{bidIdx}")
	public Bid getBid(int bidIdx);
	
	@Update("update custom set state='낙찰' where custom_idx=#{customIdx}")
	public int updateCustomState(int customIdx);

	@Update("update bid set state='마감' where bid_idx=#{bidIdx}")
	public void bidStateUpdate(int bidIdx);
	
	@Update("update custom set title=#{title}, content=#{content} , wish_price=#{wishPrice}, quantity=#{quantity},closing_date=#{closingDate} where custom_idx=#{customIdx}")
	public void updateCustom(Custom custom);
	
	@Delete("delete from custom where custom_idx=#{customIdx}")
	public int deleteCustom(int customIdx);
	
	@Select("select count(*) from custom")
	public int getBoardCount();
	
	@Select("select count(*) from custom where state=#{state}")
	public int getBoardCountByState(String state);
	
	@Select("select * from (select rownum rnum, c.* from (select custom_idx customIdx, title, content, to_char(write_date,'yyyy-MM-dd')writeDate,id, wish_price wishPrice, quantity, state, to_char(closing_date,'yyyy-MM-dd')closingDate, original_file_name originalFileName, saved_file_name savedFileName, view_cnt viewCnt from custom where state=#{param3} order by custom_idx desc) c where rownum<=#{param2}) where rnum >=#{param1}")
	public List<Custom> getChangeStateList(int startArticleNum, int endArticleNum, String state);
	
	// 유찰로 바꿔주기위한 리스트
	@Select("select custom_idx customIdx,to_char(closing_date,'yyyy-MM-dd')closingDate, state from custom where state=#{state}")
	public List<Custom> getAllRequestCustom(String state);
	
	@Update("update custom set state='유찰' where custom_idx=#{customIdx}")
	public void updateCustomStateFailure(int customIdx);
	
	@Update("update bid set state='마감' where custom_idx=#{customIdx}")
	public void updateBidState(int customIdx);
	
	@Select("select artisan_id artisanId, artisan_name artisanName "
			+ "from artisan where artisan_id=#{artisanId}")
	public Artisan getArtisanName(String artisanId);

}
