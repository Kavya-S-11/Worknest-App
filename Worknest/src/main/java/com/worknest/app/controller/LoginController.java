package com.worknest.app.controller;

import com.worknest.app.model.User;
import com.worknest.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    // Display login page
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    // Handle login form submission
    @PostMapping("/login")
    public ModelAndView login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session
    ) {
        ModelAndView mv = new ModelAndView();
        User user = userService.login(username, password); // plain-text comparison
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            // Redirect based on role
            if ("ADMIN".equals(user.getRole())) {
                mv.setViewName("redirect:/admin/dashboard");
            } else {
                mv.setViewName("redirect:/user/dashboard");
            }
        } else {
            mv.addObject("error", "Invalid username or password");
            mv.setViewName("login"); // show login page again
        }
        return mv;
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // remove all session attributes
        return "redirect:/login"; // redirect to login page
    }
}
