package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserModel;
import domain.User;

public class LoginServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println(request.getContextPath());
		String checkCode = request.getParameter("checkCode");
		String sessionCheckCode = (String) request.getSession().getAttribute(
				"checkCode");
		if (null == sessionCheckCode) {
			sessionCheckCode = "";
		}
		request.getSession().removeAttribute("checkCode");
		if (!sessionCheckCode.equalsIgnoreCase(checkCode)) {
			request.setAttribute("message", "验证码错误");
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);
			return;
		}

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);

		UserModel userModel = new UserModel();
		try {
			User existUser = userModel.login(user);
			if (existUser == null) {
				request.setAttribute("message", "用户名或密码错误");
				request.getRequestDispatcher("/login.jsp").forward(request,
						response);
			} else {
				String remember = request.getParameter("remember");
				if ("on".equals(remember)) {
					Cookie cookie = new Cookie("remember",
							existUser.getUsername());
					cookie.setPath("/webLogin");
					cookie.setMaxAge(60 * 60);
					response.addCookie(cookie);
				}
				HttpSession session = request.getSession();
				session.setAttribute("existUser", existUser);
				response.sendRedirect("/webLogin/success.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}