package com.worknest.app.service;

import com.worknest.app.dao.CommentDao;
import com.worknest.app.model.Comment;
import com.worknest.app.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CommentService {

    @Autowired
    private CommentDao cdao;

    public void save(Comment comment) {
        cdao.save(comment);
    }

    public List<Comment> getCommentsByTask(Task task) {
        return cdao.getCommentsByTask(task);
    }
}
