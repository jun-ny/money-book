package com.money.book.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.money.book.service.AccountService;
import com.money.book.vo.AccountVO;

@Controller
@RequestMapping(value = "/account")
public class AccountController {

	private Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@Autowired
	 private AccountService as;
	
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm() {
		
		return "account/joinForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	public String idCheck(String account_id) {

		String cnt = as.idCheck(account_id);
		
		return cnt;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST) 
	public String join(AccountVO account) {
		
		String page = as.join(account);
		
		return page; 
	}
	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		
		return "account/loginForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(AccountVO account) {
		
		String cnt = as.login(account);
		
		return cnt;
	}
	
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logout() {
		
		as.logout();
		
		return "redirect:/";
	}
	
	
	
}
