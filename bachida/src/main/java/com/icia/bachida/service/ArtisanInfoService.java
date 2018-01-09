package com.icia.bachida.service;

import java.io.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.vo.*;

@Service
public class ArtisanInfoService {
	@Autowired
	private ArtisanTimelineDao timeDao;
	@Autowired
	private ArtisanInfoDao dao;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	public Artisan getArtisanInfo(String artisanId) {
		return timeDao.artisanInfo(artisanId);
	}

	public void artisanInfoUpdate(Artisan artisan, MultipartFile file) {
		if (file.getOriginalFilename().equals("")) {
			dao.artisanInfoUpdate(artisan);
		}else {
			if(artisan.getOriginalFileName()!=null) {
				File f = new File(uploadPath, artisan.getSavedFileName());
				if(f.exists()) {
					f.delete();
				}
				String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
				artisan.setOriginalFileName(file.getOriginalFilename());
				artisan.setSavedFileName(savedFileName);
				File f2 = new File(uploadPath, savedFileName);
				try {
					FileCopyUtils.copy(file.getBytes(), f2);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
				artisan.setOriginalFileName(file.getOriginalFilename());
				artisan.setSavedFileName(savedFileName);
				File f = new File(uploadPath, savedFileName);
				try {
					FileCopyUtils.copy(file.getBytes(), f);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			dao.artisanInfoUpdateWithFile(artisan);
		}
	}

	public boolean nameCheck(String artisanName) {
		return dao.nameCheck(artisanName) != null ? true : false;
	}
	
	
}
