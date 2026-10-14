<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuyen Doi Tien Te - USD sang VND</title>
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
        .converter-container {
            background: #ffffff;
            padding: 40px 32px;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.08), 0 8px 10px -6px rgba(0,0,0,0.04);
            text-align: center;
            max-width: 420px;
            width: 100%;
            border: 1px solid #e2e8f0;
        }
        .badge {
            display: inline-block;
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }
        h2 {
            color: #1b2a7a;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
        }
        .form-group {
            text-align: left;
            margin-bottom: 18px;
        }
        label {
            display: block;
            font-weight: 600;
            color: #334155;
            font-size: 14px;
            margin-bottom: 6px;
        }
        input {
            padding: 12px 14px;
            width: 100%;
            border: 1.5px solid #cbd5e1;
            border-radius: 6px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            font-family: inherit;
        }
        input:focus {
            border-color: #1b2a7a;
            box-shadow: 0 0 0 3px rgba(27, 42, 122, 0.15);
        }
        button {
            background-color: #1b2a7a;
            color: white;
            padding: 14px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-weight: 600;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.2s, transform 0.1s;
        }
        button:hover {
            background-color: #121c54;
            transform: translateY(-1px);
        }
        button:active {
            transform: translateY(0);
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

    <div class="converter-container">
        <span class="badge">JSP Scriptlet &bull; Tomcat 10.1+</span>
        <h2>USD to VND Converter</h2>
        <!-- Form gui du lieu bang phuong thuc POST toi trang converter.jsp -->
        <form action="converter.jsp" method="POST">
            <div class="form-group">
                <label for="rate">Ti gia (VND / USD):</label>
                <input type="number" id="rate" name="rate" placeholder="Vi du: 25000" value="25000" required step="any" min="0"/>
            </div>

            <div class="form-group">
                <label for="usd">Luong USD can doi:</label>
                <input type="number" id="usd" name="usd" placeholder="Nhap so luong USD can doi" required step="any" min="0"/>
            </div>

            <button type="submit">Tinh toan</button>
        </form>

        <div class="footer-text">
            Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong> | CodeGym JSP Practice
        </div>
    </div>

</body>
</html>
