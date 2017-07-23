package com.task.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 测试
 * @author chenhaitao
 *
 */
@Controller
public class IndexController {
	@RequestMapping("/index")
	public String showIndex(){
		return "index";
	}
	/*@RequestMapping("/index")
	public String showIndex(){
		return "菜单说明";
	}*/
}
