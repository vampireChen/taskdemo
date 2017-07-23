<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>订阅规则管理</title>
  <%@include file="common/commonTop.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">
  <!-- 顶部导航 -->
  <%@include file="common/header.jsp" %>
  <!-- 左侧菜单 -->	
  <%@include file="common/left.jsp" %>
  <!-- 内容信息 -->
  <div class="content-wrapper" style="min-height: 910px">
    <!-- Main content -->
    <section class="content">
       <div class="row">
      	<div class="col-xs-12">
      		<div class="box">
      			<div class="box-head">
      				<button style="margin:10px" class="btn btn-success" onclick="addChanRule()">添加</button>
      			</div>
      			<form class="form-inline" id="searchForm" role="form">
      			 	<div class="form-group">
				   		 <div class="input-group" style="margin:15px 10px 0px 15px ">
					     	 <label class="input-group-addon">规则名称</label>
					     	 <input class="form-control" id="channelName" type="text">
				   		 </div>
				  	  </div>
				  	  <div class="form-group">
				   		 <div class="input-group" style="margin:15px 10px 0px 15px ">
					     	 <label class="input-group-addon">操作类型</label>
					     	 <input class="form-control" id="trackingsType" type="text">
				   		 </div>
				  	  </div>
				  	  <div class="form-group">
		                 <div class="col-sm-3">
		                   <select class="form-control" id="bizType"  style="margin:15px 10px 0px 15px ">
		                   		<option value=" ">--请选择推送类型--</option>
								<option value="PUSH">PUSH</option>
								<option value="QUERY">QUERY</option>
		                   </select>
		                 </div>
              			</div>
				  	  <div class="form-group">
				   		 <div class="input-group" style="margin:15px 10px 0px 15px ">
					     	 <button class="btn btn-success" type="button" onclick="seachUser()"><i class="fa fa-fw fa-search-plus"></i>搜索</button>
				   		 </div>
				  	  </div>
   					</form>
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>规则名称</th>
			                  <th>推送类型</th>
			                  <th>操作类型</th>
			                  <th>操作</th>
			                </tr>
		                </thead>
      				</table>
      			</div>
      		</div>
      	</div> 
      </div>
    </section>
  </div>
  <%@include file="common/footer.jsp" %>
</div>
<div class="modal" id="addChanRuleModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加规则管理</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="chanRuleForm">
         	 <input type="hidden" value="" id="ruleId" name="channelRuleEntity.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="channelName" class="col-sm-2 control-label">规则名称</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="channelName" name="channelRuleEntity.channelName" placeholder="规则名称">
                 </div>
               </div>
               <div class="form-group">
                 <label for="bizType" class="col-sm-2 control-label">推送类型</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="bizType" name="channelRuleEntity.bizType" placeholder="推送类型">
                 </div>
               </div>
<!--                <div class="form-group">
                 <label class="col-sm-2 control-label">推送类型</label>

                 <div class="col-sm-3">
                   <select class="form-control" id="jobStatus" name="channelRuleEntity.jobStatus">
                   		<option value="0">禁用</option>
                   		<option value="1">正常</option>
                   </select>
                 </div>
               </div> -->
              <div class="form-group">
                 <label for="trackingsType" class="col-sm-2 control-label">操作类型</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="trackingsType" name="channelRuleEntity.trackingsType" placeholder="操作类型">
                 </div>
               </div>
<!--                <div class="form-group">
                 <label for="jobUrl" class="col-sm-2 control-label">路径</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobUrl" name="channelRuleEntity.jobUrl" placeholder="定时访问路径">
                 </div>
               </div>
               <div class="form-group">
                 <label for="jobMemo" class="col-sm-2 control-label">描述</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobMemo" name="channelRuleEntity.memo" placeholder="任务描述">
                 </div>
               </div> -->
             </div>
           </form>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default pull-left" onclick="closeModal(this)">关闭</button>
         <button type="button" class="btn btn-primary" onclick="saveChannel()">保存</button>
       </div>
     </div>
   </div>
 </div>
<!--  <div id="myLinkToConfirm"></div> -->
<!-- ./wrapper -->
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	//页面初始化
	$(function () {
		channelRuleTabel = $("#example1").DataTable({
			"searching":false,//是否显示搜索框
			"ordering":false,//是否显示排序
			"pagingType":"full_numbers",//分页样式,一共四种,可看源码
			"lengthChange":false,//是否允许改变每页显示条数
			"bServerSide": true, //是否服务器加载数据
			"columns": [//列信息
			            { "data": "channelName","width":"22%" },
			            { "data": "bizType","width":"22%" },
			            { "data": "trackingsType","width":"22%" },
			            { "data": "" }
		            ],
		    "sAjaxSource":basePath+"wqs/queryChannelRule.action",//获取数据的服务器请求地址
		    "fnServerData":function(sSource, aoData, fnCallback){//服务器传递参数
		    	var channelName = $("#searchForm #channelName").val();
		    	var bizType = $("#searchForm #bizType").val();
		    	var trackingsType = $("#searchForm #trackingsType").val();
		    	$.ajax({    
		            "contentType": "application/json",    
		            "url": sSource,     
		            "dataType": "json",    
		            "data": { aoData: JSON.stringify(aoData),channelName:channelName,bizType:bizType,trackingsType:trackingsType}, 
		            "success": function(resp) { 
		    	    	            fnCallback(resp.result);   
		    	    	        }    
	  	    	}); 
		    },
	      	"columnDefs":[//返回数据进行转换
/*    	  			{
   	  				 "targets":2,
   	  				 "data":"id",
   	  				 "render":function( data, type, full, meta){
   	  					var result ;
   	  					if(full.jobStatus==0){
   	  						result="禁用";
   	  					}else if(full.jobStatus==1){
   	  						result="正常";
   	  					}
   	  				 	return result;
   	  				 }
   	  			}, */
   	  			//添加操作列的显示信息
   	  			{
   	  				 "targets":3,
   	  				 "render":function( data, type, full, meta){
   	  				 	var btnHtml = '<button class="btn btn-success btn-sm" data_id="'+full.id+'" onclick="editChannelRule(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
   	  				 	btnHtml += '<button class="btn btn-danger btn-sm" data_id="'+full.id+'" onclick="delChannelRule(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
   	  				 	return btnHtml;
   	  				 }
   	  			}
   	  			]
	    });
	});
	/**
	*查询调用
	**/
	function seachUser(){
		channelRuleTabel.ajax.reload();
	}
	function addChanRule(){
		$("#addChanRuleModal .modal-title").html("添加规则管理");
		$("#addChanRuleModal").show();
	}
	function editChannelRule(ele){
		$("#addChanRuleModal .modal-title").html("修改规则管理");
		var ruleId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/querychannelRuleById.action",
    		type:"post",
    		data:{id:ruleId},
    		success:function(data){
    			var channelRule = data.channelRuleEntity;
    			$("#chanRuleForm #ruleId").val(channelRule.id);
    			$("#chanRuleForm #channelName").val(channelRule.channelName);
    			$("#chanRuleForm #bizType").val(channelRule.bizType);
    			$("#chanRuleForm #trackingsType").val(channelRule.trackingsType);
    			/* $("#chanRuleForm #jobUrl").val(channelRule.jobUrl);
    			$("#chanRuleForm #jobMemo").val(channelRule.memo); */
    			//alert(JSON.stringify(data.channelRuleEntity));
    			$("#addChanRuleModal").show();
    		},
    		error:function(){
    			alert("删除失败！请联系管理员");
    		}
    	});
	}
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#chanRuleForm")[0].reset();
		$("#chanRuleForm #ruleId").val("");
	}
	
	function delChannelRule(ele){
	
		var ruleId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该规则管理!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/delChannelRule.action",
		    		type:"post",
		    		data:{id:ruleId},
		    		success:function(){
		    			alert("删除成功");
		    			channelRuleTabel.ajax.reload();
		    		},
		    		error:function(){
		    			alert("删除失败！请联系管理员");
		    		}
		    	});
		        
		    },
		    cancel: function(){
		       
		    }
		});
	
	}
	function saveChannel(){
		var ruleId = $("#chanRuleForm #ruleId").val();
		var url;
		if(ruleId){
			url = "wqs/updateChannelRule.action";
		}else{
			url = "wqs/addChannelRule.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#chanRuleForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addChanRuleModal").hide();
				$("#chanRuleForm")[0].reset();
				channelRuleTabel.ajax.reload();
				 if(ruleId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 $("#chanRuleForm #ruleId").val("");
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
</script>
</html>