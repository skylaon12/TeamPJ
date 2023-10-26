package com.team3.spring.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.config.BoardConfig;
import com.team3.spring.mapper.BoardMapper;
import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	// 리스트
	@Override
	public ArrayList<BoardVO> list(int page) {
		log.info("서비스 진입");
		return mapper.list(page);
	}
	
	// 리스트 검색
	@Override
	public ArrayList<BoardVO> listSearch(String searchKey, String word, int page) {
		log.info("서비스 진입 검색");
		return mapper.listSearch(searchKey, word, page);
	}
	
	// 쓰기
	@Override
	public int write(BoardVO gvo) {
		return mapper.write(gvo);
	}
	
	// 읽기
	@Override
	public BoardVO read(long p_id) {
		return mapper.read(p_id);
	}
	
	// 삭제
	@Override
	public int del(long p_id) {
		return mapper.del(p_id);
	}
	
	// 수정
	@Override
	public int modify(BoardVO gvo) {
		return mapper.modify(gvo);
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
	
	@Override
	public void updateHitCount(long p_id) {
		mapper.updateHitCount(p_id);
	}
	
	// 다음 글의 ID 가져오기
    @Override
    public Long getNextArticleId(Long currentArticleId) {
        return mapper.getNextArticleId(currentArticleId);
    }

    // 이전 글의 ID 가져오기
    @Override
    public Long getPreviousArticleId(Long currentArticleId) {
        return mapper.getPreviousArticleId(currentArticleId);
    }

	@Override
	public MemberVO getMemberInfo(String account) {
		
		return mapper.getMemberInfo(account);
	}

	@Override
	public String getMemberAuth(String account) {
		return mapper.getMemberAuth(account);
	}

}
