package com.money.book.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.money.book.vo.AccountVO;

@Repository
public class AccountDAO {

	@Autowired
	private SqlSession ss;
	
	public int join(AccountVO account) {

		AccountMapper am = ss.getMapper(AccountMapper.class);
		int cnt = 0;
		
		try {
			cnt = am.join(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public String idCheck(String account_id) {

		AccountMapper am = ss.getMapper(AccountMapper.class);
		String cnt = "";
		
		try {
			cnt = am.idCheck(account_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public AccountVO selectAccount(AccountVO account) {
		
		AccountMapper am = ss.getMapper(AccountMapper.class);
		AccountVO check_account = null;
		
		try {
			check_account = am.selectAccount(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return check_account;
	}

}
