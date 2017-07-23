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
      <ul id="myTab" class="nav nav-tabs"> 
		    <li class="active"><a href="#cacheQuery" data-toggle="tab"> 
		            查询缓存</a></li> 
		    <li><a href="#cacheDelete" data-toggle="tab">删除缓存</a></li>
		    <li><a href="#cacheAdd" data-toggle="tab">缓存添加（测试）</a></li> 
		</ul> 
	<div id="myTabContent" class="tab-content"> 
   		<div class="tab-pane fade in active" id="cacheQuery"> 
	       <form class="form-horizontal" role="form" style="margin-top:10px">
		       	<div class="form-group"> 
			        <div class="col-sm-4"> 
			            <input type="text" class="form-control" id="cacheKey" placeholder="请输入缓存key"> 
			        </div> 
			        <div class="col-sm-2">
			        	<button class="btn btn-success" type="button" onclick="queryCache()">查询</button>
			        </div>
			    </div> 
			    <div class="form-group">
			    	<div class="col-sm-8"> 
			    		<textarea class="form-control" id="cacheValue" rows="7"></textarea> 
			    	</div>
			    </div>
	       </form>
	    </div> 
	    <div class="tab-pane fade" id="cacheDelete"> 
	        <form class="form-horizontal" role="form" style="margin-top:10px">
		       	<div class="form-group"> 
			        <div class="col-sm-4"> 
			            <input class="form-control" id="cachekeys" placeholder="请输入缓存key,多个用英文,隔开"/>
			        </div> 
			        <div class="col-sm-2">
			        	<button class="btn btn-danger" type="button" onclick="deleteCache()">删除</button>
			        </div>
			    </div> 
	       </form>
	    </div> 
	    <div class="tab-pane fade" id="cacheAdd"> 
	        <form class="form-horizontal" role="form" style="margin-top:10px">
		       	<div class="form-group"> 
			        <div class="col-sm-4"> 
			            <input class="form-control" id="cachekeyAdd" placeholder="请输入缓存key"/>
			        </div> 
			        <div class="col-sm-2">
			        	<button class="btn btn-danger" type="button" onclick="addCache()">删除</button>
			        </div>
			    </div> 
	       </form>
	    </div> 
	</div>
    </section>
  </div>
  <%@include file="common/footer.jsp" %>
</div>
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	/**
	* 查询缓存
	*/
	function queryCache(){
		var cacheKey = $("#cacheKey").val();
		if(cacheKey == ""){
			alert("请输入缓存key");
			return false;
		}
		$.ajax({
			url:basePath+"wqs/getCacheByKey.action",
			type:"post",
			data:{cacheKey:cacheKey},
			success:function(data){
				if(data.mng == true){
					$("#cacheValue").val(data.cacheValue);
				}else{
					alert("查询失败！");
					$("#cacheValue").val(data.result.message);
				}
				
			},
			error:function(a,b,c){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	/**
	* 删除缓存
	*/
	function deleteCache(){
		var cacheKeys = $("#cachekeys").val();
		if(cacheKeys == ""){
			alert("请输入缓存key");
			return false;
		}
		$.ajax({
			url:basePath+"wqs/deleteCacheByKey.action",
			type:"post",
			data:{cacheKeys:cacheKeys},
			success:function(data){
				if(data.mng == true){
					alert("删除成功！");
					$("#cachekeys").val("");
				}else{
					alert("删除失败！");
					alert(data.result.message);
				}
			},
			error:function(a,b,c){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	function addCache(){
		var cachekeyAdd = $("#cachekeyAdd").val();
		$.ajax({
			url:basePath+"wqs/addCacheByKey.action",
			type:"post",
			data:{cachekeyAdd:cachekeyAdd},
			success:function(data){
				if(data.result.code==1){
					alert("添加成功！");
				}else{
					alert(data.result.message);
				}
			},
			error:function(a,b,c){
				alert("系统异常，请联系管理员！");
			}
		})
	}
</script>
</html>
