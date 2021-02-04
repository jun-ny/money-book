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
	
	//주 단위 가계부
	public ArrayList<HashMap<String, Object>> perWeekMoneybook(int no){
		
		//1.현재 달을 주단위로 나눠줌
		//2.db로 보내서 해당 날짜 사이의 지출과 수입 금액을 가져옴
		//3.arraylist<hashmap>에 담아서 return
		
		if(no==0) {
			
			int account_no = (int)session.getAttribute("loginNo");
			HashMap<String, Object> inputMap = new HashMap<String, Object>();
			ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
			
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = 1;
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			inputMap.put("account_no", account_no);
	
			while(true) {
				
					String start = year+"-"+month+"-"+day;
					
					day = day + 6;
					
					String end ="";
					
					if(day>lastDay) {
						end = year+"-"+month+"-"+lastDay;
					}else {
						end = year+"-"+month+"-"+day;
					}
					
					inputMap.put("start",start);
					inputMap.put("end", end);
					
					HashMap<String, Object> resultMap = new HashMap<String, Object>();
	
					resultMap.put("period", start+"~"+end);
		
					//지출
					inputMap.put("moneybook_type", "지출");
					logger.info("{} ~ {} 사이의 {}의 합계는 {}",start,end,"지출",dao.sumMoneybookAmount(inputMap));
					resultMap.put("out", "지출");
					resultMap.put("outAmount", dao.sumMoneybookAmount(inputMap));
					
					//수입
					inputMap.put("moneybook_type", "수입");
					logger.info("{} ~ {} 사이의 {}의 합계는 {}",start,end,"수입",dao.sumMoneybookAmount(inputMap));
					resultMap.put("in", "수입");
					resultMap.put("inAmount", dao.sumMoneybookAmount(inputMap));
					
					resultList.add(resultMap);
				
					if(day>=lastDay) break;
				
					day = day + 1;
				
			}
			
			return resultList;
		}else {
			
			int account_no = (int)session.getAttribute("loginNo");
			HashMap<String, Object> inputMap = new HashMap<String, Object>();
			ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
			
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = no;
			int day = 1;
			int lastDay = 0;
			
			if(month==1) {
				lastDay = 31;
			}else if(month==2) {
				lastDay = 28;
			}else if(month==3) {
				lastDay = 31;
			}else if(month==4) {
				lastDay = 30;
			}else if(month==5) {
				lastDay = 31;
			}else if(month==6) {
				lastDay = 30;
			}else if(month==7) {
				lastDay = 31;
			}else if(month==8) {
				lastDay = 31;
			}else if(month==9) {
				lastDay = 30;
			}else if(month==10) {
				lastDay = 31;
			}else if(month==11) {
				lastDay = 30;
			}else if(month==12) {
				lastDay = 31;
			}
			
			inputMap.put("account_no", account_no);
	
			while(true) {
				
					String start = year+"-"+month+"-"+day;
					
					day = day + 6;
					
					String end ="";
					
					if(day>lastDay) {
						end = year+"-"+month+"-"+lastDay;
					}else {
						end = year+"-"+month+"-"+day;
					}
					
					inputMap.put("start",start);
					inputMap.put("end", end);
					
					HashMap<String, Object> resultMap = new HashMap<String, Object>();
	
					resultMap.put("period", start+"~"+end);
		
					//지출
					inputMap.put("moneybook_type", "지출");
					logger.info("{} ~ {} 사이의 {}의 합계는 {}",start,end,"지출",dao.sumMoneybookAmount(inputMap));
					resultMap.put("out", "지출");
					resultMap.put("outAmount", dao.sumMoneybookAmount(inputMap));
					
					//수입
					inputMap.put("moneybook_type", "수입");
					logger.info("{} ~ {} 사이의 {}의 합계는 {}",start,end,"수입",dao.sumMoneybookAmount(inputMap));
					resultMap.put("in", "수입");
					resultMap.put("inAmount", dao.sumMoneybookAmount(inputMap));
					
					resultList.add(resultMap);
				
					if(day>=lastDay) break;
				
					day = day + 1;
				
			}
			
			return resultList;
			
		}
	}
	
	//월 단위 가계부
	public ArrayList<HashMap<String, Object>> perMonthMoneybookList(){
		
		int account_no = (int)session.getAttribute("loginNo");
		HashMap<String, Object> inputMap = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int presentMonth = cal.get(Calendar.MONTH) + 1;
		int lastDay = 0;
		int month = 1;
		inputMap.put("account_no", account_no);
		
		while(month<=presentMonth) {
			
			if(month==1) {
				lastDay = 31;
			}else if(month==2) {
				lastDay = 28;
			}else if(month==3) {
				lastDay = 31;
			}else if(month==4) {
				lastDay = 30;
			}else if(month==5) {
				lastDay = 31;
			}else if(month==6) {
				lastDay = 30;
			}else if(month==7) {
				lastDay = 31;
			}else if(month==8) {
				lastDay = 31;
			}else if(month==9) {
				lastDay = 30;
			}else if(month==10) {
				lastDay = 31;
			}else if(month==11) {
				lastDay = 30;
			}else if(month==12) {
				lastDay = 31;
			}
			
			String start = year+"-"+month+"-"+1;
			
			String end = year+"-"+month+"-"+lastDay;
			
			inputMap.put("start", start);
			inputMap.put("end", end);
			
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("period", month+"월");
			
			//수입
			inputMap.put("moneybook_type", "수입");
			resultMap.put("in", "수입");
			resultMap.put("inAmount", dao.sumMoneybookAmount(inputMap));

			//지출
			inputMap.put("moneybook_type", "지출");
			resultMap.put("out", "지출");
			resultMap.put("outAmount", dao.sumMoneybookAmount(inputMap));
			
			resultList.add(resultMap);
			
			month += 1;
			
		}
		
		return resultList;
		
	}
	
	public ArrayList<HashMap<String, Object>> selectInMoneybook() {

		int account_no = (int)session.getAttribute("loginNo");
		
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MoneybookVO> list = dao.selectAllMoneybook(account_no);
		ArrayList<String> dateList = moneybookDate(list);
		
		for(String moneybook_date : dateList) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			logger.info("no {} date {}",account_no, moneybook_date);
			int amount = dao.selectInMoneybook(account_no, moneybook_date);
			if(amount != 0) {
				resultMap.put("title", "수입 "+amount);
				resultMap.put("start", moneybook_date);
				resultMap.put("end", moneybook_date);
				resultList.add(resultMap);
			}
		}
		
		return resultList;
	}
	
	public ArrayList<HashMap<String, Object>> selectOutMoneybook() {

		int account_no = (int)session.getAttribute("loginNo");
		
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MoneybookVO> list = dao.selectAllMoneybook(account_no);
		ArrayList<String> dateList = moneybookDate(list);
		
		for(String moneybook_date : dateList) {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			logger.info("no {} date {}",account_no, moneybook_date);
			int amount = dao.selectOutMoneybook(account_no, moneybook_date);
			if(amount != 0) {
				resultMap.put("title", "지출 "+amount);
				resultMap.put("start", moneybook_date);
				resultMap.put("end", moneybook_date);
				resultMap.put("color", "red");
				resultList.add(resultMap);
			}
		}
		
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
		
		Collections.sort(dateList);
		
		return dateList;
	}
	
	
}
