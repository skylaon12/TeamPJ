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
	// 현재 정보 가져오기
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
	// 관리자가 회원삭제 버튼을 눌렀을 때
	// 완료되지 않은 QnA에 대해서는 삭제
	// 완료된 QnA는 나중에 써먹을 수 있으니 writer를 del_user로 바꿔줌
	// 왜? 해당 아이디로 다른 누군가가 회원가입 할 수도 있으니 회원가입이 불가능한(_) 문자를 넣어줌
	@Override
	public int deleteUser(String account) {
		mapper.deleteFQnA(account);
		mapper.modifyTQnA(account);
		return mapper.deleteUser(account);
	}

	// Q&A 관련 서비스
	@Override
	public ArrayList<BoardVO2> getLists(String p_category, String searchKey, String word, int page, String status) {
		if ( word == null || word.equals("null") ) {
	    	if ( p_category == null || p_category.isEmpty() ) {
	    		log.info("서비스 진입 - 일반 리스트");
	    		return mapper.list(page, status);
	        } else {
	        	log.info("서비스 진입 - 카테고리 리스트");
	        	return mapper.listByCategory(p_category, page, status);
	        }
	    } else {
	    	if ( p_category == null || p_category.isEmpty() ) {
	    		log.info("서비스 진입 - 일반 검색 리스트");
	    		return mapper.listSearch(searchKey, word, page, status);
	        } else {
	        	log.info("서비스 진입 - 카테고리 검색 리스트");
	        	return mapper.listSearchByCategory(p_category, searchKey, word, page, status);
	        }
	    }
	}

	@Override
	public int getStartIndex(int page) {
		int index = (page-1)* BoardConfig.AMOUNT_PER_PAGE;
		return index;
	}

	@Override
	public int getTotalCount(String status) {
		return mapper.getTotalCount(status);
	}
	
	@Override
	public int getTotalCountByCategory(String p_category, String status) {
		return mapper.getTotalCountByCategory(p_category, status);
	}
	
	@Override
	public int getSearchTotalCount(String searchKey, String word, String status) {
		return mapper.getSearchTotalCount(searchKey, word, status);
	}
	
	@Override
	public int getSearchTotalCountByCategory(String p_category, String searchKey, String word, String status) {
		return mapper.getSearchTotalCountByCategory(p_category, searchKey, word, status);
	}
	
	@Override
	public int getTotalPageCount(String p_category, String searchKey, String word, String status) {
		int totalCount;
	    
	    if ( word == null || word.equals("null") ) {
	    	if ( p_category == null || p_category.isEmpty() ) {
	            totalCount = getTotalCount(status); // 전체 카테고리 글 수 가져오기
	        } else {
	            totalCount = getTotalCountByCategory(p_category, status); // 특정 카테고리 글 수 가져오기
	        }
	    } else {
	    	if ( p_category == null || p_category.isEmpty() ) {
	            totalCount = getSearchTotalCount(searchKey, word, status); // 전체 카테고리에서 검색한 글 수 가져오기
	        } else {
	            totalCount = getSearchTotalCountByCategory(p_category, searchKey, word, status); // 특정 카테고리에서 검색한 글 수 가져오기
	        }
	    }
	    
	    return totalCount;
	}
	
	
	@Override
	public int getTotalPage(int totalCount) {
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
	
	@Override
	public int completQna(int p_id) {
		return mapper.completQna(p_id);
	}
	@Override
	public int delQna(int p_id) {
		return mapper.delQna(p_id);
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
