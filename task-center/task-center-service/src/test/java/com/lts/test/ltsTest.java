package com.lts.test;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.ltsopensource.spring.TaskTrackerAnnotationFactoryBean;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:/spring/applicationContext-service.xml","classpath*:applicationContext-context.xml"})
public class ltsTest {
	@Resource
	TaskTrackerAnnotationFactoryBean taskTracker;
	@Test
	public void test01(){
		taskTracker.start();
	}
}