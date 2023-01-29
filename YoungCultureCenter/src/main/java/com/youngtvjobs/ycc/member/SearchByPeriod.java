package com.youngtvjobs.ycc.member;

import static java.lang.Math.max;
import static java.lang.Math.min;
import static java.util.Objects.requireNonNullElse;

import java.util.Objects;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchByPeriod {

	public final String DEFAULT_INTERVAL = "1month";
	public static final Integer DEFAULT_PAGE_SIZE = 6;
	public static final Integer MIN_PAGE_SIZE = 5;
	public static final Integer MAX_PAGE_SIZE = 50;

	private Integer page = 1;
	private Integer pageSize = DEFAULT_PAGE_SIZE;

	private String settedInterval = DEFAULT_INTERVAL;
	private String startDate;
	private String endDate;
	private Integer offset;

	public SearchByPeriod() {
		// TODO Auto-generated constructor stub
	}

	public SearchByPeriod(Integer page, Integer pageSize) {
		this(page, pageSize, "");
	}

	public SearchByPeriod(Integer page, Integer pageSize, String settedInterval) {
		this.page = page;
		this.pageSize = pageSize;
		this.settedInterval = settedInterval;
	}

	public SearchByPeriod(Integer page, Integer pageSize, String startDate, String endDate) {
		super();
		this.page = page;
		this.pageSize = pageSize;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public SearchByPeriod(Integer page, Integer pageSize, String settedInterval, String startDate, String endDate,
			Integer offset) {
		super();
		this.page = page;
		this.pageSize = pageSize;
		this.settedInterval = settedInterval;
		this.startDate = startDate;
		this.endDate = endDate;
		this.offset = offset;
	}

	public String getQueryString() {
		return getQueryString(page);
	}

	// ?page=10&pageSize=10&settedInterval=&startDate=&endDate=
	public String getQueryString(Integer page) {
		return UriComponentsBuilder.newInstance().queryParam("page", page).queryParam("pageSize", pageSize)
				.queryParam("settedInterval", settedInterval)
				.queryParam("startDate", startDate)
				.queryParam("endDate", endDate)
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
		this.pageSize = requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);

		// MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
		this.pageSize = max(MIN_PAGE_SIZE, min(this.pageSize, MAX_PAGE_SIZE));
	}

	public String getSettedInterval() {
		return settedInterval;
	}

	public void setSettedInterval(String settedInterval) {
		this.settedInterval = settedInterval;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public Integer getOffset() {
		int result = (page - 1) * pageSize;
		if (result < 0)
			result = 0;

		return result;
	}

	@Override
	public int hashCode() {
		return Objects.hash(endDate, offset, page, pageSize, settedInterval, startDate);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SearchByPeriod other = (SearchByPeriod) obj;
		return Objects.equals(endDate, other.endDate) && Objects.equals(offset, other.offset)
				&& Objects.equals(page, other.page) && Objects.equals(pageSize, other.pageSize)
				&& Objects.equals(settedInterval, other.settedInterval) && Objects.equals(startDate, other.startDate);
	}

}
