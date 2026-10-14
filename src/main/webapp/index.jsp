<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Discount Calculator - Tinh Chiet Khau San Pham</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
            background-color: #f1f5f9;
            color: #0f172a;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 24px 16px;
        }
        .container {
            background-color: #ffffff;
            max-width: 520px;
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }
        .header {
            background-color: #1e293b;
            color: #ffffff;
            padding: 28px 32px;
            text-align: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: -0.5px;
            margin-bottom: 6px;
        }
        .header p {
            color: #94a3b8;
            font-size: 14px;
        }
        .form-body {
            padding: 32px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }
        .input-wrapper {
            position: relative;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px 14px;
            font-size: 15px;
            border: 1.5px solid #cbd5e1;
            border-radius: 6px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            font-family: inherit;
        }
        input[type="text"]:focus,
        input[type="number"]:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .help-text {
            font-size: 12px;
            color: #64748b;
            margin-top: 5px;
        }
        .btn-submit {
            display: block;
            width: 100%;
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            padding: 14px 20px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            margin-top: 28px;
        }
        .btn-submit:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
        }
        .btn-submit:active {
            transform: translateY(0);
        }
        .footer-info {
            padding: 18px 32px;
            background-color: #f8fafc;
            border-top: 1px solid #f1f5f9;
            text-align: center;
            font-size: 13px;
            color: #64748b;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h1>Product Discount Calculator</h1>
            <p>Ung dung tinh toan chiet khau mua hang truc tuyen</p>
        </div>

        <form action="display-discount" method="POST" class="form-body">
            <div class="form-group">
                <label for="description">Product Description (Mo ta san pham):</label>
                <div class="input-wrapper">
                    <input type="text" id="description" name="description" placeholder="Vi du: Laptop Dell XPS 15" required />
                </div>
                <div class="help-text">Ten hoac mo ta chi tiet san pham can mua.</div>
            </div>

            <div class="form-group">
                <label for="price">List Price (Gia niem yet):</label>
                <div class="input-wrapper">
                    <input type="number" id="price" name="price" step="any" min="0" placeholder="Vi du: 1500.00" required />
                </div>
                <div class="help-text">Don gia goc cua san pham truoc khi ap dung chiet khau.</div>
            </div>

            <div class="form-group">
                <label for="discount_percent">Discount Percent (Ty le chiet khau %):</label>
                <div class="input-wrapper">
                    <input type="number" id="discount_percent" name="discount_percent" step="any" min="0" max="100" placeholder="Vi du: 10" required />
                </div>
                <div class="help-text">Phan tram giam gia tu 0 den 100%.</div>
            </div>

            <button type="submit" class="btn-submit">Calculate Discount</button>
        </form>

        <div class="footer-info">
            Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong> &bull; Tomcat 10.1+ Jakarta EE
        </div>
    </div>

</body>
</html>
