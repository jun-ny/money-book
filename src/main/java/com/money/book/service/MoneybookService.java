package com.money.book.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
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
	
	//오늘을 기준으로 일주일 전 가계부
	public ArrayList<MoneybookVO> selectWeekAgoMoneybook(){
		
		//1.오늘 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, 1);
		String stringToday = sdf.format(cal.getTime());
		
		//2.오늘 날짜에서 일주일 전 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		cal.add(Calendar.DAY_OF_MONTH, -8);
		String stringWeekAgo = sdf.format(cal.getTime());
		
		logger.info("일주일 전 :{} ~ {}",stringWeekAgo,stringToday);
		
		//3.DB에서 해당 날 사이에 있는 가계부 가져오기
		HashMap<Object, String> map = new HashMap<Object, String>();
		String account_no = Integer.toString((int)session.getAttribute("loginNo"));
		
		map.put("account_no",account_no);
		map.put("start", stringWeekAgo);
		map.put("end", stringToday);
		
		ArrayList<MoneybookVO> list = dao.selectMoneybookDate(map);
		
		//4.return 값으로 선택된 가계부 return 하기
		return list;
	}
	
	//오늘 기준 한달 전 가계부
	public ArrayList<MoneybookVO> selectMonthAgoMoneybook() {

		//1.오늘 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, 1);
		String stringToday = sdf.format(cal.getTime());
		
		//2.오늘 날짜에서 한달전 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		cal.add(Calendar.DAY_OF_MONTH, -31);
		String StringMonthAgo = sdf.format(cal.getTime());
		
		logger.info("한달 전 :{} ~ {}",StringMonthAgo,stringToday);
		
		//3.DB에서 해당 날 사이에 있는 가계부 가져오기
		HashMap<Object, String> map = new HashMap<Object, String>();
		String account_no = Integer.toString((int)session.getAttribute("loginNo"));
		
		map.put("account_no",account_no);
		map.put("start", StringMonthAgo);
		map.put("end", stringToday);
		
		ArrayList<MoneybookVO> list = dao.selectMoneybookDate(map);
		
		//4.return 값으로 선택된 가계부 return 하기
		return list;
	}
		
	//오늘 기준 6개월전 가계부
	public ArrayList<MoneybookVO> selectSixMonthAgoMoneybook() {
		
		//1.오늘 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, 1);
		String stringToday = sdf.format(cal.getTime());
		
		//2.오늘 날짜에서 6개월전 날짜 구하기(yyyy-mm-dd로 포맷 바꿔주기)
		cal.add(Calendar.DAY_OF_MONTH, -181);
		String stringSixMonthAgo = sdf.format(cal.getTime());
		
		logger.info("6개월전 :{} ~ {}",stringSixMonthAgo,stringToday);
		
		//3.DB에서 해당 날 사이에 있는 가계부 가져오기
		HashMap<Object, String> map = new HashMap<Object, String>();
		String account_no = Integer.toString((int)session.getAttribute("loginNo"));
		
		map.put("account_no",account_no);
		map.put("start", stringSixMonthAgo);
		map.put("end", stringToday);
		
		ArrayList<MoneybookVO> list = dao.selectMoneybookDate(map);
		
		//4.return 값으로 선택된 가계부 return 하기
		return list;
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
		
		Collections.sort(dateList);
		
		return dateList;
	}
	
	
}
