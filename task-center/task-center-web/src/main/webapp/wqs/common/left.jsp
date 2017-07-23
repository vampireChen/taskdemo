<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page language="java" import="com.deppon.wqs.module.management.shared.domain.UserEntity" %>
<%@ page language="java" import="com.deppon.wqs.module.management.shared.domain.SysMenuEntity" %> --%>
<%@ page language="java" import="java.util.*"%>
<%-- <% UserEntity u = (UserEntity)session.getAttribute("user");
   List<SysMenuEntity> menuList = (ArrayList<SysMenuEntity>)session.getAttribute("menuList");
%> --%>
<!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">系统菜单</li>
   		<%-- <% for(SysMenuEntity menu : menuList){
   			%>
   			<li><a href="<%=basePath+menu.getMenuUrl()%>"><i class="<%=menu.getDescription() %>"></i> <span><%=menu.getMenuName() %></span></a></li>
   			<%
   		} %> --%>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>