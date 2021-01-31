package com.money.book.dao;

import com.money.book.vo.AccountVO;

public interface AccountMapper {

	public int join(AccountVO account);

	public String idCheck(String account_id);

	public AccountVO selectAccount(AccountVO account);

}
