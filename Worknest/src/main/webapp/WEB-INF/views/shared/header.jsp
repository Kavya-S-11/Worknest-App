<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.security.Principal" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<%
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    Principal userPrincipal = httpRequest.getUserPrincipal();
    boolean isAuthenticated = (userPrincipal != null);
    String username = isAuthenticated ? userPrincipal.getName() : "";
    boolean isAdmin = isAuthenticated && httpRequest.isUserInRole("ADMIN");
    boolean isUser = isAuthenticated && httpRequest.isUserInRole("USER");
%>

<style>
.header {
    background-color: #000080; /* Navy Blue */
    color: #fff;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between; 
    align-items: center;           /* Vertical centering */
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    width: 100%;
}

.header-left h1 {
    margin: 0;
    font-size: 1.8em;
    color: #fff;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.header-right a {
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s;
}

.header-right a:hover {
    color: #00f;
}
</style>

<header class="header">
    <div class="header-left">
        <h1>WorkNest App</h1>
    </div>

    <div class="header-right">
        <% if (isAuthenticated) { %>
            <% if (isAdmin) { %>
                <a href="/admin/dashboard">Admin Dashboard</a>
            <% } %>
            <% if (isUser) { %>
                <a href="/user/my-tasks">My Tasks</a>
            <% } %>
            <a href="/logout">Logout (<%= username %>)</a>
        <% } %>
    </div>
</header>
