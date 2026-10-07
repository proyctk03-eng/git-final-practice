import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_erd():
    fig, ax = plt.subplots(figsize=(16, 10), dpi=300)
    ax.set_xlim(0, 20)
    ax.set_ylim(0, 12)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Colors
    header_master = '#1E3A8A'   # Navy
    header_bridge = '#6D28D9'   # Violet
    pk_color = '#B45309'        # Amber
    fk_color = '#1D4ED8'        # Blue
    text_color = '#1E293B'
    data_type_color = '#64748B'
    line_color = '#334155'

    # Title
    ax.text(10, 11.4, "SƠ ĐỒ CƠ SỞ DỮ LIỆU QUẢN LÝ ĐIỂM THI (QuanLyDiemThi)", 
            fontsize=17, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(10, 10.9, "Mô hình quan hệ 4 bảng với ràng buộc Khóa chính (PK) & Khóa ngoại (FK)", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color='#475569')

    # Draw table function
    def draw_table(x, y, w, title, columns, header_bg=header_master):
        row_height = 0.42
        header_height = 0.6
        total_height = header_height + len(columns) * row_height

        # Table container
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

            key_type, col_name, data_type = col

            badge_x = x + 0.2
            if "PK" in key_type and "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK,FK", fontsize=8, fontweight='bold',
                        color='#7C3AED', va='center', zorder=5)
            elif "PK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK", fontsize=8, fontweight='bold',
                        color=pk_color, va='center', zorder=5)
            elif "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "FK", fontsize=8, fontweight='bold',
                        color=fk_color, va='center', zorder=5)

            name_x = x + 1.1
            font_wt = 'bold' if "PK" in key_type else 'normal'
            ax.text(name_x, curr_y + row_height/2, col_name, fontsize=9, fontweight=font_wt,
                    color=text_color, va='center', zorder=5)

            type_x = x + w - 0.25
            ax.text(type_x, curr_y + row_height/2, data_type, fontsize=8, fontstyle='italic',
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

        ax.text(x1, y1, label_start, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # Tables layout
    # 1. GiaoVien (Top Right)
    t_gv = draw_table(14.5, 9.8, 4.2, "GiaoVien", [
        ("PK", "MaGV", "VARCHAR(20)"),
        ("", "TenGV", "VARCHAR(50)"),
        ("", "SDT", "VARCHAR(10)")
    ], header_bg=header_master)

    # 2. MonHoc (Bottom Right)
    t_mh = draw_table(14.5, 5.8, 4.2, "MonHoc", [
        ("PK", "MaMH", "VARCHAR(50)"),
        ("", "TenMH", "VARCHAR(50)"),
        ("FK", "MaGV", "VARCHAR(20)")
    ], header_bg=header_master)

    # 3. HocSinh (Top Left)
    t_hs = draw_table(1.5, 9.8, 4.2, "HocSinh", [
        ("PK", "MaHS", "VARCHAR(20)"),
        ("", "TenHS", "VARCHAR(50)"),
        ("", "NgaySinh", "DATETIME"),
        ("", "Lop", "VARCHAR(20)"),
        ("", "GT", "VARCHAR(20)")
    ], header_bg=header_master)

    # 4. BangDiem (Center Bottom)
    t_bd = draw_table(8.0, 5.8, 4.4, "BangDiem", [
        ("PK,FK", "MaHS", "VARCHAR(20)"),
        ("PK,FK", "MaMH", "VARCHAR(50)"),
        ("", "DiemThi", "INT"),
        ("", "NgayKT", "DATETIME")
    ], header_bg=header_bridge)

    # Relationships
    # GiaoVien (1) -> (N) MonHoc
    draw_connector((t_gv['x'] + t_gv['w']/2, t_gv['bottom']), 
                   (t_mh['x'] + t_mh['w']/2, t_mh['y']), 
                   label_start="1", label_end="N", style="straight")

    # HocSinh (1) -> (N) BangDiem
    draw_connector((t_hs['x'] + t_hs['w'], 8.0), 
                   (t_bd['x'] + 1.0, t_bd['y']), 
                   label_start="1", label_end="N", style="orthogonal")

    # MonHoc (1) -> (N) BangDiem
    draw_connector((t_mh['x'], 4.5), 
                   (t_bd['x'] + t_bd['w'], 4.5), 
                   label_start="1", label_end="N", style="straight")

    # Legend
    leg_x, leg_y, leg_w, leg_h = 1.5, 0.8, 17.2, 1.4
    leg_box = FancyBboxPatch((leg_x, leg_y), leg_w, leg_h,
                             boxstyle="round,pad=0.04,rounding_size=0.1",
                             linewidth=1, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(leg_box)
    ax.text(leg_x + 0.3, leg_y + leg_h - 0.35, "Chú thích ràng buộc toàn vẹn:", fontsize=9.5, fontweight='bold', color='#1E293B')
    
    ax.text(leg_x + 0.3, leg_y + 0.4, "PK", fontsize=8.5, fontweight='bold', color=pk_color)
    ax.text(leg_x + 0.8, leg_y + 0.4, ": Khóa chính (Primary Key)", fontsize=8.5, color='#334155')

    ax.text(leg_x + 4.2, leg_y + 0.4, "FK", fontsize=8.5, fontweight='bold', color=fk_color)
    ax.text(leg_x + 4.7, leg_y + 0.4, ": Khóa ngoại (Foreign Key)", fontsize=8.5, color='#334155')

    ax.text(leg_x + 8.2, leg_y + 0.4, "PK,FK", fontsize=8.5, fontweight='bold', color='#7C3AED')
    ax.text(leg_x + 9.1, leg_y + 0.4, ": Khóa kết hợp (Composite Key / Bảng trung gian n - n)", fontsize=8.5, color='#334155')

    ax.text(leg_x + 15.0, leg_y + 0.4, "1 - N", fontsize=8.5, fontweight='bold', color='#DC2626')
    ax.text(leg_x + 15.6, leg_y + 0.4, ": Quan hệ một - nhiều", fontsize=8.5, color='#334155')

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/sql-create-table-practice/erd_quanly_diemthi.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/sql-create-table-practice/erd_quanly_diemthi.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated ERD: {out_file1}")

if __name__ == "__main__":
    draw_erd()
