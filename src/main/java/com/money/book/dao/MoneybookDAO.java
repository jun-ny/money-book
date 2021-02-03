package com.money.book.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.money.book.vo.MoneybookVO;

@Repository
public class MoneybookDAO {

	@Autowired
	private SqlSession ss;

	public int writeMoneybook(MoneybookVO moneybook) {

		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		int cnt = 0;
		
		try {
			cnt = mm.writeMoneybook(moneybook);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	public ArrayList<MoneybookVO> selectAllMoneybook(int account_no){
		
		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		ArrayList<MoneybookVO> list = null;
		
		try {
			list = mm.selectAllMoneybook(account_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	public ArrayList<MoneybookVO> selectMoneybookDate(HashMap<Object, String> map){
		
		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		ArrayList<MoneybookVO> list = null;
		
		try {
			list = mm.selectMoneybookDate(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int boardTotal(HashMap<String, Object> map) {
		
		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		int amount = 0;

		try {
			amount = mm.boardTotal(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return amount;
	}
	
	public int sumMoneybookAmount(HashMap<String, Object> map) {
		
		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		int amount = 0;
		
		try {
			amount = mm.sumMoneybookAmount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return amount;
	}

	public int selectInMoneybook(int account_no, String moneybook_date) {

		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		int amount = 0;
		
		try {
			amount = mm.selectInMoneybook(account_no, moneybook_date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return amount;
	}

	public int selectOutMoneybook(int account_no, String moneybook_date) {
		
		MoneybookMapper mm = ss.getMapper(MoneybookMapper.class);
		int amount = 0;
		
		try {
			amount = mm.selectOutMoneybook(account_no, moneybook_date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return amount;
	}
	
	
}
