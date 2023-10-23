package com.team3.spring.service;

import java.text.DecimalFormat;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.config.BoardConfig;
import com.team3.spring.mapper.AdminMapper;
import com.team3.spring.mapper.MovieMapper;
import com.team3.spring.mapper.TicketingMapper;
import com.team3.spring.vo.AuthVO;
import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.MemberVO;
import com.team3.spring.vo.TicketingVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class AdminServiceImpl implements AdminService{
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private TicketingMapper t_mapper;
	@Setter(onMethod_ = @Autowired)
	private MovieMapper m_mapper;
	@Override
	public MemberVO loadInfo(String account) {
		return mapper.loadInfo(account);
	}
	@Override
	public int getMemberCnt() {
		return mapper.getMemberCnt();
	}

	@Override
	public int getReserveCnt() {
		return mapper.getReserveCnt();
	}
	
	@Override
	public int getUnAnsweredCnt() {
		return mapper.getUnAnsweredCnt();
	}
	@Override
	public String getMonthRevenue() {
		// 10000 -> 10,000
		DecimalFormat df = new DecimalFormat("###,###");
		String revenue = df.format(mapper.getMonthRevenue());
		return revenue;
	}
	
	
	// 회원관련 서비스
	@Override
	public ArrayList<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
	
	@Override
	public MemberVO getMember(int id) {
		return mapper.getMember(id);
	}
	// 특정 사용자 권한 가져오기
	@Override
	public String getAuth(String account) {
		return mapper.getAuth(account);
	}
	
	@Override
	public void authDelete(String account) {
		mapper.authDelete(account);
		log.info("권한 삭제 완료");
	}
	
	@Override
	public int authInsert(AuthVO vo) {
		log.info("권한 삽입 시작");
		return mapper.authInsert(vo);
	}
	@Override
	public int deleteUser(int id, String account) {
		t_mapper.userDelete(id);
		m_mapper.userDelete(id);
		return mapper.deleteUser(account);
	}

	// Q&A 관련 서비스
	@Override
	public ArrayList<BoardVO2> list(int page) {
		// TODO Auto-generated method stub
		return mapper.list(page);
	}

	@Override
	public ArrayList<BoardVO2> listSearch(String searchKey, String word, int page) {
		// TODO Auto-generated method stub
		return mapper.listSearch(searchKey, word, page);
	}

	@Override
	public int getStartIndex(int page) {
		int index = (page-1)* BoardConfig.AMOUNT_PER_PAGE;
		return index;
	}

	@Override
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	
	@Override
	public int getSearchTotalCount(String searchKey, String word) {
		return mapper.getSearchTotalCount(searchKey, word);
	}
	
	@Override
	public int getTotalPage(String searchKey, String word) {
		int totalCount;
	    
	    if (word == null || word.equals("null")) {
	        totalCount = getTotalCount();
	    } else {
	        totalCount = getSearchTotalCount(searchKey, word);
	    }
		
	    // 전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
	    int totalPage = 0;
	    
	    if (totalCount % BoardConfig.AMOUNT_PER_PAGE == 0) {
	        totalPage = totalCount / BoardConfig.AMOUNT_PER_PAGE;
	    } else {
	        totalPage = totalCount / BoardConfig.AMOUNT_PER_PAGE + 1;
	    }
		
		return totalPage;
	}

	@Override
	public int getTotalBlock(int totalPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalBlock = 0;
		if(totalPage % BoardConfig.PAGE_PER_BLOCK == 0) {
			totalBlock = totalPage / BoardConfig.PAGE_PER_BLOCK;
		}else {
			totalBlock = totalPage / BoardConfig.PAGE_PER_BLOCK + 1;
		}		
		return totalBlock;
	}
	// Q&A 관련 서비스 끝////
	
	// 공자시항 관련 서비스
	@Override
	public ArrayList<BoardVO> getBoardList(int page) {
		
		return mapper.getBoardList(page);
	}

	@Override
	public int getTotalPage() {
		int totalCount = mapper.getTotalBoardCount();
	    
	    // 전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
	    int totalPage = 0;
	    
	    if (totalCount % BoardConfig.ADMIN_AMOUNT_PER_PAGE == 0) {
	        totalPage = totalCount / BoardConfig.ADMIN_AMOUNT_PER_PAGE;
	    } else {
	        totalPage = totalCount / BoardConfig.ADMIN_AMOUNT_PER_PAGE + 1;
	    }
		
		return totalPage;
	}
	
	@Override
	public int getStartBoardIndex(int page) {
		int index = (page-1)* BoardConfig.ADMIN_AMOUNT_PER_PAGE;
		return index;
	}

	@Override
	public BoardVO read(int p_id) {
		return mapper.read(p_id);
	}
	
	@Override
	public int write(BoardVO vo) {
		return mapper.write(vo);
	}
	@Override
	public int boardDel(int p_id) {
		return mapper.boardDel(p_id);
	}
	@Override
	public int boardModify(BoardVO vo) {
		return mapper.boardModify(vo);
	}
	// 공지사항 관련 서비스 끝
	
	// 에매 관련 서비스
	@Override
	public ArrayList<TicketingVO> getTicketList() {
		return mapper.getTicketList();
	}
	@Override
	public int delTicket(int id) {
		return mapper.delTicket(id);
	}
	

}
