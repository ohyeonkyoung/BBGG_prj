package kr.ac.kopo.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.admin.dao.AdminDaoImpl;
import kr.ac.kopo.notice.web.NoticeVO;
import kr.ac.kopo.pager.Pager;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	private static final Logger logger = LoggerFactory.getLogger(AdminDaoImpl.class);
	
	@Autowired
	SqlSession sql;
	
	@Override
	public List<NoticeVO> noticeListAll(Pager pager) {
		return sql.selectList("notice.selectNotice", pager);
	}

	@Override
	public void addNotice(NoticeVO noticeVO) {
		logger.info("제목 = {}", noticeVO.getNoticeTitle());
		logger.info("내용 = {}", noticeVO.getNoticeContent());
		sql.insert("notice.insertNotice", noticeVO);
	}

	@Override
	public NoticeVO noticeListOne(Long noticeNo) {
		return sql.selectOne("notice.noticeSelectOne", noticeNo);
	}
	
	@Override
	public void noticeCount(Long noticeNo){
		sql.update("notice.viewCount", noticeNo);
	}

	@Override
	public int total(Pager pager) {
		return sql.selectOne("notice.total", pager);
	}
}
