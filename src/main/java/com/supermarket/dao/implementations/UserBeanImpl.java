package com.supermarket.dao.implementations;

import com.supermarket.dao.interfaces.RoleBean;
import com.supermarket.dao.interfaces.UserBean;
import com.supermarket.models.Roles;
import com.supermarket.models.Users;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import javax.management.relation.Role;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

public class UserBeanImpl implements UserBean {
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void addOrUpdateUser(Users user){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.saveOrUpdate(user);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void deleteUser(Users user){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.remove(user);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public Users getUser (String login, String password){
        Users currentUser = null;
        try{
            Session session = sessionFactory.openSession();

            Criteria crit = session.createCriteria(Users.class);
            crit.add(Restrictions.eq("login", login));
            crit.add(Restrictions.eq("password", password));
            currentUser = (Users)crit.uniqueResult();
            session.close();
            return currentUser;

        }catch (Exception e){
            System.out.println();
            e.printStackTrace();
        }
        return currentUser;
    }
    public Users getUser (String login){
        Users currentUser = null;
        try{
            Session session = sessionFactory.openSession();

            Criteria crit = session.createCriteria(Users.class);
            crit.add(Restrictions.eq("login", login));
            currentUser = (Users)crit.uniqueResult();
            session.close();
            return currentUser;

        }catch (Exception e){
            System.out.println();
            e.printStackTrace();
        }
        return currentUser;
    }
    public Users getUser (Long id){
        Users currentUser = null;
        try{
            Session session = sessionFactory.openSession();

            Criteria crit = session.createCriteria(Users.class);
            crit.add(Restrictions.eq("id", id));
            currentUser = (Users)crit.uniqueResult();
            session.close();
            return currentUser;

        }catch (Exception e){
            System.out.println();
            e.printStackTrace();
        }
        return currentUser;
    }

    public List<Users> usersList(Roles role){
        List<Users> usersList = null;
        try{
            Session session = sessionFactory.openSession();

            CriteriaBuilder builder = session.getCriteriaBuilder();

            CriteriaQuery<Users> criteriaQuery = builder.createQuery(Users.class);
            Root<Users> usersRootRoot = criteriaQuery.from(Users.class);

            criteriaQuery.select(usersRootRoot);
            Predicate predicate = builder.equal(usersRootRoot.get("role"), role);
            criteriaQuery.where(predicate);
            Query query = session.createQuery(criteriaQuery);
            usersList = query.getResultList();

        }catch (Exception e){
            e.printStackTrace();
        }
        return usersList;
    }




}
