package com.controller;

import com.dao.UserDao;
import com.entities.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = { "/login", "/signup", "/logout" })
public class AuthController extends HttpServlet {
	private final UserDao userDao = new UserDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		if ("/logout".equals(path)) {
			handleLogout(request, response);
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();

		switch (path) {
		case "/login":
			handleLogin(request, response);
			break;
		case "/signup":
			handleSignup(request, response);
			break;
		case "/logout":
			handleLogout(request, response);
			break;
		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			User user = userDao.getUserByEmail(email);

			// TODO: In production, use password hashing (e.g., BCrypt) instead of plaintext
			// comparison
			if (user != null && user.getPassword().equals(password)) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("userName", user.getName());
				response.sendRedirect("home.jsp");
			} else {
				response.sendRedirect("login.jsp?error=1");
			}
		} catch (Exception e) {
			// TODO: In production, log errors properly instead of printing stack trace
			e.printStackTrace();
			response.sendRedirect("login.jsp?error=1");
		}
	}

	private void handleSignup(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (!password.equals(confirmPassword)) {
			response.sendRedirect("signup.jsp?error=mismatch");
			return;
		}

		try {
			if (userDao.getUserByEmail(email) != null) {
				response.sendRedirect("signup.jsp?error=exists");
				return;
			}

			User newUser = new User();
			newUser.setName(name);
			newUser.setEmail(email);
			newUser.setPassword(password);

			userDao.saveUser(newUser);
			response.sendRedirect("login.jsp?success=1");
		} catch (Exception e) {
			// TODO: In production, log errors properly instead of printing stack trace
			e.printStackTrace();
			response.sendRedirect("signup.jsp?error=server");
		}
	}

	private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		response.sendRedirect("login.jsp");
	}
}