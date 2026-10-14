package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Dinh tuyen URL: Khi form POST toi "/display-discount", Servlet nay se tiep nhan va xu ly
@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Neu truy cap GET truc tiep, chuyen huong ve trang nhap lieu index.jsp
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ho tro tieng Viet UTF-8 cho ca request va response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String discountPercentStr = request.getParameter("discount_percent");

        if (description == null || description.trim().isEmpty()) {
            description = "Khong co mo ta";
        }

        double listPrice = 0.0;
        double discountPercent = 0.0;
        boolean hasError = false;
        String errorMessage = "";

        try {
            listPrice = Double.parseDouble(priceStr);
            discountPercent = Double.parseDouble(discountPercentStr);

            if (listPrice < 0 || discountPercent < 0 || discountPercent > 100) {
                hasError = true;
                errorMessage = "Gia niem yet phai >= 0 va ty le chiet khau phai nam trong khoang tu 0% den 100%.";
            }
        } catch (Exception e) {
            hasError = true;
            errorMessage = "Du lieu so nhap vao khong hop le. Vui long kiem tra lai gia tri List Price va Discount Percent.";
        }

        // Tinh toan chiet khau theo dung cong thuc dac ta cua CodeGym:
        // Discount Amount = List Price * Discount Percent * 0.01
        // Discount Price = List Price - Discount Amount
        double discountAmount = listPrice * discountPercent * 0.01;
        double discountPrice = listPrice - discountAmount;

        DecimalFormat df = new DecimalFormat("#,##0.00");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Ket Qua Tinh Chiet Khau - Product Discount Calculator</title>");
            out.println("<style>");
            out.println("* { box-sizing: border-box; margin: 0; padding: 0; }");
            out.println("body { font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif; background-color: #f1f5f9; color: #0f172a; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 24px 16px; }");
            out.println(".container { background-color: #ffffff; max-width: 540px; width: 100%; border-radius: 12px; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.04); border: 1px solid #e2e8f0; overflow: hidden; }");
            out.println(".header { background-color: #1e293b; color: #ffffff; padding: 24px 32px; text-align: center; }");
            out.println(".header h1 { font-size: 22px; font-weight: 700; margin-bottom: 4px; }");
            out.println(".header p { color: #94a3b8; font-size: 13px; }");
            out.println(".body-content { padding: 32px; }");
            out.println(".result-table { width: 100%; border-collapse: collapse; margin-bottom: 24px; }");
            out.println(".result-table th, .result-table td { padding: 12px 14px; text-align: left; font-size: 14px; border-bottom: 1px solid #f1f5f9; }");
            out.println(".result-table th { color: #64748b; font-weight: 600; width: 45%; }");
            out.println(".result-table td { color: #1e293b; font-weight: 500; }");
            out.println(".highlight-row { background-color: #fff7ed; }");
            out.println(".highlight-row th { color: #c2410c; }");
            out.println(".highlight-row td { color: #ea580c; font-weight: 700; font-size: 16px; }");
            out.println(".final-row { background-color: #f0fdf4; }");
            out.println(".final-row th { color: #15803d; }");
            out.println(".final-row td { color: #16a34a; font-weight: 700; font-size: 18px; }");
            out.println(".error-box { background-color: #fef2f2; border-left: 4px solid #ef4444; color: #b91c1c; padding: 16px; border-radius: 6px; margin-bottom: 24px; font-size: 14px; line-height: 1.5; }");
            out.println(".btn-back { display: block; width: 100%; background-color: #2563eb; color: #ffffff; text-decoration: none; padding: 14px 20px; font-size: 15px; font-weight: 600; border-radius: 6px; text-align: center; transition: background-color 0.2s; }");
            out.println(".btn-back:hover { background-color: #1d4ed8; }");
            out.println(".footer-info { padding: 16px 32px; background-color: #f8fafc; border-top: 1px solid #f1f5f9; text-align: center; font-size: 13px; color: #64748b; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<div class='header'>");
            out.println("<h1>Ket Qua Tinh Chiet Khau</h1>");
            out.println("<p>Product Discount Calculation Result</p>");
            out.println("</div>");
            out.println("<div class='body-content'>");

            if (hasError) {
                out.println("<div class='error-box'>");
                out.println("<strong>Loi nhap lieu:</strong> " + errorMessage);
                out.println("</div>");
            } else {
                out.println("<table class='result-table'>");
                out.println("<tr>");
                out.println("<th>Product Description:</th>");
                out.println("<td>" + description + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<th>List Price (Gia goc):</th>");
                out.println("<td>$" + df.format(listPrice) + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<th>Discount Percent (%):</th>");
                out.println("<td>" + df.format(discountPercent) + "%</td>");
                out.println("</tr>");
                out.println("<tr class='highlight-row'>");
                out.println("<th>Discount Amount (Tien giam):</th>");
                out.println("<td>$" + df.format(discountAmount) + "</td>");
                out.println("</tr>");
                out.println("<tr class='final-row'>");
                out.println("<th>Discount Price (Gia sau giam):</th>");
                out.println("<td>$" + df.format(discountPrice) + "</td>");
                out.println("</tr>");
                out.println("</table>");
            }

            out.println("<a href='index.jsp' class='btn-back'>Quay lai trang tinh toan</a>");
            out.println("</div>");
            out.println("<div class='footer-info'>");
            out.println("Sinh vien thuc hien: <strong>Nguyen Tuan Dat</strong> &bull; Tomcat 10.1+ Jakarta EE");
            out.println("</div>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
