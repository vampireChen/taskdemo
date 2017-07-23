package com.deppon.task.service;

import org.springframework.beans.factory.annotation.Value;

import com.github.ltsopensource.spring.quartz.QuartzLTSProxyBean;

public class Test {
	public static void main(String[] args){
		String a = "lts.jobclient.bind-ip.clusterName";
		System.out.println(a.startsWith("lts.jobclient.bind-ip"));
	}
	
}
