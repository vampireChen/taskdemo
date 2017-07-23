<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>线程池配置管理</title>
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
			                  <th>配置参数编码</th>
			                  <th>配置参数名称</th>
			                  <th>配置参数值</th>
			                  <th>单位</th>
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
<div class="modal" id="addConfigModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加配置参数</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="configForm">
         	 <input type="hidden" value="" id="confId" name="configParam.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="confCode" class="col-sm-3 control-label">配置参数编码</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="confCode" name="configParam.confCode" placeholder="配置参数编码">
                 </div>
               </div>
               <span id="codeInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="confName" class="col-sm-3 control-label">配置参数名称</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="confName" name="configParam.confName" placeholder="配置参数名称">
                 </div>
               </div>
              <div class="form-group">
                 <label for="confValue" class="col-sm-3 control-label">配置参数值</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="confValue" name="configParam.confValue" placeholder="配置参数值">
                 </div>
               </div>
               <span id="valueInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="confUnit" class="col-sm-3 control-label">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="confUnit" name="configParam.confUnit" placeholder="单位">
                 </div>
               </div>
               <span id="unitInfo" style="color:red;" ></span>
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
			            { "data": "confCode","width":"25%"},
			            { "data": "confName","width":"35%"},
			            { "data": "confValue","width":"15%"},
			            { "data": "confUnit","width":"10%"},
			            { "data": "","width":"20%"},
		            ],
		    "sAjaxSource":basePath+"wqs/queryThreadConfig.action",//获取数据的服务器请求地址
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
		"columnDefs":[
		   	  			//添加操作列的显示信息
		   	  			{
		   	  				 "targets":4,
		   	  				 "render":function( data, type, full, meta){
		   	  				 	var btnHtml = '<button style="margin:1px" class="btn btn-success btn-xs" data_id="'+full.id+'" onclick="editThreadConfig(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
		   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-danger btn-xs" data_id="'+full.id+'" onclick="delThreadConfig(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
		   	  				 	return btnHtml;
		   	  				 }
		   	  			}
		   	  			]
	    });
	});
	//添加配置参数
	function addScheduleJob(){
		$("#addConfigModal .modal-title").html("添加配置参数");
		$("#addConfigModal").show();
	}
	//修改配置参数
	function editThreadConfig(ele){
		$("#addConfigModal .modal-title").html("修改配置参数");
		var confId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryThreadConfigById.action",
    		type:"post",
    		data:{id:confId},
    		success:function(data){
    			var schedule = data.configParam;
    			$("#configForm #confId").val(schedule.id);
    			$("#configForm #confCode").val(schedule.confCode);
    			$("#configForm #confName").val(schedule.confName);
    			$("#configForm #confValue").val(schedule.confValue);
    			$("#configForm #confUnit").val(schedule.confUnit);
    			$("#addConfigModal").show();
    		},
    		error:function(){
    			alert("删除失败！请联系管理员");
    		}
    	});
	}
	
	//删除配置参数
	function delThreadConfig(ele){
	
		var confId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该配置参数!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/deleteThreadConfig.action",
		    		type:"post",
		    		data:{id:confId},
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
	//保存添加修改的配置参数
	function saveSchedule(){
		var joId = $("#configForm #confId").val();
		if(checkCode()&&checkValue()&&checkUnit()){
		if(joId){
			url = "wqs/updateThreadConfig.action";
		}else{
			url = "wqs/addThreadConfig.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#configForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addConfigModal").hide();
				$("#configForm")[0].reset();
				scheduleTabel.ajax.reload();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 $("#configForm #confId").val("");
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
	function checkCode(){
		var confCode=$("#configForm #confCode").val();
		if(confCode==""){
			$("#codeInfo").html("亲,请输入配置参数编码!");
			return false;
		}else{
			$("#codeInfo").html("");
			return true;
		}
	}
	function checkValue(){
		var confValue=$("#configForm #confValue").val();
		if(confValue==""){
			$("#valueInfo").html("亲,请输入配置参数值!");
			return false;
		}else{
			$("#valueInfo").html("");
			return true;
		}
	}
	function checkUnit(){
		var confUnit=$("#configForm #confUnit").val();
		if(confUnit==""){
			$("#unitInfo").html("亲,请输入配置参数单位!");
			return false;
		}else{
			$("#unitInfo").html("");
			return true;
		}
	}
	//关闭model弹框
	function closeModal(ele){
		$("#codeInfo").hide();
		$("#valueInfo").hide();
		$("#unitInfo").hide();
		$(ele).parents(".modal").hide();
		$("#configForm")[0].reset();
		$("#configForm #confId").val("");
	}
</script>
</html>
