package com.youngtvjobs.ycc.member;

import static java.lang.Math.max;
import static java.lang.Math.min;
import static java.util.Objects.requireNonNullElse;

import java.util.Objects;

import org.springframework.web.util.UriComponentsBuilder;

public class InqPageResolver {

	private SearchByPeriod sp;

	private int totalCnt; // 게시물 총 개수
//	private int pageSize;		//한 페이지 당 게시물 개수
	public final int NAV_SIZE = 5; // page navigation size

	private int totalPage; // 전체 페이지 개수
//	private int page;				//현재 페이지

	private int beginPage; // 화면에 보여줄 첫 페이지
	private int endPage; // 화면에 보여줄 마지막 페이지
	private boolean showNext = false; // 이후를 보여줄지 여부 (endPage==totalPage 이면 showNext는 false)
	private boolean showPrev = false; // 이전을 보여줄지 여부 (beginPage==1 이 아니면 showPrev는 true)

	public InqPageResolver() {
		// TODO Auto-generated constructor stub
	}

	public InqPageResolver(SearchByPeriod sp, int totalCnt) {
		this.sp = sp;
		this.totalCnt = totalCnt;
		
		doPaging(totalCnt,sp);
	}

	private void doPaging(int totalCnt, SearchByPeriod sp) {
		this.totalPage = totalCnt/sp.getPageSize() + (totalCnt% sp.getPageSize() == 0? 0:1);
		this.sp.setPage(Math.min(sp.getPage(), totalPage));
		this.beginPage = (this.sp.getPage()-1) / NAV_SIZE * NAV_SIZE + 1;
		this.endPage = Math.min(this.beginPage + this.NAV_SIZE - 1, totalPage);
		this.showPrev = beginPage != 1;
		this.showNext = endPage != totalPage;
	}

	public InqPageResolver(SearchByPeriod sp, int totalCnt, int totalPage, int beginPage, int endPage, boolean showNext,
			boolean showPrev) {
		super();
		this.sp = sp;
		this.totalCnt = totalCnt;
		this.totalPage = totalPage;
		this.beginPage = beginPage;
		this.endPage = endPage;
		this.showNext = showNext;
		this.showPrev = showPrev;
	}

	public SearchByPeriod getSp() {
		return sp;
	}

	public void setSp(SearchByPeriod sp) {
		this.sp = sp;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isShowNext() {
		return showNext;
	}

	public void setShowNext(boolean showNext) {
		this.showNext = showNext;
	}

	public boolean isShowPrev() {
		return showPrev;
	}

	public void setShowPrev(boolean showPrev) {
		this.showPrev = showPrev;
	}

	@Override
	public int hashCode() {
		return Objects.hash(NAV_SIZE, beginPage, endPage, showNext, showPrev, sp, totalCnt, totalPage);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InqPageResolver other = (InqPageResolver) obj;
		return NAV_SIZE == other.NAV_SIZE && beginPage == other.beginPage && endPage == other.endPage
				&& showNext == other.showNext && showPrev == other.showPrev && Objects.equals(sp, other.sp)
				&& totalCnt == other.totalCnt && totalPage == other.totalPage;
	}
	
	
}