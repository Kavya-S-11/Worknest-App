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
        .container {
            max-width: 800px;
            margin-top: 20px;
            background: #ececec;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 5px 6px 18px rgba(0, 0, 0, 0.5);
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

    <div class="row form-section">
    <div class="col-md-4">
        <label for="status">Status</label>
        <select name="status" id="status" class="form-select" required>
            <option value="PENDING">Pending</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="DELAYED">Delayed</option>
            <option value="COMPLETED">Completed</option>
        </select>
    </div>

    <div class="col-md-4">
        <label for="startDate">Start Date</label>
        <input type="date" name="startDate" id="startDate" class="form-control" required>
    </div>

    <div class="col-md-4">
        <label for="dueDate">Due Date</label>
        <input type="date" name="dueDate" id="dueDate" class="form-control" required>
    </div>
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
    <label class="form-label">Assign Users:</label>

    <style>
        /* Make the dropdown as wide as the button */
        #userDropdown + .dropdown-menu { width: 100%; max-height: 240px; overflow-y: auto; }
    </style>

    <div class="dropdown w-100">
        <button class="btn btn-outline-secondary dropdown-toggle w-100 text-start"
                type="button"
                id="userDropdown"
                data-bs-toggle="dropdown"
                data-bs-auto-close="outside"
                aria-expanded="false">
            Select Users
        </button>

        <ul class="dropdown-menu p-2" aria-labelledby="userDropdown">
            <%
                // Build assignedIds once (re-using your earlier logic is fine too)
                Set<Long> assignedIdsFix = new HashSet<>();
                if (task != null && task.getAssignedUsers() != null) {
                    for (User au : task.getAssignedUsers()) {
                        if (au != null && au.getId() != null) assignedIdsFix.add(au.getId());
                    }
                }

                User currentUser = (User) request.getAttribute("currentUser");
                List<User> allUsers = (List<User>) request.getAttribute("allUsers");

                if (allUsers != null) {
                    for (User u : allUsers) {
                        String displayName = (currentUser != null && u.getId() != null
                                              && u.getId().equals(currentUser.getId()))
                                              ? "Myself" : u.getUsername();
                        String roleClass = "badge bg-primary";
                        if ("ADMIN".equalsIgnoreCase(u.getRole())) roleClass = "badge bg-danger";
                        boolean checked = assignedIdsFix.contains(u.getId());
            %>
                <li>
                    <label class="dropdown-item">
                        <input class="form-check-input me-2 user-checkbox"
                               type="checkbox"
                               name="assignedUserIds"
                               value="<%= u.getId() %>"
                               data-username="<%= displayName %>"
                               <%= checked ? "checked" : "" %> />
                        <%= displayName %> <span class="<%= roleClass %>"><%= u.getRole() %></span>
                    </label>
                </li>
            <%
                    }
                }
            %>
        </ul>
    </div>
</div>

        
        <div class="d-flex justify-content-between">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Save Task</button>
        </div>
    </form>
</div>
<jsp:include page="shared/footer.jsp"/>

<!-- Bootstrap JS (required for dropdowns) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const dropdownBtn = document.getElementById("userDropdown");
    const menu = document.querySelector("#userDropdown + .dropdown-menu");

    function updateButtonText() {
      const names = Array.from(menu.querySelectorAll(".user-checkbox:checked"))
                         .map(cb => cb.dataset.username);
      dropdownBtn.textContent = names.length ? names.join(", ") : "Select Users";
    }

    // Keep dropdown open when clicking inside (safety in case auto-close behavior differs)
    menu.addEventListener("click", function (e) { e.stopPropagation(); });

    // Update button text on selection changes
    menu.addEventListener("change", updateButtonText);

    // Initialize on load (handles edit mode pre-selections)
    updateButtonText();
  });
</script>

</body>
</html>
