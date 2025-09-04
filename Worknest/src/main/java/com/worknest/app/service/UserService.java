package com.worknest.app.service;

import com.worknest.app.dao.UserDao;
import com.worknest.app.model.Comment;
import com.worknest.app.model.Task;
import com.worknest.app.model.User;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    @Transactional
    public String registerUser(User user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return "Username already exists!";
        }

        if (userDao.findByEmail(user.getEmail()) != null) {
            return "Email already registered!";
        }

        userDao.save(user);
        return "Added successfully!";
    }
    
    @Transactional
    public User login(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
    
    @Transactional
    public boolean resetPassword(String email, String phoneNumber, String newPassword) {
        User user = userDao.findByEmailAndPhone(email, phoneNumber);
        if (user != null) {
            user.setPassword(newPassword); // No encryption as per your requirement
            userDao.update(user);
            return true;
        }
        return false;
    }
    
    @Transactional(readOnly = true)
    public User getUserById(Long id) {
        return userDao.getUserById(id);
    }

    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }
    
    @Transactional(readOnly = true)
    public Set<User> getUsersByIds(List<Long> ids) {
        return new HashSet<>(userDao.getUsersByIds(ids));
    }

 // TaskService.java
    @Transactional
    public List<Task> getTasksForUser(Long userId) {
    	return userDao.getTasksByUserId(userId);
    }


    @Transactional
    public void updateTaskStatus(Long taskId, String status) {
        userDao.updateTaskStatus(taskId, status);
    }

    @Transactional
    public void addComment(Comment comment) {
        userDao.addComment(comment);
    }
}
