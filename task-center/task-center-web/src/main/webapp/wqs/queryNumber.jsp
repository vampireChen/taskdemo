<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>数量查询</title>
  <%@include file="common/commonTop.jsp" %>
<link rel="stylesheet" type="text/css" href="../adminLte/timepicker/css/jquery-ui.css" />

<style type="text/css">
#trackNumber,#orderNumber,#synNumber,#orderSuccessNumber,#pushNumber {
	text-align: center;
	margin-bottom:10px;
}

.demo {
	width: 500px;
	margin: 20px 0;
	font-size: 12px/18px;
}

.demo p{
   margin-left:10px;
   margin-top:10px;
}

.demo span {
	font-weight: 500;
	font-size: 12px;
}
.demo .prompt{
    border-style:none;
    width:200px;
    color:red;
    font-weight:bold;
}
.demo input[type='button']{
    width:50px;
    height:30px;
}
.demo .act_time {
	width: 150px;
	height: 30px;
	line-height: 30px;
	padding: 2px;
	border: 1px solid #d3d3d3
}

.ui-timepicker-div .ui-widget-header {
	margin-bottom: 8px;
}

.ui-timepicker-div dl {
	text-align: left;
}

.ui-timepicker-div dl dt {
	height: 25px;
	margin-bottom: -25px;
}

.ui-timepicker-div dl dd {
	margin: 0 10px 10px 65px;
}

.ui-timepicker-div td {
	font-size: 90%;
}

.ui-tpicker-grid-label {
	background: none;
	border: none;
	margin: 0;
	padding: 0;
}

.ui_tpicker_hour_label,.ui_tpicker_minute_label,.ui_tpicker_second_label,.ui_tpicker_millisec_label,.ui_tpicker_time_label {
	padding-left: 20px
}

.space {
	display:block; 
	float:left; 
	width:28px
}

.box-head{
    margin-left:10px;
    margin-top:10px;
}
</style>

<script type="text/javascript" src="../adminLte/timepicker/js/jquery.min.js"></script>
<script type="text/javascript" src="../adminLte/timepicker/js/jquery-ui.js"></script>
<script type="text/javascript" src="../adminLte/timepicker/js/jquery-ui-slide.min.js"></script>
<script type="text/javascript" src="../adminLte/timepicker/js/jquery-ui-timepicker-addon.js"></script>
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
     <div class="row">
       <div class="col-xs-12">
         <div class="box">
             <div class="box-head">
               <!-- 时间控件 -->
				<div class="demo">
				      <span><b>开始时间：</b></span>
				      <input type="text" name="act_start_time" class="act_time"/>
				      <span><b>结束时间：</b></span>
				      <input type="text" name="act_stop_time" class="act_time"/>
				      <input type="button" value="重置" onclick="reset();"/>
				      <p class="prompt">
				     <!--  <input type="text" /> -->
				      </p>
				      <script type="text/javascript">
				      $("input[name='act_start_time']").datetimepicker({
				  	    showSecond: true,
				  	    /* showMillisec: true, 毫秒*/
				  	    timeFormat: 'hh:mm:ss'
				      });
				      $("input[name='act_stop_time']").datetimepicker({
				  	    showSecond: true,
				  	    timeFormat: 'hh:mm:ss'
				      });
				      </script>
			 	</div>
             </div>
             <hr></hr>
             <div class="box-body">
             <form id="queryNumber" class="queryNumber">
                    <div class="trackNumber">
						<label for="trackNumber">轨迹量:<span class="space"></span></label>
						<input id="trackNumber" name="trackNumber" style="width: 200px;"/>
						<input type="button" id="queryTrackButton" value="查询" onclick="queryTrack();"/>
                    </div>
					<div class="orderNumber">
						<label for="orderNumber">订阅量:<span class="space"></span></label>
						<input id="orderNumber" name="orderNumber" style="width: 200px;"/>
						<input type="button" id="queryOrderButton" value="查询" onclick="queryOrder();"/>
					</div>
					<div class="synNumber">
						<label for="synNumber">同步成功量:</label>
						<input id="synNumber" name="synNumber" style="width: 200px;"/>
						<input type="button" id="querySynButton" value="查询" onclick="querySyn();"/>
					</div>
					<div class="orderSuccessNumber">
						<label for="orderSuccessNumber">订阅成功量:</label>
						<input id="orderSuccessNumber" name="orderSuccessNumber" style="width: 200px;"/>
						<input type="button" id="queryOrderSuccessButton" value="查询" onclick="queryOrderSuccess();"/>
					</div>
					<div class="pushNumber">
						<label for="pushNumber">推送成功量:</label>
						<input id="pushNumber" name="pushNumber" style="width: 200px;"/>
						<input type="button" id="queryPushButton" value="查询" onclick="queryPush();"/>
					</div>
		     </form>
             </div>
         </div>
       </div>
     </div>
  </div>
  <%@include file="common/footer.jsp" %>
</div>

<%@include file="common/commonBottom.jsp" %>
</body>
<script>

//获取时间
function getTime(){
	var beginTime = $("input[name='act_start_time']").val();
	var endTime = $("input[name='act_stop_time']").val();
	if(beginTime == "" || beginTime == null){
		$(".prompt").html("*请输入开始时间！");
		$("input[name='act_start_time']").focus();
		resetText();
		return false;
	}else{
		$(".prompt").html("");
	}
	
	if(endTime == "" || endTime == null){
		$(".prompt").html("*请输入结束时间！");
		$("input[name='act_stop_time']").focus();
		resetText();
		return false;
	}else{
		$(".prompt").html("");
	}
	
	if(beginTime>endTime){
		$(".prompt").html("*结束时间必须大于开始时间！");
		$("input[name='act_stop_time']").focus();
		resetText();
		return false;
	}else{
		$(".prompt").html("");
	}
	//入参
	param = {"beginTime":beginTime,"endTime":endTime};
	return true;

}

//点击按钮置灰
function button(id){
	id.attr("disabled","disabled");
	id.css("color","gray");
	setTimeout(function(){
		recovery(id);
	},5000)
}

//置灰恢复
function recovery(id){
   	id.removeAttr("disabled");
   	id.css("color","black");
}
//重置文本框信息
function resetText(){
	$("#trackNumber").val("");
	$("#orderNumber").val("");
	$("#synNumber").val("");
	$("#orderSuccessNumber").val("");
	$("#pushNumber").val("");
}

var stopAjax = [];
//重置时间
function reset(){
	$("input[name='act_start_time']").val("");
	$("input[name='act_stop_time']").val("");
	resetText();
	console.log(stopAjax);
	for(var i=0;i<stopAjax.length;i++){
		stopAjax[i].abort();
	}
	stopAjax = [];
}


function queryTrack(){
	$("#trackNumber").val("");
	var id = $("#queryTrackButton");
	button(id);
	if(getTime()){ 
	//请求ajax
	var track = $.ajax({
				  method : "POST",
				  url:basePath+"wqs/queryTrackByCreateTime.action",
				  dataType : "json",
				  data : param,
				  success:function(result){
					  if(result.count>0){
						  $("#trackNumber").val(result.count);
					  }else{
						  $("#trackNumber").val("0");
					  }
					  recovery(id);
				  }
		});
	  stopAjax.push(track);
     }
}

function queryOrder(){
	$("#orderNumber").val("");
	var id = $("#queryOrderButton");
	button(id);
	if(getTime()){
	//请求ajax
	var order = $.ajax({
				  method : "POST",
				  url:basePath+"wqs/queryOrderByCreateDate.action",
				  dataType : "json",
				  data : param,
				  success:function(result){
					  if(result.count>0){
						  $("#orderNumber").val(result.count);
					  }else{
						  $("#orderNumber").val("0");
					  }
					  recovery(id);
				  }
		});
	   stopAjax.push(order);
  }
}

function querySyn(){
	$("#synNumber").val("");
	var id = $("#querySynButton");
	button(id);
	if(getTime()){
	//请求ajax
	var sync = $.ajax({
				  method : "POST",
				  url:basePath+"wqs/querySyncByCreateTime.action",
				  dataType : "json",
				  data : param,
				  success:function(result){
					  if(result.syncCount>0){
						  $("#synNumber").val(result.syncCount);
					  }else{
						  $("#synNumber").val("0");
					  }
					  recovery(id);
				  }
		});
	  stopAjax.push(sync);
  }
}

function queryOrderSuccess(){
	$("#orderSuccessNumber").val("");
	var id = $("#queryOrderSuccessButton");
	button(id);
	if(getTime()){
	//请求ajax
	var orderSuccess = $.ajax({
				  method : "POST",
				  url:basePath+"wqs/queryOrderCountByCreateTime.action",
				  dataType : "json",
				  data : param,
				  success:function(result){
					  if(result.orderCount>0){
					      $("#orderSuccessNumber").val(result.orderCount);
					  }else{
						  $("#orderSuccessNumber").val("0");
					  }
					  recovery(id);
				  }
		});
	   stopAjax.push(orderSuccess);
  }
} 

 function queryPush(){
	$("#pushNumber").val("");
	var id = $("#queryPushButton");
	button(id);
	if(getTime()){
	//请求ajax
	var push = $.ajax({
				  method : "POST",
				  url:basePath+"wqs/queryPushCountByCreateTime.action",
				  dataType : "json",
				  data : param,
				  success:function(result){
					  if(result.pushCount>0){
						  $("#pushNumber").val(result.pushCount);
					  }else{
						  $("#pushNumber").val("0");
					  }
					  recovery(id);
				  }
		});
	   stopAjax.push(push);
  }
} 

</script>
</html>
