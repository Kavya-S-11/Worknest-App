package com.worknest.app.controller;

import com.worknest.app.model.Task;
import com.worknest.app.model.User;
import com.worknest.app.dao.TaskDao;
import com.worknest.app.dao.UserDao;
import com.worknest.app.model.Comment;
import com.worknest.app.service.TaskService;
import com.worknest.app.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private TaskService taskService;
    
    @Autowired
    private TaskDao taskDAO;

    @Autowired
    private UserDao userDAO;

    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        Long userId = loggedInUser.getId(); // get ID from object
        
        List<Task> tasks = userService.getTasksForUser(userId);
        model.addAttribute("tasks", tasks);
        return "userDashboard";
    }

    @PostMapping("/updateStatus")
    public String updateTaskStatus(@RequestParam(name = "taskId") Long taskId,
                                   @RequestParam(name = "status") String status,
                                   HttpSession session) {
        userService.updateTaskStatus(taskId, status);
        return "redirect:/user/dashboard";
    }

    @PostMapping("/addComment")
    public String addComment(@RequestParam(name = "taskId") Long taskId,
                             @RequestParam(name = "message") String message,
                             HttpSession session) {
    	User loggedInUser = (User) session.getAttribute("loggedInUser");
        Long userId = loggedInUser.getId();
//        
//        Task task = taskDAO.getTaskById(taskId);
//        User user = userDAO.getUserById(userId);
//        
//        Comment comment = new Comment();
//        comment.setTask(task);
//        comment.setUser(user);
//        comment.setMessage(message);
//        comment.setCreatedAt(new java.util.Date());
        taskService.addComment(taskId, userId, message);
        return "redirect:/user/dashboard";
    }
}
