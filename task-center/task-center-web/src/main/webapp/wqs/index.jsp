<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<html lang="zh">
<head>
  <meta charset="utf-8">
  <title>wqs首页</title>
  <%@include file="common/commonTop.jsp" %>
  <link rel="stylesheet" href="<%=basePath%>adminLte/plugins/clock/css/default.css">
  <link rel="stylesheet" href="<%=basePath%>adminLte/plugins/clock/css/main.css">
  
</head>
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">
  <!-- 顶部导航 -->
  <%@include file="common/header.jsp" %>
  <!-- 左侧菜单 -->	
  <%@include file="common/left.jsp" %>
  <!-- 内容信息 -->
	  <div class="content-wrapper" style="min-height: 910px">
	  	<div class="row clock-container">
	  		<div class="col-lg-6">
	  			  <div class="box box-solid">
		            <div class="box-header">
		              <i class="fa fa-envelope-o"></i>
		              <h3 class="box-title">WQS 公告</h3>
		            </div>
		            <div class="box-body border-radius-none">
		              <div style="height:297px">公告页</div>
		            </div>
		          </div>
	  		</div>
	  		<div class="col-lg-6" >	
	  			<div class="box box-solid" style="background-color: burlywood;">
	  				<div class="box-body border-radius-none">
	  					<div id="myclock"></div>
	  				</div>
	  			</div>
	  			
	  		</div>
	  		
	  	</div>
	  	<div class="row">
	  		<div class="col-lg-12">
	  			<div id="container"></div>
	  		</div>
	  	</div>
	  </div>
  <%@include file="common/footer.jsp" %>
</div>
<%@include file="common/commonBottom.jsp" %>
<script src="<%=basePath%>adminLte/plugins/clock/js/jquery.thooClock.js"></script>
<script src="<%=basePath%>adminLte/plugins/highcharts/highcharts.js"></script>
<script src="<%=basePath%>adminLte/plugins/highcharts/highcharts-more.js"></script>

<script>
		var intVal, myclock;

		$(window).resize(function(){
			window.location.reload()
		});

		$(document).ready(function(){
			var audioElement = new Audio("");
			$('#myclock').thooClock({
				size:$(document).height()/3,
				onAlarm:function(){
					//all that happens onAlarm
					$('#alarm1').show();
					alarmBackground(0);
					document.body.appendChild(audioElement);
					var canPlayType = audioElement.canPlayType("audio/ogg");
					if(canPlayType.match(/maybe|probably/i)) {
						audioElement.src = 'alarm.ogg';
					} else {
						audioElement.src = 'alarm.mp3';
					}
					audioElement.addEventListener('canplay', function() {
						audioElement.loop = true;
						audioElement.play();
					}, false);
				},
				showNumerals:true,
				brandText:'THOOYORK',
				brandText2:'Germany',
				onEverySecond:function(){
				},
				offAlarm:function(){
					$('#alarm1').hide();
					audioElement.pause();
					clearTimeout(intVal);
					$('body').css('background-color','#FCFCFC');
				}
			});
			$.ajax({
				url:basePath+"wqs/queryChartData.action",
				success:function(data){
					var dataList = [];
				    var resultList = data.chartResultEntityList; 
				    for(var i=0;i<12;i++){
				    	var count = 0;
				    	$(resultList).each(function(index,value){
				    		if(i==value.orderNo){
				    			count = parseInt(value.value);
				    		}
				    	})
				    	dataList.push(count);
				    }
					var chart = Highcharts.chart('container', {
				        chart: {
				            type: 'column'
				        },
				        title: {
				            text: 'WQS时段数量报表'
				        },
				        xAxis: {
				            categories: ['00-02(时)', '02-04(时)', '04-06(时)', '06-08(时)', '08-10(时)', '10-12(时)',
				                         '12-14(时)', '14-16(时)', '16-18(时)', '18-20(时)', '20-22(时)', '22-24(时)']
				        },
				        yAxis: {
				            labels: {
				                x: -15
				            },
				            title: {
				                text: '同步到wqs数据量'
				            }
				        },
				        series: [{
				            name: '条数',
				            data: dataList
				        }],
				        responsive: {
				            rules: [{
				                condition: {
				                    maxWidth: 500
				                },
				                chartOptions: {
				                    xAxis: {
				                        labels: {
				                            formatter: function () {
				                                return this.value.charAt(0);
				                            }
				                        }
				                    },
				                    yAxis: {
				                        labels: {
				                            align: 'left',
				                            x: 0,
				                            y: -2
				                        },
				                        title: {
				                            text: ''
				                        }
				                    }
				                }
				            }]
				        }
				    });
			
				},
				error:function(){
				}
			})
		});	
	</script>

</body>
</html>