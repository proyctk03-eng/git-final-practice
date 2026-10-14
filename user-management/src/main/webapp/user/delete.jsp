<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận Xóa User</title>
    <style>
        :root {
            --danger: #c0392b;
            --danger-hover: #a93226;
            --secondary: #95a5a6;
            --secondary-hover: #7f8c8d;
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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            margin: 40px 16px;
            background-color: var(--bg);
            color: var(--text-main);
            text-align: center;
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 480px;
            margin: auto;
            background: var(--surface);
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.07), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        h2 {
            color: var(--danger);
            margin-bottom: 12px;
            font-size: 1.4rem;
        }

        p.desc {
            color: var(--text-muted);
            margin-bottom: 20px;
            font-size: 0.95rem;
        }

        .info-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            padding: 18px;
            border-radius: 8px;
            margin-bottom: 24px;
            text-align: left;
        }

        .info-row {
            display: flex;
            margin-bottom: 8px;
            font-size: 0.92rem;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            width: 100px;
            font-weight: 600;
            color: #475569;
        }

        .info-value {
            flex-grow: 1;
            color: #0f172a;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .btn {
            padding: 10px 22px;
            color: white;
            border: none;
            cursor: pointer;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.92rem;
            display: inline-block;
            transition: background-color 0.15s ease-in-out;
        }

        .btn-delete {
            background-color: var(--danger);
        }

        .btn-delete:hover {
            background-color: var(--danger-hover);
        }

        .btn-cancel {
            background-color: var(--secondary);
        }

        .btn-cancel:hover {
            background-color: var(--secondary-hover);
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Xác Nhận Xóa User!</h2>
    <p class="desc">Bạn có chắc chắn muốn xóa User này khỏi hệ thống cơ sở dữ liệu vĩnh viễn không?</p>
    
    <div class="info-box">
        <div class="info-row">
            <span class="info-label">Mã ID:</span>
            <span class="info-value">#${requestScope.user.id}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Tên User:</span>
            <span class="info-value"><strong>${requestScope.user.name}</strong></span>
        </div>
        <div class="info-row">
            <span class="info-label">Email:</span>
            <span class="info-value">${requestScope.user.email}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Quốc gia:</span>
            <span class="info-value">${requestScope.user.country}</span>
        </div>
    </div>
    
    <form action="${pageContext.request.contextPath}/users?action=delete" method="post">
        <input type="hidden" name="id" value="${requestScope.user.id}" />
        <div class="btn-group">
            <button type="submit" class="btn btn-delete">Đồng ý Xóa</button>
            <a href="${pageContext.request.contextPath}/users" class="btn btn-cancel">Hủy bỏ</a>
        </div>
    </form>
</div>

</body>
</html>
