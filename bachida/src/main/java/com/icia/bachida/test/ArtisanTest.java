package com.icia.bachida.test;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.icia.bachida.service.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class ArtisanTest {
	@Autowired
	
	
//	@Test
	public void orderTest() {
		//System.out.println(service.getOrderList("summer", 1));
	}
	
}
