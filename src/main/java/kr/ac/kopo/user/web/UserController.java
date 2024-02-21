package kr.ac.kopo.user.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.pager.Pager;
import kr.ac.kopo.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	private final String path = "user/";
	
	@Autowired
	UserService service;
	
	@GetMapping("/list")
	public String list(Model model, Pager pager) {
		List<UserVO> list = service.list(pager);
		model.addAttribute("list", list);
		return path + "list";
	}
	
	@GetMapping("/add")
	public String add() {
		return path + "signup";
	}
	
	@PostMapping("/add")
	public String add(UserVO userVO) {
		service.add(userVO);
		
		return "redirect:/";
	}
	
	@GetMapping("/update/{userNo}")
	public String update(@PathVariable Long userNo, Model model) {
		UserVO userVO = service.select(userNo);
		model.addAttribute("userVO", userVO);
		
		return path + "update";
	}
	
	@PostMapping("/update/{userNo}")
	public String update(@PathVariable Long userNo, UserVO userVO) {
		userVO.setUserNo(userNo);
		service.update(userVO);
		
		return "redirect:../list";
	}
	
	@GetMapping("/delete/{userNo}")
	public String delete(@PathVariable Long userNo) {
		service.delete(userNo);
		
		return "redirect:../list";
	}
}
