package com.supermarket.dao.interfaces;

import com.supermarket.models.Roles;
import com.supermarket.models.Users;

import javax.management.relation.Role;
import java.util.List;

public interface UserBean {
    void addOrUpdateUser(Users user);
    void deleteUser(Users user);
    Users getUser (String login, String password);
    Users getUser (String login); //needs for ajax
    Users getUser (Long id); //needs for edit
    List<Users> usersList(Roles role); //Only cashiers

}
