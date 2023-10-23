package com.team3.spring.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.config.BoardConfig;
import com.team3.spring.mapper.BoardMapper2;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl2 implements BoardService2 {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper2 mapper;

	// 리스트
	@Override
	public ArrayList<BoardVO2> list(int page) {
		log.info("서비스 진입");
		return mapper.list(page);
	}
	
	// 리스트 검색
	@Override
	public ArrayList<BoardVO2> listSearch(String searchKey, String word, int page) {
		log.info("서비스 진입 검색");
		return mapper.listSearch(searchKey, word, page);
	}
	
	// 쓰기
	@Override
	public void write(BoardVO2 gvo) {
		mapper.write(gvo);
	}
	
	// 읽기
	@Override
	public BoardVO2 read(long p_id) {
		return mapper.read(p_id);
	}
	
	// 수정
	@Override
	public void modify(BoardVO2 gvo) {
		mapper.modify(gvo);
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
    
    // 댓글 쓰기
    @Override
    public void writeComment(CommentVO gvo) {
    	mapper.writeComment(gvo);
    }
    
    // 댓글 데이터 가져오기
    @Override
    public ArrayList<CommentVO> getCommentData(long p_ori_id, int page) {
    	return mapper.getCommentData(p_ori_id, page);
    }
    
    // 전체 댓글 수 가져오기
    @Override
	public int getCommentTotalCount(long p_ori_id) {
		return mapper.getCommentTotalCount(p_ori_id);
	}
    
    @Override
	public int getTotalCommentPage(long p_ori_id) {
		int totalCount = getCommentTotalCount(p_ori_id);
		
	    // 전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
	    int totalCommentPage = 0;
	    
	    if (totalCount % BoardConfig.AMOUNT_PER_PAGE == 0) {
	    	totalCommentPage = totalCount / BoardConfig.AMOUNT_PER_PAGE;
	    } else {
	    	totalCommentPage = totalCount / BoardConfig.AMOUNT_PER_PAGE + 1;
	    }
		
		return totalCommentPage;
	}

	@Override
	public int getTotalCommentBlock(int totalCommentPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalCommentBlock = 0;
		if(totalCommentPage % BoardConfig.PAGE_PER_BLOCK == 0) {
			totalCommentBlock = totalCommentPage / BoardConfig.PAGE_PER_BLOCK;
		}else {
			totalCommentBlock = totalCommentPage / BoardConfig.PAGE_PER_BLOCK + 1;
		}		
		return totalCommentBlock;
	}

}
