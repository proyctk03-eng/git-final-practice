<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        fieldset {
            width: 450px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        legend {
            font-weight: bold;
            font-size: 18px;
            padding: 0 10px;
        }
        table {
            width: 100%;
        }
        td {
            padding: 8px;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form action="users" method="post">
        <fieldset>
            <legend>Edit User</legend>
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" value="<c:out value='${user.id}' />"/>
            <table>
                <tr>
                    <td>User Name:</td>
                    <td><input type="text" name="name" value="<c:out value='${user.name}' />" required /></td>
                </tr>
                <tr>
                    <td>User Email:</td>
                    <td><input type="email" name="email" value="<c:out value='${user.email}' />" required /></td>
                </tr>
                <tr>
                    <td>Country:</td>
                    <td><input type="text" name="country" value="<c:out value='${user.country}' />" required /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update User" /></td>
                </tr>
            </table>
            <a href="users" class="back-link">&larr; Back to User List</a>
        </fieldset>
    </form>
</body>
</html>
