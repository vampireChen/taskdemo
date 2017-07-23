<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>开关配置管理</title>
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
      				<button style="margin:10px" class="btn btn-success" onclick="addSwitch()">添加</button>
      			</div>
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>key</th>
			                  <th>key描述</th>
			                  <th>状态</th>
			                  <th>创建时间</th>
			                  <th>修改时间</th>
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
<div class="modal" id="addSwitchModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加开关</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="switchForm">
         	 <input type="hidden" value="" id="switchId" name="switchEntity.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="keyName" class="col-sm-3 control-label" >key:</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="keyName" name="switchEntity.keyName" placeholder="key名称">
                 </div>
               </div>
               <span id="keyNameInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="keyDesc" class="col-sm-3 control-label">key描述:</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="keyDesc" name="switchEntity.keyDesc" placeholder="key描述">
                 </div>
               </div>
               <span id="descInfo" style="color:red;" ></span>
              <div class="form-group">
                 <label for="status" class="col-sm-3 control-label">状态:</label>

                 <div class="col-sm-8">
                  <!--  <input type="text" class="form-control" id="status" name="switchEntity.status" placeholder="开关状态"> -->
                   <select name="switchEntity.status" id="status" class="form-control">
                   		<option value="Y">Y</option>
                   		<option value="N">N</option>
                   </select>
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
			            { "data": "keyName","width":"15%"},
			            { "data": "keyDesc","width":"20%"},
			            { "data": "status","width":"10%"},
			            { "data": "createTime","width":"20%"},
			            { "data": "modifyTime","width":"20%"},
			            { "data": "","width":"20%"},
		            ],
		    "sAjaxSource":basePath+"wqs/querySwitch.action",//获取数据的服务器请求地址
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
		   	  				 "targets":5,
		   	  				 "render":function( data, type, full, meta){
		   	  				 	var btnHtml = '<button style="margin:1px" class="btn btn-success btn-xs" data_id="'+full.id+'" onclick="editSwitch(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
		   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-danger btn-xs" data_id="'+full.id+'" onclick="delSwitch(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
		   	  				 	return btnHtml;
		   	  				 }
		   	  			}
		   	  			]
	    });
	});
	//添加开关
	function addSwitch(){
		$("#addSwitchModal .modal-title").html("添加开关");
		$("#status").hide();
		$("#addSwitchModal").show();
	}
	//修改开关
	function editSwitch(ele){
		$("#addSwitchModal .modal-title").html("修改开关");
		var switchId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/querySwitchById.action",
    		type:"post",
    		data:{id:switchId},
    		success:function(data){
    			var schedule = data.switchEntity;
    			$("#switchForm #switchId").val(schedule.id);
    			$("#switchForm #keyName").val(schedule.keyName);
    			$("#switchForm #keyDesc").val(schedule.keyDesc);
    			$("#switchForm #status").val(schedule.status);
    			//$("#status option:selected").val();
    			$("#addSwitchModal").show();
    		},
    		error:function(){
    			alert("修改失败！请联系管理员");
    		}
    	});
	}
	
	//删除开关
	function delSwitch(ele){
	
		var switchId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该开关!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/deleteSwitch.action",
		    		type:"post",
		    		data:{id:switchId},
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
	//保存添加修改的开关
	function saveSchedule(){
		var joId = $("#switchForm #switchId").val();
		if(checkKey()&&checkDesc()){
		var url;
		if(joId){
			url = "wqs/updateSwitch.action";
		}else{
			url = "wqs/addSwitch.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#switchForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addSwitchModal").hide();
				$("#switchForm")[0].reset();
				scheduleTabel.ajax.reload();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 
				 $("#switchForm #switchId").val("");
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
	function checkKey(){
		var keyName =$("#switchForm #keyName").val();
		if(keyName==""){
			$("#keyNameInfo").html("亲,请输入key!");
			return false;
		}else{
			$("#keyNameInfo").html("");
			return true;
		}
	}
	function checkDesc(){
		var keyName =$("#switchForm #keyDesc").val();
		if(keyName==""){
			$("#descInfo").html("亲,请输入key描述!");
			return false;
		}else{
			$("#descInfo").html("");
			return true;
		}
	}
	//关闭model弹框
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#switchForm")[0].reset();
		$("#keyNameInfo").hide();
		$("#switchForm #switchId").val("");
	}
</script>
</html>
