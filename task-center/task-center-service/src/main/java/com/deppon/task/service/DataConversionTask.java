package com.deppon.task.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.deppon.task.pojo.TbUser;

public class DataConversionTask {
	@Autowired
	private CopyService copyService;
	public void run() {
		List<String> conditions = new ArrayList<>();
		conditions.add("1");
		conditions.add("2");
		List<TbUser> userList = copyService.getUserByCondition(conditions);
		for (TbUser tbUser : userList) {
			copyService.insertUser(tbUser);
		}
		System.out.println("aaaa" + new Date());
	}
}
