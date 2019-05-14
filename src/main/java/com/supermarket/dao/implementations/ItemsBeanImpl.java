package com.supermarket.dao.implementations;

import com.supermarket.dao.interfaces.ItemsBean;
import com.supermarket.models.Items;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class ItemsBeanImpl  implements ItemsBean {
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void addOrUpdateItem(Items item){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.saveOrUpdate(item);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void deleteItem(Items item){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.remove(item);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public List<Items> itemsList(){
        List<Items> itemsList = null;
        try{
            Session session = sessionFactory.openSession();
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<Items> criteriaQuery = builder.createQuery(Items.class);
            Root<Items> itemsRoot = criteriaQuery.from(Items.class);
            criteriaQuery.select(itemsRoot);
            criteriaQuery.orderBy(builder.asc(itemsRoot.get("id")));
            Query query = session.createQuery(criteriaQuery);
            itemsList = query.getResultList();
        }catch (Exception e){
            e.printStackTrace();
        }
        return itemsList;
    }

    public Items getItemByUniCode (int universalProductCode){
        Items item = null;
        try{
            Session session = sessionFactory.openSession();
            Criteria crit = session.createCriteria(Items.class);
            crit.add(Restrictions.eq("universalProductCode", universalProductCode));
            item = (Items)crit.uniqueResult();
            session.close();
            return item;
        }catch (Exception e){
            System.out.println();
            e.printStackTrace();
        }
        return item;
    }

    public Items getItemsById (Long id){
        Items item = null;
        try{
            Session session = sessionFactory.openSession();

            Criteria crit = session.createCriteria(Items.class);
            crit.add(Restrictions.eq("id", id));
            item = (Items)crit.uniqueResult();
            session.close();
            return item;

        }catch (Exception e){
            System.out.println();
            e.printStackTrace();
        }
        return item;
    }

}
