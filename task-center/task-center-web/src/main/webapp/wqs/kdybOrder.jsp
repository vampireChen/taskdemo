<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>快递100管理</title>
  <%@include file="common/commonTop.jsp" %>
</head>
<style>
.box-body>.table {
    margin-bottom: 120px;
}
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    padding: 8px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid #ddd;
    text-align: center;
    white-space: nowrap;
}
.nullinfo {
    height: 70px;
    line-height: 70px;
    text-align: center;
    background-color: beige;
    font-size: 25px;
}

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
        <ul id="myTab" class="nav nav-tabs"> 
		    <li class="active"><a href="#orderInfo" data-toggle="tab">订阅信息</a></li> 
		    <li><a href="#pushInfo" data-toggle="tab">推送信息</a></li>
		</ul> 
		<div class="tab-content"> 
	   		<div class="tab-pane fade in active" id="orderInfo"> 
		       <form class="form-horizontal" role="form" style="margin-top:10px">
			       	<div class="form-group"> 
				        <div class="col-sm-4"> 
				            <input type="text" class="form-control" id="waybillNoOrder" placeholder="请输入单号"> 
				        </div> 
				        <div class="col-sm-2">
				        	<button class="btn btn-success" type="button" onclick="queryOrderByBillNoAndChanName()">查询订阅</button>
				        </div>
				         <div class="col-sm-2">
				        	<button class="btn btn-info" type="button" onclick="kdybOrder()">重新订阅</button>
				        </div>
				         <div class="col-sm-2">
				        	<button class="btn btn-danger" type="button" onclick="deleteBookOrder()">删除订阅</button>
				        </div>
				    </div> 
				    <div class="form-group">
				    	<div class="col-sm-8"> 
				    		<textarea class="form-control" id="orderDetail" rows="7"></textarea> 
				    	</div>
				    </div>
		       </form>
		    </div> 
		    <div class="tab-pane fade" id="pushInfo"> 
		        <form class="form-horizontal" role="form" style="margin-top:10px">
			       	<div class="form-group"> 
				        <div class="col-sm-4"> 
				            <input class="form-control" id="waybillNoPush" placeholder="请输入单号"/>
				        </div> 
				         <div class="col-sm-2">
				        	<button class="btn btn-success" type="button" onclick="getKdybPushByNo()">查询推送信息</button>
				        </div>
				        <div class="col-sm-2">
				        	<button class="btn btn-danger" type="button" onclick="delKdybPush()">删除推送</button>
				        </div>
				    </div> 
				     <div class="form-group">
				    	<div class="col-sm-8"> 
				    		<textarea class="form-control" id="pushDetail" rows="7"></textarea> 
				    	</div>
				    </div>
		       </form>
		    </div> 
		</div>
    </section>
  </div>
  <%@include file="common/footer.jsp" %>
</div>
<div id='win'>
	</div>
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	//订阅
	function kdybOrder() {
		var waybillNo = $("#waybillNoOrder").val();
		$.ajax({
			url:basePath+"wqs/kdybOrder.action",
			data:{waybillNo:waybillNo},
			success:function(data){
				var info = data.bookOrderRes;
				$("#orderDetail").html(info);
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	};
	//查询订阅信息
	function queryOrderByBillNoAndChanName(){
		var waybillNo = $("#waybillNoOrder").val();
		$.ajax({
			url:basePath+"wqs/queryOrderByBillNoAndChanName.action",
			data:{waybillNo:waybillNo},
			success:function(data){
				var info = JSON.stringify(data.bookOrderEntity);
				$("#orderDetail").html(info);
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	//删除订阅
	function deleteBookOrder(){
		var waybillNo = $("#waybillNoOrder").val();
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该订阅!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
					url:basePath+"wqs/deleteBookOrder.action",
					data:{waybillNo:waybillNo},
					success:function(data){
						alert("删除成功！");
					},
					error:function(){
						alert("系统异常，请联系管理员！");
					}
				})
		        
		    },
		    cancel: function(){
		       
		    }
		});
		
	}
	//查询待推送数据
	function getKdybPushByNo(){
		var waybillNo = $("#waybillNoPush").val();
		$.ajax({
			url:basePath+"wqs/getKdybPushByNo.action",
			data:{waybillNo:waybillNo},
			success:function(data){
				var info = JSON.stringify(data.kdYbTaskEntity);
				$("#pushDetail").html(info);
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	//删除待推送
	function delKdybPush(){
		var waybillNo = $("#waybillNoPush").val();
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该订阅!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
					url:basePath+"wqs/delKdybPush.action",
					data:{waybillNo:waybillNo},
					success:function(data){
						alert("删除成功！");
					},
					error:function(){
						alert("系统异常，请联系管理员！");
					}
				})
		        
		    },
		    cancel: function(){
		       
		    }
		});
		
	}
</script>
</html>
