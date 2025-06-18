<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body class="UserReg">
    <div class="auth-container">
        <h2>Sign In</h2>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error-message">Invalid email or password</div>
        <% } else if ("1".equals(request.getParameter("success"))) { %>
            <div class="success-message">Registration successful! Please sign in.</div>
        <% } %>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Sign In</button>
        </form>
        <p class="auth-link">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
    </div>
</body>
</html>