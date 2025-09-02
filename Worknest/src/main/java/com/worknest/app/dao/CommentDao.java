package com.worknest.app.dao;

import com.worknest.app.model.Comment;
import com.worknest.app.model.Task;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentDao {

    @Autowired
    private SessionFactory sessionFactory;

 // Save a comment
    public void save(Comment comment) {
        sessionFactory.getCurrentSession().saveOrUpdate(comment);
    }

    // Get all comments for a task
    @SuppressWarnings("unchecked")
    public List<Comment> getCommentsByTask(Task task) {
        return sessionFactory.getCurrentSession()
                .createQuery("from Comment c where c.task = :task order by c.createdAt asc")
                .setParameter("task", task)
                .list();
    }
}
