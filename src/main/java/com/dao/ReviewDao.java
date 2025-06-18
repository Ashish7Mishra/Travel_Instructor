package com.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.entities.Review;

import java.util.ArrayList;
import java.util.List;

public class ReviewDao {
    public void saveReview(Review review) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(review);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<Review> getReviewsByDestinationId(Long destinationId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Review> query = session.createQuery(
                "FROM Review WHERE destination.id = :destinationId ORDER BY createdAt DESC", 
                Review.class
            );
            query.setParameter("destinationId", destinationId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace(); // Replace with logging
            return new ArrayList<>();
        }
    }
}