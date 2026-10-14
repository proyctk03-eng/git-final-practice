<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Danh Sách</title>
    <style>
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --success: #16a34a;
            --success-hover: #15803d;
            --danger: #dc2626;
            --danger-hover: #b91c1c;
            --warning: #d97706;
            --info: #0284c7;
            --bg: #f8fafc;
            --surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --border-hover: #cbd5e1;
            --row-even: #f8fafc;
            --row-hover: #f1f5f9;
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
            padding: 32px 16px;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: var(--surface);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.07), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            overflow: hidden;
        }

        .header {
            padding: 24px 32px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #f8fafc 0%, #edf2f7 100%);
            flex-wrap: wrap;
            gap: 16px;
        }

        .header-title h1 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            letter-spacing: -0.02em;
        }

        .header-title p {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-top: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 18px;
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.15s ease-in-out;
        }

        .btn-primary {
            background-color: var(--primary);
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
        }

        .btn-success {
            background-color: var(--success);
            color: #ffffff;
        }

        .btn-success:hover {
            background-color: var(--success-hover);
        }

        .btn-warning {
            background-color: var(--warning);
            color: #ffffff;
        }

        .btn-danger {
            background-color: var(--danger);
            color: #ffffff;
        }

        .btn-danger:hover {
            background-color: var(--danger-hover);
        }

        .btn-secondary {
            background-color: #64748b;
            color: #ffffff;
        }

        .btn-secondary:hover {
            background-color: #475569;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.82rem;
            border-radius: 4px;
        }

        .toolbar {
            padding: 16px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
            background-color: #ffffff;
            flex-wrap: wrap;
            gap: 16px;
        }

        .search-form {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-grow: 1;
            max-width: 480px;
        }

        .search-input {
            width: 100%;
            padding: 8px 14px;
            font-size: 0.9rem;
            border: 1px solid var(--border);
            border-radius: 6px;
            outline: none;
            transition: border-color 0.15s ease-in-out;
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.12);
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
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 18px;
        }

        thead th.text-center, tbody td.text-center {
            text-align: center;
        }

        thead th.text-right, tbody td.text-right {
            text-align: right;
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
            padding: 14px 18px;
            font-size: 0.92rem;
            vertical-align: middle;
        }

        .product-id {
            font-weight: 700;
            color: var(--text-muted);
            width: 60px;
        }

        .product-name a {
            font-weight: 600;
            color: var(--primary);
            text-decoration: none;
        }

        .product-name a:hover {
            text-decoration: underline;
        }

        .product-price {
            font-weight: 700;
            color: #047857;
            font-variant-numeric: tabular-nums;
            white-space: nowrap;
        }

        .product-brand {
            font-weight: 500;
            color: #334155;
        }

        .actions {
            display: flex;
            gap: 6px;
            justify-content: center;
        }

        .badge-brand {
            display: inline-block;
            padding: 3px 10px;
            background-color: #e2e8f0;
            color: #334155;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .empty-state {
            padding: 48px 24px;
            text-align: center;
            color: var(--text-muted);
        }

        .footer-info {
            padding: 16px 32px;
            background-color: #f8fafc;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: var(--text-muted);
            flex-wrap: wrap;
            gap: 8px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div class="header-title">
            <h1>Quản Lý Sản Phẩm</h1>
            <p>Hệ thống quản lý sản phẩm theo kiến trúc MVC</p>
        </div>
        <a href="products?action=create" class="btn btn-primary">+ Tạo sản phẩm mới</a>
    </div>

    <div class="toolbar">
        <form action="products" method="get" class="search-form">
            <input type="hidden" name="action" value="search">
            <input type="text" name="query" class="search-input" placeholder="Tìm kiếm sản phẩm theo tên hoặc hãng..." value="${searchKeyword}">
            <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
            <c:if test="${not empty searchKeyword}">
                <a href="products" class="btn btn-secondary" style="background-color: #94a3b8;">Xóa lọc</a>
            </c:if>
        </form>
        <span style="font-size: 0.88rem; color: var(--text-muted);">
            Tổng cộng: <strong>${products.size()}</strong> sản phẩm
        </span>
    </div>

    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th class="text-center">ID</th>
                    <th>Tên sản phẩm</th>
                    <th class="text-right">Giá niêm yết (VNĐ)</th>
                    <th>Nhà sản xuất</th>
                    <th>Mô tả ngắn</th>
                    <th class="text-center" style="width: 200px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td class="text-center product-id">${product.id}</td>
                                <td class="product-name">
                                    <a href="products?action=view&id=${product.id}">${product.name}</a>
                                </td>
                                <td class="text-right product-price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0" /> đ
                                </td>
                                <td>
                                    <span class="badge-brand">${product.manufacturer}</span>
                                </td>
                                <td style="color: var(--text-muted);">${product.description}</td>
                                <td>
                                    <div class="actions">
                                        <a href="products?action=view&id=${product.id}" class="btn btn-secondary btn-sm" title="Xem chi tiết">Xem</a>
                                        <a href="products?action=edit&id=${product.id}" class="btn btn-warning btn-sm" title="Sửa thông tin">Sửa</a>
                                        <a href="products?action=delete&id=${product.id}" class="btn btn-danger btn-sm" title="Xóa sản phẩm">Xóa</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="empty-state">
                                Không tìm thấy sản phẩm nào phù hợp với yêu cầu tìm kiếm.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="footer-info">
        <span>Bài tập CodeGym: Tạo ứng dụng quản lý sản phẩm theo kiến trúc MVC</span>
        <span>Sinh viên thực hiện: Nguyễn Tuấn Đạt</span>
    </div>
</div>

</body>
</html>
