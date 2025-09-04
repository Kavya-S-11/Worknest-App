<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkNest - Reset Password</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
</head>
<body>
    <jsp:include page="shared/header.jsp"/>

    <main class="d-flex flex-grow-1 justify-content-center align-items-center p-3">
        <div class="container forgot-password-container" style="max-width: 450px;">
            <h2>Reset Your Password</h2>
            <p class="text-center text-muted mb-4">
                Enter your email and phone number to verify your identity, then set a new password.
            </p>

          <%
			    String message = (String) request.getAttribute("message");
			    String error = (String) request.getAttribute("error");
			    if (error != null && !error.isEmpty()) {
			%>
			    <div class="alert alert-danger" role="alert"><%= error %></div>
			<%
			    } else if (message != null && !message.isEmpty()) {
			%>
			    <div class="alert alert-success" role="alert"><%= message %></div>
			<%
			    }
			%>


          <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate>

                <div class="mb-3">
                    <label for="email" class="form-label">Email Address:</label>
                    <input type="email" class="form-control" id="email" name="email" required placeholder="name@example.com">
                </div>
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number:</label>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required placeholder="e.g., +1234567890">
                </div>
                <div class="mb-3">
                    <label for="newPassword" class="form-label">New Password:</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" minlength="4" required>
                </div>
                <div class="mb-3">
                    <label for="confirmNewPassword" class="form-label">Confirm New Password:</label>
                    <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" minlength="4" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Reset Password</button>
            </form>
			<br>
            <div class="login-link text-center">
                <a href="${pageContext.request.contextPath}/login">Remember your password? Log in here.</a>
            </div>
        </div>
    </main>

    <!-- Bootstrap JS CDN (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('.needs-validation');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmNewPassword');

    form.addEventListener('submit', function (event) {
        // Reset custom validity
        confirmPassword.setCustomValidity('');

        // Check password match
        if (newPassword.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity('Passwords do not match.');
        }

        // Bootstrap validation
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }

        form.classList.add('was-validated');
    }, false);
});
</script>
    
</body>
</html>
