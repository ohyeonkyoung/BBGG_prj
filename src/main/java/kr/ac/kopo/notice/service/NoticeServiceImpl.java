package kr.ac.kopo.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.notice.dao.NoticeDao;
import kr.ac.kopo.notice.web.NoticeVO;
import kr.ac.kopo.pager.Pager;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDao noticeDao;
	
	@Override
	public List<NoticeVO> noticeListAll(Pager pager) {		
		int total = noticeDao.total(pager);
		pager.setTotal(total);
		return noticeDao.noticeListAll(pager);
	}
	
	@Override
	public void addNotice(NoticeVO noticeVO) {
		//System.out.println(noticeVO.getAdminId());
		//System.out.println(noticeVO.getNoticeTitle());
		//System.out.println(noticeVO.getNoticeContent());
		noticeDao.addNotice(noticeVO);
	}

	@Override
	public NoticeVO noticeListOne(Long noticeNo) {
		noticeDao.noticeCount(noticeNo);
		return noticeDao.noticeListOne(noticeNo);
	}
}
