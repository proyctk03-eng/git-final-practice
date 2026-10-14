<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iNotes Dashboard - Quản lý Ghi Chú Cá Nhân</title>
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
        .strategy-banner {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: white;
            border-radius: 12px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1);
        }
        .strategy-pill {
            display: inline-flex;
            align-items: center;
            padding: 0.35rem 0.85rem;
            border-radius: 50rem;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .pill-db {
            background-color: rgba(16, 185, 129, 0.2);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.4);
        }
        .pill-file {
            background-color: rgba(245, 158, 11, 0.2);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.4);
        }
        .card-table {
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
        }
        .table > thead {
            background-color: #f1f5f9;
        }
        .table > thead th {
            font-weight: 600;
            color: #475569;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 0.85rem 1rem;
            border-bottom: 1px solid #e2e8f0;
        }
        .table > tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        .badge-type {
            font-size: 0.75rem;
            padding: 0.35rem 0.65rem;
            font-weight: 600;
            border-radius: 6px;
        }
        .badge-work { background-color: #e0e7ff; color: #4338ca; }
        .badge-study { background-color: #fef3c7; color: #b45309; }
        .badge-personal { background-color: #dcfce7; color: #15803d; }
        .badge-default { background-color: #f1f5f9; color: #475569; }
        .action-link {
            text-decoration: none;
            font-weight: 600;
            font-size: 0.875rem;
            margin: 0 0.25rem;
        }
        .action-view { color: #0284c7; }
        .action-edit { color: #d97706; }
        .action-delete { color: #dc2626; }
        .action-view:hover { color: #0369a1; text-decoration: underline; }
        .action-edit:hover { color: #b45309; text-decoration: underline; }
        .action-delete:hover { color: #b91c1c; text-decoration: underline; }
        .search-container {
            display: flex;
            gap: 0.75rem;
        }
    </style>
</head>
<body>

    <!-- Header / Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm py-3 mb-4">
        <div class="container">
            <a class="navbar-brand fs-4" href="notes">iNotes App</a>
            <span class="text-muted small">Personal Note Management System (Strategy Pattern)</span>
            <div class="ms-auto d-flex align-items-center gap-2">
                <span class="badge bg-light text-dark border">Phát triển: Nguyễn Tuấn Đạt</span>
            </div>
        </div>
    </nav>

    <div class="container mb-5">

        <!-- Strategy Control Banner -->
        <div class="strategy-banner d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="text-secondary small text-uppercase fw-bold">Strategy Pattern Runtime</span>
                    <c:choose>
                        <c:when test="${isDB}">
                            <span class="strategy-pill pill-db">MySQL Database Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="strategy-pill pill-file">Flat File (notes.txt) Active</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="small text-light text-opacity-75">
                    Tầng lưu trữ hiện hành: <strong>${currentStrategyName}</strong>. 
                    Bạn có thể chuyển đổi linh hoạt tầng lưu trữ mà không làm gián đoạn hệ thống.
                </div>
            </div>
            <div class="d-flex gap-2">
                <c:choose>
                    <c:when test="${isDB}">
                        <a href="notes?action=switch-strategy&type=FILE" class="btn btn-warning btn-sm fw-semibold">
                            Chuyển sang File Lưu Trữ (notes.txt)
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="notes?action=switch-strategy&type=DB" class="btn btn-success btn-sm fw-semibold">
                            Chuyển sang Cơ sở dữ liệu (MySQL)
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Alert messages -->
        <c:if test="${param.message == 'created'}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                Thêm mới ghi chú thành công vào <strong>${currentStrategyName}</strong>!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.message == 'updated'}">
            <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
                Cập nhật thông tin ghi chú thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.message == 'deleted'}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                Đã xóa bỏ ghi chú khỏi hệ thống!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.message == 'strategy_switched'}">
            <div class="alert alert-primary alert-dismissible fade show shadow-sm" role="alert">
                Đã chuyển đổi thành công tầng lưu trữ sang: <strong>${currentStrategyName}</strong>!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Dashboard Header & Toolbar (Tim kiem + Them moi) -->
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <div>
                <h4 class="fw-bold mb-0 text-slate-800">Danh Sách Ghi Chú (iNotes Dashboard)</h4>
                <p class="text-muted small mb-0">Quản lý, tìm kiếm và phân loại các ghi chú cá nhân thường nhật</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <!-- Search form -->
                <form action="notes" method="get" class="search-container">
                    <input type="hidden" name="action" value="search" />
                    <input type="text" name="keyword" class="form-control form-control-sm" 
                           placeholder="Tìm kiếm tiêu đề hoặc nội dung..." value="<c:out value='${keyword}'/>" style="min-width: 260px;" />
                    <button type="submit" class="btn btn-outline-secondary btn-sm fw-semibold">Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="notes" class="btn btn-outline-danger btn-sm" title="Hủy tìm kiếm">Xóa lọc</a>
                    </c:if>
                </form>

                <!-- Button Them Moi -->
                <a href="notes?action=create" class="btn btn-primary btn-sm fw-semibold d-inline-flex align-items-center">
                    + Thêm Mới
                </a>
            </div>
        </div>

        <c:if test="${not empty keyword}">
            <div class="alert alert-light border py-2 px-3 small mb-3">
                Kết quả tìm kiếm cho từ khóa: <strong>"<c:out value="${keyword}"/>"</strong> (Tìm thấy ${notes.size()} ghi chú)
            </div>
        </c:if>

        <!-- Table Danh sach Ghi chu -->
        <div class="card-table">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th style="width: 60px;" class="text-center">#</th>
                            <th>Tiêu đề</th>
                            <th style="width: 180px;">Phân loại</th>
                            <th style="width: 200px;" class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty notes}">
                                <c:forEach var="note" items="${notes}" varStatus="status">
                                    <tr>
                                        <td class="text-center text-muted fw-semibold">${note.id}</td>
                                        <td>
                                            <a href="notes?action=view&id=${note.id}" class="text-decoration-none text-dark fw-semibold">
                                                <c:out value="${note.title}"/>
                                            </a>
                                            <div class="text-muted small text-truncate" style="max-width: 500px;">
                                                <c:out value="${note.content}"/>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${note.typeId == 1}">
                                                    <span class="badge-type badge-personal">Cá nhân</span>
                                                </c:when>
                                                <c:when test="${note.typeId == 2}">
                                                    <span class="badge-type badge-work">Công việc</span>
                                                </c:when>
                                                <c:when test="${note.typeId == 3}">
                                                    <span class="badge-type badge-study">Học tập</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-type badge-default"><c:out value="${note.typeName}"/></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="notes?action=view&id=${note.id}" class="action-link action-view">Xem</a>
                                            <span class="text-muted">|</span>
                                            <a href="notes?action=edit&id=${note.id}" class="action-link action-edit">Sửa</a>
                                            <span class="text-muted">|</span>
                                            <a href="notes?action=delete&id=${note.id}" class="action-link action-delete"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa ghi chú này không?');">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <div>Chưa có ghi chú nào trong tầng lưu trữ <strong>${currentStrategyName}</strong>.</div>
                                        <div class="mt-2">
                                            <a href="notes?action=create" class="btn btn-outline-primary btn-sm">+ Thêm Ghi Chú Đầu Tiên</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mt-3 text-muted small text-end">
            Tổng cộng: <strong>${notes.size()}</strong> ghi chú | Chế độ: <strong>${currentStrategyName}</strong>
        </div>

    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
