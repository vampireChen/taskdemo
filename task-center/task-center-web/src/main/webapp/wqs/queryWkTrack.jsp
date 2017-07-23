<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Wk轨迹查询管理</title>
<%@include file="common/commonTop.jsp"%>
</head>
<style>
.box-body>.table {
	margin-bottom: 120px;
}

.table>tbody>tr>td,.table>tbody>tr>th,.table>tfoot>tr>td,.table>tfoot>tr>th,.table>thead>tr>td,.table>thead>tr>th
	{
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
		<%@include file="common/header.jsp"%>
		<!-- 左侧菜单 -->
		<%@include file="common/left.jsp"%>
		<!-- 内容信息 -->
		<div class="content-wrapper" style="min-height: 910px">
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-head">
								<button style="margin: 10px" class="btn btn-success"
									onclick="addWkWayTrack()">添加WK轨迹</button>
								<button style="margin: 10px" class="btn btn-success"
									onclick="exportWkWayTrack()">导出WK轨迹</button>
							</div>

							<div class="box-body">
								<form id="queryForm" method="post">
									<label for="waybillNo">运单号:</label> 
									<input id="waybillNo" name="waybillNo" style="width: 190px;" required="true"
										validType="length[5,12]" missingMessage="不能为空" onchange="changeInitFlag();"/>
								    <input type="button" value="查询" onclick="queryAll()" />
								</form>
								<div style="width: 1318px; height: 300px; overflow: scroll;">
									<table id="trackTable" class="table table-bordered table-hover">
										<thead>
											<tr class="fixedHead"
												style="width: 190px; border-radius: 4px; padding: 6px 12px; height: 34px;">
												<th>操作</th>
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
												<!-- <th>gpsMessage</th> -->
											</tr>
										</thead>
										<tbody id="trackTableBody">
										</tbody>
									</table>
								</div>
								<div>
								<div id="Pagination" class="pagination"></div>
								</div>
								<!-- <table id="orderTable" class="table table-bordered table-hover">  
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
						</table>
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
					</div> -->
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@include file="common/footer.jsp"%>
	</div>
	<!-- 订阅模态框 -->
	<div class="modal" id="addTrackModal">
		<div class="modal-dialog" style='width: 1050px; height: 700px;'>
			<div class="modal-content" style='width: 1050px; height: 700px;'>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" onclick="closeModal(this)">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加轨迹</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="wkWayTrackForm">
						<input type="hidden" value="" id="trackId"
							name="waybillTrackEntity.id">
						<div class="box-body">
							<table>
								<tr>
									<td>
										<div class="form-group">
											<label for=waybillNo class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>运单号</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="waybillNo"
													name="waybillTrackEntity.waybillNo" placeholder="运单号"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="orderNo" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>订单号</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="orderNo"
													name="waybillTrackEntity.orderNo" placeholder="订单号"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="trackInfo" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>标记信息</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="trackInfo"
													name="waybillTrackEntity.trackInfo" placeholder="标记信息"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="operatorCode" class="col-sm-3 control-label"
												style='width: 120px; height: 45px;'>操作人编码</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="operatorCode"
													name="waybillTrackEntity.operatorCode" placeholder="操作人编码"
													style='width: 190px; height: 45px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="operatorPhone" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>操作人电话</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="operatorPhone"
													name="waybillTrackEntity.operatorPhone" placeholder="操作人电话"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="operateCity" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>操作城市</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="operateCity"
													name="waybillTrackEntity.operateCity" placeholder="操作城市"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="orgCode" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>部门编码 </label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="orgCode"
													name="waybillTrackEntity.orgCode" placeholder="部门编码 "
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="orgName" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>部门名称</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="orgName"
													name="waybillTrackEntity.orgName" placeholder="部门名称"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="eventType" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>操作类型</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="eventType"
													name="waybillTrackEntity.eventType" placeholder="操作类型"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="orderChannel" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>订单渠道来源</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="orderChannel"
													name="waybillTrackEntity.orderChannel" placeholder="订单渠道来源"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="nextOrgCode" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>下一部门编码</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="nextOrgCode"
													name="waybillTrackEntity.nextOrgCode" placeholder="下一部门编码"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="nextOrgName" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>下一部门名称</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="nextOrgName"
													name="waybillTrackEntity.nextOrgName" placeholder="下一部门名称"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="planArriveTime" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>预计到达时间</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="planArriveTime"
													name="waybillTrackEntity.planArriveTime"
													placeholder="预计到达时间" style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="destinationDeptName"
												class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>目的站</label>
											<div class="col-sm-7">
												<input type="text" class="form-control"
													id="destinationDeptName"
													name="waybillTrackEntity.destinationDeptName"
													placeholder="目的站" style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="destinationCityName"
												class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>目的城市</label>
											<div class="col-sm-7">
												<input type="text" class="form-control"
													id="destinationCityName"
													name="waybillTrackEntity.destinationCityName"
													placeholder="目的城市" style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="opreateContent" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>提货通知内容、派送拉回原因</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="opreateContent"
													name="waybillTrackEntity.opreateContent"
													placeholder="提货通知内容、派送拉回原因"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="gpsMessage" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>GPS信息</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="gpsMessage"
													name="waybillTrackEntity.gpsMessage" placeholder="GPS信息"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="jobId" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>jobId</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="jobId"
													name="waybillTrackEntity.jobId" placeholder="jobId"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class="form-group">
											<label for="operatorName" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>操作人</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="operatorName"
													name="waybillTrackEntity.operatorName" placeholder="操作人"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="orgType" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>站点类型</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="orgType"
													name="waybillTrackEntity.orgType" placeholder="站点类型"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="productCode" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>产品类型</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="productCode"
													name="waybillTrackEntity.productCode" placeholder="产品类型"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="form-group">
											<label for="nextCity" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>下一城市</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="nextCity"
													name="waybillTrackEntity.nextCity" placeholder="下一城市"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="signer" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>签收人</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="signer"
													name="waybillTrackEntity.signer" placeholder="签收人"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="sourceBillId" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>sourceBillId</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="sourceBillId"
													name="waybillTrackEntity.sourceBillId"
													placeholder="sourceBillId"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="form-group">
											<label for="operateTime" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>操作时间</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="operateTime"
													name="waybillTrackEntity.operateTime" placeholder="操作时间"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="createTime" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>创建时间</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="createTime"
													name="waybillTrackEntity.createTime" placeholder="创建时间"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
									<td>
										<div class="form-group">
											<label for="modifyTime" class="col-sm-3 control-label"
												style='width: 120px; height: 40px;'>修改时间</label>
											<div class="col-sm-7">
												<input type="text" class="form-control" id="modifyTime"
													name="waybillTrackEntity.modifyTime" placeholder="修改时间"
													style='width: 190px; height: 40px;'>
											</div>
										</div>
									</td>
								</tr>
							</table>

						</div>
					</form>
				</div>
				<div class="modal-footer" style="text-align: center;">
					<span class="btn btn-primary" onclick="saveWkWayTrack()">确定</span>
					<span class="btn btn-default" id="noOrder">取消</span>
				</div>
			</div>
		</div>
	</div>
	<div id='win'></div>
	<!--  <div id="myLinkToConfirm"></div> -->
	<!-- ./wrapper -->
	<%@include file="common/commonBottom.jsp"%>
</body>
<script>
    //点击搜索按钮进行查询
	function queryAll(){
 		$("#trackTableBody").empty();
		$("#trackTable .track").empty();
		$("#orderTable .track").empty();
		$("#successTable .track").empty();
		$("td").removeClass("nullinfo"); 
		getDataList(0, null);
	}
	//===================================-===================================================
	/**
	 * 取消 - 确定
	 */
	$("#noOrder").click(function(){
		$("#addTrackModal").hide();
	});
	
	/**
	 * 添加-订阅
	 */
	function addWkWayTrack(){
		$("#wkWayTrackForm")[0].reset();
		$("#wkWayTrackForm #waybillNo").removeAttr("readOnly");
		$("#addTrackModal .modal-title").html("添加WK轨迹");
		$("#addTrackModal").show();
	}
	
	/*
	* 保存悟空轨迹
	*/
	function saveWkWayTrack(){
		var joId = $("#wkWayTrackForm #trackId").val();
		var url;
		if(joId){
			url = "wqs/updateWkTrack.action";
		}else{
			url = "wqs/addWkTrack.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#wkWayTrackForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addTrackModal").hide();
				$("#wkWayTrackForm")[0].reset();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 $("#wkWayTrackForm #trackId").val("");
				 queryAll();
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	/*导出轨迹*/
	function exportWkWayTrack(){
	    var waybillNo = $("#waybillNo").val();
	    if(!waybillNo){
	    	alert("请输入单号！");
	    	return;
	    }
		window.location.href=basePath+"wqs/downLoadFile.action?waybillNo="+waybillNo;
	}
	/*修改轨迹淡出框*/
	function editWkWayTrack(ele){
		$("#addTrackModal .modal-title").html("修改轨迹");
		var trackId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryByWkTrackId.action",
    		type:"post",
    		data:{id:trackId},
    		success:function(data){
    			var waybillTrack = data.waybillTrackEntity;
    			$("#wkWayTrackForm #trackId").val(waybillTrack.id);
    			$("#wkWayTrackForm #waybillNo").val(waybillTrack.waybillNo);
    			$("#wkWayTrackForm #waybillNo").attr("readonly","readonly");
    			$("#wkWayTrackForm #orderNo").val(waybillTrack.orderNo);
    			$("#wkWayTrackForm #trackInfo").val(waybillTrack.trackInfo);
    			$("#wkWayTrackForm #operatorCode").val(waybillTrack.operatorCode);
    			$("#wkWayTrackForm #operatorPhone").val(waybillTrack.operatorPhone);
    			$("#wkWayTrackForm #operateCity").val(waybillTrack.operateCity);
    			$("#wkWayTrackForm #orgCode").val(waybillTrack.orgCode);
    			$("#wkWayTrackForm #orgName").val(waybillTrack.orgName);
    			$("#wkWayTrackForm #eventType").val(waybillTrack.eventType);
    			$("#wkWayTrackForm #orderChannel").val(waybillTrack.orderChannel);
    			$("#wkWayTrackForm #nextOrgCode").val(waybillTrack.nextOrgCode);
    			$("#wkWayTrackForm #nextOrgName").val(waybillTrack.nextOrgName);
    			$("#wkWayTrackForm #planArriveTime").val(waybillTrack.planArriveTime);
    			$("#wkWayTrackForm #destinationDeptName").val(waybillTrack.destinationDeptName);
    			$("#wkWayTrackForm #destinationCityName").val(waybillTrack.destinationCityName);
    			$("#wkWayTrackForm #opreateContent").val(waybillTrack.opreateContent);
    			$("#wkWayTrackForm #gpsMessage").val(waybillTrack.gpsMessage);
    			$("#wkWayTrackForm #jobId").val(waybillTrack.jobId);
    			$("#wkWayTrackForm #operatorName").val(waybillTrack.operatorName);
    			$("#wkWayTrackForm #orgType").val(waybillTrack.orgType);
    			$("#wkWayTrackForm #productCode").val(waybillTrack.productCode);
    			$("#wkWayTrackForm #nextCity").val(waybillTrack.nextCity);
    			$("#wkWayTrackForm #signer").val(waybillTrack.signer);
    			$("#wkWayTrackForm #sourceBillId").val(waybillTrack.sourceBillId);
    			$("#wkWayTrackForm #operateTime").val(waybillTrack.operateTime);
    			$("#wkWayTrackForm #createTime").val(waybillTrack.createTime);
    			$("#wkWayTrackForm #modifyTime").val(waybillTrack.modifyTime);
    			$("#addTrackModal").show();
    		},
    		error:function(){
    			alert("系统异常！请联系管理员");
    		}
    	});
	}
	
	//删除轨迹
	function delWkWayTrack(ele){
	
		var joId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该轨迹!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/delWkTrack.action",
		    		type:"post",
		    		data:{id:joId},
		    		success:function(){
		    			alert("删除成功");
		    			queryAll();
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
	
	function closeModal(ele){
		$(ele).parents(".modal").hide();
		$("#wkWayTrackForm")[0].reset();
		$("#wkWayTrackForm #trackId").val("");
	}
	
	//选择每页显示的条数
	function changeLimit(){
		limit = $("#per_page option:selected").val();
		initFlag = true;
		getDataList(0,null);
	}
	
	//当单号和日志类别改变，页数随着改变
	function changeInitFlag(){
		initFlag = true;
	}
 	var limit = 100;
	var start = 1; 
	var initFlag = true;
	var indexNum;

	function getDataList(currPage,jg) {
		        start = currPage + 1;
		        var waybillNo = $.trim($("#waybillNo").val());
	            $.ajax({
	                url : basePath+"wqs/queryWkTrack.action",
	                type : "post",
	                dataType : 'json',
	                data : {limit:limit,start:start,waybillNo:waybillNo},
	                contentType : "application/x-www-form-urlencoded; charset=utf-8",
	                success : function(result) {
	                    if (result != "false") {
	                            if (initFlag) {
	                                $("#Pagination").pagination(
	                                        result.wayCount,
	                                        {
	                                            items_per_page : limit,
	                                            num_edge_entries : 1,
	                                            num_display_entries : 8,
	                                            callback : getDataList//回调函数
	                                        });
	                                initFlag = false;
	                            }
	                            $("#trackTableBody").html("");
	                            loadDataList(result);
	                            $('#per_page option[value='+limit+']').attr('selected',true);
	                        
	                    } else {
	                       //无数据
	                    }
	                }
	            });
	}


	    function loadDataList(result) {
			if(result != "false"){
				var queryDemoVo = result.queryDemoVo,
					waybillTrackList = queryDemoVo.waybillTrackList;
					 orderRecordsList = queryDemoVo.orderRecordsList,
					logList = queryDemoVo.logList;
				 	if(waybillTrackList == ""){
				 		$("#Pagination").hide();
						$("#trackTableBody").append("<tr><td colspan='16' class='track nullinfo'>暂无数据</td></tr>");
					}else {
						$("#Pagination").show();
						$.each(waybillTrackList , function(index,info , full){
							if(start==0 || start==1){
								indexNum = index;
							}else{
								indexNum = limit*(start-1) + index;
							}
							$("#trackTableBody").append("<tr class='track'>" 
					                +"<td >"+
	      				              "<button class='btn btn-success' data_id='"+info["id"]+"' onclick='editWkWayTrack(this)'>修改</button>"  
	      				            + "<button class='btn btn-danger' data_id='"+info["id"]+"' onclick='delWkWayTrack(this)'>删除</button>"
	      				              +"</td>"
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
									+"<td >"+info["createTime"]+"</td>"
									+"<td >"+info["modifyTime"]+"</td>"
									+"<td >"+((info["sourceBillId"] == null || info["sourceBillId"] == '')?'':info["sourceBillId"])+"</td>"
									+"<td >"+((info["nextOrgCode"] == null || info["nextOrgCode"] == '')?'':info["nextOrgCode"])+"</td>"
									+"<td >"+((info["nextOrgName"] == null || info["nextOrgName"] == '')?'':info["nextOrgName"])+"</td>"
									+"<td >"+((info["nextCity"] == null || info["nextCity"] == '')?'':info["nextCity"])+"</td>"
									+"<td >"+info["planArriveTime"]+"</td>"
									+"<td >"+((info["destinationDeptName"] == null || info["destinationDeptName"] == '')?'':info["destinationDeptName"])+"</td>"
									+"<td >"+((info["destinationCityName"] == null || info["destinationCityName"] == '')?'':info["destinationCityName"])+"</td>"
									+"<td >"+((info["signer"] == null || info["signer"] == '')?'':info["signer"])+"</td>"
									+"<td >"+((info["opreateContent"] == null || info["opreateContent"] == '')?'':info["opreateContent"])+"</td>"
								+"</tr>");
						});	
					};					 	
			}
	    } 
</script>
<link rel="stylesheet" href="../adminLte/paging/pagination.css">
<script type="text/javascript" src="../adminLte/paging/jquery.pagination.js"></script>
</html>
