# Quadratic Equation Solver Library (com.codegym:quadratic-equation-solver)

> Báo cáo kỹ thuật và tài liệu hướng dẫn đóng gói thư viện Java giải phương trình bậc hai \(ax^2 + bx + c = 0\).  
> Tác giả: Nguyễn Tuấn Đạt (proyctk03@gmail.com)  
> Tổ chức: CodeGym Vietnam  
> Phiên bản thư viện: 1.0.0  
> Định dạng đóng gói: Maven JAR (.jar)

---

## 1. Mục tiêu bài tập & Giới thiệu thư viện

Thư viện **Quadratic Equation Solver** được thiết kế nhằm mục đích:
1. Đóng gói hoàn chỉnh nghiệp vụ giải phương trình bậc hai \(ax^2 + bx + c = 0\) thành một thư viện độc lập (.jar).
2. Tách biệt hoàn toàn tầng tính toán đại số (Domain Logic) khỏi các tầng giao diện (CLI, Web JSP/Servlet, GUI Swing/JavaFX).
3. Cho phép tái sử dụng trong bất kỳ ứng dụng Java nào thông qua cơ chế quản lý gói của Maven hoặc nhúng trực tiếp tệp tin `.jar`.
4. Xử lý triệt để tất cả các trường hợp biên của toán học:
   - Hệ số \(a = 0\): Phương trình suy biến về bậc nhất \(bx + c = 0\) (vô số nghiệm, vô nghiệm, hoặc một nghiệm duy nhất).
   - Hệ số \(a \neq 0\): Phương trình bậc hai thuần túy với biệt thức \(\Delta = b^2 - 4ac\) (hai nghiệm phân biệt khi \(\Delta > 0\), nghiệm kép khi \(\Delta = 0\), hoặc vô nghiệm thực khi \(\Delta < 0\)).

---

## 2. Cấu trúc thư mục dự án

```
quadratic-equation-solver/
├── pom.xml                                 # File cấu hình build Maven và thông tin thư viện
├── README.md                               # Tài liệu hướng dẫn sử dụng và thuyết minh kỹ thuật
├── build.bat                               # Kịch bản tự động build và đóng gói JAR trên Windows
├── run.bat                                 # Kịch bản chạy thử nghiệm ứng dụng demo
└── src/
    ├── main/
    │   ├── java/
    │   │   └── com/
    │   │       └── codegym/
    │   │           ├── equation/           # Package cốt lõi của thư viện
    │   │           │   ├── EquationStatus.java      # Enum định nghĩa các trạng thái nghiệm
    │   │           │   ├── QuadraticResult.java     # Đối tượng đóng gói kết quả tính toán
    │   │           │   ├── QuadraticEquation.java   # Lớp đối tượng phương trình bậc hai
    │   │           │   └── QuadraticSolver.java     # Lớp tiện ích tĩnh giải phương trình nhanh
    │   │           └── demo/               # Package ứng dụng demo tiêu thụ thư viện
    │   │               └── LibraryDemoApp.java      # Ứng dụng console minh họa tích hợp thư viện
    │   └── resources/
    │       └── META-INF/
    │           └── MANIFEST.MF             # Manifest định nghĩa Main-Class và metadata của JAR
    └── test/
        └── java/
            └── com/
                └── codegym/
                    └── equation/           # Package kiểm thử đơn vị tự động
                        ├── QuadraticEquationTest.java # Bộ test JUnit 5 cho QuadraticEquation
                        └── QuadraticSolverTest.java   # Bộ test JUnit 5 cho QuadraticSolver
```

---

## 3. Kiến trúc các lớp và thành phần trong thư viện

### 3.1. Enum `EquationStatus`
Định nghĩa 5 trạng thái nghiệm toán học chuẩn xác:
- `INFINITE_ROOTS`: Phương trình có vô số nghiệm (\(0x^2 + 0x + 0 = 0\)).
- `NO_SOLUTION`: Phương trình vô nghiệm (\(0x = c \neq 0\) hoặc \(a \neq 0, \Delta < 0\)).
- `ONE_ROOT`: Phương trình suy biến bậc nhất có đúng 1 nghiệm duy nhất (\(a = 0, b \neq 0 \Rightarrow x = -c/b\)).
- `DOUBLE_ROOT`: Phương trình có nghiệm kép (\(a \neq 0, \Delta = 0 \Rightarrow x_1 = x_2 = -b/(2a)\)).
- `TWO_DISTINCT_ROOTS`: Phương trình có 2 nghiệm phân biệt (\(a \neq 0, \Delta > 0\)).

### 3.2. Lớp `QuadraticResult`
Đóng gói kết quả đầu ra toàn diện, bảo đảm tính bất biến (Immutable):
- `status`: Trạng thái nghiệm kiểu `EquationStatus`.
- `discriminant`: Giá trị biệt thức \(\Delta = b^2 - 4ac\).
- `root1`: Giá trị nghiệm \(x_1\) (hoặc nghiệm duy nhất).
- `root2`: Giá trị nghiệm \(x_2\).
- `message`: Thuyết minh diễn giải kết quả chi tiết bằng ngôn ngữ tự nhiên.
- Các hàm tiện ích: `hasSolutions()`, `getRootCount()`.

### 3.3. Lớp `QuadraticEquation`
Mô hình hóa thực thể phương trình bậc hai theo trường phái hướng đối tượng (OOP):
- Thuộc tính: `private double a`, `private double b`, `private double c`.
- Constructor: Khởi tạo mặc định và khởi tạo 3 tham số.
- Getters/Setters cho phép thay đổi hệ số linh hoạt.
- `getDiscriminant()`: Tính \(\Delta = b^2 - 4ac\).
- `getRoot1()`, `getRoot2()`: Lấy nghiệm theo công thức toán học cổ điển.
- `hasRealRoots()`: Kiểm tra sự tồn tại của nghiệm thực.
- `solve()`: Trả về đối tượng `QuadraticResult` chứa toàn bộ phân tích trạng thái.

### 3.4. Lớp `QuadraticSolver`
Cung cấp các hàm tiện ích tĩnh (Static Utilities):
- `QuadraticSolver.solve(a, b, c)`: Giải trực tiếp mà không cần khởi tạo đối tượng.
- `QuadraticSolver.calculateDiscriminant(a, b, c)`: Tính nhanh biệt thức \(\Delta\).
- `QuadraticSolver.formatEquation(a, b, c)`: Định dạng chuỗi toán học chuẩn (ví dụ: `2x^2 + 5x - 3 = 0`).

---

## 4. Bảng phân tích các trường hợp nghiệm toán học

| Trường hợp | Điều kiện hệ số | Biệt thức \(\Delta\) | Trạng thái (`EquationStatus`) | Nghiệm toán học |
| :--- | :--- | :--- | :--- | :--- |
| **TH 1** | \(a = 0, b = 0, c = 0\) | 0 | `INFINITE_ROOTS` | Nghiệm đúng với mọi \(x \in \mathbb{R}\) |
| **TH 2** | \(a = 0, b = 0, c \neq 0\) | 0 | `NO_SOLUTION` | Không tồn tại \(x\) thỏa mãn |
| **TH 3** | \(a = 0, b \neq 0\) | 0 | `ONE_ROOT` | \(x = -c / b\) |
| **TH 4** | \(a \neq 0\) | \(\Delta < 0\) | `NO_SOLUTION` | Vô nghiệm thực |
| **TH 5** | \(a \neq 0\) | \(\Delta = 0\) | `DOUBLE_ROOT` | \(x_1 = x_2 = -b / (2a)\) |
| **TH 6** | \(a \neq 0\) | \(\Delta > 0\) | `TWO_DISTINCT_ROOTS` | \(x_{1,2} = \frac{-b \pm \sqrt{\Delta}}{2a}\) |

---

## 5. Hướng dẫn đóng gói thư viện thành tệp tin JAR

### Cách 1: Đóng gói tự động với Maven (Khuyến nghị)
Mở cửa sổ dòng lệnh tại thư mục dự án và thực thi:

```bash
mvn clean package
```

Kết quả sau khi build:
- Thư viện chính: `target/quadratic-equation-solver-1.0.0.jar`
- Thư viện mã nguồn kèm theo: `target/quadratic-equation-solver-1.0.0-sources.jar`
- Thư viện tài liệu JavaDoc: `target/quadratic-equation-solver-1.0.0-javadoc.jar`

### Cách 2: Cài đặt vào Local Maven Repository (.m2)
Để các dự án Java khác trên cùng máy tính có thể gọi trực tiếp thông qua file `pom.xml`:

```bash
mvn clean install
```

Thư viện sẽ được lưu trữ tại:
`~/.m2/repository/com/codegym/quadratic-equation-solver/1.0.0/quadratic-equation-solver-1.0.0.jar`

### Cách 3: Đóng gói thủ công bằng script Windows
Nhấp đúp chuột vào tệp `build.bat` hoặc gõ:
```cmd
build.bat
```

---

## 6. Hướng dẫn sử dụng thư viện trong dự án khác

### 6.1. Sử dụng qua cấu hình Maven Dependency
Thêm khối khai báo sau vào tệp `pom.xml` của dự án cần sử dụng:

```xml
<dependency>
    <groupId>com.codegym</groupId>
    <artifactId>quadratic-equation-solver</artifactId>
    <version>1.0.0</version>
</dependency>
```

### 6.2. Sử dụng nhúng tệp tin JAR thủ công
- **Trong IntelliJ IDEA**:
  1. Mở dự án cần dùng thư viện.
  2. Vào `File` -> `Project Structure` (Ctrl + Alt + Shift + S).
  3. Chọn mục `Libraries` -> Nhấn biểu tượng dấu cộng `+` -> Chọn `Java`.
  4. Trỏ tới tệp `quadratic-equation-solver-1.0.0.jar` -> Nhấn `OK`.
- **Trong Eclipse**:
  1. Nhấp chuột phải vào dự án -> `Properties` -> `Java Build Path`.
  2. Chọn tab `Libraries` -> `Add External JARs...`.
  3. Chọn tệp `quadratic-equation-solver-1.0.0.jar` -> `Apply and Close`.

---

## 7. Mã nguồn mẫu minh họa tích hợp thư viện

### Cách tiếp cận 1: Hướng đối tượng (Object-Oriented Programming)

```java
import com.codegym.equation.QuadraticEquation;
import com.codegym.equation.QuadraticResult;
import com.codegym.equation.EquationStatus;

public class DemoApp {
    public static void main(String[] args) {
        // Khoi tao phuong trinh: 1x^2 - 3x + 2 = 0
        QuadraticEquation equation = new QuadraticEquation(1.0, -3.0, 2.0);

        System.out.println("Biet thuc Delta = " + equation.getDiscriminant());

        // Giai phuong trinh
        QuadraticResult result = equation.solve();

        if (result.getStatus() == EquationStatus.TWO_DISTINCT_ROOTS) {
            System.out.println("x1 = " + result.getRoot1());
            System.out.println("x2 = " + result.getRoot2());
        } else if (result.getStatus() == EquationStatus.DOUBLE_ROOT) {
            System.out.println("Nghiem kep x = " + result.getRoot1());
        } else {
            System.out.println(result.getMessage());
        }
    }
}
```

### Cách tiếp cận 2: Gọi phương thức tiện ích tĩnh (Static Method)

```java
import com.codegym.equation.QuadraticSolver;
import com.codegym.equation.QuadraticResult;

public class QuickDemo {
    public static void main(String[] args) {
        // Giai nhanh phuong trinh 2x^2 + 5x - 3 = 0
        QuadraticResult result = QuadraticSolver.solve(2.0, 5.0, -3.0);
        
        System.out.println("Ket qua: " + result.getMessage());
        System.out.printf("x1 = %.2f, x2 = %.2f\n", result.getRoot1(), result.getRoot2());
    }
}
```

---

## 8. Kiểm thử đơn vị tự động (Unit Test với JUnit 5)

Dự án tích hợp đầy đủ bộ kiểm thử trong `src/test/java`:
- `QuadraticEquationTest`: Kiểm thử toàn bộ 6 kịch bản nghiệm, kiểm thử tham số hóa `@ParameterizedTest` với `@CsvSource`, kiểm thử getter/setter và tính chính xác của \(\Delta\).
- `QuadraticSolverTest`: Kiểm thử các phương thức tiện ích giải nhanh và định dạng chuỗi toán học.

Để chạy bộ kiểm thử:
```bash
mvn test
```

---

## 9. Thông tin tác giả và bản quyền

- **Họ và tên**: Nguyễn Tuấn Đạt
- **Email**: proyctk03@gmail.com
- **Khóa học**: Java Web Developer (JWBD) - CodeGym
- **Bản quyền**: Open Source theo tiêu chuẩn giáo dục đào tạo kỹ sư phần mềm chuyên nghiệp.
