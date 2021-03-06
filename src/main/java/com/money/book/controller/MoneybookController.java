package com.money.book.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.money.book.service.MoneybookService;
import com.money.book.util.PageNavigator;
import com.money.book.vo.MoneybookVO;

@Controller
@RequestMapping(value = "/moneybook")
public class MoneybookController {

	private Logger logger = LoggerFactory.getLogger(MoneybookController.class);
	
	@Autowired
	private MoneybookService ms;
	
	@RequestMapping(value = "/moneybookList", method = RequestMethod.GET)
	public String moneybookList(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectWeekAgoMoneybook();
		ArrayList<String> tempDateList = ms.moneybookDate(list);
		ArrayList<String> dateList = new ArrayList<String>();
		
		if(tempDateList.size()<=2) {
			logger.info("넘겨주는 dateList {}",dateList);
			model.addAttribute("dateList", tempDateList);
		}else {
			for(int i = 0 ; i<3 ; i++) {
				dateList.add(tempDateList.get(i));
			}
			logger.info("dateList {}",dateList);
			model.addAttribute("dateList", dateList);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", list.size());
		model.addAttribute("type", "week");
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/monthAgoMoneybook", method = RequestMethod.GET)
	public String monthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectMonthAgoMoneybook();
		ArrayList<String> tempDateList = ms.moneybookDate(list);
		ArrayList<String> dateList = new ArrayList<String>();
		
		if(tempDateList.size()<=2) {
			logger.info("dateList {}",tempDateList);
			model.addAttribute("dateList", tempDateList);
		}else {
			for(int i = 0 ; i<3 ; i++) {
				dateList.add(tempDateList.get(i));
			}
			logger.info("dateList {}",dateList);
			model.addAttribute("dateList", dateList);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("type", "month");
		model.addAttribute("cnt", list.size());
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/sixMonthAgoMoneybook", method = RequestMethod.GET)
	public String sixMonthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectSixMonthAgoMoneybook();
		ArrayList<String> tempDateList = ms.moneybookDate(list);
		ArrayList<String> dateList = new ArrayList<String>();
		
		if(tempDateList.size()<=2) {
			logger.info("dateList {}",tempDateList);
			model.addAttribute("dateList", tempDateList);
		}else {
			for(int i = 0 ; i<3 ; i++) {
				dateList.add(tempDateList.get(i));
			}
			logger.info("dateList {}",dateList);
			model.addAttribute("dateList", dateList);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("type", "sixMonth");
		model.addAttribute("cnt", list.size());

		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/perWeekMoneybookList", method = RequestMethod.GET )
	public String perWeekMoneybookList(Model model,@RequestParam(defaultValue = "0") int no) {
		
		Calendar cal = Calendar.getInstance();
		
		logger.info("no : {}", no);
		
		ArrayList<HashMap<String, Object>> list = ms.perWeekMoneybook(no);
		int month = cal.get(Calendar.MONTH) + 1;
		
		logger.info("일주일 단위 가계부 : {}",list);
		
		model.addAttribute("list", list);
		model.addAttribute("month", month);
		model.addAttribute("no", no);
		model.addAttribute("type", "week");
		
		return "moneybook/perMoneybookList";
	}
	
	@RequestMapping(value = "/perMonthMoneybookList", method = RequestMethod.GET)
	public String perMonthMoneybookList(Model model) {
		
		ArrayList<HashMap<String, Object>> list = ms.perMonthMoneybookList();
		
		logger.info("월단위 가계부 : {}",list);
		
		model.addAttribute("list", list);
		model.addAttribute("type", "month");
		
		return "moneybook/perMoneybookList";
	}
	
	
	@RequestMapping(value = "/writeMoneybookForm", method = RequestMethod.GET)
	public String writeMoneybookForm() {
		
		return "moneybook/writeMoneybookForm";
	}
	
	@RequestMapping(value = "/writeMoneybook", method = RequestMethod.GET)
	public String writeMoneybook(MoneybookVO moneybook) {
		
		logger.info("작성된 가계부 {}",moneybook);
		
		String page = ms.writeMoneybook(moneybook);
		
		return page;
	}
	
	@RequestMapping(value = "/moneybookCalendar", method = RequestMethod.GET)
	public String moneybookCalendar() {
		
		return "moneybook/moneybookCalendar";
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectInMoneybook", method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> selectInMoneybook(){
		
		ArrayList<HashMap<String, Object>> list = ms.selectInMoneybook();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectOutMoneybook", method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> selectOutMoneybook(){
		
		ArrayList<HashMap<String, Object>> list = ms.selectOutMoneybook();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectBeforeMoneybook", method = RequestMethod.GET)
	public ArrayList<MoneybookVO> selectBeforeMoneybook(String period){
		
		logger.info("period {} ", period);
		ArrayList<MoneybookVO> list = null;
		
		if(period.equals("week")) {
			 list = ms.selectWeekAgoMoneybook();
		}else if(period.equals("month")) {
			 list = ms.selectMonthAgoMoneybook();
		}else {
			list = ms.selectSixMonthAgoMoneybook();
		}
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectBeforeMoneybookDate", method = RequestMethod.GET)
	public ArrayList<String> selectBeforeMoneybookDate(String period){
		
		logger.info("period {} ", period);
		ArrayList<MoneybookVO> list = null;
		
		if(period.equals("week")) {
			list = ms.selectWeekAgoMoneybook();
		}else if(period.equals("month")) {
			list = ms.selectMonthAgoMoneybook();
		}else {
			list = ms.selectSixMonthAgoMoneybook();
		}
		
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		return dateList;
	}
	
	@RequestMapping(value = "/moneybookPie", method = RequestMethod.GET)
	public String moneybookGraph(Model model, @RequestParam(defaultValue = "0")int month) {
		
		Calendar cal = Calendar.getInstance();
		int currentMonth = cal.get(Calendar.MONTH) + 1;
		
		model.addAttribute("currentMonth", currentMonth);
		model.addAttribute("month", month);
		
		return "moneybook/moneybookPie";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pieGraphOut", method = RequestMethod.GET)
	public ArrayList<HashMap<String, Object>> pieGraphOut(int month){
		
		ArrayList<HashMap<String, Object>> list = ms.pieGraphOut(month);
		logger.info("카테고리 별 퍼센티지 {}",list);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/pieGraphIn", method = RequestMethod.GET)
	public ArrayList<HashMap<String, Object>> pieGraphIn(int month){
		
		ArrayList<HashMap<String, Object>> list = ms.pieGraphIn(month);
		logger.info("카테고리 별 퍼센티지 {}",list);
		
		return list;
	}
	
	@RequestMapping(value = "/moneybookColumn", method = RequestMethod.GET)
	public String moneybookColumn(Model model) {
		
		ArrayList<HashMap<String, Object>> list = ms.perMonthMoneybookList();
		
		logger.info("월단위 가계부 : {}",list);
		
		model.addAttribute("in", "수입");
		model.addAttribute("out", "지출");
		model.addAttribute("list", list);
		
		return "moneybook/moneybookColumn";
	}
	
	
	
}
