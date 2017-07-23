package com.deppon.task.service;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.github.ltsopensource.tasktracker.TaskTracker;
//import com.github.ltsopensource.tasktracker.TaskTracker;
public class MyJobTest {
	public static void main(String[] args) {
		//ApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-service.xml");
//		Object bean = context.getBean("taskTrackerAnnotationFactoryBean");
//		TaskTracker annotationFac = (TaskTracker) bean;
		//annotationFac.start();
		TaskTracker taskTracker = new TaskTracker();
		taskTracker.setJobRunnerClass(MyJobRunner.class);
		taskTracker.setRegistryAddress("zookeeper://192.168.98.143:2181");
		taskTracker.setNodeGroup("test_TaskTracker");
		/*taskTracker.setRegistryAddress("zookeeper://10.230.20.101:2181");
		taskTracker.setNodeGroup("test_TaskTracker");*/
		taskTracker.setClusterName("test_cluster");
		taskTracker.setWorkThreads(20);
		taskTracker.start();
		
		//ApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-*.xml");
	}
}
