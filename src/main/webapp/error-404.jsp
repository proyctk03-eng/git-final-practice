<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không Tìm Thấy Sản Phẩm</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 80vh;
            margin: 0;
            padding: 20px;
        }
        .error-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 40px;
            max-width: 480px;
            width: 100%;
            text-align: center;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.07);
            border: 1px solid #e2e8f0;
        }
        h1 {
            font-size: 3rem;
            color: #dc2626;
            margin-bottom: 8px;
        }
        h2 {
            font-size: 1.25rem;
            margin-bottom: 16px;
        }
        p {
            color: #64748b;
            margin-bottom: 24px;
        }
        .btn {
            display: inline-block;
            background-color: #1e3a8a;
            color: #ffffff;
            padding: 10px 24px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="error-card">
    <h1>404</h1>
    <h2>Không tìm thấy sản phẩm</h2>
    <p>Sản phẩm bạn đang tìm kiếm không tồn tại hoặc đã bị xóa khỏi hệ thống.</p>
    <a href="products" class="btn">Quay lại danh sách sản phẩm</a>
</div>
</body>
</html>
