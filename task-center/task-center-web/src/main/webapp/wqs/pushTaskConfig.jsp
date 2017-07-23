<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>应用应用配置管理</title>
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
      				<button style="margin:10px" class="btn btn-success" onclick="addScheduleJob()">添加</button>
      			</div>
      			<form class="form-inline" role="form" id="searchPushTaskForm">
      				<div class="input-group search-input">
				      <div class="input-group-addon">服务器IP</div>
				       <input class="form-control" type="text" id="ip" placeholder="服务器IP">
				      </div>
				      <div class="input-group search-input">
				      <div class="input-group-addon">服务器项目标识</div>
				      <select class="form-control" id="pushTaskName" onclick="addItems()">
				      	<option value="">全部</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_DEPARRIVAL">WQS_TO_DOP_PUSH_ECS_DEPARRIVAL</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_GOT">WQS_TO_DOP_PUSH_ECS_GOT</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_PADGOT">WQS_TO_DOP_PUSH_ECS_PADGOT</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_SEND">WQS_TO_DOP_PUSH_ECS_SEND</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_SIGNED">WQS_TO_DOP_PUSH_ECS_SIGNED</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_STAREACH">WQS_TO_DOP_PUSH_ECS_STAREACH</option>
				      	<option value="WQS_TO_DOP_PUSH_ECS_OTHER">WQS_TO_DOP_PUSH_ECS_OTHER</option>
				      	<option value="WQS_TO_DOP_PUSH_FOSS">WQS_TO_DOP_PUSH_FOSS</option>
				      	<option value="WQS_TO_DOP_PUSH_FOSS_GSS">WQS_TO_DOP_PUSH_FOSS_GSS</option>
				      	<option value="WQS_TO_DOP_PUSH_FEINIU">WQS_TO_DOP_PUSH_ECS_KDYB</option>
				      	<option value="WQS_TO_DOP_PUSH_ORDER">WQS_TO_DOP_PUSH_ORDER</option>
				      	<option value="WQS_TO_DOP_PUSH_JD">WQS_TO_DOP_PUSH_JD</option>
				      </select>
					 </div>
				  	<button style="margin:10px" type="button" class="btn btn-success" onclick="searchPushTaskConfig()"><i class="fa fa-fw fa-search"></i>搜索</button>
      			</form>
			  	
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>服务器IP</th>
			                  <th>服务器项目标识</th>
			                  <th>当前项目取模数</th>
			                  <th>当前应用取模值</th>
			                  <th>取值数量</th>
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
<div class="modal" id="addPushConfigModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加应用配置参数</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="pushConfigForm">
         	 <input type="hidden" value="" id="pushId" name="pushTaskConfig.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="taskIp" class="col-sm-3 control-label">服务器IP</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="taskIp" name="pushTaskConfig.taskIp" placeholder="服务器IP">
                 </div>
               </div>
               <span id="taskIpInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="taskName" class="col-sm-3 control-label">服务器项目标识</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="taskName" name="pushTaskConfig.taskName" placeholder="服务器上项目标识">
                 </div>
               </div>
               <span id="taskNameInfo" style="color:red;" ></span>
              <div class="form-group">
                 <label for="taskMod" class="col-sm-3 control-label">当前应用取模数</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="taskMod" name="pushTaskConfig.taskMod" placeholder="当前项目取模数(操作同一个表时，该值一致)">
                 </div>
               </div>
               <span id="taskModInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="taskModNo" class="col-sm-3 control-label">当前应用取模值</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="taskModNo" name="pushTaskConfig.taskModNo" placeholder="当前应用取模值，范围(0至取模数减一)">
                 </div>
               </div>
               <span id="taskModNoInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="limitSize" class="col-sm-3 control-label">取值数量</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="limitSize" name="pushTaskConfig.limitSize" placeholder="批量数据获取数据量，单位/个，限制1000">
                 </div>
               </div>
               <span id="limitSizeInfo" style="color:red;" ></span>
             </div>
           </form>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default pull-left" onclick="closeModal(this)">关闭</button>
         <button type="button" class="btn btn-primary" onclick="saveSchedule()">保存</button>
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
	scheduleTabel = $("#example1").DataTable({
		"searching":false,//是否显示搜索框
		"ordering":false,//是否显示排序
		"pagingType":"full_numbers",//分页样式,一共四种,可看源码
		"lengthChange":false,//是否允许改变每页显示条数
		"bServerSide": true, //是否服务器加载数据
		"columns": [//列信息
		            { "data": "taskIp","width":"20%"},
		            { "data": "taskName","width":"25%"},
		            { "data": "taskMod","width":"15%"},
		            { "data": "taskModNo","width":"15%"},
		            { "data": "limitSize","width":"10%"},
		            { "data": "","width":"20%"},
		           ],
		   "sAjaxSource":basePath+"wqs/queryPushTaskConfig.action",//获取数据的服务器请求地址
		   "fnServerData":function(sSource, aoData, fnCallback){//服务器传递参数
		   	var taskIp = $("#searchPushTaskForm #ip").val();
		   	var taskName = $("#pushTaskName").val();
		   	$.ajax({    
		           "contentType": "application/json",    
		           "url": sSource,     
		           "dataType": "json",    
		           "data": { aoData: JSON.stringify(aoData),taskIp:taskIp,taskName:taskName }, 
		           "success": function(resp) { 
		   	    	            fnCallback(resp.result);   
		   	    	        }    
		    	}); 
		   },
		"columnDefs":[
	   	  			//添加操作列的显示信息
	   	  			{
   	  				 "targets":5,
   	  				 "render":function( data, type, full, meta){
   	  				 	var btnHtml = '<button style="margin:4px" class="btn btn-success btn-xs" data_id="'+full.id+'" onclick="editPushConfig(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
   	  				 	btnHtml += '<button style="margin:4px" class="btn btn-danger btn-xs" data_id="'+full.id+'" onclick="delPushConfig(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
   	  				 	return btnHtml;
   	  				 }
	   	  			}
		   	  		]
		});
	});
//下拉框加载
 /* function addItems() {  
     $.ajax({
         url: basePath+"wqs/queryPushTaskConfigById.action",  
         data: null,
         success: function(resp) { 
         	$("#loading").hide();
	    	      var pushTaskConfigList = resp.pushTaskConfigList;  
	    	      var html="";
	    	      $(pushTaskConfigList).each(function(index,value){
	    	    	html += "<option value=''>"+"全部</option> ";
	    	      	html += "<option value='"+value.taskName+"'>"+value.taskName+"</option> ";
	    	      })
	    	      if(html){
	    	    	  $("#pushTaskName").append(html);
	    	      	//$("#pushTaskName").html(html);
	    	      }else{
	    	      	alert("无数据！");
	    	      	$("#pushTaskName").append(html);
	    	      }   
	    	},
	    	error:function(){
	    		$("#loading").hide();
	    		alert("系统异常！");
	    	}
     });            
 }; */
	//搜索调用
	function searchPushTaskConfig(){
		scheduleTabel.ajax.reload();
	}
	//添加应用配置参数
	function addScheduleJob(){
		$("#addPushConfigModal .modal-title").html("添加应用配置参数");
		$("#addPushConfigModal").show();
	}
	//修改应用配置参数
	function editPushConfig(ele){
		$("#addPushConfigModal .modal-title").html("修改应用配置参数");
		var pushId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryPushTaskConfigById.action",
    		type:"post",
    		data:{id:pushId},
    		success:function(data){
    			var schedule = data.pushTaskConfig;
    			$("#pushConfigForm #pushId").val(schedule.id);
    			$("#pushConfigForm #taskIp").val(schedule.taskIp);
    			$("#pushConfigForm #taskName").val(schedule.taskName);
    			$("#pushConfigForm #taskMod").val(schedule.taskMod);
    			$("#pushConfigForm #taskModNo").val(schedule.taskModNo);
    			$("#pushConfigForm #limitSize").val(schedule.limitSize);
    			$("#addPushConfigModal").show();
    		},
    		error:function(){
    			alert("删除失败！请联系管理员");
    		}
    	});
	}
	
	//删除应用配置参数
	function delPushConfig(ele){
	
		var pushId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该应用配置参数!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/deletePushTaskConfig.action",
		    		type:"post",
		    		data:{id:pushId},
		    		success:function(){
		    			alert("删除成功");
		    			scheduleTabel.ajax.reload();
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
	//保存添加修改的应用配置参数
	function saveSchedule(){
		var joId = $("#pushConfigForm #pushId").val();
		if(checTaskIp()&&checTaskName()
		&&checTaskMod()&&checkTaskModNo()&&checkLimitSize()){
		if(joId){
			url = "wqs/updatePushTaskConfig.action";
		}else{
			url = "wqs/addPushTaskConfig.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#pushConfigForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addPushConfigModal").hide();
				$("#pushConfigForm")[0].reset();
				var name=data.pushTaskConfig.taskName;
				 if(joId){
					 alert("修改成功！");
					 
					 $("#pushTaskName").val(name);
					 scheduleTabel.ajax.reload();
				 }else{
					 alert("添加成功！"); 
					 
					 $("#pushTaskName").val(name);
					 scheduleTabel.ajax.reload();
				 }
				 $("#pushConfigForm #pushId").val("");
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
		}else{
			return false;
		}
	}
	//校验方法
	function checTaskIp(){
		var taskIp=$("#pushConfigForm #taskIp").val();
		if(taskIp==""){
			$("#taskIpInfo").html("亲,请输入服务器IP!");
			return false;
		}else{
			$("#taskIpInfo").html("");
			return true;
		}
	}
	function checTaskName(){
		var taskName=$("#pushConfigForm #taskName").val();
		if(taskName==""){
			$("#taskNameInfo").html("亲,请输入服务器项目标识!");
			return false;
		}else{
			$("#taskNameInfo").html("");
			return true;
		}
	}
	function checTaskMod(){
		var taskMod=$("#pushConfigForm #taskMod").val();
		var r = /^[0-9]*[1-9][0-9]*$/
		if(taskMod==""){
			$("#taskModInfo").html("亲,请输入取模数!");
			return false;
		}else if(!r.test(taskMod)){
			$("#taskModInfo").html("");
			$("#taskModInfo").html("亲,请输入非0整数!");
			return false;
		}else{
			$("#taskModInfo").html("");
			return true;
		}
	}
	function checkTaskModNo(){
		var taskModNo=$("#pushConfigForm #taskModNo").val();
		var r = /^\d+$/
		if(taskModNo==""){
			$("#taskModNoInfo").html("亲,请输入当前应用取模值!");
			return false;
		}else if(!r.test(taskModNo)){
			$("#taskModNoInfo").html("");
			$("#taskModNoInfo").html("亲,请输入正整数!");
			return false;
		}else {
			var x=parseInt(taskModNo);
			if(isNaN(x) || x<0 || x>9){
				$("#taskModNoInfo").html("");
				$("#taskModNoInfo").html("亲,请输入0-9的整数!");
				return false;
			}else{
				
			$("#taskModNoInfo").html("");
			return true;
			}
		}
	}
	function checkLimitSize(){
		var limitSize=$("#pushConfigForm #limitSize").val();
		var r = /^[0-9]*[1-9][0-9]*$/
		if(limitSize==""){
			$("#limitSizeInfo").html("亲,请输入当前应用取值数量!");
			return false;
		}else if(!r.test(limitSize)){
			$("#limitSizeInfo").html("");
			$("#limitSizeInfo").html("亲,请输入非0整数!");
			return false;
		}else{
			$("#limitSizeInfo").html("");
			return true;
		}
	}
	//关闭model弹框
	function closeModal(ele){
		$("#taskIpInfo").hide();
		$("#taskNameInfo").hide();
		$("#taskModInfo").hide();
		$("#taskModNoInfo").hide();
		$("#limitSizeInfo").hide();
		$(ele).parents(".modal").hide();
		$("#pushConfigForm")[0].reset();
		$("#pushConfigForm #pushId").val("");
	}
</script>
</html>
