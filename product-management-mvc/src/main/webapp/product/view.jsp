<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm - ${product.name}</title>
    <style>
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --warning: #d97706;
            --danger: #dc2626;
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
            max-width: 680px;
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
            background: linear-gradient(135deg, #f8fafc 0%, #edf2f7 100%);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--primary);
        }

        .content {
            padding: 32px;
        }

        .badge-brand {
            display: inline-block;
            padding: 4px 12px;
            background-color: #dbeafe;
            color: #1e40af;
            border-radius: 9999px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .product-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        .product-price-box {
            font-size: 1.5rem;
            font-weight: 800;
            color: #047857;
            margin-bottom: 24px;
            padding: 12px 16px;
            background-color: #ecfdf5;
            border-radius: 8px;
            display: inline-block;
        }

        .detail-card {
            border: 1px solid var(--border);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 28px;
        }

        .detail-row {
            display: flex;
            padding: 14px 18px;
            border-bottom: 1px solid var(--border);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-row:nth-child(even) {
            background-color: #f8fafc;
        }

        .detail-label {
            width: 150px;
            font-weight: 600;
            color: #475569;
            font-size: 0.92rem;
        }

        .detail-value {
            flex-grow: 1;
            font-size: 0.95rem;
            color: #0f172a;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
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

        .btn-warning {
            background-color: var(--warning);
            color: #ffffff;
        }

        .btn-danger {
            background-color: var(--danger);
            color: #ffffff;
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
        <h1>Thông Tin Chi Tiết Sản Phẩm</h1>
        <a href="products" class="btn btn-secondary" style="padding: 7px 14px; font-size: 0.85rem;">Quay lại danh sách</a>
    </div>

    <div class="content">
        <span class="badge-brand">Hãng: ${product.manufacturer}</span>
        <h2 class="product-title">${product.name}</h2>
        <div class="product-price-box">
            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0" /> VNĐ
        </div>

        <div class="detail-card">
            <div class="detail-row">
                <span class="detail-label">Mã sản phẩm:</span>
                <span class="detail-value">#${product.id}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Tên sản phẩm:</span>
                <span class="detail-value">${product.name}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Nhà sản xuất:</span>
                <span class="detail-value">${product.manufacturer}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Mô tả chi tiết:</span>
                <span class="detail-value">${product.description}</span>
            </div>
        </div>

        <div class="btn-group">
            <a href="products?action=edit&id=${product.id}" class="btn btn-warning">Chỉnh sửa thông tin</a>
            <a href="products?action=delete&id=${product.id}" class="btn btn-danger">Xóa sản phẩm</a>
            <a href="products" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>
</div>

</body>
</html>
