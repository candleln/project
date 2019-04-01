package com.projecthh.common;

public class PageMaker {
	private int totalCount;     
	private int displayPageNum = 10;   
	private int startPage;     
	private int endPage;       
	private boolean prev;       // 페이징 버튼 활성화 여부
	private boolean next;      
	private int totalPage;
	private int currIndex;

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount, int page) {
		this.totalCount = totalCount;
		
		calcData(page);
		this.currIndex = page;
	}
	
	private void calcData(int page) {
		totalPage = (int) Math.ceil(totalCount / (double) displayPageNum);
		
		endPage = (int) (Math.ceil(page / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		if ( startPage < 1 ) {
			startPage = 1;
		}
		if ( endPage > totalPage ) {
			endPage = totalPage;
		}
		
		
		prev = startPage == 1 ? false : true;
		
		next = endPage * 10 >= totalCount ? false : true;
		
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrIndex() {
		return currIndex;
	}

	public void setCurrIndex(int currIndex) {
		this.currIndex = currIndex;
	}
}
	
