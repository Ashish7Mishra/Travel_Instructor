package com.dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import com.entities.User;
import com.entities.Destination;
import com.entities.Review;
import com.entities.Booking;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration()
                .configure("hibernate.cfg.xml")
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Destination.class)
                .addAnnotatedClass(Review.class)
                .addAnnotatedClass(Booking.class)
                .buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        getSessionFactory().close();
    }
}