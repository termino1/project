package com.icia.bachida.util;

import com.icia.bachida.vo.*;

public class PagingUtil {
	private static int sizeOfPagination = 5;		// 화면 하단에 출력할 페이지의 수
	private static int numberOfArticleForPage = 10;		// 한페이지당 출력할 글의 개수
	public static Pagination setPageMaker(int pageNo, int numberOfTotalArticle) {		
		// pageNo : board/view?pageNo=7과 같이 사용자가 선택한 페이지 번호.  
		// numberOfTotalArticle : 게시판 전체 글의 개수. select count(*)로 얻어온다
		int numberOfTotalPage;					
		// 페이지의 개수. 글이 135, numberOfArticleForPage가 10인 경우 페이지의 개수는 14개
		int groupNo;
		// 하단의 페이지네이션 그룹의 크기
		// numberOfPage가 33이고 sizeOfPagination가 10일 경우 결과
		// groupNo	startPage	endPage		이전으로	다음으로
		//	0		1			10			X			11
		//	1		11			20			10			21
		//	2		21			30			20			31
		//	3		31			33			30			X
		int startArticle;			// 첫번째 글의 번호
		int endArticle;				// 마지막 글의 번호
		int startPage;				// 화면 하단 페이지 그룹의 첫 페이지 번호
		int endPage;				// 화면 하단 페이지 그룹의 마지막 페이지 번호	
		int prev;					// 이전으로 버튼에 링크할 페이지 번호
		int next;					// 다음으로 버튼에 링크할 페이지 번호
									// prev, next의 값이 -1인 경우 버튼 출력 안함
		Pagination pagination = new Pagination();
		// 페이지의 개수 계산
		// 글이 135개, 페이지당 글의 수가 10일 때 페이지 숫자는 14개
		numberOfTotalPage = (numberOfTotalArticle-1)/numberOfArticleForPage +1;
		// 페이지 번호는 페이지 개수보다 커질 수 없다
		if(pageNo>numberOfTotalPage) pageNo = numberOfTotalPage;
		// 페이지가 7일 때 출력할 글번호는 61~70
		// startArticle = (7-1)*10+1;
		System.out.println("pageNo:"+pageNo);
		
		startArticle = (pageNo-1)*numberOfArticleForPage+1;
		endArticle = pageNo*numberOfArticleForPage;
		pagination.setStartArticleNum(startArticle);
		pagination.setEndArticleNum(endArticle);
		
		// 페이지가 10일 때 하단에 출력할 페이지번호는 그룹 0
		// 나눗셈한 결과가 그룹 번호가 되는데 페이지 번호가 10일 경우
		// 10으로 나눈 몫은 1이 되어버리므로 pageNo-1을해서 나눈다
		groupNo = ((pageNo-1)/sizeOfPagination);
		startPage = groupNo*sizeOfPagination+1;
		endPage = startPage + sizeOfPagination - 1;
		// endPage는 페이지 개수보다 커질 수 없다
		if(endPage>=numberOfTotalPage) endPage = numberOfTotalPage;
		else endPage = startPage + sizeOfPagination -1;
		pagination.setStartPage(startPage);
		pagination.setEndPage(endPage);
		
		// 이전으로 버튼은 startPage-1의 값을 가진다
		prev = startPage-1;
		// prev값이 잘못된 경우 -1로 바꾸자
		if(prev<=0) prev=-1;
		// 다음으로 버튼은 endPage+1의 값을 가진다
		// 하지만 endPage가 정말 마지막 페이지일 경우 버튼을 생략(-1로)
		next = endPage + 1;
		if(endPage>=numberOfTotalPage) next = -1;
		pagination.setPrev(prev);
		pagination.setNext(next);
		pagination.setPageno(pageNo);
		return pagination;
	}

}