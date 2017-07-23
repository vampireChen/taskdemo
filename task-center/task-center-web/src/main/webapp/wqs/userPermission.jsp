<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户管理权限</title>
  <%@include file="common/commonTop.jsp" %>
</head>
<style type="text/css">
.two{ color:#F00}
</style>
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
      				<button style="margin:10px" class="btn btn-success" onclick="addUser()">添加</button>
      			</div>
      				<form class="form-inline" id="searchForm" role="form">
      			 	<div class="form-group">
				   		 <div class="input-group" style="margin:15px 10px 0px 15px ">
					     	 <label class="input-group-addon">用户名</label>
					     	 <input class="form-control" id="nameCheck" type="text">
				   		 </div>
				  	  </div>
				  	  <!-- <div class="form-group">
				   		 <div class="input-group" style="margin:15px 10px 0px 15px ">
					     	 <label class="input-group-addon">用户昵称</label>
					     	 <input class="form-control" id="nickCheck" type="text">
				   		 </div>
				  	  </div> -->
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
			                  <th>用户id</th>
			                  <th>用户名</th>
			                  <th>用户昵称</th>
			                  <th>操作</th>
			                </tr>
		                </thead>
      				</table>
      			</div>
      		</div>
      		<input type="hidden" id="currentId"/>
      	</div> 
      </div>
    </section>
  </div>
  <%@include file="common/footer.jsp" %>
</div>
<div class="modal" id="addUserModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加规则管理</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="userForm">
             <div class="box-body">
               <div class="form-group">
                 <label for="channelName" class="col-sm-2 control-label">用户名</label>

                 <div class="col-sm-10">
                   <td><input type="text" id="nameone" onblur="checkname()"  class="form-control" /><span   id="name1" class="two"></span></td>
                 </div>
               </div>
               <div class="form-group">
                 <label for="bizType" class="col-sm-2 control-label">用户密码</label>
                 <div class="col-sm-10">
                  <td><input type="password" id="pwd" onblur="checkpwd()"  class="form-control" /><span   id="pwd1" class="two"></span></td>
                 </div>
               </div>
              <div class="form-group">
                 <label for="trackingsType" class="col-sm-2 control-label">确认密码</label>
                 <div class="col-sm-10">
                   <td><input type="password" id="repwd" onblur="checkrepwd()"  class="form-control" /><span   id="repwd1" class="two"></span></td>
                 </div>
               </div>
                <div class="form-group">
                 <label for="trackingsType" class="col-sm-2 control-label">用户昵称</label>
                 <div class="col-sm-10">
                   <td><input type="text" id="nick"   class="form-control" /><span   id="name1" class="two"></span></td>
                 </div>
               </div>
             </div>
           </form>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default pull-left" onclick="closeModal(this)">关闭</button>
         <button type="button" class="btn btn-primary" onclick="saveUser()">保存</button>
       </div>
     </div>
   </div>
 </div>
 <%/* 删除-弹出框  */ %>
		<div class="modal-content" style="display:none;width: 350px;position: fixed;left: 50%;top: 50%;margin-left: -250px;margin-top: -100px;" id="user_delete_content_div">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				</button>
				<h4 class="modal-title" id="title" style="margin-bottom: 0px;font-size:16px;">
					确定<span style="color: red;">删除此用户?</span>
				</h4>
			 </div>

			<div class="modal-footer" style="text-align: center;">
				<button class="btn btn-primary" id="noDelete" style="margin-top: 7px;">取消</button>
				<button class="btn btn-default" id="yesDelete" style="margin-top: 7px;">确定</button>
			</div>
		</div> 
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	//页面初始化
	$(function () {
	
		 userTabel = $("#example1").DataTable({
			"searching":false,//是否显示搜索框
			"ordering":false,//是否显示排序
			"pagingType":"full_numbers",//分页样式,一共四种,可看源码
			"lengthChange":false,//是否允许改变每页显示条数
			"bServerSide": true, //是否服务器加载数据
			"columns": [//列信息
			            { "data": "id","width":"22%" },
			            { "data": "userName","width":"22%" },
			            { "data": "nickName","width":"22%" },
			            { "data": "" }
		            ],
		    "sAjaxSource":basePath+"wqs/queryUserPermsion.action",//获取数据的服务器请求地址
		    "fnServerData":function(sSource, aoData, fnCallback){//服务器传递参数
		    	var nameCheck = $("#searchForm #nameCheck").val();
		    	var nickCheck = $("#searchForm #nickCheck").val();
		    	$.ajax({    
		            "contentType": "application/json",    
		            "url": sSource,     
		            "dataType": "json",    
		            "data": { aoData: JSON.stringify(aoData),nameCheck:nameCheck,nickCheck:nickCheck}, 
		            "success": function(resp) { 
    	    	            fnCallback(resp.pageResultUtil);   
	    	    	        }    
	  	    	}); 
		    },
	      	"columnDefs":[//返回数据进行转换
   	  			{
   	  				 "targets":3,
   	  				 "render":function( data, type, full, meta){
   	  					var	btnHtml = '<button class="btn btn-danger btn-sm" data_id="'+full.id+'" onclick="delUser(this)"><i class="fa fa-fw fa-remove" ></i>删除</button>';
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
		userTabel.ajax.reload();
	}
	function addUser(){
		$("#addUserModal .modal-title").html("添加用户管理");
		$("#addUserModal").show();
	}
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#nameone").val("");
		$("#pwd").val("");
		$("#nick").val("");
		$("#repwd").val("");
	}
	
	/**
	 * 确定 -确定删除
	 */
	$("#yesDelete").click(function(){
		ajax.doDelete();
	});
	
	/**
	 * 取消 - 确定删除
	 */
	$("#noDelete").click(function(){
		opt.userDelete.hide();
	});
	function delUser(ele){
		//获取用户id
		var userId = $(ele).attr("data_id");
		opt.userDelete.show(userId);
	}
	var opt = {
			userDelete:{
				show:function(id){
					opt.cid.set(id);//设置当前ID
					$("#user_delete_content_div").show();
				},
				hide:function(){
					$("#user_delete_content_div").hide();
				},
			},
			cid:{
				set:function(currentId){//设置当前ID
					$("#currentId").val(currentId);
				},
				get:function(){//获取当前ID
					return $("#currentId").val();
				},
				empty:function(){//清空当前ID
					$("#currentId").val("");
				}
			},
	  };
	var ajax = {
			doDelete:function(){
				var url = "delUserById.action";
				$.post(url , {"id":opt.cid.get()} , function(result){
					opt.userDelete.hide();
					if(result.mng == false){
						userTabel.ajax.reload();
						alert("删除失败");
					}else{
						userTabel.ajax.reload();
						alert("删除成功");
					};
				 });
			},
	};
    /**
    *验证部分
    **/
	 var pwd;
	function checkname(){
		var nameone=document.getElementById("nameone").value;
		var name1=document.getElementById("name1");
		name1.innerHTML="";
		if(nameone == ""){
		name1.innerHTML="用户名输入有误";
		return false;
		}
		return true;
	
	}
	function checkpwd(){
	  pwd=document.getElementById("pwd").value;
	  var pwd1=document.getElementById("pwd1");
	  pwd1.innerHTML="";
	  var reg=/^[A-Za-z0-9]{4,10}$/;
	  if(reg.test(pwd)==false){
		 pwd1.innerHTML="密码必须有4-10位的数字或者字符"; 
		 return false;
	  }else{
		  return true;
		}
		return true;
	}
	function checkrepwd(){
		var repwd=document.getElementById("repwd").value;
		var repwd1=document.getElementById("repwd1");
		repwd1.innerHTML="";
		if(pwd!=repwd){
		repwd1.innerHTML="两次密码不一致";
		return false;
		}if(repwd==""){
		repwd1.innerHTML="不能为空";	
		}
		
	  return true;
	}
	function saveUser(){
		if(checkname()&&checkpwd()&&checkrepwd()){
			var url = "wqs/addUser.action";
			var nick=document.getElementById("nick").value;
			var param = {"nameone":$("#nameone").val(),"pwd" : pwd ,"nick":nick}
			$.ajax({
				url:basePath+url,
				type:"post",
				data:param,
				dataType: "json",
				success:function(data){
					$("#addUserModal").hide();
					$("#userForm")[0].reset();
					userTabel.ajax.reload();
					 alert("添加成功！"); 
				},
				error:function(){
					alert("系统异常，请联系管理员！");
				}
			})
		}else{
			return false;
		}
	}
</script>
</html>
