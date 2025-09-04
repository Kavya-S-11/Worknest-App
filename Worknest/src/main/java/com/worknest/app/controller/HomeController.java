package com.worknest.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "welcome"; // corresponds to /WEB-INF/views/welcome.jsp
    }
}
