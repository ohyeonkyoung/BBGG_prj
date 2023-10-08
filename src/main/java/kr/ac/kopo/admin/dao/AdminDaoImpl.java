package kr.ac.kopo.admin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.fake.web.FakeVO;
import kr.ac.kopo.item.web.ItemVO;
import kr.ac.kopo.partner.web.PartnerVO;
import kr.ac.kopo.user.web.UserVO;

@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	SqlSession sql;

	
	@Override
	public List<UserVO> userList(UserVO userVO) {
		return sql.selectList("admin.selectUserList", userVO);
	}

	@Override
	public List<PartnerVO> partnerList(PartnerVO partnerVO) {
		return sql.selectList("admin.selectPartnerList", partnerVO);
	}
	
	@Override
	public List<ItemVO> itemList(ItemVO itemVO) {
		return sql.selectList("admin.selectItemList", itemVO);
	}

	@Override
	public List<FakeVO> fakeList(FakeVO fakeVO) {
		return sql.selectList("admin.selectFakeList", fakeVO);
	}
	
	@Override
	public int countUser(UserVO userVO) {
		return sql.selectOne("admin.countUser", userVO);
	}
	
	@Override
	public int countPartner(PartnerVO partnerVO) {
		return sql.selectOne("admin.countPartner", partnerVO);
	}
	
	@Override
	public int countItem(ItemVO itemVO) {
		return sql.selectOne("admin.countItem", itemVO);
	}
	
	@Override
	public int countFake(FakeVO fakeVO) {
		return sql.selectOne("admin.countFake", fakeVO);
	}
}