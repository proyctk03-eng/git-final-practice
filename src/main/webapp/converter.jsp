<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ket Qua Chuyen Doi - USD to VND</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f8fafc;
            color: #1e293b;
            padding: 20px;
        }
        .result-container {
            background: #ffffff;
            padding: 40px 32px;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.08), 0 8px 10px -6px rgba(0,0,0,0.04);
            text-align: center;
            max-width: 440px;
            width: 100%;
            border: 1px solid #e2e8f0;
        }
        h2 {
            color: #1b2a7a;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 24px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 15px;
            color: #475569;
        }
        .detail-row strong {
            color: #0f172a;
        }
        .success-box {
            background-color: #f0fdf4;
            border: 1px solid #dcfce7;
            border-left: 4px solid #16a34a;
            padding: 18px;
            border-radius: 8px;
            margin-top: 24px;
            text-align: center;
        }
        .success-label {
            font-size: 13px;
            color: #15803d;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .success-value {
            font-size: 24px;
            font-weight: 700;
            color: #16a34a;
        }
        .error-box {
            background-color: #fef2f2;
            border: 1px solid #fee2e2;
            border-left: 4px solid #ef4444;
            padding: 18px;
            border-radius: 8px;
            margin-top: 24px;
            text-align: left;
        }
        .error-title {
            color: #b91c1c;
            font-weight: 700;
            font-size: 16px;
            margin-bottom: 4px;
        }
        .error-desc {
            color: #7f1d1d;
            font-size: 14px;
        }
        .back-btn {
            display: block;
            text-decoration: none;
            padding: 12px 24px;
            background-color: #1b2a7a;
            color: white;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            margin-top: 24px;
            transition: background-color 0.2s;
        }
        .back-btn:hover {
            background-color: #121c54;
        }
        .footer-text {
            margin-top: 24px;
            padding-top: 16px;
            border-top: 1px solid #f1f5f9;
            font-size: 12px;
            color: #94a3b8;
        }
    </style>
</head>
<body>

    <div class="result-container">
        <h2>KET QUA CHUYEN DOI TIEN TE</h2>

        <%-- Mo the Scriptlet de thuc thi ma Java xu ly du lieu --%>
        <%
            DecimalFormat dfCurrency = new DecimalFormat("#,##0.##");
            DecimalFormat dfVND = new DecimalFormat("#,##0");

            try {
                // Lay du lieu tu Request va ep kieu
                float rate = Float.parseFloat(request.getParameter("rate"));
                float usd = Float.parseFloat(request.getParameter("usd"));

                if (rate < 0 || usd < 0) {
                    throw new IllegalArgumentException("Gia tri khong duoc am.");
                }

                // Tinh toan
                float vnd = rate * usd;
        %>

        <%-- In ket qua binh thuong bang the Expression --%>
        <div class="detail-row">
            <span>Ti gia quy doi:</span>
            <strong><%= dfCurrency.format(rate) %> VND / USD</strong>
        </div>
        <div class="detail-row">
            <span>Luong USD chuyen doi:</span>
            <strong>$<%= dfCurrency.format(usd) %></strong>
        </div>

        <div class="success-box">
            <div class="success-label">Thanh tien quy doi:</div>
            <div class="success-value"><%= dfVND.format(vnd) %> VND</div>
        </div>

        <%-- Xu ly khoi ngoai le neu co loi nhap lieu --%>
        <%
            } catch (Exception e) {
        %>

        <div class="error-box">
            <div class="error-title">Loi xu ly du lieu!</div>
            <div class="error-desc">Du lieu dau vao khong hop le hoac bi bo trong. Vui long kiem tra lai gia tri ti gia va so luong USD.</div>
        </div>

        <%
            }
        %>
        <%-- Ket thuc ma Java --%>

        <a href="index.jsp" class="back-btn">Quay lai trang chu</a>

        <div class="footer-text">
            Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong> | CodeGym JSP Practice
        </div>
    </div>

</body>
</html>
