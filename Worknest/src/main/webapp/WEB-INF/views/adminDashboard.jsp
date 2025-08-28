<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.worknest.app.model.Task" %>
<%@ page import="com.worknest.app.model.User" %>
<%@ page import="com.worknest.app.model.Comment" %>
<%@ page import="com.worknest.app.service.CommentService" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body { background-color: #f4f6f8; font-family: Arial, sans-serif; }
        .sidebar { height: 100vh; background: #2c3e50; padding-top: 20px; position: fixed; width: 220px; color: #fff; }
        .sidebar a { display: block; color: black; padding: 12px 20px; text-decoration: none; transition: 0.3s;background-color:#d8f9ff;border-radius:40px; }
        .sidebar a:hover { background: #baecff; }
        .main-content { margin-left: 230px; padding: 20px; }
        .navbar { background-color: #2980b9; }
        .navbar .navbar-brand, .navbar .nav-link { color: white !important; }
        h2 { color: #2c3e50; }
        .table th { background-color: #2980b9; color: white; }
        .btn-primary { background-color: #2980b9; border: none; }
        .status-card { padding: 15px; border-radius: 8px; margin-bottom: 15px; }
        .pending { background-color: lightgreen; }
        .in-progress { background-color: lightblue; }
        .delayed { background-color: cyan; }
        .completed{ background-color: pink;}
       
    </style>
</head>
<body>

<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <div class="d-flex">
            <a class="nav-link" href="<%= request.getContextPath() %>/logout">Logout</a>
        </div>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center">Menu</h4>
    <a href="<%= request.getContextPath() %>/admin/createTask">Create Task</a>
    <br>
    <a  href="<%= request.getContextPath() %>/logout">Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h2>Tasks Overview</h2>

    <!-- Status Summary -->
    <%
    Map<String, Long> statusCounts = (Map<String, Long>) request.getAttribute("statusCounts");
    if (statusCounts == null) {
        statusCounts = new HashMap<>();
    }
%>

<div class="row">
    <div class="col-md-3">
        <div class="status-card pending">
            <h4>Pending</h4>
            <h3><%= statusCounts.getOrDefault("PENDING", 0L) %></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="status-card in-progress">
            <h4>In Progress</h4>
            <h3><%= statusCounts.getOrDefault("IN_PROGRESS", 0L) %></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="status-card delayed">
            <h4>Delayed</h4>
            <h3><%= statusCounts.getOrDefault("DELAYED", 0L) %></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="status-card completed">
            <h4>Completed</h4>
            <h3><%= statusCounts.getOrDefault("COMPLETED", 0L) %></h3>
        </div>
    </div>
</div>


    <!-- Task Table -->
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Status</th>
            <th>Start Date</th>
            <th>Due Date</th>
            <th>Users</th>
            <th>Actions</th>
            <th>Comments</th>
        </tr>
        </thead>
        <tbody>
<%
    List<Task> taskList = (List<Task>) request.getAttribute("tasks");
    if (taskList != null && !taskList.isEmpty()) {
        for (Task task : taskList) {
%>
<tr>
    <td><%= task.getId() %></td>
    <td><%= task.getTitle() %></td>
    <td><%= task.getStatus() %></td>
    <td><%= task.getStartDate() %></td>
    <td><%= task.getDueDate() %></td>
    <td>
        <%
            if (task.getAssignedUsers() != null) {
                for (User u : task.getAssignedUsers()) {
                	out.print(u.getUsername() + ",");
                }
            }
        %>
    </td>
    <td>
        <a href="<%= request.getContextPath() %>/admin/editTask?id=<%= task.getId() %>" class="btn btn-sm btn-warning">Edit</a>
        <a href="<%= request.getContextPath() %>/admin/deleteTask/<%= task.getId() %>" class="btn btn-sm btn-danger">Delete</a>
    </td>
    <!-- Comments column -->
    <td>
        <%
            Set<Comment> comments = task.getComments(); // get comments for this task
            if (comments != null && !comments.isEmpty()) {
                for (Comment c : comments) {
        %>
            <div style="font-size: 0.85rem; margin-bottom: 2px;">
                <strong><%= c.getUser().getUsername() %>:</strong> <%= c.getMessage() %>
                <small class="text-muted">(<%= c.getCreatedAt() %>)</small>
            </div>
        <%
                }
            } else {
        %>
            <div style="font-size: 0.85rem;">No comments yet</div>
        <%
            }
        %>

        <!-- Add comment form -->
        <form action="<%= request.getContextPath() %>/admin/task/<%= task.getId() %>/addComment" method="post" class="mt-1">
            <input type="text" name="message" placeholder="Write a comment..." class="form-control form-control-sm" required>
            <button type="submit" class="btn btn-sm btn-primary mt-1">Add</button>
        </form>
    </td>
</tr>
<%
        } // end task loop
    } else {
%>
<tr>
    <td colspan="8" class="text-center">No tasks found</td>
</tr>
<%
    }
%>
</tbody>
        
    </table>
</div>

</body>
</html>
