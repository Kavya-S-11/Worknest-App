package com.worknest.app.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.worknest.app.model.Comment;
import com.worknest.app.model.Task;
import com.worknest.app.model.User;


@Repository
public class UserDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public User findByUsername(String username) {
        Query<User> query = getSession().createQuery(
            "from User where username = :username", User.class);
        query.setParameter("username", username);
        return query.uniqueResult();
    }

    public User findByEmail(String email) {
        Query<User> query = getSession().createQuery(
            "from User where email = :email", User.class);
        query.setParameter("email", email);
        return query.uniqueResult();
    }

    public void save(User user) {
        getSession().save(user);
    }
    
    public User findByEmailAndPhone(String email, String phoneNumber) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM User u WHERE u.email = :email AND u.phoneNumber = :phone";
        Query<User> query = session.createQuery(hql, User.class);
        query.setParameter("email", email);
        query.setParameter("phone", phoneNumber);
        return query.uniqueResult();
    }

    public void update(User user) {
        sessionFactory.getCurrentSession().update(user);
    }
    public User getUserById(Long id) {
        return getSession().get(User.class, id);
    }

    public List<User> getAllUsers() {
        return getSession().createQuery("from User", User.class).list();
    }
    
    public List<User> getUsersByIds(List<Long> ids) {
        String hql = "FROM User u WHERE u.id IN (:ids)";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, User.class)
                .setParameterList("ids", ids)
                .getResultList();
    }

    public List<Task> getTasksForUser(Long userId) {
        return sessionFactory.getCurrentSession()
                .createQuery("select distinct t from Task t left join fetch t.comments left join fetch t.assignedUsers u where u.id = :uid", Task.class)
                .setParameter("uid", userId)
                .list();
    }

    public void updateTaskStatus(Long taskId, String status) {
        Task task = sessionFactory.getCurrentSession().get(Task.class, taskId);
        if (task != null) {
            task.setStatus(status);
            task.setLastUpdated(java.time.LocalDateTime.now());
            sessionFactory.getCurrentSession().update(task);
        }
    }

    @SuppressWarnings("deprecation")
	public void addComment(Comment comment) {
    	getSession().save(comment);
    }
    
    public List<Task> getTasksByUserId(Long userId) {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT t FROM Task t JOIN t.assignedUsers u WHERE u.id = :userId", Task.class)
                .setParameter("userId", userId)
                .getResultList();
    }

}
