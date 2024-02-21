package kr.ac.kopo.admin.dao;

import java.util.List;

import kr.ac.kopo.fake.web.FakeVO;
import kr.ac.kopo.item.web.ItemVO;
import kr.ac.kopo.pager.Pager;
import kr.ac.kopo.partner.web.PartnerVO;
import kr.ac.kopo.user.web.UserVO;

public interface AdminDao {

	List<UserVO> userList(UserVO userVO);
	List<UserVO> userListAll(Pager pager);
	List<PartnerVO> partnerList(PartnerVO partnerVO);
	List<PartnerVO> partnerListAll(Pager pager);
	List<ItemVO> itemList(ItemVO itemVO);
	List<FakeVO> fakeList(FakeVO fakeVO);
	
	int countUser();
	int countUserYestd();
	int countPartner();
	int countPartnerYestd();
	int countItem();
	int countItemYestd();
	int countFake();
	int countFakeYestd();
	
	int total(Pager pager);
	
}
