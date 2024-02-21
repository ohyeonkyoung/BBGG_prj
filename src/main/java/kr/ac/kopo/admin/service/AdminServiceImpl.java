package kr.ac.kopo.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.admin.dao.AdminDao;
import kr.ac.kopo.fake.web.FakeVO;
import kr.ac.kopo.item.web.ItemVO;
import kr.ac.kopo.pager.Pager;
import kr.ac.kopo.partner.web.PartnerVO;
import kr.ac.kopo.user.web.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDao adminDao;
	
	@Override
	public List<UserVO> userList(UserVO userVO) {
		return adminDao.userList(userVO);
	}
	
	@Override
	public List<UserVO> userListAll(Pager pager) {
		int total = adminDao.total(pager);
		pager.setTotal(total);
		return adminDao.userListAll(pager);
	}
	
	@Override
	public List<PartnerVO> partnerList(PartnerVO partnerVO) {
		return adminDao.partnerList(partnerVO);
	}
	
	@Override
	public List<PartnerVO> partnerListAll(Pager pager) {
		int total = adminDao.total(pager);
		pager.setTotal(total);
		return adminDao.partnerListAll(pager);
	}

	@Override
	public List<ItemVO> itemList(ItemVO itemVO) {
		return adminDao.itemList(itemVO);
	}

	@Override
	public List<FakeVO> fakeList(FakeVO fakeVO) {
		return adminDao.fakeList(fakeVO);
	}

	@Override
	public Integer userCount() {
		int countUser = adminDao.countUser();
		return adminDao.countUser();
	}
	
	@Override
	public Integer userYestdCount() {
		int countUserYestd = adminDao.countUserYestd();
		return adminDao.countUserYestd();
	}
	
	@Override
	public Integer partnerCount() {
		int countPartner = adminDao.countPartner();
		return adminDao.countPartner();
	}
	
	@Override
	public Integer partnerYestdCount() {
		int countPartnerYestd = adminDao.countPartnerYestd();
		return adminDao.countPartnerYestd();
	}
	
	@Override
	public Integer itemCount() {
		int countItem = adminDao.countItem();
		return adminDao.countItem();
	}
	
	@Override
	public Integer itemYestdCount() {
		int countItemYestd = adminDao.countItemYestd();
		return adminDao.countItemYestd();
	}
	
	@Override
	public Integer fakeCount() {
		int countFake = adminDao.countFake();
		return adminDao.countFake();
	}

	@Override
	public Integer fakeYestdCount() {
		int fakeUserYestd = adminDao.countFakeYestd();
		return adminDao.countFakeYestd();
	}

}