<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkNest - Login</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
</head>
<body>
    <jsp:include page="shared/header.jsp"/>

    <main class="d-flex flex-grow-1 justify-content-center align-items-center p-3">
        <div class="container login-container" style="max-width: 450px;">
            <h2>Login to WorkNest</h2>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null && !error.isEmpty()) {
            %>
                <div class="alert alert-danger" role="alert"><%= error %></div>
            <%
                }
            %>
            <%
                String message = (String) request.getAttribute("message");
                if (message != null && !message.isEmpty()) {
            %>
                <div class="alert alert-success" role="alert"><%= message %></div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username:</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                         <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/reset-password" class="text-decoration-none">Forgot password?</a>
            </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Login</button>
            </form>

   			<br>
            <div class="register-link text-center">
                <a href="${pageContext.request.contextPath}/register">Don't have an account? Register here.</a>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS CDN (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
