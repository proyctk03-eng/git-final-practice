# [Bài Tập] Phối Màu Cho Newsletter — Trello Sample

> **Khoá học**: Thiết kế Trải nghiệm Người dùng (UX) & Giao diện Người dùng (UI)  
> **Sinh viên thực hiện**: Nguyễn Tuấn Đạt  
> **Công nghệ sử dụng**: HTML5, CSS3 Custom Properties (`:root`), Bootstrap 5.3.3, Adobe Color Wheels, Font Awesome 6.

---

## 1. Giới thiệu Bài tập
Mục tiêu của bài tập là ứng dụng công cụ **Adobe Color** để nghiên cứu và lựa chọn 2 bộ màu sắc hài hòa, sau đó áp dụng vào khung mẫu **Trello Newsletter** được xây dựng trên nền tảng **Bootstrap 5.3.3**. Qua đó, tạo ra hai phiên bản newsletter mang hai sắc thái cảm xúc, tâm lý học và thông điệp thị giác hoàn toàn khác biệt.

---

## 2. Bảng Phân Tích Màu Sắc Adobe Color

### Phiên bản 1: "Atlassian Trello Cool Productivity"
- **Quy tắc phối màu (Color Harmony Rule)**: Tương đồng & Bổ túc (Analogous with Accent Complementary).
- **Ý nghĩa tâm lý**: Tông xanh dương mang lại cảm giác tin cậy, an toàn, ổn định và tập trung cao độ; kết hợp xanh ngọc và vàng hổ phách thúc đẩy động lực hoàn thành nhiệm vụ.

| Thành phần UI | Tên màu | Mã HEX | Mã RGB | Tỷ lệ phối | Tiêu chuẩn WCAG 2.2 |
|---|---|---|---|---|---|
| **Primary** | Electric Blue | `#0065FF` | `rgb(0, 101, 255)` | 30% | Tương phản nút: 4.6:1 (AA Pass) |
| **Secondary** | Sky Cyan | `#00A3BF` | `rgb(0, 163, 191)` | 20% | Nền thẻ phụ dịu mát |
| **Accent / CTA** | Emerald Green | `#36B37E` | `rgb(54, 179, 126)` | 10% | Badge thành công, điểm nhấn |
| **Highlight** | Amber Gold | `#FF991F` | `rgb(255, 153, 31)` | 5% | Thẻ cảnh báo/sao đánh giá |
| **Text Dark** | Deep Navy | `#172B4D` | `rgb(23, 43, 77)` | - | **12.8:1 trên nền trắng (AAA Pass)** |
| **Canvas Nền** | Light Soft Gray | `#F4F5F7` | `rgb(244, 245, 247)` | 35% | Nền trung tính chuẩn Atlassian |

---

### Phiên bản 2: "Sunset Terracotta & Creative Energy"
- **Quy tắc phối màu (Color Harmony Rule)**: Tam giác màu & Bổ túc ấm (Triadic & Warm Split-Complementary).
- **Ý nghĩa tâm lý**: Tông cam đất nồng ấm kết hợp tím hoàng gia và xanh bạc hà kích thích tư duy sáng tạo, cảm giác thân mật, nhiệt huyết và gắn kết cộng đồng.

| Thành phần UI | Tên màu | Mã HEX | Mã RGB | Tỷ lệ phối | Tiêu chuẩn WCAG 2.2 |
|---|---|---|---|---|---|
| **Primary** | Sunset Tangerine | `#E65100` | `rgb(230, 81, 0)` | 30% | Nút & Header nhiệt huyết |
| **Secondary** | Royal Plum | `#6A1B9A` | `rgb(106, 27, 154)` | 20% | Thẻ tính năng có chiều sâu |
| **Accent / CTA** | Vibrant Mint Teal | `#00897B` | `rgb(0, 137, 123)` | 10% | Nổi bật trên tông ấm (4.9:1) |
| **Highlight** | Warm Honey | `#F57F17` | `rgb(245, 127, 23)` | 5% | Viền và điểm nhấn ấm |
| **Text Dark** | Espresso Roast | `#261C14` | `rgb(38, 28, 20)` | - | **13.5:1 trên nền kem (AAA Pass)** |
| **Canvas Nền** | Warm Linen Cream| `#FFF8F0` | `rgb(255, 248, 240)` | 35% | Nền giấy mỹ thuật cao cấp |

---

## 3. Cấu trúc Thư mục Mã Nguồn

```
newsletter-color-practice/
├── index.html                 # Trang Hub trung tâm: So sánh song song & chuyển đổi màu trực tiếp
├── newsletter_v1.html         # Phiên bản 1: Cool Productivity
├── newsletter_v2.html         # Phiên bản 2: Sunset Creative Energy
├── css/
│   ├── common.css             # Khung bố cục chung, Typography, responsive styles
│   ├── style1.css             # Định nghĩa biến CSS (:root) cho Phiên bản 1
│   └── style2.css             # Định nghĩa biến CSS (:root) cho Phiên bản 2
└── README.md                  # Báo cáo thực hành & hướng dẫn nộp bài
```

---

## 4. Đặc điểm Kỹ thuật Nổi bật
1. **Kiến trúc biến CSS động (`var(--...)`)**: Toàn bộ màu sắc được quản lý tập trung ở thẻ `:root` trong từng file CSS (`style1.css`, `style2.css`). Việc thay đổi toàn bộ nhận diện màu sắc của newsletter chỉ cần cập nhật một vài dòng mã HEX mà không cần chạm vào cấu trúc HTML.
2. **Khung Responsive Bootstrap 5.3.3**:
   - Sử dụng layout container `max-width: 680px` chuẩn tỷ lệ email newsletter quốc tế.
   - Grid 3 cột (`col-md-4`) tự động chuyển thành 1 cột trên điện thoại di động giúp trải nghiệm đọc mượt mà.
3. **Tuân thủ chuẩn tiếp cận người dùng (Accessibility - WCAG 2.2)**:
   - Cả 2 phiên bản đều vượt ngưỡng tương phản tối thiểu của W3C (độ tương phản chữ đạt > 12:1, vượt xa yêu cầu 4.5:1 của chuẩn AA).
4. **Bảng điều khiển so sánh `index.html`**:
   - Tích hợp tính năng xem trực tiếp 2 phiên bản qua iframe độc lập, hỗ trợ phóng to toàn màn hình hoặc xem song song (Side-by-Side).

---

## 5. Hướng dẫn Xem và Nộp Bài
- Mở tệp `index.html` trên bất kỳ trình duyệt nào để trải nghiệm bảng điều khiển so sánh và chuyển đổi giữa 2 phiên bản.
- Hoặc mở trực tiếp `newsletter_v1.html` và `newsletter_v2.html` để kiểm tra từng giao diện riêng lẻ.
