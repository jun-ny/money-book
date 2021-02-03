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
	private final int COUNTPERPAGE = 5;
	private final int PAGEPERGROUP = 5;
	
	@Autowired
	private MoneybookService ms;
	
	@RequestMapping(value = "/moneybookList", method = RequestMethod.GET)
	public String moneybookList(
			@RequestParam(value = "page", defaultValue= "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText, 
			Model model) {
		
		int cnt = ms.boardTotal(searchText);
		System.out.println("현재 가계부 항목의 개수 : " +cnt);
		PageNavigator navi = new PageNavigator(COUNTPERPAGE, PAGEPERGROUP, page, cnt);

		
		ArrayList<MoneybookVO> list = ms.selectWeekAgoMoneybook(navi.getStartRecord(), navi.getCountPerPage());
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("cnt", cnt);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "week");
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/monthAgoMoneybook", method = RequestMethod.GET)
	public String monthAgoMoneybook(
			@RequestParam(value = "page", defaultValue= "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText, 
			Model model) {
		
		int cnt = ms.boardTotal(searchText);
		PageNavigator navi = new PageNavigator(COUNTPERPAGE, PAGEPERGROUP, page, cnt);

		ArrayList<MoneybookVO> list = ms.selectMonthAgoMoneybook(navi.getStartRecord(), navi.getCountPerPage());
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "month");
		model.addAttribute("cnt", cnt);
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/sixMonthAgoMoneybook", method = RequestMethod.GET)
	public String sixMonthAgoMoneybook(
			@RequestParam(value = "page", defaultValue= "1") int page,
			@RequestParam(value = "searchText", defaultValue = "") String searchText, 
			Model model) {
		
		int cnt = ms.boardTotal(searchText);
		PageNavigator navi = new PageNavigator(COUNTPERPAGE, PAGEPERGROUP, page, cnt);

		ArrayList<MoneybookVO> list = ms.selectSixMonthAgoMoneybook(navi.getStartRecord(), navi.getCountPerPage());
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "sixMonth");
		model.addAttribute("cnt", cnt);

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
}
