package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

public interface IUserDAO {
    void insertUser(User user) throws SQLException;

    User selectUser(int id);

    List<User> selectAllUsers();

    boolean deleteUser(int id) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    // Search & Sort
    List<User> searchByCountry(String country);

    List<User> sortByName();

    // MySQL Stored Procedure
    User getUserById(int id);

    void insertUserStore(User user) throws SQLException;

    // Transaction Management
    void addUserTransaction(User user, int[] permissionIds) throws SQLException;

    // Test Without Transaction
    void insertUpdateWithoutTransaction() throws SQLException;

    // Test With Transaction (JDBC Transaction All-or-Nothing)
    void insertUpdateUseTransaction();

    // MySQL Stored Procedures (Exercise: List, Update, Delete)
    List<User> selectAllUsersSP();

    boolean updateUserSP(User user) throws SQLException;

    boolean deleteUserSP(int id) throws SQLException;
}

