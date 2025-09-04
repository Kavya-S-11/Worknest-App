package com.worknest.app.controller;

import com.worknest.app.model.Comment;
import com.worknest.app.model.Task;
import com.worknest.app.model.User;
import com.worknest.app.service.TaskService;
import com.worknest.app.service.UserService;

import jakarta.servlet.http.HttpSession;

import com.worknest.app.service.CommentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private TaskService taskService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    
    @GetMapping("/createTask")
    public String createTaskForm(Model model, HttpSession session) {
        List<User> allUsers = userService.getAllUsers();
        
        // Get logged-in user from session
        User currentUser = (User) session.getAttribute("loggedInUser");

        model.addAttribute("allUsers", allUsers);
        model.addAttribute("currentUser", currentUser); // for "Myself"
        return "createTask"; // or editTask
    }


    // Save new task
    @PostMapping("/saveTask")
    public String saveTask(
    		@RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("status") String status,
            @RequestParam("startDate") String startDate,
            @RequestParam("dueDate") String dueDate,
            @RequestParam(name = "assignedUserIds", required = false) List<Long> assignedUserIds,
            HttpSession session) {
        
    	Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        task.setStartDate(LocalDate.parse(startDate));
        task.setDueDate(LocalDate.parse(dueDate));

        User admin = (User) session.getAttribute("loggedInUser");
        if (admin != null) {
            task.setAssignedBy(admin);
        }

        
        if (assignedUserIds != null) {
            Set<User> users = userService.getUsersByIds(assignedUserIds);
            task.setAssignedUsers(users);
        }

        taskService.saveTask(task);
        return "redirect:/admin/dashboard";
    }


    // Delete task
    @GetMapping("/deleteTask/{id}")
    public String deleteTask(@PathVariable("id") Long id) {
        taskService.deleteTask(id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/dashboard")
    public String showAdminDashboard(Model model) {
        Map<String, Long> statusCounts = taskService.getTaskStatusCounts();
        model.addAttribute("statusCounts", statusCounts);
        
        // Fetch tasks with assigned users and comments
        List<Task> tasks = taskService.getAllTasksWithComments();

        model.addAttribute("tasks", tasks);

        return "adminDashboard";
    }


    
 // Show Edit Task form
    @GetMapping("/editTask")
    public String editTask(@RequestParam("id") Long taskId, Model model) {
        Task task = taskService.getTaskById(taskId);
        
        // Initialize assignedUsers to avoid lazy-loading issues
        task.getAssignedUsers().size();

        List<User> allUsers = userService.getAllUsers();

        
        model.addAttribute("task", task);
        model.addAttribute("allUsers", allUsers);
        
        return "editTask";
    }
    
    @PostMapping("/updateTask")
    public String updateTask(
            @RequestParam("id") Long taskId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("status") String status,
            @RequestParam("startDate") String startDate,
            @RequestParam("dueDate") String dueDate,
            @RequestParam(value = "assignedUsers", required = false) List<Long> assignedUserIds) {

        Task task = taskService.getTaskById(taskId);
        if (task != null) {
            task.setTitle(title);
            task.setDescription(description);
            task.setStatus(status);
            task.setStartDate(LocalDate.parse(startDate));
            task.setDueDate(LocalDate.parse(dueDate));

            if (assignedUserIds != null) {
                Set<User> users = userService.getUsersByIds(assignedUserIds);
                task.setAssignedUsers(users);
            } else {
                task.setAssignedUsers(null); // unassign all if none selected
            }

            taskService.saveTask(task); // update the task
        }

        return "redirect:/admin/dashboard";
    }
    
    @PostMapping("/task/{taskId}/addComment")
    public String addComment(@PathVariable("taskId") Long taskId,
                             @RequestParam("message") String message,
                             HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        Task task = taskService.getTaskById(taskId);

        Comment comment = new Comment();
        comment.setTask(task);
        comment.setUser(currentUser);
        comment.setMessage(message);

        commentService.save(comment);

        return "redirect:/admin/dashboard"; // reload the dashboard
    }

    @GetMapping("/addUser")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        return "addUser";
    }
    @PostMapping("/addUser")
    public String registerUser(@ModelAttribute User user, Model model) {
        String message = userService.registerUser(user);
        model.addAttribute("message", message);
        return "addUser";
    }

}
