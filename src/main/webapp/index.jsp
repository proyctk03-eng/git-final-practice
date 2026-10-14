<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.ArrayList, com.codegym.model.Customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Neu customerList chua duoc truyen tu Servlet thi khoi tao truc tiep tren trang JSP
    if (request.getAttribute("customerList") == null) {
        List<Customer> defaultCustomers = new ArrayList<>();
        defaultCustomers.add(new Customer(1, "Mai Văn Hoàn", "1983-08-20", "Hà Nội", "images/customer1.svg"));
        defaultCustomers.add(new Customer(2, "Nguyễn Văn Nam", "1983-08-21", "Bắc Giang", "images/customer2.svg"));
        defaultCustomers.add(new Customer(3, "Nguyễn Thái Hòa", "1983-08-22", "Nam Định", "images/customer3.svg"));
        defaultCustomers.add(new Customer(4, "Trần Đăng Khoa", "1983-08-17", "Hà Tây", "images/customer4.svg"));
        defaultCustomers.add(new Customer(5, "Nguyễn Đình Thi", "1983-08-19", "Hà Nội", "images/customer5.svg"));
        request.setAttribute("customerList", defaultCustomers);
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hiển Thị Danh Sách Khách Hàng</title>
    <style>
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --surface: #ffffff;
            --bg: #f8fafc;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --border-hover: #cbd5e1;
            --row-even: #f8fafc;
            --row-hover: #f1f5f9;
            --badge-bg: #dbeafe;
            --badge-text: #1e40af;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            line-height: 1.6;
            padding: 40px 20px;
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
            background: var(--surface);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.07), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            overflow: hidden;
        }

        .header {
            padding: 28px 32px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #f8fafc 0%, #edf2f7 100%);
        }

        .header-content h1 {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--primary);
            letter-spacing: -0.02em;
            margin-bottom: 4px;
        }

        .header-content p {
            font-size: 0.92rem;
            color: var(--text-muted);
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 14px;
            background-color: var(--badge-bg);
            color: var(--badge-text);
            border-radius: 9999px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            font-size: 0.88rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 16px 20px;
            border: none;
        }

        thead th.text-center, tbody td.text-center {
            text-align: center;
        }

        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background-color 0.15s ease-in-out;
        }

        tbody tr:nth-child(even) {
            background-color: var(--row-even);
        }

        tbody tr:hover {
            background-color: var(--row-hover);
        }

        tbody td {
            padding: 16px 20px;
            font-size: 0.95rem;
            vertical-align: middle;
        }

        .col-stt {
            width: 80px;
            font-weight: 700;
            color: var(--text-muted);
        }

        .customer-name {
            font-weight: 600;
            color: var(--text-main);
        }

        .customer-dob {
            color: #334155;
            font-variant-numeric: tabular-nums;
        }

        .customer-address {
            color: #475569;
        }

        .col-image {
            width: 110px;
        }

        .avatar-img {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 2px solid #ffffff;
            display: block;
            margin: 0 auto;
        }

        .footer-info {
            padding: 18px 32px;
            background-color: #f8fafc;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .footer-info a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .footer-info a:hover {
            text-decoration: underline;
        }

        @media (max-width: 640px) {
            body {
                padding: 16px 10px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                padding: 20px;
            }

            .footer-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                padding: 16px 20px;
            }

            thead th, tbody td {
                padding: 12px 14px;
            }

            .avatar-img {
                width: 44px;
                height: 44px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div class="header-content">
            <h1>Danh Sách Khách Hàng</h1>
            <p>Luyện tập sử dụng thư viện JSTL (c:forEach) trong trang JSP</p>
        </div>
        <div class="header-badge">
            Tổng cộng: 5 khách hàng
        </div>
    </div>

    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th class="text-center col-stt">STT</th>
                    <th>Tên</th>
                    <th>Ngày sinh</th>
                    <th>Địa chỉ</th>
                    <th class="text-center col-image">Ảnh</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="customer" items="${customerList}" varStatus="status">
                    <tr>
                        <td class="text-center col-stt">${status.count}</td>
                        <td class="customer-name">${customer.name}</td>
                        <td class="customer-dob">${customer.dob}</td>
                        <td class="customer-address">${customer.address}</td>
                        <td class="text-center col-image">
                            <img src="${customer.image}" alt="${customer.name}" class="avatar-img">
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="footer-info">
        <span>Bài tập CodeGym: Hiển thị danh sách khách hàng bằng JSTL</span>
        <span>Tác giả: Nguyễn Tuấn Đạt</span>
    </div>
</div>

</body>
</html>
