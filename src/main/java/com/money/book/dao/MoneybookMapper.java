package com.money.book.dao;

import java.util.ArrayList;

import com.money.book.vo.MoneybookVO;

public interface MoneybookMapper {

	public int writeMoneybook(MoneybookVO moneybook);

	public ArrayList<MoneybookVO> selectAllMoneybook(int account_no);
	
}
