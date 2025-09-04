package com.worknest.app.controller;

import com.worknest.app.model.User;
import com.worknest.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

//    @PostMapping("/register")
//    public String registerUser(@ModelAttribute("user") User user, Model model) {
//        String message = userService.registerUser(user);
//        model.addAttribute("message", message);
//        return "register";
//    }
    
    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, Model model) {
        System.out.println(">>> RegisterController called");
        String message = userService.registerUser(user);
        System.out.println(">>> Service returned: " + message);
        model.addAttribute("message", message);
        return "register";
    }

}
