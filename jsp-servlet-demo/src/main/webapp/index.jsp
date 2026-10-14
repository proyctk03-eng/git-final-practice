<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeGym JSP Demo - Thoi Gian He Thong</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            max-width: 580px;
            width: 100%;
            padding: 40px 32px;
            text-align: center;
        }
        .badge {
            display: inline-block;
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            letter-spacing: 0.5px;
        }
        h2 {
            color: #1b2a7a;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
        }
        p.subtitle {
            font-size: 16px;
            color: #64748b;
            margin-bottom: 24px;
        }
        .time-box {
            background-color: #fff7ed;
            border: 1px solid #ffedd5;
            border-left: 4px solid #f15a24;
            padding: 18px 20px;
            border-radius: 8px;
            margin-bottom: 28px;
            text-align: left;
        }
        .time-label {
            font-size: 13px;
            color: #9a3412;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .time-value {
            font-size: 18px;
            font-family: 'Consolas', 'Courier New', monospace;
            color: #c2410c;
            font-weight: 700;
            word-break: break-all;
        }
        .btn {
            display: inline-block;
            background-color: #1b2a7a;
            color: #ffffff;
            padding: 12px 28px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            transition: background-color 0.2s, transform 0.1s;
        }
        .btn:hover {
            background-color: #2a3eb1;
            transform: translateY(-1px);
        }
        .student-info {
            margin-top: 32px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
            font-size: 13px;
            color: #94a3b8;
        }
    </style>
</head>
<body>

    <div class="card">
        <span class="badge">Tomcat 10.1+ / Jakarta EE</span>
        <h2>Chao mung toi lop hoc Java Web!</h2>
        <p class="subtitle">Trang JSP dong duoc bien dich truc tiep boi may chu Web.</p>

        <%-- Xu ly ma Java dong lay thoi gian he thong qua Scriptlet --%>
        <%
            java.util.Date date = new java.util.Date();
        %>

        <div class="time-box">
            <div class="time-label">Thoi gian he thong hien tai:</div>
            <div class="time-value"><%= date %></div>
        </div>

        <a href="hello" class="btn">Di toi HelloServlet</a>

        <div class="student-info">
            Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong> &bull; Du an: jsp-servlet-demo
        </div>
    </div>

</body>
</html>
