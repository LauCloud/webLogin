<%@page import="utils.CookieUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<script type="text/javascript">
	function changeImg() {
		document.getElementById("checkImg").setAttribute("src", "/webLogin/CheckImgServlet?time="+new Date().getTime())
	}
</script>
</head>
<body>
<center>
<h3>登陆页面</h3>
<%
	Cookie[] cookies = request.getCookies();
	Cookie cookie =	CookieUtils.findCookie(cookies, "remember");
	String userName = "";
	if(null != cookie){
		userName = cookie.getValue();
	}
%>
<form action="/webLogin/LoginServlet" method="post">
<table border="0px">
	<tr>
		<td>用户名：</td>
		<td><input type="text" name="username" value="<%= userName %>" /></td>
	</tr>
	<tr>
		<td>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
		<td><input type="password" name="password" /></td>
	</tr>
	<tr>
		<td>验证码：</td>
		<td><input type="text" name="checkCode" size="4"/>
		<img id="checkImg" src="/webLogin/CheckImgServlet" />
		<a href="#" onclick="changeImg()">看不清，换一张</a></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="remember"/>记住我</td>
	</tr>
	<tr>
		<td colspan="2"><center><input type="submit" /></center></td>
	</tr>
</table>
</form>
<br/>
<br/>
<%
	String message = "";
	if(request.getAttribute("message")!=null){
		message = (String)request.getAttribute("message");
	}
%>
<h4><font color="red"><%=message %></font></h4>
</center>
</body>
</html>