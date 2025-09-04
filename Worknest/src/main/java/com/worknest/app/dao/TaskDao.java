package com.worknest.app.dao;

import com.worknest.app.model.Task;
import com.worknest.app.model.User;
import com.worknest.app.model.Comment;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public class TaskDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    // Add task
    public void saveTask(Task task) {
        getSession().saveOrUpdate(task);
    }

    // Get all tasks
    public List<Task> getAllTasks() {
        return getSession().createQuery(
            "select distinct t from Task t left join fetch t.assignedUsers", Task.class
        ).list();
    }


    // Get task by ID
    public Task getTaskById(Long id) {
        return getSession().get(Task.class, id);
    }

    // Delete task
    public void deleteTask(Long id) {
        Task task = getTaskById(id);
        if (task != null) {
            getSession().delete(task);
        }
    }

    // Assign users to task
    public void assignUsersToTask(Long taskId, Set<User> users) {
        Task task = getTaskById(taskId);
        if (task != null) {
            task.getAssignedUsers().addAll(users);
            getSession().update(task);
        }
    }

    // Remove user from task
    public void removeUserFromTask(Long taskId, Long userId) {
        Task task = getTaskById(taskId);
        if (task != null) {
            task.getAssignedUsers().removeIf(u -> u.getId().equals(userId));
            getSession().update(task);
        }
    }

    // Update task status
    public void updateTaskStatus(Long taskId, String status) {
        Task task = getTaskById(taskId);
        if (task != null) {
            task.setStatus(status);
            getSession().update(task);
        }
    }

    // Add comment to task
    public void addCommentToTask(Comment comment) {
        getSession().save(comment);
    }

    // Get comments by taskId
    public List<Comment> getCommentsForTask(Long taskId) {
        Query<Comment> query = getSession().createQuery("from Comment where task.id = :taskId", Comment.class);
        query.setParameter("taskId", taskId);
        return query.list();
    }
    
    public List<Task> getAllTasksWithComments() {
        return getSession()
            .createQuery("select distinct t from Task t " +
                         "left join fetch t.comments " +
                         "left join fetch t.assignedUsers", Task.class)
            .list();
    }


    public List<Object[]> getTaskStatusCountsRaw() {
        return getSession()
                .createQuery("SELECT t.status, COUNT(t) FROM Task t GROUP BY t.status", Object[].class)
                .getResultList();
    }

    
}
