package com.money.book.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.money.book.vo.MoneybookVO;

public interface MoneybookMapper {

	public int writeMoneybook(MoneybookVO moneybook);

	public ArrayList<MoneybookVO> selectAllMoneybook(int account_no);
	
	public ArrayList<MoneybookVO> selectMoneybookDate(HashMap<Object, String> map);
	
	public int sumMoneybookAmount(HashMap<String, Object> map);
	
}
