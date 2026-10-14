# [Bài tập] Tạo Layout Với RWD (Responsive Web Design)

- **Sinh viên thực hiện**: Nguyễn Tuấn Đạt
- **Bài tập**: Tạo layout với RWD (Responsive Web Design) bằng DIV và CSS

## 1. Giới Thiệu & Mục Tiêu

Bài tập hướng dẫn kỹ thuật thiết kế giao diện thích ứng (**Responsive Web Design - RWD**) sử dụng thẻ `<div>`, hệ thống lưới tỷ lệ phần trăm (**Fluid Grid System**) và truy vấn đa phương tiện (**CSS Media Queries**). Trang web có khả năng tự động biến đổi linh hoạt từ bố cục 3 cột trên máy tính sang 2 cột trên máy tính bảng và 1 cột xếp chồng trên điện thoại di động.

### Mục tiêu bài học:
- **Thấu hiểu vai trò của Viewport Meta Tag**: Kiểm soát tỷ lệ hiển thị trên mọi kích thước màn hình thiết bị.
- **Làm chủ thuộc tính `box-sizing: border-box`**: Đảm bảo lề đệm (`padding`) và đường viền (`border`) không làm biến dạng hoặc vỡ lưới layout.
- **Xây dựng hệ thống lưới 12 cột linh hoạt**: Sử dụng các lớp CSS `.col-1` đến `.col-12` (Desktop) và `.col-s-1` đến `.col-s-12` (Tablet).
- **Vận dụng CSS Media Queries**: Thiết lập các điểm ngắt (**Breakpoints**) tại `600px` và `768px` để chuyển đổi bố cục mượt mà.

---

## 2. 4 Trụ Cột Cốt Lõi Của Responsive Web Design

### 1. Viewport Meta Tag
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```
- Nếu không có thẻ này, trình duyệt di động sẽ tự động thu nhỏ trang web về tỷ lệ 980px của màn hình desktop khiến chữ trở nên li ti và bắt người dùng phải phóng to/thu nhỏ thủ công.

### 2. Thuộc tính `box-sizing: border-box`
```css
* {
    box-sizing: border-box;
}
```
- Mặc định (`content-box`), chiều rộng thực tế = `width + padding + border`.
- Với `border-box`, `width` bao gồm cả `padding` và `border`, giúp việc chia cột tỷ lệ phần trăm (25% + 50% + 25% = 100%) luôn chính xác tuyệt đối mà không sợ bị rớt dòng.

### 3. Hệ Thống Lưới 12 Cột Tỷ Lệ Phần Trăm (Fluid Grid)
- Một trang web chia làm 12 cột, mỗi cột chiếm $\frac{100\%}{12} \approx 8.33\%$.
- Cột chiếm 3 phần (`col-3`): $3 \times 8.33\% = 25\%$.
- Cột chiếm 6 phần (`col-6`): $6 \times 8.33\% = 50\%$.

### 4. Bảng Phân Phối Cột Theo Điểm Ngắt (Breakpoints)

| Vùng hiển thị | Kích thước màn hình | Cột Trái (Menu) | Cột Giữa (Main) | Cột Phải (Aside) | Bố cục tổng thể |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Mobile** | Dưới `600px` | `100%` | `100%` | `100%` | **1 Cột** xếp chồng dọc |
| **Tablet** | Từ `600px` đến `767px` | `25%` (`col-s-3`) | `75%` (`col-s-9`) | `100%` (`col-s-12`) | **2 Cột** (Menu + Main) phía trên, Aside buông dưới |
| **Desktop** | Từ `768px` trở lên | `25%` (`col-3`) | `50%` (`col-6`) | `25%` (`col-3`) | **3 Cột** song song cân đối |

---

## 3. Cấu Trúc Mã Nguồn

```text
tao_layout_voi_rwd/
├── index.html           # Bản chuẩn theo đúng đề bài CodeGym (Chania layout)
├── styles.css           # Hệ thống lưới 12 cột fluid, float & media queries
├── modern_rwd.html      # Bản nâng cấp giao diện hiện đại & Bộ giả lập Viewport
├── modern_rwd.css       # CSS Grid & Flexbox, dark theme, interactive buttons
└── README.md            # Báo cáo kỹ thuật chi tiết
```

---

## 4. Điểm Nổi Bật Ở Bản Hiện Đại (`modern_rwd.html`)

Nhằm nâng cấp trải nghiệm trực quan theo tiêu chuẩn cao cấp:
1. **Bộ giả lập kích thước màn hình trực tiếp (Interactive Viewport Simulator)**:
   - Trang bị 3 nút bấm chuyển đổi nhanh ngay trên giao diện: **Desktop (100%)**, **Tablet (768px)** và **Mobile (390px)**.
   - Bạn có thể quan sát bố cục co giãn và thay đổi tức thì mà không cần phải mở DevTools hoặc kéo cửa sổ trình duyệt.
2. **Kiến trúc CSS Grid hai chiều**: Tối ưu hóa việc phân chia không gian, loại bỏ hoàn toàn các hạn chế của kỹ thuật `float` và `clearfix`.
3. **Typography & Card UI hiện đại**: Phối màu Dark/Indigo sang trọng, biểu tượng trực quan, huy hiệu thống kê và hiệu ứng hover mượt mà.

---

## 5. Hướng Dẫn Trải Nghiệm & Kiểm Thử

1. **Bản chuẩn CodeGym**: Mở tệp [**`index.html`**](file:///C:/Users/dathao/Downloads/tao_layout_voi_rwd/index.html) và thử co giãn cửa sổ trình duyệt hoặc bấm `F12` -> `Ctrl + Shift + M` để xem các chế độ di động.
2. **Bản nâng cấp trực quan**: Mở tệp [**`modern_rwd.html`**](file:///C:/Users/dathao/Downloads/tao_layout_voi_rwd/modern_rwd.html) và click thử các nút tab Desktop, Tablet, Mobile trên thanh công cụ.
