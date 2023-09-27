package kr.ac.kopo.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.ac.kopo.item.web.ItemVO;

public interface ItemDao {

	List<ItemVO> itemList();

	ItemVO itemSelect(ItemVO itemVO);

	void itemAdd(ItemVO itemVO);

	void leaseAdd(HashMap<String, Long> map);

	void monthAdd(HashMap<String, Long> map);

	List<ItemVO> partItemList(Long partnerNo);

	void updateStatus(Long itemNo);

	String selectStatus(Long itemNo);

	void deleteItem(Long itemNo);

}
