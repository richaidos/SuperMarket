package com.supermarket.dao.implementations;

import com.supermarket.dao.interfaces.TransactionHistoryInterface;
import com.supermarket.models.Items;
import com.supermarket.models.TransactionHistory;
import com.supermarket.models.Users;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;


public class TransactionHistoryInterfaceImpl implements TransactionHistoryInterface {

    private SessionFactory sessionFactory;
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void addTransactionHistory(TransactionHistory history){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.save(history);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public void deleteTransactionHistory(TransactionHistory history){
        try{
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.remove(history);
            transaction.commit();
            session.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public List<TransactionHistory> transactionHistoryList(){
        List<TransactionHistory> transactionHistoryList = null;
        try{
            Session session = sessionFactory.openSession();
            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<TransactionHistory> criteriaQuery = builder.createQuery(TransactionHistory.class);
            Root<TransactionHistory> transactionHistoryRoot = criteriaQuery.from(TransactionHistory.class);
            criteriaQuery.select(transactionHistoryRoot);
            criteriaQuery.orderBy(builder.desc(transactionHistoryRoot.get("transactionTime")));
            Query query = session.createQuery(criteriaQuery);
            transactionHistoryList = query.getResultList();
        }catch (Exception e){
            e.printStackTrace();
        }
        return transactionHistoryList;
    }

    public List<TransactionHistory> transactionHistoryList(Users user){
        List<TransactionHistory> transactionHistoryList = null;
        try{
            Session session = sessionFactory.openSession();

            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<TransactionHistory> criteriaQuery = builder.createQuery(TransactionHistory.class);
            Root<TransactionHistory> historyRoot = criteriaQuery.from(TransactionHistory.class);
            criteriaQuery.select(historyRoot);
            Predicate predicate = builder.equal(historyRoot.get("users"), user);
            criteriaQuery.where(predicate);
            criteriaQuery.orderBy(builder.desc(historyRoot.get("transactionTime")));
            Query query = session.createQuery(criteriaQuery);
            transactionHistoryList = query.getResultList();

        }catch (Exception e){
            e.printStackTrace();
        }
        return transactionHistoryList;
    }

    public List<TransactionHistory> transactionHistoryList(Items item){
        List<TransactionHistory> transactionHistoryList = null;
        try{
            Session session = sessionFactory.openSession();

            CriteriaBuilder builder = session.getCriteriaBuilder();
            CriteriaQuery<TransactionHistory> criteriaQuery = builder.createQuery(TransactionHistory.class);
            Root<TransactionHistory> historyRoot = criteriaQuery.from(TransactionHistory.class);
            criteriaQuery.select(historyRoot);
            Predicate predicate = builder.equal(historyRoot.get("itemId"), item);
            criteriaQuery.where(predicate);
            criteriaQuery.orderBy(builder.desc(historyRoot.get("transactionTime")));
            Query query = session.createQuery(criteriaQuery);
            transactionHistoryList = query.getResultList();

        }catch (Exception e){
            e.printStackTrace();
        }
        return transactionHistoryList;
    }
}
