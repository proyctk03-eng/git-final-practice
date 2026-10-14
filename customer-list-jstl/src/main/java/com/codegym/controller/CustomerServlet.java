package com.codegym.controller;

import com.codegym.model.Customer;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/customers", "/customer-list"})
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private List<Customer> customerList;

    @Override
    public void init() throws ServletException {
        super.init();
        customerList = new ArrayList<>();
        customerList.add(new Customer(1, "Mai Văn Hoàn", "1983-08-20", "Hà Nội", "images/customer1.svg"));
        customerList.add(new Customer(2, "Nguyễn Văn Nam", "1983-08-21", "Bắc Giang", "images/customer2.svg"));
        customerList.add(new Customer(3, "Nguyễn Thái Hòa", "1983-08-22", "Nam Định", "images/customer3.svg"));
        customerList.add(new Customer(4, "Trần Đăng Khoa", "1983-08-17", "Hà Tây", "images/customer4.svg"));
        customerList.add(new Customer(5, "Nguyễn Đình Thi", "1983-08-19", "Hà Nội", "images/customer5.svg"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("customerList", customerList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
