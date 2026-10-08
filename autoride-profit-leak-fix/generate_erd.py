import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_autoride_erd():
    fig, ax = plt.subplots(figsize=(18, 12), dpi=300)
    ax.set_xlim(0, 24)
    ax.set_ylim(0, 16)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color Scheme
    header_cars = '#1E3A8A'       # Navy
    header_rentals = '#0F766E'    # Teal / Primary Transaction
    header_inspections = '#6D28D9'# Violet / Event Log
    pk_color = '#B45309'          # Amber
    fk_color = '#1D4ED8'          # Blue
    uk_color = '#047857'          # Emerald
    text_color = '#1E293B'
    data_type_color = '#64748B'
    line_color = '#334155'

    # Title
    ax.text(12, 15.3, "MÔ HÌNH DỮ LIỆU TỐI ƯU HÓA HỆ THỐNG AUTORIDE (AUTORIDE DATABASE ERD)", 
            fontsize=17, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(12, 14.7, "Khắc phục triệt để các khoảng trống dữ liệu (Data Gaps) - Bảo vệ tính toàn vẹn tài chính", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color='#475569')

    def draw_table(x, y, w, title, columns, header_bg):
        row_height = 0.42
        header_height = 0.6
        total_height = header_height + len(columns) * row_height

        # Container
        box = FancyBboxPatch((x, y - total_height), w, total_height,
                             boxstyle="round,pad=0.02,rounding_size=0.12",
                             linewidth=1.5, edgecolor='#94A3B8', facecolor='#FFFFFF', zorder=3)
        ax.add_patch(box)

        # Header
        header_box = FancyBboxPatch((x, y - header_height), w, header_height,
                                    boxstyle="round,pad=0.02,rounding_size=0.12",
                                    linewidth=0, facecolor=header_bg, zorder=4)
        ax.add_patch(header_box)
        ax.fill([x, x + w, x + w, x], [y - header_height, y - header_height, y - header_height + 0.1, y - header_height + 0.1],
                color=header_bg, zorder=4)

        ax.text(x + w/2, y - header_height/2, title, fontsize=11, fontweight='bold',
                ha='center', va='center', color='#FFFFFF', zorder=5)

        curr_y = y - header_height
        for i, col in enumerate(columns):
            curr_y -= row_height
            if i % 2 == 1:
                row_bg = patches.Rectangle((x, curr_y), w, row_height,
                                          facecolor='#F8FAFC', edgecolor='none', zorder=3.5)
                ax.add_patch(row_bg)

            key_type, col_name, data_type, highlight = col

            badge_x = x + 0.2
            if "PK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK", fontsize=8, fontweight='bold', color=pk_color, va='center', zorder=5)
            elif "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "FK", fontsize=8, fontweight='bold', color=fk_color, va='center', zorder=5)
            elif "UK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "UK", fontsize=8, fontweight='bold', color=uk_color, va='center', zorder=5)

            name_x = x + 1.1
            font_wt = 'bold' if ("PK" in key_type or highlight) else 'normal'
            font_color = '#DC2626' if highlight else text_color
            ax.text(name_x, curr_y + row_height/2, col_name, fontsize=9, fontweight=font_wt, color=font_color, va='center', zorder=5)

            type_x = x + w - 0.25
            ax.text(type_x, curr_y + row_height/2, data_type, fontsize=8, fontstyle='italic', color=data_type_color, ha='right', va='center', zorder=5)

        return {'x': x, 'y': y, 'w': w, 'h': total_height, 'bottom': y - total_height}

    def draw_connector(p1, p2, label_start="1", label_end="N", style="straight"):
        x1, y1 = p1
        x2, y2 = p2
        if style == "orthogonal":
            mid_x = (x1 + x2) / 2
            ax.plot([x1, mid_x, mid_x, x2], [y1, y1, y2, y2], color=line_color, lw=1.6, zorder=2)
        else:
            ax.plot([x1, x2], [y1, y2], color=line_color, lw=1.6, zorder=2)

        ax.text(x1, y1, label_start, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # Tables
    # 1. Cars (Left)
    t_cars = draw_table(1.5, 12.0, 5.0, "Cars (Danh mục xe)", [
        ("PK", "car_id", "INT AUTO_INC", False),
        ("", "model_name", "VARCHAR(100)", False),
        ("UK", "license_plate", "VARCHAR(20) UNIQUE", False)
    ], header_cars)

    # 2. Rentals (Center)
    t_rentals = draw_table(8.5, 13.5, 6.8, "Rentals (Hợp đồng thuê xe)", [
        ("PK", "rental_id", "INT AUTO_INC", False),
        ("FK", "car_id", "INT", False),
        ("", "customer_name", "VARCHAR(100)", False),
        ("", "rent_date", "DATETIME", False),
        ("", "return_date", "DATETIME", False),
        ("", "status [FIXED]", "ENUM('BOOKED','ACTIVE','COMPLETED','CANCELLED')", True),
        ("", "security_deposit [NEW]", "DECIMAL(12, 2)", True),
        ("", "late_fee [NEW]", "DECIMAL(12, 2)", True),
        ("", "damage_fee [NEW]", "DECIMAL(12, 2)", True)
    ], header_rentals)

    # 3. Inspections (Right)
    t_inspections = draw_table(17.5, 12.0, 5.2, "Inspections (Biên bản kiểm tra)", [
        ("PK", "inspection_id", "INT AUTO_INC", True),
        ("FK", "rental_id", "INT", True),
        ("", "inspection_date", "DATETIME", True),
        ("", "damage_description", "TEXT", True),
        ("", "inspector_name", "VARCHAR(100)", True)
    ], header_inspections)

    # Connectors
    # Cars (1) -> (N) Rentals
    draw_connector((t_cars['x'] + t_cars['w'], 11.0), (t_rentals['x'], 11.0), label_start="1", label_end="N", style="straight")

    # Rentals (1) -> (N) Inspections
    draw_connector((t_rentals['x'] + t_rentals['w'], 10.5), (t_inspections['x'], 10.5), label_start="1", label_end="N", style="straight")

    # Callout / Explanation Box
    box_x, box_y, box_w, box_h = 1.5, 1.0, 21.2, 5.5
    exp_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(exp_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.4, "BẢNG ĐỐI CHIẾU THẨM ĐỊNH DATA GAPS VÀ KHẮC PHỤC:", fontsize=11, fontweight='bold', color='#1E293B')

    gaps_text = [
        ("Lỗi 1 (Status thiếu kiểm soát):", "Legacy dùng VARCHAR(50) lỏng lẻo -> Khắc phục: ENUM khóa chặt 4 trạng thái hợp đồng."),
        ("Lỗi 2 (Không có trường tài chính):", "Legacy thiếu tiền cọc và tiền phạt -> Khắc phục: Thêm security_deposit, late_fee, damage_fee kiểu DECIMAL(12,2)."),
        ("Lỗi 3 (Thiếu biên bản kiểm tra):", "Legacy không ghi nhận được hư hỏng xe -> Khắc phục: Tạo bảng Inspections (1 - N) lưu chi tiết lỗi và tên giám định viên."),
        ("Bảo đảm nghiệp vụ (Trigger chốt chặn):", "Tạo Trigger BEFORE INSERT trên Inspections để ngăn chặn ghi biên bản khi hợp đồng vẫn ở trạng thái 'BOOKED'."),
        ("Công thức hoàn tiền tự động:", "Tiền hoàn trả cho khách = security_deposit - late_fee - damage_fee (10.000.000 - 0 - 2.000.000 = 8.000.000 VNĐ).")
    ]

    cur_ty = box_y + box_h - 0.9
    for title_gap, desc_gap in gaps_text:
        ax.text(box_x + 0.5, cur_ty, title_gap, fontsize=9.5, fontweight='bold', color='#DC2626')
        ax.text(box_x + 6.8, cur_ty, desc_gap, fontsize=9, color='#334155')
        cur_ty -= 0.85

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/autoride-profit-leak-fix/erd_autoride.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/autoride-profit-leak-fix/erd_autoride.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated AutoRide ERD: {out_file1}")

if __name__ == "__main__":
    draw_autoride_erd()
