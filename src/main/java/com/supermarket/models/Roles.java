package com.supermarket.models;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "roles")
public class Roles implements Serializable {

    @Id()
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    public Roles() {

    }

    public Roles(String name) {
        this.name = name;
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
}
