// ------------------------------------常量----------------------------------
operatorCount = {
	defaultV : 0,
	successV : 1,
	failureV : -1
}; // 操作返回值 1为成功，-1为失败
delAgencyType = 'MANY'; // 删除的类型，批量
delType = 'MANY'; // 删除的类型，批量
viewState = {
	add : 'ADD',
	update : 'UPDATE',
	view : 'VIEW'
}; // 查看状态viewState："ADD"新增,"UPDATE"修改,"VIEW"查看
booleanType = {
	yes : 'Y',
	no : 'N'
}; // booleanType 对应后台常量 "布尔类型"
effectiveState = {
	active : 'Y',
	inactive : 'N'
}; // booleanType 对应后台常量 "生效/未生效"
booleanStr = {
	yes : 'true',
	no : 'false'
}; // booleanStr 从复选框中得到值
operateType = {
	save : 'SAVE'
}; // 标识 是否 保存操作
levelType = {
	p : 'PARENT',
	c : 'CHILDREN'
}; // 标识 是父容器还是子容器

/**
 * .
 * <p>
 * AJAX请求<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param url请求地址,PARAMS参数,successFn调用成功,
 *            exceptionFn调用异常,FAILFN调用失败,ASYNC是否异步
 * @时间 2012-12-07
 */
requestAjaxJson = function(url, params, successFn, exceptionFn,
		failFn, async) {
	Ext.Ajax.request({
		url : url,
		async : Ext.isEmpty(async) ? true : false,// 默认是异步
		jsonData : params,
		success : function(response) {
			var result = Ext.decode(response.responseText);
			if (result.success) {
				successFn(result);
			} else {
				exceptionFn(result);
			}
		},
		exception : function(response) {
			exceptionFn(Ext.decode(response.responseText));
		}
			// ,failure:function(response){//平台已拦截
			// var result = Ext.decode(response.responseText);
			// failFn(result);
			// }
		});
};
/**
 * .
 * <p>
 * 填值方法<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param form[]需要加载数据的form,formRecord[]需要加载的数据model
 *            grid[]需要加载数据的grid,girdData[]需要加载的数据data
 * @时间 2012-12-07
 */
formReset = function(form, formRecord, grid, girdData) {
	if (!Ext.isEmpty(form) && !Ext.isEmpty(formRecord)) {
		Ext.Array.each(form, function(name, index, countriesItSelf) {
					form[index].loadRecord(formRecord[index]);
				});
	}
	if (!Ext.isEmpty(grid)) {
		Ext.Array.each(grid, function(name, index, countriesItSelf) {
					if (Ext.isEmpty(girdData)) {
						grid[index].store.loadData([]);
					} else {
						grid[index].store.loadPage(1);
					}
				});
	}
};
/**
 * .
 * <p>
 * form表单所有元素 设置 readOnly值<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param form需要设值的表单，flag表单readOnly值
 * @时间 2012-12-13
 */
formSetReadOnly = function(flag, form) {
	var arr = form.items.items;
	if (!Ext.isEmpty(arr)) {
		for (var i = 0; i < arr.length; i++) {
			arr[i].setReadOnly(flag);
		}
	}
};
formFieldSetReadOnly = function(flag, form) {
	var arr = form.query('field');
	if (!Ext.isEmpty(arr)) {
		for (var i = 0; i < arr.length; i++) {
			arr[i].setReadOnly(flag);
		}
	}
};
/**
 * .
 * <p>
 * 消息提示框 ，无国际化<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param message,fun
 * @时间 2012-12-13
 */
showInfoMsg = function(message, fun) {
	var len = message.length;
	Ext.Msg.show({
				title : '提醒您:',
				width : 110 + len * 15,
				msg : '<div id="message">' + message + '</div>',
				buttons : Ext.Msg.OK,
				icon : Ext.MessageBox.INFO,
				callback : function(e) {
					if (!Ext.isEmpty(fun)) {
						if (e == 'ok') {
							fun();
						}
					}
				}
			});

	// setTimeout(function(){
	// Ext.Msg.hide();
	// }, 3000);
};

/**
 * .
 * <p>
 * 查看状态下 只有 取消按钮可用 [添加网点,取消]按钮分别占 0和1<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param message,fun
 * @时间 2012-12-13
 */
operateWinBtn = function(win, viewState, operateType) {
	// 查看状态下 只有 取消按钮可用 [添加网点,取消]按钮分别占 0和1
	if (viewState.view === viewState) {
		var btnArr = win.query('button');
		for (var i = 0; i < btnArr.length; i++) {
			btnArr[i].setDisabled(i != 2);
		}
	} else if (!Ext.isEmpty(operateType)
			&& operateType.save === operateType) {
		var btnArr = win.query('button');
		for (var i = 0; i < btnArr.length; i++) {
			btnArr[i].setDisabled(i > 2);
		}
	}
};
/**
 * .
 * <p>
 * 覆盖Ext.form.RadioGroup的setValue方法<br/> item.getRawValue全为false
 * <p>
 * 
 * @author 张斌
 * @时间 2012-3-25
 */
Ext.override(Ext.form.RadioGroup, {
			setValue : function(v) {
				if (this.rendered)
					this.items.each(function(item) {
								item.setValue(item.inputValue == v);
							});
				else {
					for (var k = 0; k < this.items.items.length; k++) {
						this.items.items[k]
								.setValue(this.items.items[k].inputValue == v);
					}
				}
			}
		});

/**
 * .
 * <p>
 * 公共方法，通过storeId和model创建STORE<br/>
 * <p>
 * 
 * @param storeId
 * @param model
 *            store所用到的model名
 * @param fields
 *            store所用到的fields
 * @returns store 返回创建的store
 * @author 张斌
 * @时间 2012-8-31
 */
getStore = function(storeId, model, fields, data) {
	var store = null;
	if (!Ext.isEmpty(storeId)) {
		store = Ext.data.StoreManager.lookup(storeId);
	}
	if (Ext.isEmpty(data)) {
		data = [];
	}
	if (!Ext.isEmpty(model)) {
		if (Ext.isEmpty(store)) {
			store = Ext.create('Ext.data.Store', {
						storeId : storeId,
						model : model,
						data : data
					});
		}
	}
	if (!Ext.isEmpty(fields)) {
		if (Ext.isEmpty(store)) {
			store = Ext.create('Ext.data.Store', {
						storeId : storeId,
						fields : fields,
						data : data
					});
		}
	}
	return store;
};

var ajaxRequest= function (url, params, successFn, failFn) {
	var exptoken2 = params.exptoken;
	Ext.Ajax.request({
				url : url+'?exptoken='+encodetoke,
				jsonData : params,
				success : function(response) {
					var result = Ext.decode(response.responseText);
					if (result.success) {
						successFn(result);
					} else {
						failFn(result);
					}
				},
				failure : function(response) {
					var result = Ext.decode(response.responseText);
					failFn(result);
				},
				exception : function(response) {
					var result = Ext.decode(response.responseText);
					failFn(result);
				}
			});
};

/**
 * 设置元素为readOnly<br/>
 * @param readOnlyIdList
 *            设置为readOnly的元素ID数组
 * @author 张斌
 * @时间 2012-3-15
 */
setReadOnly = function(readOnlyIdList) {
	for (var i = 0; i < readOnlyIdList.length; i++) {
		Ext.getCmp(readOnlyIdList[i]).setReadOnly(true);
		Ext.getCmp(readOnlyIdList[i]).addCls('readonly');
	}
};

/**
 * 设置元素为隐藏并且销毁，使其不在校验<br/>
 * @param hiddenIdList
 *            设置为readOnly的元素ID数组
 * @author 张斌
 * @时间 2012-3-15
 */
setHiddenAndDestroy = function(hiddenIdList) {
	for (var i = 0; i < hiddenIdList.length; i++) {
		Ext.getCmp(hiddenIdList[i]).hide();
		Ext.getCmp(hiddenIdList[i]).destroy();
	}
};
/**
 * 设置元素为隐藏<br/>
 * @param hiddenIdList
 *            设置为readOnly的元素ID数组
 * @author 张斌
 * @时间 2012-3-15
 */
setHidden = function(hiddenIdList) {
	for (var i = 0; i < hiddenIdList.length; i++) {
		Ext.getCmp(hiddenIdList[i]).hide();
	}
};
/**
 * 设置元素为销毁<br/>
 * @param destoryIdList
 *            设置为destory的元素ID数组
 * @author 张斌
 * @时间 2012-3-21
 */
setDestroy = function(destoryIdList) {
	for (var i = 0; i < destoryIdList.length; i++) {
		Ext.getCmp(destoryIdList[i]).destroy();
	}
};
/**
 * 设置元素为不可用<br/>
 * @param disabledIdList
 *            设置为Disabled的元素ID数组
 * @author 张斌
 * @时间 2012-3-21
 */
setDisabled = function(disabledIdList) {
	for (var i = 0; i < disabledIdList.length; i++) {
		Ext.getCmp(disabledIdList[i]).setDisabled(true);
	}
};
/**
 * 清楚事件<br/>
 * @param clearIdList
 *            设置为清楚时间的元素ID数组
 * @author 张斌
 * @时间 2012-3-22
 */
clearListeners = function(clearIdList) {
	for (var i = 0; i < clearIdList.length; i++) {
		Ext.getCmp(clearIdList[i]).clearListeners();
	}
};

/**
 * 数组中是否有空值<br/>
 * @param array
 *            数组
 * @author 张斌
 * @时间 2012-3-24
 */
isHaveEmpty = function(array) {
	var boolen = false;
	for (var i = 0; i < array.length; i++) {
		if (Ext.isEmpty(array[i])) {
			boolen = true;
			return boolen;
		}
	}
	return boolen;
};
/**
 * JS日期的format方法<br/>
 * @param format
 *            日期格式
 * @author 张斌
 * @时间 2012-3-23
 */
Date.prototype.format = function(format) {
	if (Ext.isEmpty(this) || this.getTime() == 0
			|| this.toString().indexOf('GMT') == -1) {
		return null;
	}
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
		// millisecond
	};

	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4
						- RegExp.$1.length));
	};

	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1
							? o[k]
							: ("00" + o[k]).substr(("" + o[k]).length));
		}
	};
	return format;
};

/**
 * 根据传的参数生成查询条件<br/>
 * @param modelList
 *            要转换的Modellist
 * @returns dataList
 * @author 张斌
 * @时间 2012-4-16
 */
changeModelListToDataList = function(modelList) {
	var dataList = new Array();
	for (var i = 0; i < modelList.length; i++) {
		dataList.push(modelList[i].data);
	}
	return dataList;
};
/**
 * 数据的将全局变量复制出来<br/>
 * @param modelList
 *            要转换的Modellist
 * @returns dataList
 * @author 张斌
 * @时间 2012-4-16
 */
copyModelListToDataList = function(modelList) {
	var dataList = new Array();
	for (var i = 0; i < modelList.length; i++) {
		dataList.push(modelList[i]);
	}
	return dataList;
};
/**
 * @功能：为js中的STRING加上trim方法
 * @作者： 张斌
 * @创建时间：2012-02-20
 */
String.prototype.trim = function() {
	// 用正则表达式将前后空格
	// 用空字符串替代。
	return this.replace(/(^\s*)|(\s*$)/g, "");
};

// 警告
showWoringMessage = function(message, fun) {
	var len = message.length;
	Ext.Msg.show({
				title : '提醒您:',
				msg : message,
				// cls:'mesbox',
				width : 110 + len * 15,
				msg : '<div id="message">' + message + '</div>',
				buttons : Ext.Msg.OK,
				icon : Ext.MessageBox.WARNING,
				callback : function(e) {
					if (!Ext.isEmpty(fun)) {
						if (e == 'ok') {
							fun();
						}
					}
				}
			});
};
// 是和否选择
showQuestionMes = function(message, fun) {
	var len = message.length;
	Ext.Msg.show({
				title : '提醒您:',
				width : 110 + len * 15,
				msg : '<div id="message">' + message + '</div>',
				buttons : Ext.Msg.YESNO,
				icon : Ext.MessageBox.QUESTION,
				callback : function(e) {
					if (!Ext.isEmpty(fun)) {
						fun(e);
					}
				}
			});
};
// 信息
showInfoMes = function(message, fun) {
	var len = message.length;
	Ext.Msg.show({
				title : '提醒您:',
				width : 110 + len * 15,
				msg : '<div id="message">' + message + '</div>',
				buttons : Ext.Msg.OK,
				icon : Ext.MessageBox.INFO,
				callback : function(e) {
					if (!Ext.isEmpty(fun)) {
						if (e == 'ok') {
							fun();
						}
					}
				}
			});

	// setTimeout(function(){
	// Ext.Msg.hide();
	// }, 3000);
};
// 错误
showErrorMes = function(message, fun) {
	var len = message.length;
	Ext.Msg.show({
				title : '提醒您:',
				width : 110 + len * 15,
				msg : '<div id="message">' + message + '</div>',
				buttons : Ext.Msg.OK,
				icon : Ext.MessageBox.ERROR,
				callback : function(e) {
					if (!Ext.isEmpty(fun)) {
						if (e == 'ok') {
							fun();
						}
					}
				}
			});
};
// ADD -ALL
addAll = function(list, all) {
	var newlist = new Array();
	newlist.push(all);
	for (var i = 0; i < list.length; i++) {
		newlist.push(list[i]);
	}
	return newlist;
};

// changeCodeToName(LIST)
changeCodeToName = function(list, code) {
	var name = '';
	for (var i = 0; i < list.length; i++) {
		if (list[i].valueCode == code) {
			name = list[i].valueName;
		}
	}
	return name;
};
// changeCodeToName(store)
changeCodeToNameStore = function(store, code) {
	var name = '';
	if (!Ext.isEmpty(store)) {
		store.each(function(record) {
					if (record.get('valueCode') == code) {
						name = record.get('valueName');
					}
				});
	}
	return name;
};
/**
 * .
 * <p>
 * AJAX请求<br/>
 * <p>
 * 
 * @author LIXUEXING
 * @param url请求地址,PARAMS参数,successFn调用成功,
 *            exceptionFn调用异常,FAILFN调用失败,ASYNC是否异步
 * @时间 2012-12-07
 */
requestAjaxJson = function(url, params, successFn, exceptionFn,
		failFn, async) {

	Ext.Ajax.request({
		url : url,
		async : Ext.isEmpty(async) ? true : false,// 默认是异步
		jsonData : params,
		success : function(response) {
			var result = Ext.decode(response.responseText);
			if (result.success) {
				successFn(result);
			} else {
				exceptionFn(result);
			}
		},
		exception : function(response) {
			exceptionFn(Ext.decode(response.responseText));
		}
			// ,failure:function(response){//平台已拦截
			// var result = Ext.decode(response.responseText);
			// failFn(result);
			// }
		});
};

/*
 * 转换long类型为日期
 */
changeLongToDate = function(value) {
	if (value != null) {
		var date = new Date(value);
		return date;
	} else {
		return null;
	}
};