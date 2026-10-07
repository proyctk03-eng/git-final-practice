import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, Polygon

# Font configuration
plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_relational_3nf(output_path):
    fig, ax = plt.subplots(figsize=(20, 14), dpi=300)
    ax.set_xlim(0, 26)
    ax.set_ylim(0, 18)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color scheme
    header_bg_master = '#1E3A8A'  # Navy for master / dimension tables
    header_bg_trans = '#0F766E'   # Teal for transaction headers
    header_bg_detail = '#6D28D9'  # Violet for transaction details
    table_border = '#CBD5E1'
    table_bg = '#FFFFFF'
    pk_color = '#B45309'
    fk_color = '#1D4ED8'
    text_color = '#1E293B'
    data_type_color = '#64748B'
    line_color = '#475569'

    # Title
    ax.text(13, 17.4, "MÔ HÌNH THỰC THỂ QUAN HỆ CHUẨN HÓA 3NF (RELATIONAL SCHEMA)", 
            fontsize=18, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(13, 16.8, "Hệ thống Quản lý Đơn đặt hàng & Phiếu giao hàng (Crow's Foot Notation)", 
            fontsize=12, fontstyle='italic', ha='center', va='center', color='#475569')

    # Function to render a database table card
    def draw_table(x, y, w, title, columns, header_bg=header_bg_master):
        row_height = 0.38
        header_height = 0.55
        total_height = header_height + len(columns) * row_height

        # Table outer card
        box = FancyBboxPatch((x, y - total_height), w, total_height,
                             boxstyle="round,pad=0.02,rounding_size=0.12",
                             linewidth=1.5, edgecolor='#94A3B8', facecolor=table_bg, zorder=3)
        ax.add_patch(box)

        # Header clip / background
        header_box = FancyBboxPatch((x, y - header_height), w, header_height,
                                    boxstyle="round,pad=0.02,rounding_size=0.12",
                                    linewidth=0, facecolor=header_bg, zorder=4)
        ax.add_patch(header_box)
        # Flatten bottom of header
        ax.fill([x, x + w, x + w, x], [y - header_height, y - header_height, y - header_height + 0.1, y - header_height + 0.1],
                color=header_bg, zorder=4)

        # Header text
        ax.text(x + w/2, y - header_height/2, title, fontsize=10.5, fontweight='bold',
                ha='center', va='center', color='#FFFFFF', zorder=5)

        # Columns
        curr_y = y - header_height
        for i, col in enumerate(columns):
            curr_y -= row_height
            # Alternate light background
            if i % 2 == 1:
                row_bg = patches.Rectangle((x, curr_y), w, row_height,
                                          facecolor='#F8FAFC', edgecolor='none', zorder=3.5)
                ax.add_patch(row_bg)

            # Key type badge
            key_type = col[0]
            col_name = col[1]
            data_type = col[2]

            badge_x = x + 0.2
            if "PK" in key_type and "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK,FK", fontsize=7.5, fontweight='bold',
                        color='#7C3AED', va='center', zorder=5)
            elif "PK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK", fontsize=7.5, fontweight='bold',
                        color=pk_color, va='center', zorder=5)
            elif "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "FK", fontsize=7.5, fontweight='bold',
                        color=fk_color, va='center', zorder=5)

            # Column name
            name_x = x + 1.0
            font_wt = 'bold' if "PK" in key_type else 'normal'
            ax.text(name_x, curr_y + row_height/2, col_name, fontsize=8.5, fontweight=font_wt,
                    color=text_color, va='center', zorder=5)

            # Data type
            type_x = x + w - 0.2
            ax.text(type_x, curr_y + row_height/2, data_type, fontsize=7.5, fontstyle='italic',
                    color=data_type_color, ha='right', va='center', zorder=5)

        return {'x': x, 'y': y, 'w': w, 'h': total_height, 'bottom': y - total_height}

    # Connector drawer
    def draw_connector(p1, p2, label_start="1", label_end="N", style="orthogonal"):
        x1, y1 = p1
        x2, y2 = p2
        if style == "orthogonal":
            mid_x = (x1 + x2) / 2
            ax.plot([x1, mid_x, mid_x, x2], [y1, y1, y2, y2], color=line_color, lw=1.6, zorder=2)
        elif style == "ortho_y":
            mid_y = (y1 + y2) / 2
            ax.plot([x1, x1, x2, x2], [y1, mid_y, mid_y, y2], color=line_color, lw=1.6, zorder=2)
        else:
            ax.plot([x1, x2], [y1, y2], color=line_color, lw=1.6, zorder=2)

        # Labels
        ax.text(x1, y1, label_start, fontsize=9, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # 1. DRAW MASTER / DIMENSION TABLES
    # DON_VI_KHACH (top center)
    t_dvk = draw_table(11.0, 16.0, 4.0, "DON_VI_KHACH", [
        ("PK", "MaDV", "VARCHAR(20)"),
        ("", "TenDV", "VARCHAR(100)"),
        ("", "DiaChi", "VARCHAR(200)"),
        ("", "DienThoai", "VARCHAR(20)")
    ], header_bg=header_bg_master)

    # NGUOI_DAT (top-left)
    t_nd = draw_table(2.0, 14.5, 3.8, "NGUOI_DAT", [
        ("PK", "MaND", "VARCHAR(20)"),
        ("", "HoTenND", "VARCHAR(100)"),
        ("FK", "MaDV", "VARCHAR(20)")
    ], header_bg=header_bg_master)

    # NGUOI_NHAN (top-right)
    t_nn = draw_table(20.2, 14.5, 3.8, "NGUOI_NHAN", [
        ("PK", "MaNN", "VARCHAR(20)"),
        ("", "HoTenNN", "VARCHAR(100)"),
        ("FK", "MaDV", "VARCHAR(20)")
    ], header_bg=header_bg_master)

    # NGUOI_GIAO (middle-right)
    t_ng = draw_table(20.5, 9.8, 3.5, "NGUOI_GIAO", [
        ("PK", "MaNG", "VARCHAR(20)"),
        ("", "HoTenNG", "VARCHAR(100)")
    ], header_bg=header_bg_master)

    # NOI_GIAO (bottom-right)
    t_ddg = draw_table(20.5, 6.0, 3.5, "NOI_GIAO", [
        ("PK", "MaDDG", "VARCHAR(20)"),
        ("", "TenNoiGiao", "VARCHAR(200)")
    ], header_bg=header_bg_master)

    # HANG_HOA (bottom-left)
    t_hang = draw_table(2.0, 4.5, 3.8, "HANG_HOA", [
        ("PK", "MaHang", "VARCHAR(20)"),
        ("", "TenHang", "VARCHAR(100)"),
        ("", "DvTinh", "VARCHAR(50)"),
        ("", "MoTaHang", "TEXT")
    ], header_bg=header_bg_master)

    # 2. DRAW TRANSACTION HEADERS & DETAILS
    # DON_DAT_HANG (center-left)
    t_dh = draw_table(2.0, 10.0, 3.8, "DON_DAT_HANG", [
        ("PK", "SoDH", "VARCHAR(20)"),
        ("", "NgayDat", "DATE"),
        ("FK", "MaND", "VARCHAR(20)")
    ], header_bg=header_bg_trans)

    # CHI_TIET_DAT_HANG (center-left lower)
    t_ctdh = draw_table(7.8, 8.5, 4.2, "CHI_TIET_DAT_HANG", [
        ("PK,FK", "SoDH", "VARCHAR(20)"),
        ("PK,FK", "MaHang", "VARCHAR(20)"),
        ("", "SoLuongDat", "INT")
    ], header_bg=header_bg_detail)

    # PHIEU_GIAO_HANG (center-right)
    t_pg = draw_table(14.0, 10.5, 4.2, "PHIEU_GIAO_HANG", [
        ("PK", "SoPG", "VARCHAR(20)"),
        ("", "NgayGiao", "DATE"),
        ("FK", "SoDH", "VARCHAR(20)"),
        ("FK", "MaNG", "VARCHAR(20)"),
        ("FK", "MaNN", "VARCHAR(20)"),
        ("FK", "MaDDG", "VARCHAR(20)")
    ], header_bg=header_bg_trans)

    # CHI_TIET_GIAO_HANG (center lower)
    t_ctgh = draw_table(10.5, 4.8, 4.4, "CHI_TIET_GIAO_HANG", [
        ("PK,FK", "SoPG", "VARCHAR(20)"),
        ("PK,FK", "MaHang", "VARCHAR(20)"),
        ("", "SoLuongGiao", "INT"),
        ("", "DonGiaGiao", "DECIMAL(18,2)"),
        ("", "ThanhTien", "DECIMAL(18,2)")
    ], header_bg=header_bg_detail)

    # 3. RELATIONSHIP CONNECTORS
    # DON_VI_KHACH (1) -> (N) NGUOI_DAT
    draw_connector((t_dvk['x'], 15.0), (t_nd['x'] + t_nd['w'], 13.5), label_start="1", label_end="N", style="orthogonal")

    # DON_VI_KHACH (1) -> (N) NGUOI_NHAN
    draw_connector((t_dvk['x'] + t_dvk['w'], 15.0), (t_nn['x'], 13.5), label_start="1", label_end="N", style="orthogonal")

    # NGUOI_DAT (1) -> (N) DON_DAT_HANG
    draw_connector((t_nd['x'] + t_nd['w']/2, t_nd['bottom']), (t_dh['x'] + t_dh['w']/2, t_dh['y']), label_start="1", label_end="N", style="straight")

    # DON_DAT_HANG (1) -> (N) CHI_TIET_DAT_HANG
    draw_connector((t_dh['x'] + t_dh['w'], 9.0), (t_ctdh['x'], 8.0), label_start="1", label_end="N", style="orthogonal")

    # HANG_HOA (1) -> (N) CHI_TIET_DAT_HANG
    draw_connector((t_hang['x'] + t_hang['w'], 4.0), (t_ctdh['x'] + 0.5, t_ctdh['bottom']), label_start="1", label_end="N", style="orthogonal")

    # DON_DAT_HANG (1) -> (N) PHIEU_GIAO_HANG
    draw_connector((t_dh['x'] + t_dh['w'], 9.5), (t_pg['x'], 9.5), label_start="1", label_end="N", style="straight")

    # NGUOI_GIAO (1) -> (N) PHIEU_GIAO_HANG
    draw_connector((t_ng['x'], 9.0), (t_pg['x'] + t_pg['w'], 9.0), label_start="1", label_end="N", style="straight")

    # NGUOI_NHAN (1) -> (N) PHIEU_GIAO_HANG
    draw_connector((t_nn['x'] + 1.0, t_nn['bottom']), (t_pg['x'] + t_pg['w'] - 0.5, t_pg['y']), label_start="1", label_end="N", style="orthogonal")

    # NOI_GIAO (1) -> (N) PHIEU_GIAO_HANG
    draw_connector((t_ddg['x'], 5.5), (t_pg['x'] + t_pg['w'], 8.0), label_start="1", label_end="N", style="orthogonal")

    # PHIEU_GIAO_HANG (1) -> (N) CHI_TIET_GIAO_HANG
    draw_connector((t_pg['x'] + 1.0, t_pg['bottom']), (t_ctgh['x'] + t_ctgh['w'] - 1.0, t_ctgh['y']), label_start="1", label_end="N", style="straight")

    # HANG_HOA (1) -> (N) CHI_TIET_GIAO_HANG
    draw_connector((t_hang['x'] + t_hang['w'], 3.0), (t_ctgh['x'], 3.0), label_start="1", label_end="N", style="straight")

    # Legend & Notes box
    leg_x, leg_y, leg_w, leg_h = 16.0, 0.4, 9.5, 2.0
    leg_box = FancyBboxPatch((leg_x, leg_y), leg_w, leg_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(leg_box)
    ax.text(leg_x + 0.3, leg_y + leg_h - 0.3, "Chú thích chuẩn hoá Cơ sở dữ liệu:", fontsize=9.5, fontweight='bold', color='#1E293B')
    
    # Legend badges
    ax.text(leg_x + 0.3, leg_y + 1.1, "PK", fontsize=8.5, fontweight='bold', color=pk_color)
    ax.text(leg_x + 0.9, leg_y + 1.1, ": Khóa chính (Primary Key)", fontsize=8, color='#334155')

    ax.text(leg_x + 4.5, leg_y + 1.1, "FK", fontsize=8.5, fontweight='bold', color=fk_color)
    ax.text(leg_x + 5.1, leg_y + 1.1, ": Khóa ngoại (Foreign Key)", fontsize=8, color='#334155')

    ax.text(leg_x + 0.3, leg_y + 0.5, "1 - N", fontsize=8.5, fontweight='bold', color='#DC2626')
    ax.text(leg_x + 1.0, leg_y + 0.5, ": Quan hệ một - nhiều (Một thực thể cha liên kết nhiều thực thể con)", fontsize=8, color='#334155')

    plt.tight_layout()
    plt.savefig(output_path, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Rendered Relational 3NF ERD: {output_path}")

if __name__ == "__main__":
    draw_relational_3nf("c:/Users/dathao/Downloads/AI/git-final-practice/erd-order-management/erd_relational_3nf.png")
