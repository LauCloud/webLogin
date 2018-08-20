<%@page import="domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录成功页面</title>
</head>
<body>
	<%
		if (null == request.getSession().getAttribute("existUser")) {
	%>
	您还未登录！请先去登录：
	<a href="/webLogin/login.jsp">登录</a>
	<%
		} else {
			User existUser = (User) request.getSession().getAttribute(
					"existUser");
	%>
	欢迎您！<%=existUser.getNickname()%><a href="/webLogin/LogoutServlet">退出登录</a>
	<%
		}
	%>
</body>
</html>