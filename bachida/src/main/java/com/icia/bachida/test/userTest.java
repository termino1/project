package com.icia.bachida.test;



import java.util.*;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.service.*;
import com.icia.bachida.vo.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class userTest {
	@Autowired
	private UserDao dao;
	@Autowired
	private PcustomDao pcustomDao;
	@Autowired UserService service;
	@Autowired
	private ArtisanTimelineDao tdao;
	@Autowired
	private PasswordEncoder encoder;
	@Test
	public void test() {
		tdao.artisanInfo("canon90");
	}
	
	/*@Test
	public void testListPage() {
		int startArticleNum = 1;
		int endArticleNum = 50;
		List<Pcustom> list = pcustomDao.listPcustom(startArticleNum, endArticleNum);
		for(Pcustom pcustom:list) {
			System.out.println(pcustom.getPcustomIdx() + ":" + pcustom.getTitle());
		}
	}*/
}
