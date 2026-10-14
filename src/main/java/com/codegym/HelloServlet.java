package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Khai bao dinh tuyen URL: Khi nguoi dung truy cap "/hello", Servlet se duoc kich hoat
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cau hinh phan hoi HTML voi bang ma ky tu UTF-8 ho tro Tieng Viet
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Hello Servlet - CodeGym</title>");
            out.println("<style>");
            out.println("body { font-family: 'Segoe UI', Arial, sans-serif; text-align: center; margin-top: 80px; background-color: #f8fafc; color: #1e293b; }");
            out.println(".container { max-width: 600px; margin: 0 auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }");
            out.println("h1 { color: #1b2a7a; font-size: 28px; margin-bottom: 12px; }");
            out.println("p { color: #475569; font-size: 16px; line-height: 1.6; }");
            out.println(".badge { display: inline-block; background-color: #e0f2fe; color: #0369a1; padding: 6px 12px; border-radius: 9999px; font-weight: 600; font-size: 14px; margin-bottom: 20px; }");
            out.println("a.btn { display: inline-block; background-color: #1b2a7a; color: white; padding: 10px 24px; text-decoration: none; border-radius: 6px; font-weight: 500; margin-top: 24px; transition: background-color 0.2s; }");
            out.println("a.btn:hover { background-color: #2a3eb1; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<span class='badge'>Jakarta Servlet 6.0 / Tomcat 10.1+</span>");
            out.println("<h1>Chao mung ban den voi Servlet dau tien!</h1>");
            out.println("<p>Ung dung Java Web dang chay muot ma tren he thong.</p>");
            out.println("<p>Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong></p>");
            out.println("<a href='index.jsp' class='btn'>Quay lai trang chu JSP</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
