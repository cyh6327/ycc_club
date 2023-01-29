package com.youngtvjobs.ycc.search;

import org.springframework.web.util.UriComponentsBuilder;
import static java.util.Objects.requireNonNullElse;
import static java.lang.Math.*;

public class SearchItem {
	
	public static final int DEFAULT_PAGE_SIZE = 10;
	public static final int MIN_PAGE_SIZE = 5;
	public static final int MAX_PAGE_SIZE = 50;
	
	
	private Integer page = 1;
	private Integer pageSize = DEFAULT_PAGE_SIZE;
	private String option = "";
	private String keyword = "";
	private Integer offset;
	private String type;
	private String array = "";
	
	public SearchItem() {
		// TODO Auto-generated constructor stub
	}
	
	public SearchItem(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
	public SearchItem(Integer page, Integer paseSize) {
		this(page, paseSize, "", "", "", "");
	}
	
	public SearchItem(Integer page, Integer pageSize, String option, String keyword, String type, String array) {
		//super();
		this.page = page;
		this.pageSize = pageSize;
		this.option = option;
		this.keyword = keyword;
		this.type = type;
		this.array = array;
	}
	
	
	public String getQueryString() {
		return getQueryString(page);
	}
	
	// ?page=10&pageSize=10&option=A&keyword=title
	public String getQueryString(Integer page) {
		return UriComponentsBuilder.newInstance()	//객체 생성
				.queryParam("page", page)
				.queryParam("pageSize", pageSize)
				.queryParam("option", option)
				.queryParam("keyword", keyword)
				.queryParam("array", array)
				.queryParam("type", type)
				.build().toString();
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);	//pageSize가 null이면 DEFAULT_PAGE_SIZE 리턴
		
		// MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
		this.pageSize = max(MIN_PAGE_SIZE, min(this.pageSize, MAX_PAGE_SIZE));	//max: 두 값 중 더 큰 값을 반환
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Integer getOffset() {
		 int result = (page-1) * pageSize; // offset => 변경
	        if(result <0) {result= 0;}
	        return result;
	}

	

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getArray() {
		return array;
	}

	public void setArray(String array) {
		this.array = array;
	}

	@Override
	public String toString() {
		return "SearchItem [page=" + page + ", pageSize=" + pageSize + ", option=" + option + ", keyword=" + keyword
				+ ", offset=" + offset + "]";
	}
	
	

}