<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to WorkNest</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Link to your external stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">

</head>
<body>
    <jsp:include page="shared/header.jsp"/>

    <main>
        <div class="container welcome-container" style="max-width: 700px;">
            <h1>Welcome to WorkNest!</h1>
            <p>
                "Get things done with WorkNest! Assign, track, update, and comment — all in one place.
                 Turn task chaos into organized teamwork and watch your productivity soar."
            </p>
            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg">Login</a>
				<a href="${pageContext.request.contextPath}/register" class="btn btn-secondary btn-lg">Register</a>

            </div>
        </div>
    </main>

    <jsp:include page="shared/footer.jsp"/>

    <!-- Bootstrap JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
