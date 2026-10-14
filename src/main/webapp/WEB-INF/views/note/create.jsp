<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Mới Ghi Chú - iNotes</title>
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
        .form-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            max-width: 680px;
            margin: 0 auto;
        }
        .form-label {
            font-weight: 600;
            color: #334155;
            font-size: 0.925rem;
            margin-bottom: 0.4rem;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            padding: 0.65rem 0.85rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .storage-indicator {
            font-size: 0.85rem;
            color: #64748b;
            background: #f1f5f9;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
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
        <div class="form-card">
            <div class="border-bottom pb-3 mb-3">
                <h4 class="fw-bold text-slate-800 mb-1">Thêm Mới Ghi Chú</h4>
                <p class="text-muted small mb-0">Nhập thông tin tiêu đề, danh mục và nội dung chi tiết cho ghi chú của bạn</p>
            </div>

            <div class="storage-indicator d-flex justify-content-between align-items-center">
                <span>Lưu vào tầng: <strong>${currentStrategyName}</strong></span>
                <span class="badge bg-primary">Strategy Pattern</span>
            </div>

            <!-- Form Them Moi Ghi Chu -->
            <form action="notes" method="post">
                <input type="hidden" name="action" value="create" />

                <!-- Tiêu đề -->
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề: <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="title" name="title" 
                           placeholder="Ví dụ: Họp giao ban đầu tuần, Ôn tập Design Pattern..." required />
                </div>

                <!-- Phân loại -->
                <div class="mb-3">
                    <label for="typeId" class="form-label">Phân loại: <span class="text-danger">*</span></label>
                    <select class="form-select" id="typeId" name="typeId" required>
                        <c:forEach var="t" items="${noteTypes}">
                            <option value="${t.id}">${t.name} - ${t.description}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Nội dung -->
                <div class="mb-4">
                    <label for="content" class="form-label">Nội dung:</label>
                    <textarea class="form-control" id="content" name="content" rows="6" 
                              placeholder="Nhập nội dung chi tiết ghi chú tại đây..."></textarea>
                </div>

                <!-- Nút thao tác: Lưu Ghi Chú | Hủy bỏ -->
                <div class="d-flex align-items-center gap-2 pt-2 border-top">
                    <button type="submit" class="btn btn-primary fw-semibold px-4">Lưu Ghi Chú</button>
                    <a href="notes" class="btn btn-light border px-4">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
