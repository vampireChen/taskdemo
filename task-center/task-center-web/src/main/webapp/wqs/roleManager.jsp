<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>角色配置管理</title>
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
      				<button style="margin:10px" class="btn btn-success" onclick="addRole()">添加</button>
      			</div>
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>角色名称</th>
			                  <th>角色描述</th>
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
<div class="modal" id="addRoleModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加用户角色</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="roleForm">
         	 <input type="hidden" value="" id="roleId" name="roleEntity.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="name" class="col-sm-3 control-label" >角色名:</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="name" name="roleEntity.name" placeholder="角色名称">
                 </div>
               </div>
               <span id="nameInfo" style="color:red;" ></span>
               <div class="form-group">
                 <label for="description" class="col-sm-3 control-label">角色描述:</label>

                 <div class="col-sm-8">
                   <input type="text" class="form-control" id="description" name="roleEntity.description" placeholder="角色描述">
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
			            { "data": "name","width":"15%"},
			            { "data": "description","width":"20%"},
			            { "data": "insertDate","width":"20%"},
			            { "data": "updateDate","width":"20%"},
			            { "data": "","width":"20%"},
		            ],
		    "sAjaxSource":basePath+"wqs/queryRole.action",//获取数据的服务器请求地址
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
		   	  				 	var btnHtml = '<button style="margin:1px" class="btn btn-success btn-xs" data_id="'+full.id+'" onclick="editRole(this)"><i class="fa fa-fw fa-edit"></i>修改</button>';
		   	  				 	btnHtml += '<button style="margin:1px" class="btn btn-danger btn-xs" data_id="'+full.id+'" onclick="delRole(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
		   	  				 	return btnHtml;
		   	  				 }
		   	  			}
		   	  			]
	    });
	});
	//添加用户角色
	function addRole(){
		$("#addRoleModal .modal-title").html("添加用户角色");
		$("#status").hide();
		$("#addRoleModal").show();
	}
	//修改用户角色
	function editRole(ele){
		$("#addRoleModal .modal-title").html("修改用户角色");
		var roleId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryRoleById.action",
    		type:"post",
    		data:{id:roleId},
    		success:function(data){
    			var schedule = data.roleEntity;
    			$("#roleForm #roleId").val(schedule.id);
    			$("#roleForm #name").val(schedule.name);
    			$("#roleForm #description").val(schedule.description);
    			$("#addRoleModal").show();
    		},
    		error:function(){
    			alert("修改失败！请联系管理员");
    		}
    	});
	}
	
	//删除用户角色
	function delRole(ele){
	
		var roleId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该用户角色!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/deleteRole.action",
		    		type:"post",
		    		data:{id:roleId},
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
	//保存添加修改的用户角色
	function saveSchedule(){
		var joId = $("#roleForm #roleId").val();
		if(checkName()){
		var url;
		if(joId){
			url = "wqs/updateRole.action";
		}else{
			url = "wqs/addRole.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#roleForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addRoleModal").hide();
				$("#roleForm")[0].reset();
				scheduleTabel.ajax.reload();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 
				 $("#roleForm #roleId").val("");
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
	function checkName(){
		var name =$("#roleForm #name").val();
		if(name==""){
			$("#nameInfo").html("亲,请输入角色名!");
			return false;
		}else{
			$("#nameInfo").html("");
			return true;
		}
	}
	//关闭model弹框
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#roleForm")[0].reset();
		$("#nameInfo").hide();
		$("#roleForm #roleId").val("");
	}
</script>
</html>
