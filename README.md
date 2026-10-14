# [Bai tap] Ung dung Product Discount Calculator (JSP / Servlet)

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Lop / Ma sinh vien**: K23C - Khoa Cong nghe Thong tin
- **Du an**: product-discount-calculator (Maven Webapp chuan Jakarta EE 10 / Tomcat 10.1+)

---

## 1. Muc tieu & Mo ta bai tap

Xay dung ung dung Java Web tinh toan chi phi chiet khau cho san pham khi mua hang truc tuyen (Product Discount Calculator):
- **Trang nhap lieu (`index.jsp`)**: Cung cap form nhap lieu voi phuong thuc `POST` gui toi endpoint `display-discount`.
  - `description`: Mo ta thong tin san pham (Product Description).
  - `price`: Gia niem yet ban dau cua san pham (List Price).
  - `discount_percent`: Ty le phan tram giam gia (Discount Percent).
- **Tieu chi xu ly (`DiscountServlet.java`)**:
  - Tiep nhan cac tham so tu HTTP POST request.
  - Tinh toan luong chiet khau (Discount Amount):
    $$\text{Discount Amount} = \text{List Price} \times \text{Discount Percent} \times 0.01$$
  - Tinh toan gia ban sau khi giam (Discount Price):
    $$\text{Discount Price} = \text{List Price} - \text{Discount Amount}$$
  - Hien thi bang ket qua chi tiet, truc quan va ho tro quay lai trang tinh toan.

---

## 2. Cau truc thu muc tieu chuan

```text
product-discount-calculator/
├── pom.xml                                   # Cấu hình Maven dependencies (Jakarta Servlet 6.0, JSP 3.1)
├── README.md                                 # Tài liệu dự án và hướng dẫn đóng gói
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── DiscountServlet.java  # Servlet controller xu ly POST tai /display-discount
        └── webapp/
            ├── index.jsp                     # Giao dien form nhap lieu chiet khau san pham
            └── WEB-INF/
                └── web.xml                   # Cau hinh Web descriptor chuan Jakarta EE 10
```

---

## 3. Chi tiet ky thuat cot loi

### 3.1. Cau hinh `pom.xml` (Jakarta EE 10 / Tomcat 10.1+)
```xml
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>jakarta.servlet.jsp</groupId>
    <artifactId>jakarta.servlet.jsp-api</artifactId>
    <version>3.1.1</version>
    <scope>provided</scope>
</dependency>
```

### 3.2. Form nhap lieu trong `index.jsp`
```html
<form action="display-discount" method="POST">
    <input type="text" name="description" required />
    <input type="number" name="price" step="any" min="0" required />
    <input type="number" name="discount_percent" step="any" min="0" max="100" required />
    <button type="submit">Calculate Discount</button>
</form>
```

### 3.3. Tinh toan va phan hoi trong `DiscountServlet.java`
```java
@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double listPrice = Double.parseDouble(request.getParameter("price"));
        double discountPercent = Double.parseDouble(request.getParameter("discount_percent"));

        double discountAmount = listPrice * discountPercent * 0.01;
        double discountPrice = listPrice - discountAmount;

        // Render ket qua ra HTML
    }
}
```

---

## 4. Huong dan dong goi va trien khai len Tomcat 10.1+

### Buoc 1: Dong goi Maven (.war)
Chay lenh sau tai thu muc goc cua du an:
```bash
mvn clean package
```
File `product-discount-calculator.war` se duoc tao ra tai thu muc `target/`.

### Buoc 2: Trien khai file WAR len Tomcat
1. Sao chep file `target/product-discount-calculator.war` vao thu muc `webapps/` cua Apache Tomcat 10.1+.
2. Khoi dong Tomcat bang script:
   - Windows: `bin/startup.bat`
   - Linux / macOS: `bin/startup.sh`

### Buoc 3: Kiem thu tren trinh duyet
- Truy cap trang chu: `http://localhost:8080/product-discount-calculator/`
- Nhap thu du lieu:
  - Product Description: `Laptop Dell XPS 15`
  - List Price: `1500.00`
  - Discount Percent: `10`
- Nhan `Calculate Discount` de kiem tra ket qua:
  - Discount Amount: `$150.00`
  - Discount Price: `$1,350.00`
