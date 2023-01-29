package com.youngtvjobs.ycc.course;

import org.springframework.web.util.UriComponentsBuilder;
import static java.util.Objects.requireNonNullElse;
import static java.lang.Math.*;

public class CourseSearchItem {
	public static final int DEFAULT_PAGE_SIZE = 10;
	public static final int MIN_PAGE_SIZE = 5;
	public static final int MAX_PAGE_SIZE = 50;

	private Integer page = 1;
	private Integer pageSize = DEFAULT_PAGE_SIZE;
	private String cate = "";
	private String target = "";
	private String stat = "";
	private String keyword = "";
	private Integer offset;
	private String orderby = "";
//	private Integer course_id;
	
	public CourseSearchItem() {
		// TODO Auto-generated constructor stub
	}
	
	public CourseSearchItem(Integer page, Integer pageSize) {
		this(page, pageSize, "", "", "", "", "");
	}

	public CourseSearchItem(Integer page, Integer pageSize, String cate, String target, String stat, String keyword, String orderby) {
		// super();
		this.page = page;
		this.pageSize = pageSize;
		this.cate = cate;
		this.target = target;
		this.stat = stat;
		this.keyword = keyword;
		this.orderby = orderby;
	}
	
	public String getQueryString() {
		return getQueryString(page);
	}
	
	// ?page=10&pageSize=10&cate=All&target=All&stat=All&keyword=title
	public String getQueryString(Integer page) {
		return UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("pageSize", pageSize)
				.queryParam("cate", cate)
				.queryParam("target", target)
				.queryParam("stat", stat)
				.queryParam("keyword", keyword)
				.queryParam("orderby", orderby)
				.build().toString();
	}
	
//	public int getCourse_id() {
//		return course_id;
//	}
//
//	public void setCourse_id(int course_id) {
//		this.course_id = course_id;
//	}

	public String getStat() {
		return stat;
	}

	public void setStat(String stat) {
		this.stat = stat;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
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
		this.pageSize = requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);
		
		// MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
		this.pageSize = max(MIN_PAGE_SIZE, min(this.pageSize, MAX_PAGE_SIZE));
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Integer getOffset() {
		int result = (page-1)*pageSize;
		if(result < 0) result = 0;
		
		return result;
	}

	@Override
	public String toString() {
		return "SearchItem [page=" + page + ", pageSize=" + pageSize + ", cate=" + cate + ", target=" + target
				+ ", stat=" + stat + ", keyword=" + keyword + ", offset=" + offset + ", orderby=" + orderby + "]";
	}

}
