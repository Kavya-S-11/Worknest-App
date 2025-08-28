package com.worknest.app.service;

import com.worknest.app.dao.TaskDao;
import com.worknest.app.dao.UserDao;
import com.worknest.app.model.Task;
import com.worknest.app.model.User;
import com.worknest.app.model.Comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class TaskService {

    @Autowired
    private TaskDao taskDAO;

    @Autowired
    private UserDao userDAO;

    // Create or update task
    @Transactional
    public void saveTask(Task task) {
        taskDAO.saveTask(task);
    }

    // Get all tasks
    @Transactional(readOnly = true)
    public List<Task> getAllTasks() {
        return taskDAO.getAllTasks();
    }

    // Get task by ID
    @Transactional(readOnly = true)
    public Task getTaskById(Long id) {
        return taskDAO.getTaskById(id);
    }

    // Delete task
    @Transactional
    public void deleteTask(Long id) {
        taskDAO.deleteTask(id);
    }

    // Get all users
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    // Get users by IDs (for assigning)
    @Transactional(readOnly = true)
    public Set<User> getUsersByIds(List<Long> ids) {
        Set<User> users = new HashSet<>();
        for (Long id : ids) {
            User user = userDAO.getUserById(id);
            if (user != null) {
                users.add(user);
            }
        }
        return users;
    }

    // Update task status
    @Transactional
    public void updateTaskStatus(Long taskId, String status) {
        taskDAO.updateTaskStatus(taskId, status);
    }

    // Add comment to a task
    @Transactional
    public void addComment(Long taskId, Long userId, String message) {
        Task task = taskDAO.getTaskById(taskId);
        User user = userDAO.getUserById(userId);

        if (task != null && user != null) {
            Comment comment = new Comment();
            comment.setTask(task);
            comment.setUser(user);
            comment.setMessage(message);
            comment.setCreatedAt(new Date());
//comment.setCreatedAt(java.sql.Date.valueOf(LocalDate.now()));
            taskDAO.addCommentToTask(comment);
        }
    }
    
    @Transactional
    public Map<String, Long> getTaskStatusCounts() {
        List<Object[]> results = taskDAO.getTaskStatusCountsRaw();
        Map<String, Long> counts = new HashMap<>();
        for (Object[] row : results) {
            counts.put((String) row[0], (Long) row[1]);
        }
        return counts;
    }
    
    @Transactional(readOnly = true)
    public List<Task> getAllTasksWithComments() {
        return taskDAO.getAllTasksWithComments();
    }

}
