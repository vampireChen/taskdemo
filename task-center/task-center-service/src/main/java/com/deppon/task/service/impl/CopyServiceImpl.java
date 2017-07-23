package com.deppon.task.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deppon.task.mapper.TbUserCopyMapper;
import com.deppon.task.mapper.TbUserMapper;
import com.deppon.task.mapper.TbUserMapperByCondition;
import com.deppon.task.pojo.TbUser;
import com.deppon.task.pojo.TbUserCopy;
import com.deppon.task.pojo.TbUserExample;
import com.deppon.task.pojo.TbUserExample.Criteria;
import com.deppon.task.service.CopyService;


@Service
public class CopyServiceImpl implements CopyService {

	@Autowired
	private TbUserMapper userMapper;
	@Autowired
	private TbUserMapperByCondition usrMapperCondition;
	@Autowired
	private TbUserCopyMapper userCopyMapper;
	@Override
	public TbUser getUser(long id) {
		TbUserExample example = new TbUserExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(id);
		List<TbUser> list = userMapper.selectByExample(example);
		if(list != null && list.size() > 0){
			TbUser user = list.get(0);
			return user;
		}
		return null;
	}
	@Override
	public int insertUser(TbUser tbUser) {
		String str = JsonUtils.objectToJson(tbUser);
		TbUserCopy copyUser = JsonUtils.jsonToPojo(str, TbUserCopy.class);
		return userCopyMapper.insert(copyUser);
	}
	@Override
	public List<TbUser> getUserByCondition(List<String> conditions) {
		List<TbUser> userList = usrMapperCondition.getUserList(conditions);
		return userList;
	}
	@Override
	public List<TbUser> getAllUser() {
		TbUserExample example = new TbUserExample();
		List<TbUser> result = userMapper.selectByExample(example);
		return result;
	}
}
