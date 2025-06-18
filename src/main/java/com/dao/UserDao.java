package com.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.entities.User;

public class UserDao {
	public void saveUser(User user) {
		Transaction transaction = null;
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			transaction = session.beginTransaction();
			session.save(user);
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		}
	}

	public User getUserByEmail(String email) {
		// Open a connection to the database
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {

			// Write a query to find the user by email
			String hql = "FROM User WHERE email = :email";

			// Create the query and set the email value
			Query<User> query = session.createQuery(hql, User.class);
			query.setParameter("email", email);

			// Get the single result (or null if not found)
			User user = query.uniqueResult();

			// Return the found user
			return user;

		} catch (Exception e) {
			// If there's an error, print it and return null
			e.printStackTrace();
			return null;
		}
	}

}