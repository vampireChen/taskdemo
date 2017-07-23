package com.deppon.task.support;

import com.github.ltsopensource.core.cluster.Node;
import com.github.ltsopensource.core.commons.utils.StringUtils;
import com.github.ltsopensource.core.listener.MasterChangeListener;

public class MasterChangeListenerImpl implements MasterChangeListener {

	@Override
	public void change(Node master, boolean isMaster) {
		// 一个节点组master节点变化后的处理 , 譬如我多个JobClient， 但是有些事情只想只有一个节点能做。
        if(isMaster){
            System.out.println("我变成了节点组中的master节点了， 恭喜， 我要放大招了");
        }else{
            System.out.println(StringUtils.format("master节点变成了{}，不是我，我不能放大招，要猥琐", master));
        }
	}
}
