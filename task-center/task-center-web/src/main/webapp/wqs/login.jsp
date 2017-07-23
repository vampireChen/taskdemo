<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登录管理系统</title>
<%--  <%@include file="common/commonTop.jsp" %> --%>
<link href="<%=basePath %>adminLte/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>adminLte/bootstrap/css/signin.css" rel="stylesheet">
</head>
<body>

<div class="signin">
	<div class="signin-head"><img src="<%=basePath %>adminLte/bootstrap/images/test/deppon_head.jpg" alt="" class="img-circle"></div>
	<form class="form-signin" role="form" action="<%=basePath %>login" method="post">
		<input type="text" name="name" id="name" class="form-control" placeholder="用户名" required autofocus />
		<span id="nameInfo" style="color:red;"></span>
		<input type="password" name="upwd" id="upwd" class="form-control" placeholder="密码" required />
		<span id="upwdInfo" style="color:red;"></span>
		<span class="btn btn-lg btn-warning btn-block" type="button" onclick="logininfo()">登录</span>
		<label class="checkbox">
			<input type="checkbox" value="remember-me">记住我
		</label>
	</form>
</div>
</body>
<%@include file="common/commonBottom.jsp" %>
<script>
var basePath = "<%=basePath%>";
function logininfo(){
	var param = charm.getData();
	if(param != false){
		//请求ajax
		$.ajax({
			  method : "POST",
			  url:basePath+"wqs/login.action",
			  dataType : "json",
			  data : param,
			  success : function(result){
					if(result.mng == false){
						$("#name").val("");
						$("#upwd").val("");
						$("#upwdInfo").html("用户名或密码输入不正确");
					}else{
						window.location.href='index.action';
					}
			  	},
			error:function(result){
				$("#upwdInfo").html("用户名或密码输入不正确");
			}
		});
	}
}
var charm = {
		getData : function(){
 			
 			//效验用户名
 			var name =$("#name").val();
 			if(name == ""){
 				charm.info("#nameInfo","请输入用户名称");
 				return false; 
 			}else{
 				charm.info("#nameInfo","");
 			}
 			
 			//效验密码
 			var upwd =$("#upwd").val();
 			if(upwd == ""){
 				charm.info("#upwdInfo","请输入密码");
 				return false; 
 			}else{
 				charm.info("#upwdInfo","");
 			}
			return {
				"name" : name,
				"upwd" : upwd 
			};
		},
		info: function(id,message){
			$(""+id).html(message);
		}
	};
	
	 //回车提交事件
	$("body").keydown(function() {
	    if (event.keyCode == "13") {//keyCode=13是回车键
	    	logininfo();
	    }
	});
</script>
</html>
