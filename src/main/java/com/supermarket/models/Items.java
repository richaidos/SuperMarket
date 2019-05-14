package com.supermarket.models;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "items")
public class Items{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "universal_product_code", length = 10, unique = true)
    private int universalProductCode;
    @Column(name = "price")
    private double price;
    @Column(name = "amounts")
    private int amounts;

    public Items() {
    }

    public Items(String name, int universalProductCode, double price, int amounts) {
        this.name = name;
        this.universalProductCode = universalProductCode;
        this.price = price;
        this.amounts = amounts;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUniversalProductCode() {
        return universalProductCode;
    }

    public void setUniversalProductCode(int universalProductCode) {
        this.universalProductCode = universalProductCode;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAmounts() {
        return amounts;
    }

    public void setAmounts(int amounts) {
        this.amounts = amounts;
    }
}
