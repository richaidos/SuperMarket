package com.supermarket.dao.interfaces;

import com.supermarket.models.Items;
import com.supermarket.models.TransactionHistory;
import com.supermarket.models.Users;

import java.util.List;

public interface TransactionHistoryInterface {
    void addTransactionHistory(TransactionHistory history);
    void deleteTransactionHistory(TransactionHistory history);
    List<TransactionHistory> transactionHistoryList();
    List<TransactionHistory> transactionHistoryList(Users user);
    List<TransactionHistory> transactionHistoryList(Items item);
}
