<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.worknest.app.model.Task" %>
<%@ page import="com.worknest.app.model.Comment" %>
<%@ page import="com.worknest.app.model.User" %>
<%@ page import="java.util.Set" %>

<%
    // Get the list of tasks assigned to the user
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
    <style>
        body {
            padding: 20px;
                    }
        .navbar { background-color: #000080; }
        .navbar .navbar-brand, .navbar .nav-link { color: white !important; }
        h1 {
            margin-bottom: 30px;
            color:#000080;
        }
        h2{
        	color:black;
        }
        .status-select {
            width: 130px;
        }
        .comment-input {
            width: calc(100% - 100px);
            display: inline-block;
        }
        .comment-btn {
            display: inline-block;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .status-card {
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            color: #fff;
            margin-bottom: 20px;
        }
        .status-pending { background-color: #ffc107; }
        .status-in-progress { background-color: #17a2b8; }
        .status-completed { background-color: #28a745; }
        .status-delayed { background-color: #dc3545; }
    </style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">User Dashboard</a>
        <div class="d-flex">
            <a class="nav-link" href="<%= request.getContextPath() %>/logout">Logout</a>
        </div>
    </div>
</nav>
<div class="container">
    <h1 class="text-center">Welcome to Your Dashboard</h1>

    <h2>My Tasks</h2>
    <table class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
                <th>Start Date</th>
                <th>Due Date</th>
                <th>Last Updated</th>
                <th>Assigned Users</th>
                <th>Comments</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (tasks != null) {
                for (Task task : tasks) {
        %>
            <tr>
                <td><%= task.getTitle() %></td>
                <td><%= task.getDescription() %></td>
                <td><%= task.getStatus() %></td>
                <td><%= task.getStartDate() %></td>
                <td><%= task.getDueDate() %></td>
                <td><%= task.getLastUpdated() %></td>
                <td>
				    <%
				        Set<User> assignedUsers = task.getAssignedUsers();
				        if (assignedUsers != null && !assignedUsers.isEmpty()) {
				            for (User u : assignedUsers) {
				    %>
				        <%= u.getUsername() %><br/>
				    <%
				            }
				        } else {
				    %>
				        No users assigned
				    <%
				        }
				    %>
				</td>
                
                <td>
                    <div style="max-height: 150px; overflow-y: auto;">
                        <%
                            Set<Comment> comments = task.getComments();
                            if (comments != null) {
                                for (Comment comment : comments) {
                                    User commentUser = comment.getUser();
                        %>
                            <b><%= commentUser.getUsername() %>:</b> <%= comment.getMessage() %><br/>
                        <%
                                }
                            }
                        %>
                    </div>
                    <form action="addComment" method="post" class="mt-2 d-flex">
                        <input type="hidden" name="taskId" value="<%= task.getId() %>"/>
                        <input type="text" name="message" placeholder="Add a comment" class="form-control comment-input" required/>
                        <button type="submit" class="btn btn-primary comment-btn ms-2">Comment</button>
                    </form>
                </td>
                <td>
                    <form action="updateStatus" method="post" class="d-flex flex-column gap-2">
                        <input type="hidden" name="taskId" value="<%= task.getId() %>"/>
                        <select name="status" class="form-select status-select">
                            <option value="PENDING" <%= "PENDING".equals(task.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(task.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="COMPLETED" <%= "COMPLETED".equals(task.getStatus()) ? "selected" : "" %>>Completed</option>
                            <option value="DELAYED" <%= "DELAYED".equals(task.getStatus()) ? "selected" : "" %>>Delayed</option>
                        </select>
                        <button type="submit" class="btn btn-success btn-sm mt-1">Update</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="8" class="text-center">No tasks assigned.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
