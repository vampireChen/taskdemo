<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>轨迹查询管理</title>
  <%@include file="common/commonTop.jsp" %>
</head>
<style>
.box-body>.table {
    margin-bottom: 100px;
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
       <div class="row">
      	<div class="col-xs-12">
      		<div class="box">
      			<div class="box-head">
      				<button style="margin:10px" class="btn btn-success" onclick="addCarniao()">菜鸟订阅</button>
      			</div>
      			
      			<div class="box-body">
      			<form id="queryForm" method="post">
					<label for="waybillNo">运单号:</label>
					  <input id="waybillNo" name="waybillNo" style="width: 200px;" required="true" validType="length[5,12]" missingMessage="不能为空" onchange="changeInitFlag();"/>
					<input type="button" value="查询"  onclick="queryAll()"/>
				</form>
					<div style="width:1318px; height:300px; overflow:scroll;">
      				<table id="trackTable" class="table table-bordered table-hover">
      					<thead>
			                <tr class="fixedHead" style="width: 200px; border-radius: 4px;padding: 6px 12px;height: 34px;">
			                  <th>num</th>
			                  <th>waybillNo</th>
			                  <th>orderNo</th>
			                  <th>eventType</th>
			                  <th>operateTime</th>
			                  <th>operateCity</th>
			                  <th>operatorName</th>
			                  <th>operatorCode</th>
			                  <th>operatorPhone</th>
			                  <th>orgType</th>
			                  <th>orgCode</th>
			                  <th>orgName</th>
			                  <th>trackInfo</th>
			                  <th>jobId</th>
			                  <th>orderChannel</th>
			                  <th>productCode</th>
			                  <th>createTime</th>
			                  <th>modifyTime</th>
		                      <th>sourceBillId</th>
		                      <th>nextOrgCode</th>
		                      <th>nextOrgName</th>
		                      <th>nextCity</th>
		                      <th>planArriveTime</th>
		                      <th>destinationDeptName</th>
		                      <th>destinationCityName</th>
		                      <th>signer</th>
		                      <th>opreateContent</th>
			                </tr>
		                </thead>
		                <tbody id="trackTableBody"></tbody>
      				</table>
      				</div>
      				<div id="Pagination" class="pagination"></div>
      				<div style="width:1318px; height:300px; overflow:scroll;">
      					<table id="orderTable" class="table table-bordered table-hover">  
						    <thead>
						        <tr>  
						            <th >id</th>  
						            <th >channelOrderNo</th>  
						            <th >channelName</th>  
						            <th >orderType</th>  
						            <th >createDate</th>  
						            <th >active</th>  
						            <th >waybillNo</th>
						            <th >logisticProviderID</th>  
						        </tr>  
						    </thead> 
						    <tbody id="orderTableBody"></tbody> 
						</table>
						</div>
						<div id="orderPagination" class="pagination"></div>
						<div style="width:1318px; height:300px; overflow:scroll;">
							<table id="successTable" class="table table-bordered table-hover" >  
							    <thead>
							        <tr>  
						        	 	<th >num</th> 
							            <th >id</th>  
							            <th >biz_type</th>  
							            <th >exec_biz_id</th>  
							            <th >exec_biz_billno</th>  
							            <th >create_time</th>  
							        </tr>  
							    </thead>  
							</table>
					</div>
      			</div>
      		</div>
      	</div> 
      </div>
    </section>
  </div>
  <%@include file="common/footer.jsp" %>
</div>
<!-- 订阅模态框 -->
<div class="modal" id="addOrder">
   <div class="modal-dialog">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">菜鸟订阅</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="scheduleForm">
         	 <input type="hidden" value="" id="jobId" name="scheduleJobEntity.id">
             <div class="box-body">
               <div class="form-group">
                 <label for="jobName" class="col-sm-2 control-label">运单信息</label>
                 <div class="col-sm-10">
                   <textarea cols="50" rows="5"  id="orderWaybills" placeholder="运单信息格式:xxxxxxx-xxxx;xxxxxxx-xxxx;xxxxxxx-;&nbsp;&nbsp;注:分号为英文分号"></textarea>
                 </div>
               </div>
               </div>
               
               <div class="form-group">
                 <label class="col-sm-2 control-label">选择渠道</label>
                 <div class="col-sm-3">
                   <select class="form-control" id="channelName" name="scheduleJobEntity.jobStatus" style="width: 152px;">
                   		<option value=" ">--请选择渠道--</option>
						<option value="TAOBAO">淘宝</option>
						<option value="EWBTAOBAO">天猫家装</option>
						<option value="APP">APP</option>
						<option value="GW">官网</option>
                   </select>
                 </div>
               </div>
               
               <div class="form-group">
                 <label class="col-sm-2 control-label">是否仓配</label>
                 <div class="col-sm-3">
                   <select class="form-control" id="cnwd" name="scheduleJobEntity.jobStatus" style="width: 152px;">
                   		<option value="">--是否仓配--</option>
                   		<option value="CN_WD">是</option>
						<option value="">否</option>
                   </select>
                 </div>
               </div>
              
              <div class="modal-footer" style="text-align:center;">
				<span class="btn btn-primary" id="yesOrder">确定</span>
				<span class="btn btn-default" id="noOrder">取消</span>
			 </div>
             </div>
       </div>
     </div>
   </div>
   <div id='win'>
	</div>
<!--  <div id="myLinkToConfirm"></div> -->
<!-- ./wrapper -->
<%@include file="common/commonBottom.jsp" %>
</body>
<script>
	 $(".begininfo").empty();
	 $(".track").empty();
	 $("td").removeClass("nullinfo");
	
	 //点击搜索按钮进行查询
	 function queryAll() {
		 getDataList(0, null);
	 }
	 
	 //当单号和日志类别改变，页数随着改变
	 function changeInitFlag(){
		 initFlag = true;
	 }

	//选择每页显示的条数
	function changeLimit(){
		limit = $("#per_page option:selected").val();
		initFlag = true;
		getDataList(0,null);
	}
	
	var limit = 100;
	var start = 1;
	var initFlag = true;
	
	function getDataList(currPage,jg) {
		 start = currPage + 1;
		 $(".begininflo").empty();
		 $(".track").empty();
		 $("td").removeClass("nullinfo");
		 	var waybillNo = $.trim($("#waybillNo").val());
			if(waybillNo == ""){
				alert("请输入运单号");
				return false;
			}
         $.ajax({
             url : basePath+"wqs/queryTrack.action",
             type : "post",
             dataType : 'json',
             data : {limit:limit,start:start,waybillNo:waybillNo},
             contentType : "application/x-www-form-urlencoded; charset=utf-8",
             success : function(result) {
                     if (initFlag) {
                    	 if(result.wayCount!=0){
                             $("#Pagination").pagination(
                        		 result.wayCount,
                                 {
                                     items_per_page : limit,
                                     num_edge_entries : 1,
                                     num_display_entries : 8,
                                     callback : getDataList//回调函数
                             });
                    	 }
                    	 if(result.orderCount!=0){
	                         $("#orderPagination").pagination(
	                       		 result.orderCount,
	                                {
	                                    items_per_page : limit,
	                                    num_edge_entries : 1,
	                                    num_display_entries : 8,
	                                    callback : getDataList//回调函数
	                        }); 
                    	 }
                         initFlag = false;
                       }
                       $("#trackTableBody").html("");
                       $("#orderTableBody").html("");
                       loadDataList(result);
                       $('#per_page option[value='+limit+']').attr('selected',true);
             }
         });
	}


	    function loadDataList(result) {
			if(result != "false"){
				var queryDemoVo = result.queryDemoVo,
					waybillTrackList = queryDemoVo.waybillTrackList,
					orderRecordsList = queryDemoVo.orderRecordsList,
					logList = queryDemoVo.logList;
				 	if(waybillTrackList == ""){
				 		$("#Pagination").hide();
						$("#trackTable").append("<tr class='begininfo'><td colspan='16' class='track nullinfo'>暂无数据</td></tr>");
					}else {
						$("#Pagination").show();
						$.each(waybillTrackList , function(index , info ){
							if(start==0 || start==1){
								indexNum = index;
							}else{
								indexNum = limit*(start-1) + index;
							}
							$("#trackTable").append("<tr class='track'>" 
									+"<td >"+(indexNum+1)+"</td>"
									+"<td >"+info["waybillNo"]+"</td>"
									+"<td >"+((info["orderNo"] == null || info["orderNo"] == '')?'':info["orderNo"])+"</td>"
									+"<td >"+((info["eventType"] == null || info["eventType"] == '')?'':info["eventType"])+"</td>"
									+"<td >"+info["operateTime"]+"</td>"
									+"<td >"+((info["operateCity"] == null || info["operateCity"] == '')?'':info["operateCity"])+"</td>"
									+"<td >"+((info["operatorName"] == null || info["operatorName"] == '')?'':info["operatorName"])+"</td>"
									+"<td >"+((info["operatorCode"] == null || info["operatorCode"] == '')?'':info["operatorCode"])+"</td>"
									+"<td >"+((info["operatorPhone"] == null || info["operatorPhone"] == '')?'':info["operatorPhone"])+"</td>"
									+"<td >"+((info["orgType"] == null || info["orgType"] == '')?'':info["orgType"])+"</td>"
									+"<td >"+((info["orgCode"] == null || info["orgCode"] == '')?'':info["orgCode"])+"</td>"
									+"<td >"+((info["orgName"] == null || info["orgName"] == '')?'':info["orgName"])+"</td>"
									+"<td >"+((info["trackInfo"] == null || info["trackInfo"] == '')?'':info["trackInfo"])+"</td>"
									+"<td >"+((info["jobId"] == null || info["jobId"] == '')?'':info["jobId"])+"</td>"
									+"<td >"+((info["orderChannel"] == null || info["orderChannel"] == '')?'':info["orderChannel"])+"</td>"
									+"<td >"+((info["productCode"] == null || info["productCode"] == '')?'':info["productCode"])+"</td>"
									+"<td >"+(info["createTime"])+"</td>"
									+"<td >"+(info["modifyTime"])+"</td>"
									+"<td >"+((info["sourceBillId"] == null || info["sourceBillId"] == '')?'':info["sourceBillId"])+"</td>"
									+"<td >"+((info["nextOrgCode"] == null || info["nextOrgCode"] == '')?'':info["nextOrgCode"])+"</td>"
									+"<td >"+((info["nextOrgName"] == null || info["nextOrgName"] == '')?'':info["nextOrgName"])+"</td>"
									+"<td >"+((info["nextCity"] == null || info["nextCity"] == '')?'':info["nextCity"])+"</td>"
									+"<td >"+(info["planArriveTime"])+"</td>"
									+"<td >"+((info["destinationDeptName"] == null || info["destinationDeptName"] == '')?'':info["destinationDeptName"])+"</td>"
									+"<td >"+((info["destinationCityName"] == null || info["destinationCityName"] == '')?'':info["destinationCityName"])+"</td>"
									+"<td >"+((info["signer"] == null || info["signer"] == '')?'':info["signer"])+"</td>"
									+"<td >"+((info["opreateContent"] == null || info["opreateContent"] == '')?'':info["opreateContent"])+"</td>"
								+"</tr>");
						});	
					};
					if(orderRecordsList == ""){
						$("#orderPagination").hide();
						$("#orderTable").append("<tr class='begininfo'><td colspan='8' class='track nullinfo'>暂无数据</td></tr>");
					}else {
						$("#orderPagination").show();
						$.each(orderRecordsList , function(index , data ){
							if(start==0 || start==1){
								indexNum = index;
							}else{
								indexNum = limit*(start-1) + index;
							}
							
							$("#orderTable").append("<tr class='track'>" 
									+"<td >"+data["id"]+"</td>"
									+"<td >"+((data["channelOrderNo"] == null || data["channelOrderNo"] == '')?'':data["channelOrderNo"])+"</td>"
									+"<td >"+((data["channelName"] == null || data["channelName"] == '')?'':data["channelName"])+"</td>"
									+"<td >"+((data["orderType"] == null || data["orderType"] == '')?'':data["orderType"])+"</td>"
									+"<td >"+(data["createDate"])+"</td>"
									+"<td >"+((data["active"] == null || data["active"] == '')?'':data["active"])+"</td>"
									+"<td >"+((data["waybillNo"] == null || data["waybillNo"] == '')?'':data["waybillNo"])+"</td>"
									+"<td >"+((data["logisticProviderID"] == null || data["logisticProviderID"] == '')?'':data["logisticProviderID"])+"</td>"
								+"</tr>");
						});	
					};
					if(logList == ""){
						$("#successTable").append("<tr class='begininfo'><td colspan='6' class='track nullinfo'>暂无数据</td></tr>");
					}else {
						$.each(logList , function(i , row ){
							$("#successTable").append("<tr class='track'>" 
									+"<td >"+(i+1)+"</td>"
									+"<td >"+row["id"]+"</td>"
									+"<td >"+row["bizType"]+"</td>"
									+"<td >"+row["execBizId"]+"</td>"
									+"<td >"+row["execBizBillNo"]+"</td>"
									+"<td >"+(row["createTime"])+"</td>"
								+"</tr>");
						});	
					};
				 	
				 	
			}
  	   }
	//===================================-===================================================
	/**
	 * 取消 - 确定
	 */
	$("#noOrder").click(function(){
		$("#addOrder").hide();
	});
	/**
	 * 添加-订阅
	 */
	function addCarniao(){
		$("#addOrder .modal-title").html("菜鸟仓配");
		$("#orderWaybills").val("");
		$("#channelName").val("");
		$("#cnwd").val("");
		$("#addOrder").show();
	}
	/**
	 * 确定 -确定添加
	 */
	$("#yesOrder").click(function(){
			ajax.doSaveOrder();
	});
	
	
	var ajax = {
			doSaveOrder:function(){//添加/编辑
				var addOrderHtml = basePath+"wqs/orderTrack.action";
				var param = charm.getData();
				console.log(param);
				if(param){
				$.post(addOrderHtml , charm.getData() , function(result){
					console.log(result);
					$("#addOrder").hide();
					if(result != "false"){
						var orderTrackVo = result.orderTrackVo,
						failedList = orderTrackVo.failedList;
						if(failedList){
							var waybillnos = "订阅失败或重复订阅的运单号：";
							for(var i in failedList){
								if(i>0){
									waybillnos += ",";
								}
								if(failedList[i]){
									waybillnos += failedList[i];
								}
							}
							alert(waybillnos);
						}
						else{
							alert('全部订阅成功！');
						}
					} 
			    });
			 };
		},
			
	}
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#scheduleForm")[0].reset();
		$("#scheduleForm #jobId").val("");
	}
	var charm = {
			getData:function(){
				var orderWaybills = $.trim($("#orderWaybills").val());
				if(orderWaybills == ""){
					alert("请添加运单信息");
					return false;
				}
				var channelName = $.trim($("#channelName").val());
				if(channelName == ""){
					alert("请选择订阅渠道");
					return false;
				}
				var cnwd = $.trim($("#cnwd").val());
				return {
					"orderInfos":orderWaybills,
					"channelName" : channelName , 
					"cnwd":cnwd
				}
			},
	}
</script>
<link rel="stylesheet" href="../adminLte/paging/pagination.css">
<script type="text/javascript" src="../adminLte/paging/jquery.pagination.js"></script>
</html>
