<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>菜单管理</title>
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
       <div class="row">
      	<div class="col-xs-12">
      		<div class="box">
      			<div class="box-head">
      				<button style="margin:10px" class="btn btn-success" onclick="addSysMenu()">添加菜单</button>
      			</div>
      			
      			<div class="box-body">
      			<form id="queryForm" method="post">
					<label for="menuName">菜单名:</label>
					  <input id="menuName" name="menuName" style="width: 190px;" required="true" validType="length[5,12]" missingMessage="不能为空" />
					<input type="button" value="查询"  onclick="queryAll()"/>
				</form>
					<div style="width:990x; height:300px;">
      				<table id="MenuTable" class="table table-bordered table-hover">
      					<thead>
			                <tr class="fixedHead" style="width: 190px; border-radius: 4px;padding: 6px 12px;height: 34px;">
			                  <th>操作</th>
			                  <th>菜单地址</th>
			                  <th>菜单名称</th>
			                  <th>菜单排序</th>
			                  <th>菜单状态</th>
			                  <th>描述</th>
			                </tr>
		                </thead>
		                <tbody id="MenuTableBody">
		                </tbody>
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
<div class="modal" id="addMenuModal" >
   <div class="modal-dialog" style='width:1050; height:700px;'>
     <div class="modal-content" style='width:550px; height:440px;margin: 95px auto;'>
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal(this)">
           <span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">添加菜单</h4>
       </div>
       <div class="modal-body">
         <form class="form-horizontal" id="SysMenuForm">
         	 <input type="hidden" value="" id="MenuId" name="sysMenuEntity.id">
          <div class="box-body">
                 <div class="form-group" >
                  <label for=menuName class="col-sm-3 control-label">菜单名称</label>
                 <div class="col-sm-7">
                   <input type="text" class="form-control" id="menuName" name="sysMenuEntity.menuName" 
                   placeholder="菜单名称">
                 </div>
                </div>
                 <div class="form-group" >
                 <label for="menuUrl" class="col-sm-3 control-label">菜单地址</label>
                  <div class="col-sm-7">
                   <input type="text" class="form-control" id="menuUrl" name="sysMenuEntity.menuUrl" 
                   placeholder="菜单地址">
                  </div>
                 </div>
                 <div class="form-group" >
                 <label for="sort" class="col-sm-3 control-label">菜单排序</label>
                  <div class="col-sm-7">
                   <input type="text" class="form-control" id="sort" name="sysMenuEntity.sort" 
                   placeholder="菜单排序">
                  </div>
                 </div>
                 <div class="form-group" >
                 <label for="active" class="col-sm-3 control-label">菜单状态</label>
                 <div class="col-sm-7">
                   <select class="form-control" id="active" name="sysMenuEntity.active">
                   	<option value="0">启用</option>
                   	<option value="1">禁用</option>
                   </select>
                 </div>
               </div>
                 <div class="form-group" >
                 <label for="description" class="col-sm-3 control-label">描述</label>
                  <div class="col-sm-7">
                   <input type="text" class="form-control" id="description" name="sysMenuEntity.description" 
                   placeholder="描述">
                  </div>
                 </div>
             </div>
           </form>
         </div>
              <div class="modal-footer" style="text-align:center;">
				<span class="btn btn-primary" onclick="saveSysMenu()">确定</span>
				<span class="btn btn-default" id="noOrder">取消</span>
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
	//查询菜单
	function queryAll() {
		$("#MenuTableBody").empty();
		$("#MenuTable .Menu").empty();
		$("td").removeClass("nullinfo");
	 	var menuName = $.trim($("#menuName").val());
		if(menuName == ""){
			alert("请输入菜单名称");
			return false;
		}
		//入参
		param = {"menuName":menuName};
		//请求ajax
		$.ajax({
			  method : "POST",
			  url:basePath+"wqs/queryBySysMenuNames.action",
			  dataType : "json",
			  data : param,
			  success : function(result){
					if(result != "false"){
						var sysMenuVo = result.sysMenuVo,
							sysMenuEntityList = result.sysMenuEntityList;

						 	if(sysMenuEntityList == ""){
								$("#MenuTableBody").append("<tr><td colspan='6' class='Menu nullinfo'>暂无数据</td></tr>");
							}else {
								$.each(sysMenuEntityList , function(index , info , full){
									$("#MenuTableBody").append("<tr class='Menu'>" 
							                +"<td >"+
			      				              "<button class='btn btn-success' data_id='"+info["id"]+"' onclick='editSysMenu(this)'>修改</button>"  
			      				            + "<button class='btn btn-danger' data_id='"+info["id"]+"' onclick='delSysMenu(this)'>删除</button>"
			      				              +"</td>"
											+"<td >"+info["menuName"]+"</td>"
											+"<td >"+((info["menuUrl"] == null || info["menuUrl"] == '')?'':info["menuUrl"])+"</td>"
											+"<td >"+((info["sort"] == null || info["sort"] == '')?'':info["sort"])+"</td>"
											+"<td >"+((info["active"] == null || info["active"] == '')?'':info["active"])+"</td>"
											+"<td >"+((info["description"] == null || info["description"] == '')?'':info["description"])+"</td>"
										+"</tr>");
								});	
							};					 	 
					}
			  	} 
			});
	};
	//===================================-===================================================
	/**
	 * 取消 - 确定
	 */
	$("#noOrder").click(function(){
		$("#addMenuModal").hide();
	});
	
	/**
	 * 添加-订阅
	 */
	function addSysMenu(){
		$("#SysMenuForm")[0].reset();
		$("#SysMenuForm #menuName").removeAttr("readOnly");
		$("#addMenuModal .modal-title").html("添加菜单");
		$("#addMenuModal").show();
	}
	
	/*
	* 保存悟空菜单
	*/
	function saveSysMenu(){
		var joId = $("#SysMenuForm #MenuId").val();
		var url;
		if(joId){
			url = "wqs/updateSysMenu.action";
		}else{
			url = "wqs/addSysMenu.action";
		}
		$.ajax({
			url:basePath+url,
			type:"post",
			data:$("#SysMenuForm").serialize(),
			dataType: "json",
			success:function(data){
				$("#addMenuModal").hide();
				$("#SysMenuForm")[0].reset();
				 if(joId){
					 alert("修改成功！"); 
				 }else{
					 alert("添加成功！"); 
				 }
				 $("#SysMenuForm #MenuId").val("");
				 queryAll();
			},
			error:function(){
				alert("系统异常，请联系管理员！");
			}
		})
	}
	/*修改菜单淡出框*/
	function editSysMenu(ele){
		$("#addMenuModal .modal-title").html("修改菜单");
		var MenuId = $(ele).attr("data_id");
		$.ajax({
    		url:basePath+"wqs/queryBySysMenuId.action",
    		type:"post",
    		data:{id:MenuId},
    		success:function(data){
    			var waybillMenu = data.sysMenuEntity;
    			$("#SysMenuForm #MenuId").val(waybillMenu.id);
    			$("#SysMenuForm #menuName").val(waybillMenu.menuName);
    			//$("#SysMenuForm #menuName").attr("readonly","readonly");
    			$("#SysMenuForm #menuUrl").val(waybillMenu.menuUrl);
    			$("#SysMenuForm #active").val(waybillMenu.active);
    			$("#SysMenuForm #sort").val(waybillMenu.sort);
    			$("#SysMenuForm #description").val(waybillMenu.description);
    			$("#addMenuModal").show();
    		},
    		error:function(){
    			alert("系统异常！请联系管理员");
    		}
    	});
	}
	
	//删除菜单
	function delSysMenu(ele){
	
		var joId = $(ele).attr("data_id");
		
		$.confirm({
		    title: '操作提示!',
		    content: '你确定要删除该菜单!',
		    confirmButton:"确定",
		    cancelButton:"取消",
		    confirmButtonClass:"btn-success",
		    confirm: function(){
		    	$.ajax({
		    		url:basePath+"wqs/delSysMenu.action",
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
		$("#SysMenuForm")[0].reset();
		$("#SysMenuForm #MenuId").val("");
	}
</script>
</html>
