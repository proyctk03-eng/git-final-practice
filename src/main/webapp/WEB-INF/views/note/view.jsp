<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Ghi Chú - iNotes</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }
        .navbar-brand {
            font-weight: 700;
            color: #2563eb !important;
            letter-spacing: -0.5px;
        }
        .detail-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 2.5rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            max-width: 720px;
            margin: 0 auto;
        }
        .content-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 1.5rem;
            white-space: pre-wrap;
            line-height: 1.7;
            color: #334155;
            min-height: 160px;
        }
    </style>
</head>
<body>

    <!-- Header / Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm py-3 mb-4">
        <div class="container">
            <a class="navbar-brand fs-4" href="notes">iNotes App</a>
            <div class="ms-auto">
                <a href="notes" class="btn btn-outline-secondary btn-sm">Trở về Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="detail-card">
            <div class="d-flex justify-content-between align-items-start border-bottom pb-3 mb-4">
                <div>
                    <span class="badge bg-secondary mb-2">ID: #${note.id}</span>
                    <h3 class="fw-bold text-slate-800 mb-1"><c:out value="${note.title}"/></h3>
                    <div class="text-muted small">
                        Danh mục: <strong><c:out value="${note.typeName}"/></strong>
                        <c:if test="${not empty note.createdAt}">
                            | Ngày tạo: <c:out value="${note.createdAt}"/>
                        </c:if>
                    </div>
                </div>
                <div class="badge bg-light text-dark border">
                    Tầng lưu trữ: ${currentStrategyName}
                </div>
            </div>

            <div class="mb-4">
                <h6 class="text-muted text-uppercase fw-bold small mb-2">Nội dung ghi chú</h6>
                <div class="content-box"><c:out value="${note.content}"/></div>
            </div>

            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                <a href="notes" class="btn btn-outline-secondary">Trở về danh sách</a>
                <div class="d-flex gap-2">
                    <a href="notes?action=edit&id=${note.id}" class="btn btn-warning text-dark fw-semibold">Sửa ghi chú</a>
                    <a href="notes?action=delete&id=${note.id}" class="btn btn-danger fw-semibold"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa ghi chú này không?');">Xóa ghi chú</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
