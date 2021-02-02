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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.money.book.service.MoneybookService;
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
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "week");
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/monthAgoMoneybook", method = RequestMethod.GET)
	public String monthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectMonthAgoMoneybook();
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "month");
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/sixMonthAgoMoneybook", method = RequestMethod.GET)
	public String sixMonthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectSixMonthAgoMoneybook();
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		model.addAttribute("type", "sixMonth");
		
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
	
}
