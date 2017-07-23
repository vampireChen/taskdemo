<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>定时任务管理</title>
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
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>名称</th>
			                  <th>分组</th>
			                  <th>状态</th>
			                  <th>表达式</th>
			                  <th>路径</th>
			                  <th>描述</th>
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
<div class="modal" id="addScheduleModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加定时任务</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="scheduleForm">
         	 <input type="hidden" value="" id="jobId" name="scheduleJobEntity.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="jobName" class="col-sm-2 control-label">名称</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobName" name="scheduleJobEntity.jobName" placeholder="定时名称">
                 </div>
               </div>
               <div class="form-group">
                 <label for="jobGroup" class="col-sm-2 control-label">分组</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobGroup" name="scheduleJobEntity.jobGroup" placeholder="定时分组">
                 </div>
               </div>
              <div class="form-group">
                 <label for="cronExpression" class="col-sm-2 control-label">表达式</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="cronExpression" name="scheduleJobEntity.cronExpression" placeholder="定时表达式">
                 </div>
               </div>
               <div class="form-group">
                 <label for="jobUrl" class="col-sm-2 control-label">路径</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobUrl" name="scheduleJobEntity.jobUrl" placeholder="定时访问路径">
                 </div>
               </div>
               <div class="form-group">
                 <label for="jobMemo" class="col-sm-2 control-label">描述</label>

                 <div class="col-sm-10">
                   <input type="text" class="form-control" id="jobMemo" name="scheduleJobEntity.memo" placeholder="任务描述">
                 </div>
               </div>
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
			            { "data": "jobName","width":"7%" },
			            { "data": "jobGroup","width":"7%" },
			            { "data": "jobStatus","width":"7%" },
			            { "data": "cronExpression","width":"10%" },
			            { "data": "jobUrl","width":"15%" },
			            { "data": "memo","width":"15%" },
			            { "data": "" }
		            ],
		    "sAjaxSource":basePath+"wqs/queryScheduleJob.action",//获取数据的服务器请求地址
		    "fnServerData":function(sSource, aoData, fnCallback){//服务器传递参数
		    	$.ajax({    
		            "contentType": "application/json",    
		            "url": sSource,     
		            "dataType": "json",    
		            "data": { aoData: JSON.stringify(aoData) }, 
		            "success": function(resp) { 
		    	    	            fnCallback(resp.result);   
		    	    	        }    
	  	    	}); 
		    },
	      	"columnDefs":[//返回数据进行转换
   	  			{
   	  				 "targets":2,
   	  				 "data":"id",
   	  				 "render":function( data, type, full, meta){
   	  					var result ;
   	  					if(full.jobStatus==0){
   	  						result="暂停";
   	  					}else if(full.jobStatus==1){
   	  						result="正常";
   	  					}else if(full.jobStatus==2){
   	  						result="禁用";
   	  					}
   	  				 	return result;
   	  				 }
   	  			},
   	  			//添加操作列的显示信息
   	  			{
   	  				 "targets":6,
   	  				 "render":function( data, type, full, meta){
   	  				 	var btnHtml = '<button style="margin:1px" class="btn btn-success btn-xs" data_id="'+full.id+'" onclick="editScheduleJob(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-warning btn-xs" data_id="'+full.id+'" onclick="pauseScheduleJob(this)"><i class="fa fa-fw fa-pause" ></i>暂停</button>';
   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-info btn-xs" data_id="'+full.id+'" onclick="recoverScheduleJob(this)"><i class="fa fa-fw fa-play" ></i>恢复</button></br>';
   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-primary btn-xs" data_id="'+full.id+'" onclick="executeScheduleJob(this)"><i class="fa fa-fw fa-refresh" ></i>立即执行一次</button>';
   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-danger btn-xs" data_id="'+full.id+'" onclick="delScheduleJob(this)"><i class="fa fa-fw fa-remove" ></i>禁用</button>';
   	  				 	return btnHtml;
   	  				 }
   	  			}
   	  			]
	    });
	});
	//添加定时任务
	function addScheduleJob(){
		$("#addScheduleModal .modal-title").html("添加定时任务");
		$("#addScheduleModal").show();
	}
	//修改定时任务
	function editScheduleJob(ele){
		$("#addScheduleModal .modal-title").html("修改定时任务");
		var jobId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryScheduleJobById.action",
    		type:"post",
    		data:{id:jobId},
    		success:function(data){
    			var schedule = data.scheduleJobEntity;
    			$("#scheduleForm #jobId").val(schedule.id);
    			$("#scheduleForm #jobName").val(schedule.jobName);
    			$("#scheduleForm #jobGroup").val(schedule.jobGroup);
    			//$("#scheduleForm #jobStatus").val(schedule.jobStatus);
    			$("#scheduleForm #cronExpression").val(schedule.cronExpression);
    			$("#scheduleForm #jobUrl").val(schedule.jobUrl);
    			$("#scheduleForm #jobMemo").val(schedule.memo);
    			//alert(JSON.stringify(data.scheduleJobEntity));
    			$("#addScheduleModal").show();
    		},
    		error:function(){
    			alert("删除失败！请联系管理员");
    		}
    	});
	}
	
	//禁用定时任务
	function delScheduleJob(ele){
	
		var jobId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该定时任务!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/deleteScheduleJob.action",
		    		type:"post",
		    		data:{id:jobId},
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
	//暂停定时任务
	function pauseScheduleJob(ele){
	
		var jobId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要暂停该定时任务!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/stopScheduleJob.action",
		    		type:"post",
		    		data:{id:jobId},
		    		success:function(){
		    			alert("暂停成功");
		    			scheduleTabel.ajax.reload();
		    		},
		    		error:function(){
		    			alert("暂停失败！请联系管理员");
		    		}
		    	});
		        
		    },
		    cancel: function(){
		       
		    }
		});
	
	}
	//恢复定时任务
	function recoverScheduleJob(ele){
	
		var jobId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要恢复该定时任务!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/recoverScheduleJob.action",
		    		type:"post",
		    		data:{id:jobId},
		    		success:function(){
		    			alert("恢复成功");
		    			scheduleTabel.ajax.reload();
		    		},
		    		error:function(){
		    			alert("恢复失败！请联系管理员");
		    		}
		    	});
		        
		    },
		    cancel: function(){
		       
		    }
		});
	
	}
	//立即执行一次
	function executeScheduleJob(ele){
	
		var jobId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要立即执行一次该定时任务!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/executeScheduleJob.action",
		    		type:"post",
		    		data:{id:jobId},
		    		success:function(){
		    			alert("执行成功");
		    			scheduleTabel.ajax.reload();
		    		},
		    		error:function(){
		    			alert("执行失败！请联系管理员");
		    		}
		    	});
		        
		    },
		    cancel: function(){
		       
		    }
		});
	
	}
	//保存添加修改的定时任务
	function saveSchedule(){
		var joId = $("#scheduleForm #jobId").val();
		var url;
		if(joId){
			url = "wqs/updateScheduleJob.action";
		}else{
			url = "wqs/addScheduleJob.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#scheduleForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addScheduleModal").hide();
				$("#scheduleForm")[0].reset();
				scheduleTabel.ajax.reload();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 $("#scheduleForm #jobId").val("");
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	
	//关闭model弹框
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#scheduleForm")[0].reset();
		$("#scheduleForm #jobId").val("");
	}
</script>
</html>
