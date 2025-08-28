<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Set, java.util.HashSet" %>
<%@ page import="com.worknest.app.model.User, com.worknest.app.model.Task" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Task</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
    <!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .container {
            max-width: 600px;
            margin-top: 40px;
            background: #ececec;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 5px 5px 6px 18px rgba(0, 0, 0, 0.5);
        }
        h2 {
            color: #2c3e50;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
        }
        label {
            font-weight: 500;
            color: #34495e;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #1abc9c;
            border-color: #16a085;
            font-weight: bold;
            border-radius: 8px;
            padding: 10px 20px;
        }
        .btn-primary:hover {
            background-color: #16a085;
        }
        .btn-secondary {
            border-radius: 8px;
        }
        .form-section {
            margin-bottom: 20px;
        }
        
    </style>
</head>
<body>
<jsp:include page="shared/header.jsp"/>
<div class="container">
    <h2>Create New Task</h2>
    <form action="${pageContext.request.contextPath}/admin/saveTask" method="post">
        
        <div class="form-section">
            <label for="title">Task Title</label>
            <input type="text" name="title" id="title" class="form-control" placeholder="Enter task title" required>
        </div>

        <div class="form-section">
            <label for="description">Description</label>
            <textarea name="description" id="description" class="form-control" rows="4" placeholder="Enter task description"></textarea>
        </div>

        <div class="form-section">
            <label for="status">Status</label>
            <select name="status" id="status" class="form-select" required>
          <option value="PENDING">Pending</option>
		    <option value="IN_PROGRESS">In Progress</option>
		    <option value="DELAYED">Delayed</option>
		    <option value="COMPLETED">Completed</option>
            </select>
        </div>

        <div class="form-section">
            <label for="startDate">Start Date</label>
            <input type="date" name="startDate" id="startDate" class="form-control" required>
        </div>

        <div class="form-section">
            <label for="dueDate">Due Date</label>
            <input type="date" name="dueDate" id="dueDate" class="form-control" required>
        </div>

<%
    // read users provided by controller: (controller should set model attribute "users")
    List<User> users = (List<User>) request.getAttribute("userList");

    // read task (for edit). If creating new, task may be null.
    Task task = (Task) request.getAttribute("task");

    // build a set of assigned user ids for quick contains() checks
    Set<Long> assignedIds = new HashSet<>();
    if (task != null && task.getAssignedUsers() != null) {
        for (User au : task.getAssignedUsers()) {
            if (au != null && au.getId() != null) {
                assignedIds.add(au.getId());
            }
        }
    }
%>
<div class="form-section">
    <label class="form-label">Assign Users:</label><br>
    <%
        User currentUser = (User) request.getAttribute("currentUser"); // logged-in user
        List<User> allUsers = (List<User>) request.getAttribute("allUsers"); // all users
        Set<User> assignedUsers = (task != null && task.getAssignedUsers() != null) ? task.getAssignedUsers() : new HashSet<>();
    %>
    <% if(allUsers != null) {
        for(User u : allUsers) { 
            String displayName = u.equals(currentUser) ? "Myself" : u.getUsername();
            String roleClass = "badge bg-secondary"; // default normal user
            if("ADMIN".equalsIgnoreCase(u.getRole())) {
                roleClass = "badge bg-danger"; // admin in red
            } else {
                roleClass = "badge bg-primary"; // normal user in blue
            }
    %>
        <div class="form-check mb-1">
            <input class="form-check-input" type="checkbox" name="assignedUserIds" value="<%= u.getId() %>"
                <%= assignedUsers.contains(u) ? "checked" : "" %> >
            <label class="form-check-label">
                <%= displayName %> 
                <span class="<%= roleClass %>"><%= u.getRole() %></span>
            </label>
        </div>
    <% }} %>
</div>

        
        <div class="d-flex justify-content-between">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Save Task</button>
        </div>
    </form>
</div>
<jsp:include page="shared/footer.jsp"/>
</body>
</html>
