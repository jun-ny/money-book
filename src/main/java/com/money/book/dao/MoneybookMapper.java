package com.money.book.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.money.book.vo.MoneybookVO;

public interface MoneybookMapper {

	public int writeMoneybook(MoneybookVO moneybook);

	public ArrayList<MoneybookVO> selectAllMoneybook(int account_no);
	
	public int boardTotal(HashMap<String, Object> map);

	public ArrayList<MoneybookVO> selectMoneybookDate(HashMap<Object, String> map);
	
	public int sumMoneybookAmount(HashMap<String, Object> map);

	public int selectInMoneybook(@Param("account_no")int account_no, @Param("moneybook_date")String moneybook_date);

	public int selectOutMoneybook(@Param("account_no")int account_no, @Param("moneybook_date")String moneybook_date);
	
	
}
