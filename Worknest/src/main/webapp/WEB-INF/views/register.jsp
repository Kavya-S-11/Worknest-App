<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.worknest.app.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>WorkNest - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
</head>
<body>
<jsp:include page="shared/header.jsp"/>

<div class="container" style="max-width: 500px; margin-top: 50px;">
    <h2 class="text-center mb-4">Register for WorkNest</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-info">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" name="username" required class="form-control">
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" name="password" required class="form-control">
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" name="email" required class="form-control">
        </div>

        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number:</label>
            <input type="tel" name="phoneNumber" required class="form-control">
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role:</label>
            <select name="role" class="form-select">
                <option value="USER">User</option>
                <option value="ADMIN">Admin</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100 mt-3">Register</button>
    </form>

    <div class="text-center mt-3">
        <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
    </div>
</div>

<jsp:include page="shared/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
