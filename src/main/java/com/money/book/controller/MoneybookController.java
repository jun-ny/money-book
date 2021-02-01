package com.money.book.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/monthAgoMoneybook", method = RequestMethod.GET)
	public String monthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectMonthAgoMoneybook();
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		
		return "moneybook/moneybookList";
	}
	
	@RequestMapping(value = "/sixMonthAgoMoneybook", method = RequestMethod.GET)
	public String sixMonthAgoMoneybook(Model model) {
		
		ArrayList<MoneybookVO> list = ms.selectSixMonthAgoMoneybook();
		ArrayList<String> dateList = ms.moneybookDate(list);
		
		logger.info("dateList {}", dateList);
		
		model.addAttribute("list", list);
		model.addAttribute("dateList", dateList);
		
		return "moneybook/moneybookList";
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
