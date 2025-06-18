package com.dao;

import com.entities.Booking;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class BookingDao {
    public void saveBooking(Booking booking) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(booking);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace(); // Replace with logging in production
        }
    }

    public Booking getBookingById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Booking.class, id);
        } catch (Exception e) {
            e.printStackTrace(); // Replace with logging in production
            return null;
        }
    }
}