Ext.onReady(function () {
  Ext.define('Wqs.management.scheduleJob.scheduleJobEntity', {
    extend: 'Ext.data.Model',
    fields: [
      {name: 'id', type: 'string'},
      {name: 'jobName', type: 'string'},
      {name: 'jobGroup',  type: 'string'},
      {name: 'jobStatus', type: 'string'},
      {name: 'cronExpression', type: 'string'},
      {name: 'memo', type: 'string'},
      {name: 'jobUrl', type: 'string'}
    ]
  });
 
  Ext.define('Wqs.store.ScheduleJob', {
    extend  : 'Ext.data.Store',
    storeId	: 'storeId',
    model   : 'Wqs.management.scheduleJob.scheduleJobEntity',
    fields  : ['id', 'jobName', 'jobGroup','jobStatus','cronExpression','memo','jobUrl'],
    proxy	: {
        type	: 'ajax',
        url		: '/wqs-management-web/wqs/queryScheduleJob.action',
        reader	: {
            type	: 'json',
//            root	: 'channels'
            root	: 'scheduleJobs'	
        }
    },
    autoLoad: true
  });
 
  Ext.define('Wqs.view.ScheduleJobList', {
    extend	: 'Ext.grid.Panel',
    alias	: 'widget.ScheduleJobList',
    width: 750,
    height: 900,
    autoHeight:true, 
    autoWidth:true, 
    title	: 'JobList',//定时任务列表
    //store	: 'Books',
    store: 'ScheduleJob',
    initComponent: function () {
      this.tbar = [{
	        text    : 'Add',//新增
	        action  : 'add',
	        iconCls : 'channle-add'
	      },
	      {
	    	  //fieldLabel : '任务名称',
	    	  id : 'jobNameId',
	    	  emptyText : 'JobName',//任务名称
	    	  xtype : 'textfield',
	    	  width : 100,
	      },
	      {
	    	  id : 'jobGroupId',
	    	  emptyText : 'JobGroup',//任务组
	    	  xtype : 'textfield',
	    	  width : 100,
	      },
	      {
	    	  //fieldLabel : ' 任务状态    0禁用 1启用 2删除',
	    	  id : 'jobStatusId',
	    	  emptyText : 'JobStatus',//任务状态
	    	  xtype : 'textfield',
	    	  width : 100,
	      },
	      {
	          text    : 'search',//
	          action  : 'search',
	          iconCls : 'channle-search'
	      },
	      {
	          text    : 'pause',//暂停
	          action  : 'stop',
	          iconCls : 'channle-search'
	      },
	      {
	          text    : 'recover',//恢复
	          action  : 'recover',
	          iconCls : 'channle-search'
	      },
	      {
	          text    : 'startNow',//立即运行
	          action  : 'run',
	          iconCls : 'channle-search'
	      }
     ];
      this.columns = [
        { header: 'jobName', dataIndex: 'jobName', flex: 1 },
        { header: 'jobGroup', dataIndex: 'jobGroup' },
        { header: 'jobStatus', dataIndex: 'jobStatus' , width: 60 },
        { header: 'cronExpression', dataIndex: 'cronExpression' , width: 60 },
        { header: 'jobUrl', dataIndex: 'jobUrl' , width: 100 },
        { header: 'memo', dataIndex: 'memo' , width: 60 },
        { header: 'delete', width: 50,
          renderer: function (v, m, r) {
            var id = Ext.id();
            Ext.defer(function () {
              Ext.widget('image', {
                renderTo: id,
                name: 'delete',
                src : '../wqs/images/channle_delete.png',
                listeners : {
                  afterrender: function (me) { 
                    me.getEl().on('click', function() {
                      var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
                      console.log('grid' + grid);
                      if (grid) {
                        var sm = grid.getSelectionModel();
                        var rs = sm.getSelection();
                        if (!rs.length) {
                          Ext.Msg.alert('Info', 'no select!');
                          return;
                        }
                        Ext.Msg.confirm('Remove Book', 
                          'Are you sure delete it?', 
                          function (button) {
                            if (button == 'yes') {
                            	var param = {'id':rs[0].get('id')};
                            	console.log(param);
                            	
                            	Ext.Ajax.request({
                            	    url		: '/wqs-management-web/wqs/deleteScheduleJob.action',
                            	    method  : 'POST',
                            	    params:param,
                            	    success: function(response){
                            	    	var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
                            	        grid.getStore().load();
                            	    }
                            	});
                            }
                        });
                      }
                    });
                  }
                }
              });
            }, 50);
            return Ext.String.format('<div id="{0}"></div>', id);
          }
        }
      ];
      this.callParent(arguments);
    }
  });
 
    Ext.define('Wqs.view.ScheduleJobForm', {
      extend  : 'Ext.window.Window',
      alias   : 'widget.ScheduleJobform',
      title   : 'addJob',//增加任务
      width   : 350,
      layout  : 'fit',
      resizable: false,
      closeAction: 'hide',
      modal   : true,
      config  : {
        recordIndex : 0,
        action : ''
      },
      items   : [{
        xtype : 'form',
        layout: 'anchor',
        bodyStyle: {
          background: 'none',
          padding: '10px',
          border: '0'
        },
        defaults: {
          xtype : 'textfield',
          anchor: '100%'
        },
        items : [{
          name  : 'jobName',
          fieldLabel: 'jobName'
        },{
          name: 'jobGroup',
          fieldLabel: 'jobGroup'
        },{
          name: 'jobStatus',
          fieldLabel: 'jobStatus'
        },{
          name: 'cronExpression',
          fieldLabel: 'cronExpression'
        },{
          name: 'jobUrl',
          fieldLabel: 'jobUrl'
        },{
          name: 'memo',
          fieldLabel: 'memo'
        }]
      }],
      buttons: [{
        text: 'add',
        action: 'add'
      },{
        text    : 'reset',
        handler : function () { 
          this.up('window').down('form').getForm().reset(); 
        }
      },{
        text   : 'cancle',
        handler: function () { 
          this.up('window').close();
        }
      }]
    });
 
  Ext.define('Wqs.controller.ScheduleJob', {
    extend  : 'Ext.app.Controller',
    stores : ['ScheduleJob'],
    views   : ['ScheduleJobList', 'ScheduleJobForm'],
    refs    : [{
      ref   : 'formWindow',
      xtype : 'ScheduleJobform',
      selector: 'ScheduleJobform',
      autoCreate: true
    }],
    init: function () {
      this.control({
        'ScheduleJobList > toolbar > button[action=add]': {click: this.showAddForm },
        'ScheduleJobList > toolbar > button[action=search]': {click: this.doSearchChannle},
        'ScheduleJobList > toolbar > button[action=stop]': {click: this.doStopChannle},
        'ScheduleJobList > toolbar > button[action=recover]': {click: this.doRecoverChannle},
        'ScheduleJobList > toolbar > button[action=run]': {click: this.doRunChannle},
        'ScheduleJobList': {
          itemdblclick: this.onRowdblclick
        },
        'ScheduleJobform button[action=add]': {
          click: this.doAddChannle
        }
      });
    },
    onRowdblclick: function(me, record, item, index) {
      var win = this.getFormWindow();
      win.setTitle('editJob');
      win.setAction('edit');
      console.log(index);
      //win.setRecordIndex(index);
      //把渠道规则ID赋值给win的recordIndex(目的是为了在做更新操作时，方便把ID传给后台，根据ID进行更新)
      win.setRecordIndex(record.internalId);
      console.log(record);
      win.down('form').getForm().setValues(record.data);
      win.show();
    },
    showAddForm: function () {
      var win = this.getFormWindow();
      win.setTitle('addJob');
      win.setAction('add');
      win.down('form').getForm().reset();
      win.show();
    },
    doSearchChannle: function () {
    	var url = '/wqs-management-web/wqs/queryScheduleJob.action';
    	 var store = this.getScheduleJobStore();
    	var jobNameValue = Ext.getCmp("jobNameId").getValue();
    	var jobGroupValue = Ext.getCmp("jobGroupId").getValue();
    	var jobStatusValue = Ext.getCmp("jobStatusId").getValue();
    	var params = {
    			'scheduleJobEntity.jobName':jobNameValue,
    			'scheduleJobEntity.jobGroup':jobGroupValue,
    			'scheduleJobEntity.jobStatus':jobStatusValue
    		};
    	console.log("queryParams:"+params);
    	Ext.Ajax.request({
      		url		: url,
      		dataType:'json',
        	//method  : 'POST',
      		async: false, //设置为同步
      		params: params,	
        	success: function(response){
        			var result = Ext.decode(response.responseText);
        			console.log(result);
        			store.removeAll();
        			store.loadData(result.scheduleJobs);
        		}
        	});
    },
    doAddChannle: function () {
    	var win = this.getFormWindow();
    	var store = this.getScheduleJobStore();
    	var values = win.down('form').getValues();
    	//获取双击时赋给recordIndex的渠道规则ID
    	var index =  win.getRecordIndex();
    	var obj = eval(values);
    	var params = {
    			'scheduleJobEntity.jobName':obj.jobName,
    			'scheduleJobEntity.jobGroup':obj.jobGroup,
    			'scheduleJobEntity.jobStatus':obj.jobStatus,
    			'scheduleJobEntity.cronExpression':obj.cronExpression,
    			'scheduleJobEntity.memo':obj.memo,
    			'scheduleJobEntity.jobUrl':obj.jobUrl,
    			'scheduleJobEntity.id':index
    	};
    	//var params = {channelName:obj.channelName};
    	var action = win.getAction();
    	var url = '';
    	if(action == 'edit') {
    		url = '/wqs-management-web/wqs/updateScheduleJob.action';
    	}
    	else {
    		url = '/wqs-management-web/wqs/addScheduleJob.action';
    	}
    	Ext.Ajax.request({
    		url		: url,
    		dataType:'json',
    		//method  : 'POST',
    		async: false, //设置为同步
    		params: params,	
    		success: function(response){
    			store.load();
    		}
    	});
    	win.close();
    },
    doRunChannle: function (action) {
    	var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        console.log('grid' + grid);
        if (grid) {
        	var sm = grid.getSelectionModel();
        	var rs = sm.getSelection();
        	if (!rs.length) {
        		Ext.Msg.alert('Info', 'no select!');
        		return;
        	}
        	var url = '/wqs-management-web/wqs/executeScheduleJob.action';
        	Ext.Msg.confirm('Remove Book', 
        			'Are you sure run now?', 
        			function (button) {
        		if (button == 'yes') {
        			var param = {'id':rs[0].get('id')};
        			Ext.Ajax.request({
        				url		: url,
        				method  : 'POST',
        				params:param,
        				success: function(response){
        					var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        					grid.getStore().load();
        				}
        			});
        		}
        	});
        }
    },
    doStopChannle: function (action) {
    	var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        console.log('grid' + grid);
        if (grid) {
        	var sm = grid.getSelectionModel();
        	var rs = sm.getSelection();
        	if (!rs.length) {
        		Ext.Msg.alert('Info', 'no select!');
        		return;
        	}
        	var url ='/wqs-management-web/wqs/stopScheduleJob.action';
        	Ext.Msg.confirm('Remove Book', 
        			'Are you sure pause it?', 
        			function (button) {
        		if (button == 'yes') {
        			var param = {'id':rs[0].get('id')};
        			Ext.Ajax.request({
        				url		: url,
        				method  : 'POST',
        				params:param,
        				success: function(response){
        					var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        					grid.getStore().load();
        				}
        			});
        		}
        	});
        }
    },
    doRecoverChannle: function (action) {
    	var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        console.log('grid' + grid);
        if (grid) {
        	var sm = grid.getSelectionModel();
        	var rs = sm.getSelection();
        	if (!rs.length) {
        		Ext.Msg.alert('Info', 'no select!');
        		return;
        	}
        	var url = '/wqs-management-web/wqs/recoverScheduleJob.action';
        	Ext.Msg.confirm('Remove Book', 
        			'Are you sure recover it?', 
        			function (button) {
        		if (button == 'yes') {
        			var param = {'id':rs[0].get('id')};
        			Ext.Ajax.request({
        				url		: url,
        				method  : 'POST',
        				params:param,
        				success: function(response){
        					var grid = Ext.ComponentQuery.query('ScheduleJobList')[0];
        					grid.getStore().load();
        				}
        			});
        		}
        	});
        }
    }
    
  });
 
  Ext.application({
    name  : 'Wqs',
    controllers: ['ScheduleJob'],
      launch: function () {
        Ext.widget('ScheduleJobList', {
          width : 800,
          height: 400,
          renderTo: Ext.getBody()
        });
      }
    }
  );
});