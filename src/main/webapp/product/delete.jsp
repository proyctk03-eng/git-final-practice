<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Xóa Sản Phẩm</title>
    <style>
        :root {
            --primary: #1e3a8a;
            --danger: #dc2626;
            --danger-hover: #b91c1c;
            --bg: #f8fafc;
            --surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
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
            max-width: 600px;
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
            background: #fef2f2;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--danger);
        }

        .content {
            padding: 28px 32px;
        }

        .warning-text {
            color: #991b1b;
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 20px;
            padding: 12px 16px;
            background-color: #fee2e2;
            border-left: 4px solid var(--danger);
            border-radius: 4px;
        }

        .product-details {
            border: 1px solid var(--border);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 24px;
        }

        .detail-row {
            display: flex;
            padding: 12px 16px;
            border-bottom: 1px solid var(--border);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-row:nth-child(even) {
            background-color: #f8fafc;
        }

        .detail-label {
            width: 140px;
            font-weight: 600;
            color: #475569;
            font-size: 0.9rem;
        }

        .detail-value {
            flex-grow: 1;
            font-size: 0.95rem;
            color: #0f172a;
        }

        .btn-group {
            display: flex;
            gap: 12px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 22px;
            font-size: 0.92rem;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.15s ease-in-out;
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
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Xác Nhận Xóa Sản Phẩm</h1>
        <a href="products" class="btn btn-secondary" style="padding: 7px 14px; font-size: 0.85rem;">Quay lại danh sách</a>
    </div>

    <div class="content">
        <div class="warning-text">
            Cảnh báo: Hành động này sẽ xóa vĩnh viễn sản phẩm khỏi hệ thống và không thể hoàn tác.
        </div>

        <div class="product-details">
            <div class="detail-row">
                <span class="detail-label">Mã sản phẩm (ID):</span>
                <span class="detail-value"><strong>${product.id}</strong></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Tên sản phẩm:</span>
                <span class="detail-value"><strong>${product.name}</strong></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Giá niêm yết:</span>
                <span class="detail-value" style="color: #047857; font-weight: 700;">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0" /> VNĐ
                </span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Nhà sản xuất:</span>
                <span class="detail-value">${product.manufacturer}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Mô tả:</span>
                <span class="detail-value">${product.description}</span>
            </div>
        </div>

        <form method="post" action="products?action=delete&id=${product.id}">
            <div class="btn-group">
                <button type="submit" class="btn btn-danger">Xác nhận xóa</button>
                <a href="products" class="btn btn-secondary">Hủy bỏ</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
