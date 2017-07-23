Ext.define('Wqs.management.channelrule.ChannelRuleEntity',{
	extend: 'Ext.data.Model',
	fields : [{
		name:'id',
		type:'string'
	},{
		name:'channelName',
		type:'string'
	},{
		name:'bizType',
		type:'string'
	},{
		name:'trackingsType',
		type:'string'
	},{
		name:'createTime',
		type:'date',
		defaultValue : null
	},{
		name:'modifyTime',
		type:'date',
		defaultValue : null
	}]
});