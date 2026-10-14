<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>User Management Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        .toolbar {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
        }
        .actions a {
            display: inline-block;
            margin-right: 10px;
            padding: 8px 14px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border-radius: 4px;
            font-size: 14px;
        }
        .actions a.btn-sort {
            background-color: #17a2b8;
        }
        .actions a.btn-all {
            background-color: #6c757d;
        }
        .actions a:hover {
            opacity: 0.9;
        }
        .search-box {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .search-box input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 200px;
        }
        .search-box input[type="submit"] {
            padding: 8px 14px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-box input[type="submit"]:hover {
            background-color: #218838;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }
        th, td {
            padding: 10px 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .action-links a {
            margin-right: 8px;
            color: #007bff;
            text-decoration: none;
        }
        .action-links a.delete {
            color: #dc3545;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .badge {
            background-color: #e2e3e5;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            color: #383d41;
        }
    </style>
</head>
<body>
    <center>
        <h1>User Management</h1>
    </center>

    <div class="toolbar">
        <div class="actions">
            <a href="users?action=create">+ Add New User</a>
            <a href="users?action=sort" class="btn-sort">Sort by Name (A-Z)</a>
            <a href="users" class="btn-all">Show All Users</a>
        </div>
        <form action="users" method="get" class="search-box">
            <input type="hidden" name="action" value="search" />
            <input type="text" name="country" placeholder="Search by country..." value="${countrySearch}" />
            <input type="submit" value="Search" />
        </form>
    </div>

    <c:if test="${not empty countrySearch}">
        <p>Search results for country: <strong>"${countrySearch}"</strong> (<a href="users">Clear search</a>)</p>
    </c:if>
    <c:if test="${isSorted}">
        <p><span class="badge">Sorted by Name (A-Z)</span> (<a href="users">Reset default order</a>)</p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Country</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${listUser}">
                <tr>
                    <td><c:out value="${user.id}" /></td>
                    <td><c:out value="${user.name}" /></td>
                    <td><c:out value="${user.email}" /></td>
                    <td><c:out value="${user.country}" /></td>
                    <td class="action-links">
                        <a href="users?action=edit&id=<c:out value='${user.id}' />">Edit</a>
                        <a href="users?action=delete&id=<c:out value='${user.id}' />" class="delete" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listUser}">
                <tr>
                    <td colspan="5" style="text-align: center; color: #888; padding: 20px;">No users found.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
