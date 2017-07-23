<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>日志管理</title>
  <%@include file="common/commonTop.jsp" %>
  <style type="text/css">
  	.search-input{
  		margin:30px;
  	}
	.loading{  
	    width:100%;  
	    height:100%;  
	    display:none;
	    position: absolute;  
	    top:0;  
	    left:0;  
	    color:#fff;  
	    padding-left:60px;  
	    font-size:15px;  
	    background: #000 url(images/loader.gif) no-repeat 50% 45%;  
	    opacity: 0.7;  
	    z-index:9999;  
	    -moz-border-radius:20px;  
	    -webkit-border-radius:20px;  
	    border-radius:20px;  
	    filter:progid:DXImageTransform.Microsoft.Alpha(opacity=70);  
	}  
  </style>
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
      				<form class="form-inline" role="form" id="searchSyncLogForm">
					    <div class="input-group search-input">
					      <div class="input-group-addon">单号</div>
					      <input class="form-control" type="text" id="waybillNo" placeholder="单号" onchange="changeInitFlag();">
					    </div>
					    <div class="input-group search-input">
					      <div class="input-group-addon">日志类别</div>
					      <select class="form-control" id="logClass" onchange= "changeInitFlag();" >
					      	<option value="ORDER">订阅</option>
					      	<option value="PUSH">推送</option>
					      	<option value="SYNC" selected>同步</option>
					      	<option value="TRACKLOG">轨迹</option>
					      </select>
					    </div>
					  	<button style="margin:10px" type="button" id="btn-success" class="btn btn-success" onclick="searchSyncLog()"><i class="fa fa-fw fa-search"></i>搜索</button>
      				</form>
      			</div>
      			<div class="box-body">
      				<table id="example1" class="table table-bordered table-hover">
      					<thead>
			                <tr>
			                  <th>单号</th>
			                  <th>轨迹</th>
			                  <th>同步类</th>
			                  <th>描述</th>
			                  <th>日志类别</th>
			                  <th>日志类型</th>
			                  <th>创建时间</th>
			                  <th>操作时间</th>
			                  <th>来源系统</th>
			                </tr>
		                </thead>
		                <tbody id="logTableBody">
		                
		                </tbody>
      				</table>
      			</div>
      			<div id="Pagination" class="pagination">
      			</div>
      		</div>
      	</div> 
      </div>
    </section>
  </div>
  <div class="loading" id="loading"></div>
  <%@include file="common/footer.jsp" %>
</div>
<!--  <div id="myLinkToConfirm"></div> -->
<!-- ./wrapper -->
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	//选择每页显示的条数
	function changeLimit(){
		limit = $("#per_page option:selected").val();
		initFlag = true;
		getDataList(0,null);
	}
	//点击搜索按钮进行查询
 	function searchSyncLog(){
		getDataList(0,null);
	} 

	//当单号和日志类别改变，页数随着改变
	function changeInitFlag(){
		initFlag = true;
	}
	
	var limit = 100; 
	var start = 1;
    var initFlag = true; 
	function getDataList(currPage,jg) {
	     var waybillNo = $("#waybillNo").val();
	     if(waybillNo == "" ){
	         alert("请输入单号");
	         return false;
	     }
	     var logClass= $("#logClass").val();
         $.ajax({
             url : basePath+"wqs/queryWqsLog.action",
             type : "post",
             dataType : 'json',
             beforeSend:function(){
            	$("#loading").show();
             },
             complete:function(){
            	$("#loading").hide();
             },
             data : {limit : limit, start:currPage + 1,waybillNo:waybillNo,logClass:logClass},
             contentType : "application/x-www-form-urlencoded; charset=utf-8",
             success : function(resp) {
                        if (initFlag) { 
                         $("#Pagination").pagination(
                        		 resp.wqsCount,
                                 {
                                     items_per_page : limit,
                                     num_edge_entries : 1,
                                     num_display_entries : 8,
                                     callback : getDataList//回调函数
                         		 }
                        		 );
                         initFlag =false;
                        }
                       $("#logTableBody").html("");
                       loadDataList(resp);
                       $('#per_page option[value='+limit+']').attr('selected',true);
             },
           	error:function(){
          		$("#loading").hide();
          		alert("系统异常！");
          	}
         });
	}


	    function loadDataList(resp) {
	         $("#loading").hide();
	 	      var wqsLogEntitys = resp.wqsLogEntitys;
	 	      var html="";
	 	      $(wqsLogEntitys).each(function(index,value){
	 	      	html += "<tr>";
	 	      	html += "<td>"+value.waybillNo+"</td>";
	 	      	html += "<td>"+value.eventType+"</td>";
	 	      	html += "<td>"+value.className+"</td>";
	 	      	html += "<td>"+value.note+"</td>";
	 	      	html += "<td>"+value.logClass+"</td>";
	 	      	html += "<td>"+value.logType+"</td>";
	 	      	html += "<td>"+value.createTime+"</td>";
	 	      	html += "<td>"+value.operateTime+"</td>";
	 	      	html += "<td>"+value.sourceSystem+"</td>";
	 	      	html += "</tr>"
	 	      })
	 	      if(html){
	 	    	$("#Pagination").show();
	 	      	$("#logTableBody").html(html);
	 	      }else{
	 	      	$("#Pagination").hide();
	 	      	alert("无数据！");
	 	      	$("#logTableBody").html(html);
	 	      }   
  	   }
	
</script>
<link rel="stylesheet" href="../adminLte/paging/pagination.css">
<script type="text/javascript" src="../adminLte/paging/jquery.pagination.js"></script>
</html>
