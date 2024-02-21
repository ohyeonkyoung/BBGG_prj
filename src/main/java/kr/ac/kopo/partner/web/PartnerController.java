package kr.ac.kopo.partner.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.file.FileMngUtil;
import kr.ac.kopo.file.FileService;
import kr.ac.kopo.file.FileVO;
import kr.ac.kopo.item.web.ItemVO;
import kr.ac.kopo.pager.Pager;
import kr.ac.kopo.partner.service.PartnerService;
import kr.ac.kopo.user.web.UserVO;

@Controller
@RequestMapping("/partner")
public class PartnerController {

	private final String path = "partner/";
	
	private final String fileStorePath = "D:/upload";
	
	private static final Logger logger = LoggerFactory.getLogger(PartnerController.class);
	
	@Autowired
	PartnerService service;
	
	//파일 첨부에 필요한 Component
	@Autowired
    FileService fileService;
    
    @Autowired
    FileMngUtil fileUtil;
	
	 @GetMapping("/getRespCount")
	 @ResponseBody
	    public Map<String, List> getRespCount(HttpSession session) {
		 	PartnerVO partnerVO = (PartnerVO) session.getAttribute("loginPartnerVO");
		 	
		 	Long partnerNo = partnerVO.getPartnerNo();
		    Map<String, List> result = service.getRespCount(partnerNo);
	        return result;
	    }
	 
	 @GetMapping("/getItemCount")
	 @ResponseBody
	 public Map<String, Integer> getItemCount(HttpSession session) {
		 PartnerVO partnerVO = (PartnerVO) session.getAttribute("loginPartnerVO");
		 
		 Long partnerNo = partnerVO.getPartnerNo();
		 Map<String, Integer> itemCount = service.getItemCount(partnerNo);
		 return itemCount;
	 }
	 
	@GetMapping("/{partnerNo}")
	public String partner(@PathVariable Long partnerNo, Model model, HttpSession session) {
		PartnerVO loginPartnerVO = (PartnerVO) session.getAttribute("loginPartnerVO");
		partnerNo = loginPartnerVO.getPartnerNo();
		
		PartnerVO partnerVO = service.select(partnerNo);
		model.addAttribute("partnerVO", partnerVO);
		
		return "indexPartner";
	}
	//파트너 회원가입창 이동
	@GetMapping("/add")
	public String add() {
		return path + "signup";
	}
	
	//파트너 회원가입 정보 세션에 저장
	@PostMapping("/add")
	public String add(HttpSession session, UserVO partUserVO) {
		session.setAttribute("partUserVO", partUserVO);
		
		return "redirect:/partner/add/auth";
	}
	
	//2차 인증창 이동
	@GetMapping("/add/auth")
	public String auth() {
		
		return path + "auth";
	}

	//파트너 회원가입 완료
	@PostMapping("/add/auth")
	public String addAuth(PartnerVO partnerVO, HttpSession session) {
		
		UserVO partUserVO = (UserVO) session.getAttribute("partUserVO");
		partnerVO.setPartnerName(partUserVO.getUserName());
		partnerVO.setUserId(partUserVO.getUserId());
		partnerVO.setUserPw(partUserVO.getUserPw());
		partnerVO.setPhone(partUserVO.getPhone());

		Long partnerNo = service.add(partnerVO);
		
		session.removeAttribute("partUserVO");
		
		
		return "redirect:/partner/" + partnerNo;
	}
	
	
	@GetMapping("/list")
	public String list(Model model, Pager pager) {
		List<PartnerVO> list = service.list(pager);
		model.addAttribute("list", list);
		return path + "list";
	}
	
	
	@PostMapping("/update/{partnerNo}")
	public String update(@PathVariable Long partnerNo, PartnerVO partnerVO, MultipartFile file) throws Exception {

		if(file.isEmpty()) {
			service.update(partnerVO, null);
		}
		//중개사무소 소개 사진  업로드 처리
	    FileVO newFileVO = null;

	    if (!file.isEmpty()) {
	    	newFileVO = fileUtil.parseFileInfo(file, "PARTNER", fileStorePath);
	    }
	    service.update(partnerVO, newFileVO);
	    
		return "redirect:/partner/myPage";
	}
	
	
	@GetMapping("/delete/{partnerNo}")
	public String delete(@PathVariable Long partnerNo) {
		service.delete(partnerNo);
		
		return "redirect:../list";
	}
	
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
		PartnerVO loginPartnerVO = (PartnerVO) session.getAttribute("loginPartnerVO");
		if(loginPartnerVO == null) {
			return "redirect:/login";
		}
		Long partnerNo = loginPartnerVO.getPartnerNo();
		PartnerVO partnerVO = service.select(partnerNo);
		model.addAttribute("partnerVO", partnerVO);
		
		return path + "myPage";
	}
	
	@GetMapping("/info/{partnerNo}")
	public String partnerInfo(@PathVariable Long partnerNo, 
								@RequestParam(name = "sortBy", defaultValue = "latest") String sortBy,	
								Model model) {
		
		//중개사무소 정보
		PartnerVO partnerVO = service.select(partnerNo);
		model.addAttribute(partnerVO);
		
		//중개사무소의 모든 방
		List<ItemVO> itemList = service.selectItemList(partnerNo, sortBy);
	
		model.addAttribute("itemList", itemList);
		
		return path + "partnerInfo";
	}
	
	@ResponseBody
	@GetMapping("/itemCount/{partnerNo}")
	public int itemCount(@PathVariable Long partnerNo) {
		Map<String,Integer> itemCount = service.getItemCount(partnerNo);
		Integer wait = itemCount.get("itemWaitCount");
		Integer comp = itemCount.get("itemCompCount");
		int sum = wait + comp;
		return sum;
	}
}
