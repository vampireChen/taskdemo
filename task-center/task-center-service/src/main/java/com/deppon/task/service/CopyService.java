package com.deppon.task.service;

import java.util.List;

import com.deppon.task.pojo.TbUser;


public interface CopyService {
	TbUser getUser(long id);
	int insertUser(TbUser tbUser);
	List<TbUser> getUserByCondition(List<String> conditions);
	List<TbUser> getAllUser();
}
