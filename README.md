# [Bài tập] Tạo Giao Diện Giản Lược Của Trang Chủ Facebook

> **Khóa học**: Lập trình Web Frontend & Thiết kế Giao diện Người dùng (CodeGym)  
> **Học viên thực hiện**: Nguyễn Tuấn Đạt  
> **Kho lưu trữ (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Thư mục bài tập**: `facebook-homepage-layout/`  
> **Mục tiêu kỹ thuật**: Thiết kế Fixed Header và Sidebars cố định kết hợp Main Feed cuộn độc lập

---

## 1. Mục Tiêu & Yêu Cầu Cốt Lõi

1. **Thành phần giao diện bắt buộc**:
   - **Fixed Header ở trên cùng**: Thanh điều hướng trên cùng luôn ghim cố định khi người dùng cuộn xem bài viết, tích hợp Logo, Ô tìm kiếm, Các tab trung tâm (Trang chủ, Watch, Marketplace, Nhóm, Gaming) và Các biểu tượng tiện ích (Menu, Messenger, Thông báo, Avatar).
   - **Các phần Sidebar hai bên**:
     - *Sidebar trái (Navigation Menu)*: Cố định bên trái màn hình, hiển thị danh mục chức năng chính (Bạn bè, Kỷ niệm, Đã lưu, Nhóm) và Lối tắt cá nhân của người dùng.
     - *Sidebar phải (Contacts & Sponsored)*: Cố định bên phải màn hình, hiển thị nội dung tài trợ và danh sách bạn bè đang trực tuyến (Online Contacts).
   - **Phần nội dung chính (Main Feed)**: Nằm ở giữa, co giãn linh hoạt theo tỷ lệ màn hình, bao gồm khay tin (Stories Tray), khung tạo bài viết (Post Composer) và danh sách bài viết Newsfeed có đầy đủ tương tác (Thích, Bình luận, Chia sẻ).
2. **Kỹ thuật CSS áp dụng**:
   - `position: fixed`, `position: relative`, `top`, `left`, `right`.
   - Phân cấp hiển thị `z-index: 1000` chống đè lấp giao diện.
   - Hàm tính toán kích thước động `height: calc(100vh - 56px);`.
   - Cơ chế cô lập thanh cuộn `overflow-y: auto`.
   - Bố cục kết hợp giữa CSS Flexbox và CSS Grid.
   - Thiết kế thích ứng đa thiết bị (Responsive Design).

---

## 2. Kiến Trúc Bố Cục & Cơ Chế Định Vị (Layout Architecture)

```
+-------------------------------------------------------------------------------+
|               FIXED HEADER (height: 56px, position: fixed, z-index: 1000)     |
+----------------------+--------------------------------+-----------------------+
|  LEFT SIDEBAR        |  MAIN FEED CONTAINER           |  RIGHT SIDEBAR        |
|  width: 280px        |  max-width: 680px (margin: auto)|  width: 280px        |
|  position: fixed     |  Cuộn dọc theo nội dung trang  |  position: fixed     |
|  height: 100vh-56px  |  - Stories Tray                |  height: 100vh-56px  |
|  overflow-y: auto    |  - Create Post Composer        |  overflow-y: auto    |
|                      |  - Newsfeed Post Cards         |                      |
+----------------------+--------------------------------+-----------------------+
```

### 2.1. Phân tích Fixed Header (`position: fixed`)
- **Vấn đề**: Khi người dùng cuộn trang xuống sâu để đọc bài viết, thanh Header thông thường sẽ bị trôi mất khỏi tầm mắt, khiến người dùng mất quyền truy cập nhanh vào menu điều hướng và tìm kiếm.
- **Giải pháp**:
  ```css
  .fixed-header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 56px;
      z-index: 1000; /* Dam bao luon noi tren cac the bai viet */
      background-color: #FFFFFF;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
  }
  ```
- **Lưu ý bù đắp lề (Layout Offset)**: Vì phần tử `fixed` bị tách hoàn toàn ra khỏi luồng tài liệu thông thường (Normal Flow), khối nội dung bên dưới phải được cấp phát khoảng cách bù trừ `margin-top: 56px` để tránh bị Header che khuất phần đầu trang.

---

### 2.2. Phân tích Sidebars cố định với thanh cuộn độc lập
- **Cấu hình vị trí và kích thước**:
  ```css
  .sidebar {
      width: 280px;
      height: calc(100vh - 56px); /* Chiem tron ven phan chieu cao con lai cua man hinh */
      position: fixed;
      top: 56px;
      overflow-y: auto; /* Cho phep cuon doc lap khi danh muc vuot qua chieu cao viewport */
      padding: 1rem 0.5rem;
  }
  .sidebar-left { left: 0; }
  .sidebar-right { right: 0; }
  ```
- **Ý nghĩa trải nghiệm (UX)**: Người dùng có thể cuộn danh mục bạn bè hoặc danh sách tính năng bên cạnh trái/phải mà không làm thay đổi vị trí của bảng tin bài viết ở giữa màn hình.

---

### 2.3. Bố cục thích ứng linh hoạt (Responsive Media Queries)
Hệ thống bố cục tự động tái cơ cấu theo kích thước khung nhìn:
- **Màn hình máy tính lớn (> 1100px)**: Hiển thị đầy đủ cả 3 cột (Header + Sidebar trái + Main Feed + Sidebar phải).
- **Màn hình máy tính bảng (820px - 1100px)**: Tự động ẩn Sidebar phải (`display: none;`), nhường không gian cho Main Feed và Sidebar trái.
- **Màn hình điện thoại di động (< 820px)**: Ẩn cả 2 Sidebar, Main Feed chiếm 100% độ rộng màn hình, ẩn các tab phụ trên Header để tối ưu diện tích cảm ứng.

---

## 3. Trích Đoạn Mã Nguồn Tiêu Biểu (`index.html`)

```html
<!-- 1. Header co dinh -->
<header class="fixed-header">
    <div class="header-left">
        <a href="#" class="fb-logo">f</a>
        <div class="search-box">
            <input type="text" class="search-input" placeholder="Tìm kiếm trên Facebook">
        </div>
    </div>
    <nav class="header-center">
        <a href="#" class="nav-tab active">Trang chủ</a>
        <a href="#" class="nav-tab">Watch</a>
        <a href="#" class="nav-tab">Marketplace</a>
    </nav>
    <div class="header-right">
        <button class="icon-btn">Messenger</button>
        <button class="icon-btn">Thông báo</button>
        <div class="user-profile-btn">
            <div class="avatar">Đ</div>
            <span>Tuấn Đạt</span>
        </div>
    </div>
</header>

<!-- 2. Main Layout 3 cot -->
<div class="main-layout">
    <!-- Sidebar trai -->
    <aside class="sidebar sidebar-left">
        <!-- Menu chuc nang co dinh -->
    </aside>

    <!-- Main Feed o giua -->
    <main class="feed-container">
        <!-- Stories tray, Create post, Newsfeed posts -->
    </main>

    <!-- Sidebar phai -->
    <aside class="sidebar sidebar-right">
        <!-- Danh sach ban be online co dinh -->
    </aside>
</div>
```

---

## 4. Cấu Trúc Thư Mục Bàn Giao

```
facebook-homepage-layout/
├── index.html       # Giao diện Facebook hoàn chỉnh (Fixed Header, Sidebars, Stories, Posts)
├── demo.html        # Thanh tra bố cục (Layout Inspector) hỗ trợ bật tắt linh hoạt các khối
└── README.md        # Thuyết minh kỹ thuật chi tiết về cơ chế Position Fixed và Layout 3 cột
```

---

## 5. Hướng Dẫn Mở & Kiểm Tra

1. **Kiểm tra giao diện Facebook hoàn chỉnh**:
   - Mở tệp [index.html](file:///c:/Users/dathao/Downloads/AI/git-final-practice/facebook-homepage-layout/index.html) trong trình duyệt.
   - Thử cuộn trang chuột xuống dưới: Quan sát thanh Header ở trên cùng và 2 Sidebar hai bên hoàn toàn đứng yên, chỉ có bảng tin bài viết ở giữa cuộn mượt mà.
   - Thử bấm nút "Thích" trên bài viết để kiểm tra hiệu ứng chuyển màu xanh và tăng bộ đếm lượt thích.
   - Thu nhỏ cửa sổ trình duyệt để quan sát cơ chế Responsive: Sidebar phải tự ẩn khi màn hình dưới 1100px, cả 2 Sidebar tự ẩn khi dưới 820px.
2. **Kiểm tra thanh tra bố cục tương tác**:
   - Mở tệp [demo.html](file:///c:/Users/dathao/Downloads/AI/git-final-practice/facebook-homepage-layout/demo.html) để quan sát sơ đồ Wireframe và bấm các nút điều khiển ẩn/hiện Sidebar và chế độ mô phỏng Mobile.
