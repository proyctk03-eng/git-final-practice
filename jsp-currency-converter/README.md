# [Thuc hanh] Ung dung chuyen doi tien te - JSP

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Lop / Ma sinh vien**: K23C - Khoa Cong nghe Thong tin
- **Du an**: jsp-currency-converter (Maven Webapp chuan Jakarta EE 10 / Tomcat 10.1+)

---

## 1. Muc tieu & Mo ta

Luyen tap tao va xu ly du lieu truc tiep voi JSP thong qua viec nhung ma Java vao trang HTML (Scriptlet va Expression):
- **Trang nhap lieu (`index.jsp`)**: Chua bieu mau nhap lieu gom `rate` (ti gia VND/USD) va `usd` (luong USD can doi), su dung phuong thuc `POST` gui toi `converter.jsp`.
- **Trang xu ly & ket qua (`converter.jsp`)**:
  - Su dung the JSP Scriptlet `<% ... %>` de nhan tham so tu request, ep kieu sang so thuc va thuc hien phep tinh chuyen doi:
    $$\text{VND} = \text{USD} \times \text{Rate}$$
  - Hien thi ket qua truc tiep bang the JSP Expression `<%= ... %>`.
- **Tuong thich he thong**: Chuan dac ta Jakarta EE 10 tren nen tang may chu Apache Tomcat 10.1+.

---

## 2. Cau truc thu muc tieu chuan

```text
jsp-currency-converter/
├── pom.xml                        # File cau hinh khai bao thu vien quan ly boi Maven
├── README.md                      # Tai lieu huong dan dong goi va van hanh
└── src/
    └── main/
        └── webapp/                # Thu muc chua giao dien va logic JSP
            ├── index.jsp          # Trang chu chua Form nhap ti gia va luong USD
            ├── converter.jsp      # Trang xu ly tinh toan va in ket qua bang ma Java nhung
            └── WEB-INF/
                └── web.xml        # File cau hinh ung dung Web chuan Jakarta EE 10
```

---

## 3. Huong dan dong goi va trien khai len Tomcat 10.1+

1. **Bien dich va dong goi (.war):**
   ```bash
   mvn clean package
   ```
   Tep tin `jsp-currency-converter.war` se duoc tao ra tai thu muc `target/`.

2. **Trien khai len may chu Tomcat:**
   - Sao chep `target/jsp-currency-converter.war` vao thu muc `webapps/` cua Apache Tomcat 10.1+.
   - Khoi dong server bang script `bin/startup.bat` (Windows) hoac `bin/startup.sh` (Linux/macOS).

3. **Kiem thu tren trinh duyet:**
   - Truy cap: `http://localhost:8080/jsp-currency-converter/`
   - Nhap thu: Ti gia = `25000`, Luong USD = `100` -> Nhan ket qua `2,500,000 VND`.
