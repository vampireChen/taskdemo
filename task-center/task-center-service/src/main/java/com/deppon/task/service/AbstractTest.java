package com.deppon.task.service;

import org.springframework.beans.factory.InitializingBean;

public abstract class AbstractTest implements InitializingBean{
	
	@Override
	public void afterPropertiesSet() throws Exception {
		// 创建并启动线程
		StartThread startThead = new StartThread();
		startThead.start();

	}
	 class StartThread extends Thread {
		
		@Override
		public void run() {
			super.run();
			String taskIP = getTaskIP();
			System.out.println(taskIP);
		}
		
	}
	public abstract String getTaskIP();
}
