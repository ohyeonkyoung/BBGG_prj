package kr.ac.kopo.notice.dao;

import java.util.List;

import kr.ac.kopo.notice.web.NoticeVO;
import kr.ac.kopo.pager.Pager;

public interface NoticeDao {

	List<NoticeVO> noticeListAll(Pager pager);
	void addNotice(NoticeVO noticeVO);
	NoticeVO noticeListOne(Long noticeNo);
	
	// 조회수
	void noticeCount(Long noticeNo);
	
	int total(Pager pager);
}
