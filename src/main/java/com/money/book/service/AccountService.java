package com.money.book.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.money.book.dao.AccountDAO;
import com.money.book.vo.AccountVO;

@Service
public class AccountService {

	@Autowired
	private AccountDAO dao;
	
	@Autowired
	private HttpSession session;
	
	public String join(AccountVO account) {
		
		int cnt = dao.join(account);
		
		if(cnt==1) {
			return "/account/joinSuccess";
		}else {
			return "/account/joinFail";
		}
		
	}

	public String idCheck(String account_id) {

		String cnt = dao.idCheck(account_id);
		
		return cnt;
	}

	public String login(AccountVO account) {

		AccountVO check_account = dao.selectAccount(account);
		
		if(check_account != null && account.getAccount_pw().equals(check_account.getAccount_pw())) {
			session.setAttribute("loginId", account.getAccount_id());
			return "1";
		}else {
			return "0";
		}
		
	}

	public void logout() {

		session.removeAttribute("loginId");
		
	}

}
