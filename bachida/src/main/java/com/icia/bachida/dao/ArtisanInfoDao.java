package com.icia.bachida.dao;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class ArtisanInfoDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	// 사진 외에 정보 변경
	public void artisanInfoUpdate(Artisan artisan) {
		tpl.update("artisanInfoMapper.artisanInfoUpdate",artisan);
	}
	// 사진 포함 정보 변경
	public void artisanInfoUpdateWithFile(Artisan artisan) {
		tpl.update("artisanInfoMapper.artisanInfoUpdateWithFile",artisan);
	}
	public String nameCheck(String artisanName) {
		return tpl.selectOne("artisanInfoMapper.nameCheck",artisanName);
	}
}
