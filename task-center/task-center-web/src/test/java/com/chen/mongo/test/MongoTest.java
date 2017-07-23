package com.chen.mongo.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.deppon.task.pojo.OriUgcInAccountTurnOverInfo;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/applicationContext-mongo.xml" })
public class MongoTest {
	@Autowired
	private MongoTemplate mongoTemplate;
	
	@Test
	public void test(){
		OriUgcInAccountTurnOverInfo findOne = mongoTemplate.findOne(new Query(Criteria.where("messageId").is("b84ca1b0-3640-4972-a60e-73324a4f5bf9_670101488383996905417721")), OriUgcInAccountTurnOverInfo.class);
		System.out.println(findOne.getAccount());
	}
}
