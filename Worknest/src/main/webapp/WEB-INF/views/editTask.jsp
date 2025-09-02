<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.worknest.app.model.User" %>
<%@ page import="com.worknest.app.model.Task" %>
<%
    Task task = (Task) request.getAttribute("task");
    List<User> allUsers = (List<User>) request.getAttribute("allUsers");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container{
        background: #ececec;
        }
        .form-container {
            max-width: 700px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #343a40;
        }
        .form-check {
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
  <jsp:include page="shared/header.jsp"/>
<div class="container">
    <div class="form-container">
        <h2>Edit Task</h2>
        <form action="${pageContext.request.contextPath}/admin/updateTask" method="post">

            <input type="hidden" name="id" value="<%=task.getId()%>">

            <!-- Title -->
            <div class="mb-3">
                <label class="form-label">Title:</label>
                <input type="text" class="form-control" name="title" value="<%=task.getTitle()%>" required>
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label class="form-label">Description:</label>
                <textarea class="form-control" name="description" rows="3"><%=task.getDescription()%></textarea>
            </div>

            <!-- Status -->
            <div class="mb-3">
                <label class="form-label">Status:</label>
                <select class="form-select" name="status">
                    <option value="PENDING" <%=task.getStatus().equals("PENDING") ? "selected" : ""%>>Pending</option>
                    <option value="IN_PROGRESS" <%=task.getStatus().equals("IN_PROGRESS") ? "selected" : ""%>>In Progress</option>
                    <option value="COMPLETED" <%=task.getStatus().equals("COMPLETED") ? "selected" : ""%>>Completed</option>
                    <option value="DELAYED" <%=task.getStatus().equals("DELAYED") ? "selected" : ""%>>Delayed</option>
                </select>
            </div>

            <!-- Start Date -->
            <div class="mb-3">
                <label class="form-label">Start Date:</label>
                <input type="date" class="form-control" name="startDate" value="<%=task.getStartDate()%>" required>
            </div>

            <!-- Due Date -->
            <div class="mb-3">
                <label class="form-label">Due Date:</label>
                <input type="date" class="form-control" name="dueDate" value="<%=task.getDueDate()%>" required>
            </div>

            <!-- Assign Users -->
            <div class="mb-3">
                <label class="form-label">Assign Users:</label><br>
                <% if(allUsers != null) {
                    for(User u : allUsers) { %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="assignedUsers" value="<%=u.getId()%>"
                                <%= task.getAssignedUsers().contains(u) ? "checked" : "" %> >
                            <label class="form-check-label"><%=u.getUsername()%></label>
                        </div>
                <% }} %>
            </div>

            <!-- Submit -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4">Update Task</button>
               <a href="/Worknest/admin/dashboard" class="btn btn-secondary px-4">Cancel</a>
               
            </div>
        </form>
    </div>
</div>
    <jsp:include page="shared/footer.jsp"/>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
