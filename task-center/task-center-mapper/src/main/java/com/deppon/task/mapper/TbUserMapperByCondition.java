package com.deppon.task.mapper;

import java.util.List;

import com.deppon.task.pojo.TbUser;


public interface TbUserMapperByCondition {
	List<TbUser> getUserList(List<String> conditions);
}
