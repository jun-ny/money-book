package com.money.book.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.money.book.vo.MoneybookVO;

public interface MoneybookMapper {

	public int writeMoneybook(MoneybookVO moneybook);

	public ArrayList<MoneybookVO> selectAllMoneybook(MoneybookVO moneybook);
	
	public int boardTotal(HashMap<String, Object> map);

	public ArrayList<MoneybookVO> selectMoneybookDate(HashMap<String, Object> map);
	
	public int sumMoneybookAmount(HashMap<String, Object> map);

	public int selectInMoneybook(@Param("account_no")int account_no
								,@Param("moneybook_date")String moneybook_date);

	public int selectOutMoneybook(@Param("account_no")int account_no
								,@Param("moneybook_date")String moneybook_date);
	
	public int sumMoneybookAmountType(@Param("account_no")int account_no
									,@Param("moneybook_type")String moneybook_type
									,@Param("start")String start
									,@Param("end")String end);
	
	public int categoryAmount(@Param("account_no")int account_no
							,@Param("moneybook_category")String moneybook_category
							,@Param("moneybook_type")String moneybook_type
							,@Param("start")String start
							,@Param("end")String end);
	
}
