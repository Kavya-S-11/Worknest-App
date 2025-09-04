package com.worknest.app.controller;

import com.worknest.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ResetPasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/reset-password")
    public String showResetPasswordPage() {
        return "forgot_password"; // your JSP view
    }

    @PostMapping("/reset-password")
    public String resetPassword(HttpServletRequest request) {
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmNewPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            return "forgot_password"; // JSP page name
        }

        boolean updated = userService.resetPassword(email, phone, newPassword);
        if (updated) {
            request.setAttribute("message", "Password reset successful! You can now login.");
        } else {
            request.setAttribute("error", "No user found with the given email and phone number.");
        }

        return "forgot_password"; // Return back to JSP page
    }
}
