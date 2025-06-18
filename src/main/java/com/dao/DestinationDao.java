package com.dao;

import org.hibernate.Session;
import org.hibernate.query.Query;
import com.entities.Destination;

import java.util.ArrayList;
import java.util.List;

public class DestinationDao {
    public List<Destination> getAllDestinations() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Destination", Destination.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Destination> searchDestinations(String searchTerm, String country) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Destination WHERE LOWER(name) LIKE :searchTerm";
            if (country != null && !country.isEmpty()) {
                hql += " AND country = :country";
            }
            Query<Destination> query = session.createQuery(hql, Destination.class);
            query.setParameter("searchTerm", "%" + (searchTerm != null ? searchTerm.toLowerCase() : "") + "%");
            if (country != null && !country.isEmpty()) {
                query.setParameter("country", country);
            }
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Destination getDestinationByName(String name) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            if (name == null) {
                System.out.println("DestinationDao: getDestinationByName called with null name");
                return null;
            }
            String trimmedName = name.trim();
            System.out.println("DestinationDao: Querying for destination name: '" + trimmedName + "'");
            Query<Destination> query = session.createQuery(
                "FROM Destination WHERE LOWER(name) = :name", 
                Destination.class
            );
            query.setParameter("name", trimmedName.toLowerCase());
            Destination result = query.uniqueResult();
            System.out.println("DestinationDao: Query result: " + (result != null ? result.getName() : "null"));
            return result;
        } catch (Exception e) {
            System.out.println("DestinationDao: Error querying destination name: '" + name + "'");
            e.printStackTrace();
            return null;
        }
    }
}