<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Mới Sản Phẩm</title>
    <style>
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --success: #16a34a;
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

        .alert-success {
            padding: 12px 20px;
            margin: 20px 32px 0 32px;
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            border-radius: 6px;
            font-size: 0.92rem;
        }

        .alert-danger {
            padding: 12px 20px;
            margin: 20px 32px 0 32px;
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
            border-radius: 6px;
            font-size: 0.92rem;
        }

        form {
            padding: 28px 32px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            color: #334155;
        }

        .form-control {
            width: 100%;
            padding: 10px 14px;
            font-size: 0.95rem;
            border: 1px solid var(--border);
            border-radius: 6px;
            outline: none;
            transition: border-color 0.15s ease-in-out;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 85px;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 28px;
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

        .btn-primary {
            background-color: var(--primary);
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
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
        <h1>Thêm Mới Sản Phẩm</h1>
        <a href="products" class="btn btn-secondary" style="padding: 7px 14px; font-size: 0.85rem;">Quay lại danh sách</a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert-danger">${error}</div>
    </c:if>

    <form method="post" action="products?action=create">
        <div class="form-group">
            <label for="id">Mã sản phẩm (ID):</label>
            <input type="number" id="id" name="id" class="form-control" placeholder="Ví dụ: 7" required>
        </div>

        <div class="form-group">
            <label for="name">Tên sản phẩm:</label>
            <input type="text" id="name" name="name" class="form-control" placeholder="Nhập tên sản phẩm" required>
        </div>

        <div class="form-group">
            <label for="price">Giá sản phẩm (VNĐ):</label>
            <input type="number" id="price" name="price" step="1000" class="form-control" placeholder="Ví dụ: 15000000" required>
        </div>

        <div class="form-group">
            <label for="manufacturer">Nhà sản xuất / Hãng:</label>
            <input type="text" id="manufacturer" name="manufacturer" class="form-control" placeholder="Ví dụ: Apple, Samsung, Sony..." required>
        </div>

        <div class="form-group">
            <label for="description">Mô tả chi tiết:</label>
            <textarea id="description" name="description" class="form-control" placeholder="Mô tả thông số kỹ thuật, tính năng nổi bật..."></textarea>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">Lưu sản phẩm</button>
            <a href="products" class="btn btn-secondary">Hủy bỏ</a>
        </div>
    </form>
</div>

</body>
</html>
