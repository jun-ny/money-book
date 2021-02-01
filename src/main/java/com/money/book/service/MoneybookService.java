package com.money.book.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.money.book.dao.MoneybookDAO;
import com.money.book.vo.MoneybookVO;

@Service
public class MoneybookService {

	private static final Logger logger = LoggerFactory.getLogger(MoneybookService.class);
	
	@Autowired
	private MoneybookDAO dao;

	@Autowired
	private HttpSession session;

	public String writeMoneybook(MoneybookVO moneybook) {
		
		int account_no = (int)session.getAttribute("loginNo");
		moneybook.setAccount_no(account_no);
		
		int cnt = dao.writeMoneybook(moneybook);
		
		return "redirect:/moneybook/moneybookList";
	}
	
	//오늘을 기준으로 일주일 전후 가계부
	public ArrayList<MoneybookVO> selectPerWeekMoneybook(){
		
		int account_no = (int)session.getAttribute("loginNo");
		ArrayList<MoneybookVO> list = dao.selectAllMoneybook(account_no);
		
		ArrayList<MoneybookVO> resultList = new ArrayList<MoneybookVO>();
		
		//1.오늘 날짜 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String stringToday = sdf.format(cal.getTime());
		
		//2.오늘 날짜에서 일주일 후 일주일 전 날짜 구하기
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String stringBeforeWeekDay = sdf.format(cal.getTime());
		
		cal.add(Calendar.DAY_OF_MONTH, 14);
		String stringAfterWeekDay = sdf.format(cal.getTime());
		
		java.util.Date beforeWeekDay = null;
		java.util.Date afterWeekDay = null;
		
		try {	
			beforeWeekDay = sdf.parse(stringBeforeWeekDay);
			afterWeekDay = sdf.parse(stringAfterWeekDay);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//3.모든 가계부 작성일에서 앞서 구한 일주일 후 일주일 전 사이에 있는 가계부 선택하기
		for(MoneybookVO moneybook : list) {
			
			java.util.Date moneybook_indate = null;
			
			try {
				 moneybook_indate = sdf.parse(moneybook.getMoneybook_date());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(beforeWeekDay.before(moneybook_indate) && moneybook_indate.before(afterWeekDay)) {
				logger.info("{} 는 {} 와 {} 사이 이다.", moneybook.getMoneybook_date(), stringBeforeWeekDay, stringAfterWeekDay);
				resultList.add(moneybook);
			}
			
		}
		
		//4.return 값으로 선택된 가계부 return 하기
		return resultList;
	}
	
	
	//가계부의 중복되는 날짜 빼기
	public ArrayList<String> moneybookDate(ArrayList<MoneybookVO> list){
		
		ArrayList<String> dateList = new ArrayList<String>();
		
		for(MoneybookVO moneybook : list) {
			
			if(dateList.isEmpty()) {
				dateList.add(moneybook.getMoneybook_date());
			} else {
				
				if(!dateList.contains(moneybook.getMoneybook_date())) {
					dateList.add(moneybook.getMoneybook_date());
				}
				
			}
		}

		return dateList;
	}
	
	
	//가계부의 날짜 갯수 구하기
	public ArrayList<Integer> moneybookDateCount(ArrayList<String> dateList, ArrayList<MoneybookVO> moneybookList){
		
		ArrayList<Integer> cntList = new ArrayList<Integer>();
		
		for(String date : dateList) {
			int cnt = 0;
			for(MoneybookVO moneybook : moneybookList) {
				if(date.equals(moneybook.getMoneybook_date())) {
					cnt++;
				}
			}
			
			cntList.add(cnt);
		}
		
		return cntList;
	}
	
	
	
	
}
