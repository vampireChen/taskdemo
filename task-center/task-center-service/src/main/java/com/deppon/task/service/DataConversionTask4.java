package com.deppon.task.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.deppon.task.pojo.TbUser;

public class DataConversionTask4{
	@Autowired
	private CopyService copyService;
	public void run() {
		List<String> conditions = new ArrayList<>();
		conditions.add("5");
		conditions.add("6");
		List<TbUser> userList = copyService.getUserByCondition(conditions);
		for (TbUser tbUser : userList) {
			copyService.insertUser(tbUser);
		}
	}
}
