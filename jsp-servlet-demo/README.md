# [Thuc hanh] Tao trang web hien thi thoi gian he thong (JSP / Servlet)

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Ma sinh vien / Lop**: K23C - Khoa Cong nghe Thong tin
- **Du an**: jsp-servlet-demo (Maven Webapp chuan Jakarta EE 10 / Tomcat 10.1+)

---

## 1. Muc tieu & Mo ta

Xay dung ung dung Java Web dau tien su dung mo hinh Maven Webapp voi JSP va Servlet:
- Su dung Scriptlet trong trang `index.jsp` de truy xuat va hien thi thoi gian he thong may chu theo thoi gian thuc (`java.util.Date`).
- Xay dung Servlet dau tien `HelloServlet.java` dinh tuyen bang annotation `@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})`.
- Cau hinh ung dung tuong thich hoan toan voi dac ta Jakarta EE 10 va may chu Apache Tomcat 10.1+ (chuyen doi toan bo package tu `javax.servlet` sang `jakarta.servlet`).

---

## 2. Cau truc thu muc tieu chuan

```text
jsp-servlet-demo/
├── pom.xml                                   # File cau hinh Maven dependencies (Jakarta Servlet 6.0, JSP 3.1)
├── README.md                                 # Tai lieu huong dan dong goi va van hanh
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── HelloServlet.java     # Servlet controller xu ly GET request tai /hello
        └── webapp/
            ├── index.jsp                     # Giao dien trang chu hien thi thoi gian thuc cua server
            └── WEB-INF/
                └── web.xml                   # File cau hinh ung dung Web chuan Jakarta EE 10
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

### 3.2. Scriptlet xu ly thoi gian trong `index.jsp`
Trang JSP su dung Scriptlet de khoi tao doi tuong Date va bieu thuc JSP Expression de in ra man hinh:
```jsp
<%
    java.util.Date date = new java.util.Date();
%>
<p>Thoi gian he thong hien tai: <strong><%= date %></strong></p>
```

### 3.3. Servlet controller `HelloServlet.java`
```java
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1>Chao mung ban den voi Servlet dau tien!</h1>");
        }
    }
}
```

---

## 4. Huong dan dong goi va trien khai len Tomcat 10.1+

### Buoc 1: Bien dich va dong goi (.war) bang Maven
Chay lenh sau tai thu muc goc cua du an:
```bash
mvn clean package
```
Sau khi hien thi thong bao `BUILD SUCCESS`, file dong goi `jsp-servlet-demo.war` se duoc tao ra ben trong thu muc `target/`.

### Buoc 2: Trien khai file .war len may chu Tomcat
1. Sao chep file `target/jsp-servlet-demo.war` vao thu muc `webapps/` cua may chu Apache Tomcat 10.1+.
2. Khoi dong Tomcat bang script:
   - Tren Windows: chay `bin/startup.bat`
   - Tren Linux / macOS: chay `bin/startup.sh`

### Buoc 3: Kiem tra tren trinh duyet
- Trang chu JSP hien thi thoi gian: `http://localhost:8080/jsp-servlet-demo/`
- Trang Servlet kiem thu: `http://localhost:8080/jsp-servlet-demo/hello`
