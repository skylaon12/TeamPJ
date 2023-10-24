package com.team3.spring.service;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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
	
	@Override
	public ArrayList<BoardVO2> getLists(String p_category, String searchKey, String word, int page) {
	    if ( word == null || word.equals("null") ) {
	    	if ( p_category == null || p_category.isEmpty() ) {
	    		log.info("서비스 진입 - 일반 리스트");
	    		return mapper.list(page);
	        } else {
	        	log.info("서비스 진입 - 카테고리 리스트");
	        	return mapper.listByCategory(p_category, page);
	        }
	    } else {
	    	if ( p_category == null || p_category.isEmpty() ) {
	    		log.info("서비스 진입 - 일반 검색 리스트");
	    		return mapper.listSearch(searchKey, word, page);
	        } else {
	        	log.info("서비스 진입 - 카테고리 검색 리스트");
	        	return mapper.listSearchByCategory(p_category, searchKey, word, page);
	        }
	    }
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
	public int getTotalCountByCategory(String p_category) {
		return mapper.getTotalCountByCategory(p_category);
	}
	
	@Override
	public int getSearchTotalCount(String searchKey, String word) {
		return mapper.getSearchTotalCount(searchKey, word);
	}
	
	@Override
	public int getSearchTotalCountByCategory(String p_category, String searchKey, String word) {
		return mapper.getSearchTotalCountByCategory(p_category, searchKey, word);
	}
	
	@Override
	public int getTotalPageCount(String p_category, String searchKey, String word) {
		int totalCount;
	    
	    if ( word == null || word.equals("null") ) {
	    	if ( p_category == null || p_category.isEmpty() ) {
	            totalCount = getTotalCount(); // 전체 카테고리 글 수 가져오기
	        } else {
	            totalCount = getTotalCountByCategory(p_category); // 특정 카테고리 글 수 가져오기
	        }
	    } else {
	    	if ( p_category == null || p_category.isEmpty() ) {
	            totalCount = getSearchTotalCount(searchKey, word); // 전체 카테고리에서 검색한 글 수 가져오기
	        } else {
	            totalCount = getSearchTotalCountByCategory(p_category, searchKey, word); // 특정 카테고리에서 검색한 글 수 가져오기
	        }
	    }
	    
	    return totalCount;
	}
	
	@Override
	public int getTotalPage(int totalCount) {
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
	
	@Override
	public void endAnswer(long p_id) {
		mapper.endAnswer(p_id);
	}
	
	@Override
	public Timestamp getCommentCreatedTime(long p_ori_id) {
		return mapper.getCommentCreatedTime(p_ori_id);
	}
	
	@Override
	public void updateCommentInfo(ArrayList<BoardVO2> boards) {
		Long threshold = (long) 60 * 1000; // 60초 임계값 테스트
        Long currentTime = System.currentTimeMillis(); // 현재 시간 가져오기

        for (BoardVO2 board : boards) {
            int p_id = board.getP_id();
            int totalCommentCount = getCommentTotalCount(p_id);

            Timestamp commentTime = getCommentCreatedTime(p_id);
            log.info("댓글 작성 시간 =>" + commentTime);

            if (commentTime != null) {
                Long commentTimeMillis = commentTime.getTime();
                log.info("댓글 작성 시간 변환 =>" + commentTimeMillis);

                // 댓글이 24시간 이내에 작성되었다면 "New" 표시
                if ((currentTime - commentTimeMillis) < threshold) {
                    board.setNewComment(true);
                } else {
                    board.setNewComment(false);
                }
            } else {
                // 댓글이 없거나 댓글 작성 시간이 없는 경우
                board.setNewComment(false);
            }

            // 댓글 수 설정
            board.setCommentCount(totalCommentCount);
        }
	}
	
	@Override
	public void updateModelWithPageInfo(Model model, int page, String p_category, String searchKey, String word) {
        int totalCount = getTotalPageCount(p_category, searchKey, word);
        int totalPage = getTotalPage(totalCount);
        int totalBlock = getTotalBlock(totalPage);
        int currentBlock = (int) Math.ceil((double) page / BoardConfig.PAGE_PER_BLOCK);
        int blockStartNo = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK + 1;
        int blockEndNo = Math.min(currentBlock * BoardConfig.PAGE_PER_BLOCK, totalPage);
        
        // 이전 다음 버튼 계산 처리
	    boolean hasPrev = true;
	    boolean hasNext = true;
	    int prevPage = 0;
	    int nextPage = 0;
	    
	    if (currentBlock == 1) {
	    	hasPrev = false;
	    } else {
	    	hasPrev = true;
	    	prevPage = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK;
	    }
	    
	    if(currentBlock < totalBlock ){
	    	hasNext = true;
	    	nextPage = currentBlock * BoardConfig.PAGE_PER_BLOCK + 1;
	    } else {
	    	hasNext = false;
	    }
	    
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("totalBlock", totalBlock);
	    model.addAttribute("currentBlock", currentBlock);
	    model.addAttribute("blockStartNo", blockStartNo);
	    model.addAttribute("blockEndNo", blockEndNo);
	    model.addAttribute("hasPrev", hasPrev);
	    model.addAttribute("hasNext", hasNext);
	    model.addAttribute("prevPage", prevPage);
	    model.addAttribute("nextPage", nextPage);
    }
	
	@Override
	public void calculateCommentPagingInfo(Model model, int coPage, long p_id) {
	    int totalCount = getCommentTotalCount(p_id);
	    int totalPage = getTotalCommentPage(p_id);
	    int totalBlock = getTotalCommentBlock(totalPage);
	    int currentBlock = (int) Math.ceil((double) coPage / BoardConfig.PAGE_PER_BLOCK_COMMENT);
	    int blockStartNo = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK_COMMENT + 1;
	    int blockEndNo = Math.min(currentBlock * BoardConfig.PAGE_PER_BLOCK_COMMENT, totalPage);
	    // 이전 다음 버튼 계산 처리
	    boolean hasPrev = true;
	    boolean hasNext = true;
	    int prevPage = 0;
	    int nextPage = 0;
	    
	    if (currentBlock == 1) {
	        hasPrev = false;
	    } else {
	        hasPrev = true;
	        prevPage = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK_COMMENT;
	    }
	    
	    if (currentBlock < totalBlock ){
	        hasNext = true;
	        nextPage = currentBlock * BoardConfig.PAGE_PER_BLOCK_COMMENT + 1;
	    } else {
	        hasNext = false;
	    }

	    // 댓글 페이징 정보를 모델에 추가
	    model.addAttribute("commentTotalCount", totalCount);
	    model.addAttribute("commentTotalPage", totalPage);
	    model.addAttribute("commentTotalBlock", totalBlock);
	    model.addAttribute("commentCurrentBlock", currentBlock);
	    model.addAttribute("commentBlockStartNo", blockStartNo);
	    model.addAttribute("commentBlockEndNo", blockEndNo);
	    model.addAttribute("commentHasPrev", hasPrev);
	    model.addAttribute("commentHasNext", hasNext);
	    model.addAttribute("commentPrevPage", prevPage);
	    model.addAttribute("commentNextPage", nextPage);
	}
}
