Ext.onReady(function () {
  Ext.define('Wqs.management.channelrule.ChannelRuleEntity', {
    extend: 'Ext.data.Model',
    fields: [
      {name: 'id', type: 'string'},
      {name: 'channelName', type: 'string'},
      {name: 'bizType',  type: 'string'},
      {name: 'trackingsType', type: 'string'}
    ]
  });
 
  Ext.define('Wqs.store.Channles', {
    extend  : 'Ext.data.Store',
    storeId	: 'storeId',
    model   : 'Wqs.management.channelrule.ChannelRuleEntity',
    fields  : ['id', 'channelName', 'bizType','trackingsType'],
    proxy	: {
        type	: 'ajax',
        url		: '/wqs-management-web/wqs/queryChannelRule.action',
        reader	: {
            type	: 'json',
            root	: 'channels'
        }
    },
    autoLoad: true
  });
 
  Ext.define('Wqs.view.ChannlesList', {
    extend	: 'Ext.grid.Panel',
    alias	: 'widget.channleslist',
    width: 750,
    height: 900,
    autoHeight:true, 
    autoWidth:true, 
    title	: '轨迹列表',
    //store	: 'Books',
    store: 'Channles',
    initComponent: function () {
      this.tbar = [{
        text    : '新增',
        action  : 'add',
        iconCls : 'channle-add'
      },
      {
    	  //fieldLabel : '渠道名称',
    	  id : 'channelNameId',
    	  emptyText : '渠道名称',
    	  xtype : 'textfield',
    	  width : 100,
      },
      {
    	  id : 'bizTypeId',
    	  emptyText : '类型',
    	  xtype : 'textfield',
    	  width : 100,
      },
      {
    	  //fieldLabel : '轨迹类型',
    	  id : 'trackingsTypeId',
    	  emptyText : '轨迹类型',
    	  xtype : 'textfield',
    	  width : 100,
      },
      {
          text    : '查询',
          action  : 'search',
          iconCls : 'channle-search'
        }];
      this.columns = [
        { header: '渠道名称', dataIndex: 'channelName', flex: 1 },
        { header: '类型', dataIndex: 'bizType' },
        { header: '轨迹类型', dataIndex: 'trackingsType' , width: 60 },
        { header: '删除', width: 50,
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
                      var grid = Ext.ComponentQuery.query('channleslist')[0];
                      console.log('grid' + grid);
                      if (grid) {
                        var sm = grid.getSelectionModel();
                        var rs = sm.getSelection();
                        if (!rs.length) {
                          Ext.Msg.alert('Info', '没有记录被选中');
                          return;
                        }
                        Ext.Msg.confirm('Remove Book', 
                          '你确定要删除吗?', 
                          function (button) {
                            if (button == 'yes') {
                              //grid.store.remove(rs[0]);
                            	//var channle = rs[0].getData();
                            	var param = {'id':rs[0].get('id')};
                            	console.log(param);
                            	
                            	Ext.Ajax.request({
                            	    url		: '/wqs-management-web/wqs/delChannelRule.action',
                            	    method  : 'POST',
                            	    //jsonData: channle,
                            	    params:param,
                            	    success: function(response){
                            	    	var grid = Ext.ComponentQuery.query('channleslist')[0];
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
 
    Ext.define('Wqs.view.ChannlesForm', {
      extend  : 'Ext.window.Window',
      alias   : 'widget.channlesform',
      title   : '增加渠道',
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
          name  : 'channelName',
          fieldLabel: '渠道名称'
        },{
          name: 'bizType',
          fieldLabel: '类型'
        },{
          name: 'trackingsType',
          fieldLabel: '轨迹类型'
        }]
      }],
      buttons: [{
        text: '确定',
        action: 'add'
      },{
        text    : '重置',
        handler : function () { 
          this.up('window').down('form').getForm().reset(); 
        }
      },{
        text   : '取消',
        handler: function () { 
          this.up('window').close();
        }
      }]
    });
 
  Ext.define('Wqs.controller.Channles', {
    extend  : 'Ext.app.Controller',
    //stores  : ['Books'],
    stores : ['Channles'],
    //views   : ['BooksList', 'BooksForm'],
    views   : ['ChannlesList', 'ChannlesForm'],
    refs    : [{
      ref   : 'formWindow',
      xtype : 'channlesform',
      selector: 'channlesform',
      autoCreate: true
    }],
    init: function () {
      this.control({
        'channleslist > toolbar > button[action=add]': {
          click: this.showAddForm
        },
        'channleslist > toolbar > button[action=search]': {
            click: this.doSearchChannle
          },
        'channleslist': {
          itemdblclick: this.onRowdblclick
        },
        'channlesform button[action=add]': {
          click: this.doAddChannle
        }
      });
    },
    onRowdblclick: function(me, record, item, index) {
      var win = this.getFormWindow();
      win.setTitle('编辑渠道规则');
      win.setAction('edit');
      console.log(index);
      //win.setRecordIndex(index);
      //把渠道规则ID赋值给win的recordIndex(目的是为了在做更新操作时，方便把ID传给后台，根据ID进行更新)
      win.setRecordIndex(record.internalId);
      console.log('win' + win);
      console.log(record);
      win.down('form').getForm().setValues(record.data);
      win.show();
    },
    showAddForm: function () {
      var win = this.getFormWindow();
      win.setTitle('增加渠道规则');
      win.setAction('add');
      win.down('form').getForm().reset();
      win.show();
    },
    doSearchChannle: function () {
    	var url = '/wqs-management-web/wqs/searchChannleRule.action';
    	//var grid = Ext.ComponentQuery.query('channleslist')[0];
    	 var store = this.getChannlesStore();
    	var channelNameValue = Ext.getCmp("channelNameId").getValue();
    	var bizTypeValue = Ext.getCmp("bizTypeId").getValue();
    	var trackingsValue = Ext.getCmp("trackingsTypeId").getValue();
    	console.log(channelNameValue);
    	console.log(bizTypeValue);
    	console.log(trackingsValue);
    	var params = {'channelRuleEntity.channelName':channelNameValue,'channelRuleEntity.bizType':bizTypeValue,'channelRuleEntity.trackingsType':trackingsValue};
    	//var params = {'entity.channelName':channelNameValue,'entity.bizType':bizTypeValue,'entity.trackingsType':trackingsValue};
    	console.log(params);
    	Ext.Ajax.request({
      		url		: url,
      		dataType:'json',
        	//method  : 'POST',
      		async: false, //设置为同步
      		params: params,	
        	success: function(response){
        	    	//store.load();
        			var result = Ext.decode(response.responseText);
        			console.log(result);
        			store.removeAll();
        			store.loadData(result.chanList);
        		}
        	});
    },
    doAddChannle: function () {
      var win = this.getFormWindow();
      //var store = this.getBooksStore();
      var store = this.getChannlesStore();
      var values = win.down('form').getValues();
      //获取双击时赋给recordIndex的渠道规则ID
      var index =  win.getRecordIndex();
      console.log(index);
      var obj = eval(values);
      console.log(obj.channelName);
      //var params = {'channelRuleEntity':{'channelName':obj.channelName,'bizType':obj.bizType,'trackingsType':obj.trackingsType}};
      var params = {'channelRuleEntity.channelName':obj.channelName,'channelRuleEntity.bizType':obj.bizType,'channelRuleEntity.trackingsType':obj.trackingsType,
    		  'channelRuleEntity.id':index};
      //var params = {channelName:obj.channelName};
      console.log(params);
      console.log(values);
      var action = win.getAction();
   //   var book = Ext.create('Wqs.management.channelrule.ChannelRuleEntity', values);
      var url = '';
      if(action == 'edit') {
    	  url = '/wqs-management-web/wqs/updateChannelRule.action';
      }
      else {
    	  url = '/wqs-management-web/wqs/addChannelRule.action';
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
    }
  });
 
  Ext.application({
    name  : 'Wqs',
    controllers: ['Channles'],
      launch: function () {
        Ext.widget('channleslist', {
          width : 500,
          height: 300,
          renderTo: Ext.getBody()
        });
      }
    }
  );
});