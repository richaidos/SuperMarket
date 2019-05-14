package com.supermarket.dao.implementations;

import com.supermarket.dao.interfaces.RoleBean;
import com.supermarket.models.Roles;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class RoleBeanImpl implements RoleBean {
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Roles getRoleById(Long id){
        Roles role = null;
        try{
            Session session = sessionFactory.openSession();
            role = session.get(Roles.class, id);
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return role;
    }
}
