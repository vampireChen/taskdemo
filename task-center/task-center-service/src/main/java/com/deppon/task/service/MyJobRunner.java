package com.deppon.task.service;


import java.util.Date;
import java.util.concurrent.atomic.AtomicLong;

import com.github.ltsopensource.core.commons.utils.DateUtils;
import com.github.ltsopensource.core.domain.Action;
import com.github.ltsopensource.tasktracker.Result;
import com.github.ltsopensource.tasktracker.runner.JobContext;
import com.github.ltsopensource.tasktracker.runner.JobRunner;

public class MyJobRunner implements JobRunner{

	@Override
	public Result run(JobContext jobContext) throws Throwable {
		AtomicLong counter = new AtomicLong(0);
		try {
			System.out.println(DateUtils.formatYMD_HMS(new Date()) + "   " + counter.incrementAndGet());
			Thread.sleep(1000);
			jobContext.getBizLogger().info("测试,业务日志");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(DateUtils.formatYMD_HMS(new Date()));
			return new Result(Action.EXECUTE_EXCEPTION, e.getMessage());
		}
		return new Result(Action.EXECUTE_SUCCESS, "执行成功了，哈哈");
		//return new Result(Action.EXECUTE_FAILED, "执行失败");
	}

}
