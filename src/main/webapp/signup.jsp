<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body class="UserReg">
    <div class="auth-container">
        <h2>Sign Up</h2>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="error-message">
                <% if ("exists".equals(error)) { %>
                    Email already exists
                <% } else if ("mismatch".equals(error)) { %>
                    Passwords don't match
                <% } else { %>
                    Registration failed
                <% } %>
            </div>
        <% } %>
        <form action="signup" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Sign Up</button>
        </form>
        <p class="auth-link">Already have an account? <a href="login.jsp">Sign In</a></p>
    </div>
</body>
</html>