package com.supermarket.models;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "transaction_history")
public class TransactionHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private Items itemId;

    @ManyToOne
    @JoinColumn(name = "cashier_id")
    private Users users;

    @Column(name = "amount")
    private int amount;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "transaction_time")
    private Date transactionTime;

    public TransactionHistory() {
    }

    public TransactionHistory(Items itemId, Users users, int amount, Date transactionTime) {
        this.itemId = itemId;
        this.users = users;
        this.amount = amount;
        this.transactionTime = transactionTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Items getItemId() {
        return itemId;
    }

    public void setItemId(Items itemId) {
        this.itemId = itemId;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(Date transactionTime) {
        this.transactionTime = transactionTime;
    }
}
