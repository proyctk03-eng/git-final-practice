import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, Polygon, Ellipse
from PIL import Image

# Setup fonts
plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

# 1. DRAW INPUT ERD MODEL (CHEN NOTATION)
def draw_input_erd(output_path):
    fig, ax = plt.subplots(figsize=(20, 13), dpi=300)
    ax.set_xlim(0, 26)
    ax.set_ylim(0, 16)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color palette
    entity_color = '#1E3A8A'     # Navy
    entity_bg = '#EFF6FF'        # Light Blue
    rel_color = '#6D28D9'        # Violet
    rel_bg = '#F5F3FF'           # Light Violet
    attr_color = '#0F766E'       # Teal
    attr_bg = '#F0FDFA'          # Light Teal
    line_color = '#334155'       # Slate
    pk_color = '#B45309'         # Amber
    multi_color = '#D97706'      # Multivalued attribute

    # Title
    ax.text(13, 15.3, "MÔ HÌNH THỰC THỂ KẾT HỢP (ERD) - BÀI TOÁN QUẢN LÝ VẬT TƯ", 
            fontsize=18, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(13, 14.7, "Ký pháp Chen: Thực thể, Mối quan hệ, Thuộc tính đơn và Thuộc tính đa trị (Số điện thoại)", 
            fontsize=12, fontstyle='italic', ha='center', va='center', color='#475569')

    # Helpers
    def draw_entity(x, y, w, h, text):
        rect = FancyBboxPatch((x - w/2, y - h/2), w, h,
                              boxstyle="round,pad=0.08,rounding_size=0.15",
                              linewidth=2, edgecolor=entity_color, facecolor=entity_bg, zorder=3)
        ax.add_patch(rect)
        ax.text(x, y, text, fontsize=11, fontweight='bold', ha='center', va='center', color=entity_color, zorder=4)

    def draw_rel(x, y, size_w, size_h, text):
        diamond = Polygon([[x, y + size_h], [x + size_w, y], [x, y - size_h], [x - size_w, y]],
                          closed=True, linewidth=2, edgecolor=rel_color, facecolor=rel_bg, zorder=3)
        ax.add_patch(diamond)
        ax.text(x, y, text, fontsize=10, fontweight='bold', ha='center', va='center', color=rel_color, zorder=4)

    def draw_attr(x, y, w, h, text, is_pk=False, is_multi=False):
        edge = pk_color if is_pk else (multi_color if is_multi else attr_color)
        bg = '#FEF3C7' if is_pk else ('#FEF3C7' if is_multi else attr_bg)
        fg = edge
        if is_multi:
            # Outer ellipse
            e_outer = Ellipse((x, y), w + 0.35, h + 0.25, linewidth=1.5, edgecolor=edge, facecolor='none', zorder=3)
            ax.add_patch(e_outer)
        e = Ellipse((x, y), w, h, linewidth=1.5, edgecolor=edge, facecolor=bg, zorder=3.5)
        ax.add_patch(e)
        ax.text(x, y, text, fontsize=8.5, fontweight='bold' if (is_pk or is_multi) else 'normal',
                ha='center', va='center', color=fg, zorder=4)

    def draw_line(x1, y1, x2, y2, label=None, label_pos=0.5, label_offset=(0, 0)):
        ax.plot([x1, x2], [y1, y2], color=line_color, linewidth=1.5, zorder=2)
        if label:
            lx = x1 + (x2 - x1) * label_pos + label_offset[0]
            ly = y1 + (y2 - y1) * label_pos + label_offset[1]
            ax.text(lx, ly, label, fontsize=9.5, fontweight='bold', ha='center', va='center',
                    color='#DC2626', bbox=dict(boxstyle='circle,pad=0.15', facecolor='#FFFFFF', edgecolor='none'), zorder=5)

    # 1. ENTITIES
    # PHIEUXUAT (Top Left)
    px_x, px_y = 4.0, 11.5
    draw_entity(px_x, px_y, 3.2, 0.9, "PHIEUXUAT")

    # VATTU (Center)
    vt_x, vt_y = 13.0, 8.5
    draw_entity(vt_x, vt_y, 3.0, 0.9, "VATTU")

    # PHIEUNHAP (Top Right)
    pn_x, pn_y = 22.0, 11.5
    draw_entity(pn_x, pn_y, 3.2, 0.9, "PHIEUNHAP")

    # DONDH (Bottom Left)
    dh_x, dh_y = 4.0, 4.5
    draw_entity(dh_x, dh_y, 3.0, 0.9, "DONDH")

    # NHACC (Bottom Right)
    ncc_x, ncc_y = 22.0, 4.5
    draw_entity(ncc_x, ncc_y, 3.0, 0.9, "NHACC")

    # 2. RELATIONSHIPS
    # XUAT (PHIEUXUAT - VATTU: n - m)
    xuat_x, xuat_y = 8.5, 10.0
    draw_rel(xuat_x, xuat_y, 1.1, 0.6, "XUAT")
    draw_line(px_x, px_y, xuat_x, xuat_y, label="N", label_pos=0.5, label_offset=(-0.15, 0.25))
    draw_line(xuat_x, xuat_y, vt_x, vt_y, label="M", label_pos=0.5, label_offset=(0.15, 0.25))

    # NHAP (PHIEUNHAP - VATTU: n - m)
    nhap_x, nhap_y = 17.5, 10.0
    draw_rel(nhap_x, nhap_y, 1.1, 0.6, "NHAP")
    draw_line(pn_x, pn_y, nhap_x, nhap_y, label="N", label_pos=0.5, label_offset=(0.15, 0.25))
    draw_line(nhap_x, nhap_y, vt_x, vt_y, label="M", label_pos=0.5, label_offset=(-0.15, 0.25))

    # DAT_HANG (DONDH - VATTU: n - m)
    dat_x, dat_y = 8.5, 6.5
    draw_rel(dat_x, dat_y, 1.2, 0.6, "DONDH_VT")
    draw_line(dh_x, dh_y, dat_x, dat_y, label="N", label_pos=0.5, label_offset=(-0.15, -0.25))
    draw_line(dat_x, dat_y, vt_x, vt_y, label="M", label_pos=0.5, label_offset=(0.15, -0.25))

    # CUNG_CAP (NHACC - DONDH: 1 - n)
    cc_x, cc_y = 13.0, 4.5
    draw_rel(cc_x, cc_y, 1.3, 0.6, "CUNG CAP")
    draw_line(ncc_x, ncc_y, cc_x, cc_y, label="1", label_pos=0.5, label_offset=(0, 0.3))
    draw_line(cc_x, cc_y, dh_x, dh_y, label="N", label_pos=0.5, label_offset=(0, 0.3))

    # 3. ATTRIBUTES
    # PHIEUXUAT attributes
    draw_line(px_x, px_y, 1.8, 13.0)
    draw_attr(1.8, 13.0, 1.8, 0.6, "SoPX (PK)", is_pk=True)
    draw_line(px_x, px_y, 4.0, 13.3)
    draw_attr(4.0, 13.3, 1.9, 0.6, "NgayXuat", is_pk=False)

    # Relationship XUAT attributes
    draw_line(xuat_x, xuat_y, 8.5, 11.8)
    draw_attr(8.5, 11.8, 1.7, 0.55, "DGXuat", is_pk=False)
    draw_line(xuat_x, xuat_y, 6.8, 8.8)
    draw_attr(6.8, 8.8, 1.7, 0.55, "SLXuat", is_pk=False)

    # VATTU attributes
    draw_line(vt_x, vt_y, 13.0, 10.3)
    draw_attr(13.0, 10.3, 1.8, 0.6, "MaVTU (PK)", is_pk=True)
    draw_line(vt_x, vt_y, 13.0, 6.8)
    draw_attr(13.0, 6.8, 1.8, 0.6, "TenVTU", is_pk=False)

    # PHIEUNHAP attributes
    draw_line(pn_x, pn_y, 22.0, 13.3)
    draw_attr(22.0, 13.3, 1.9, 0.6, "NgayNhap", is_pk=False)
    draw_line(pn_x, pn_y, 24.2, 13.0)
    draw_attr(24.2, 13.0, 1.8, 0.6, "SoPN (PK)", is_pk=True)

    # Relationship NHAP attributes
    draw_line(nhap_x, nhap_y, 17.5, 11.8)
    draw_attr(17.5, 11.8, 1.7, 0.55, "DGNhap", is_pk=False)
    draw_line(nhap_x, nhap_y, 19.2, 8.8)
    draw_attr(19.2, 8.8, 1.7, 0.55, "SLNhap", is_pk=False)

    # DONDH attributes
    draw_line(dh_x, dh_y, 1.8, 5.5)
    draw_attr(1.8, 5.5, 1.8, 0.6, "SoDH (PK)", is_pk=True)
    draw_line(dh_x, dh_y, 1.8, 3.5)
    draw_attr(1.8, 3.5, 1.8, 0.6, "NgayDH", is_pk=False)

    # NHACC attributes
    draw_line(ncc_x, ncc_y, 24.5, 6.0)
    draw_attr(24.5, 6.0, 1.8, 0.6, "MaNCC (PK)", is_pk=True)
    draw_line(ncc_x, ncc_y, 24.5, 4.5)
    draw_attr(24.5, 4.5, 1.8, 0.6, "TenNCC", is_pk=False)
    draw_line(ncc_x, ncc_y, 24.5, 3.0)
    draw_attr(24.5, 3.0, 1.8, 0.6, "DiaChi", is_pk=False)
    
    # Multivalued attribute SDT (double ellipse)
    draw_line(ncc_x, ncc_y, 22.0, 2.2)
    draw_attr(22.0, 2.2, 1.8, 0.6, "SDT (Đa trị)", is_pk=False, is_multi=True)

    # Legend
    leg = FancyBboxPatch((0.5, 0.5), 11.5, 1.8, boxstyle="round,pad=0.04,rounding_size=0.1",
                         linewidth=1, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(leg)
    ax.text(0.8, 1.9, "Chú thích ký pháp Chen:", fontsize=9.5, fontweight='bold', color='#1E293B')
    
    # Symbols
    ax.add_patch(FancyBboxPatch((0.8, 1.3), 0.5, 0.25, boxstyle="round,pad=0.02,rounding_size=0.05", facecolor=entity_bg, edgecolor=entity_color, lw=1))
    ax.text(1.5, 1.4, "Thực thể", fontsize=8.5, color='#334155')

    ax.add_patch(Polygon([[3.0, 1.55], [3.25, 1.42], [3.0, 1.3], [2.75, 1.42]], facecolor=rel_bg, edgecolor=rel_color, lw=1))
    ax.text(3.4, 1.4, "Mối quan hệ", fontsize=8.5, color='#334155')

    ax.add_patch(Ellipse((4.9, 1.42), 0.45, 0.25, facecolor=attr_bg, edgecolor=attr_color, lw=1))
    ax.text(5.3, 1.4, "Thuộc tính đơn", fontsize=8.5, color='#334155')

    ax.add_patch(Ellipse((7.2, 1.42), 0.45, 0.25, facecolor='#FEF3C7', edgecolor=pk_color, lw=1))
    ax.text(7.6, 1.4, "Khóa chính (PK)", fontsize=8.5, color='#334155')

    # Double ellipse legend
    ax.add_patch(Ellipse((9.7, 1.42), 0.55, 0.32, facecolor='none', edgecolor=multi_color, lw=1.2))
    ax.add_patch(Ellipse((9.7, 1.42), 0.4, 0.22, facecolor='#FEF3C7', edgecolor=multi_color, lw=1))
    ax.text(10.2, 1.4, "Thuộc tính đa trị", fontsize=8.5, fontweight='bold', color=multi_color)

    ax.text(0.8, 0.8, "Quy tắc chuyển đổi: Thuộc tính đa trị sẽ được tách thành 1 bảng riêng biệt trong mô hình quan hệ.", fontsize=8.5, fontstyle='italic', color='#475569')

    plt.tight_layout()
    plt.savefig(output_path, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Rendered Input ERD: {output_path}")

# 2. DRAW RELATIONAL SCHEMA (AFTER CONVERSION)
def draw_relational_schema(output_path):
    fig, ax = plt.subplots(figsize=(22, 14), dpi=300)
    ax.set_xlim(0, 28)
    ax.set_ylim(0, 18)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Colors
    header_master = '#1E3A8A'   # Navy for strong entities
    header_bridge = '#6D28D9'   # Violet for many-to-many detail tables
    header_multi = '#B45309'    # Amber for multivalued attribute table
    pk_color = '#B45309'
    fk_color = '#1D4ED8'
    text_color = '#1E293B'
    data_type_color = '#64748B'
    line_color = '#475569'

    # Title
    ax.text(14, 17.3, "MÔ HÌNH DỮ LIỆU QUAN HỆ SAU CHUYỂN ĐỔI (RELATIONAL SCHEMA)", 
            fontsize=18, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(14, 16.7, "Bao gồm 8 bảng quan hệ chuẩn hóa 3NF, xử lý đầy đủ quan hệ 1-n, n-m và thuộc tính đa trị", 
            fontsize=12, fontstyle='italic', ha='center', va='center', color='#475569')

    def draw_table(x, y, w, title, columns, header_bg=header_master):
        row_height = 0.4
        header_height = 0.58
        total_height = header_height + len(columns) * row_height

        box = FancyBboxPatch((x, y - total_height), w, total_height,
                             boxstyle="round,pad=0.02,rounding_size=0.12",
                             linewidth=1.5, edgecolor='#94A3B8', facecolor='#FFFFFF', zorder=3)
        ax.add_patch(box)

        header_box = FancyBboxPatch((x, y - header_height), w, header_height,
                                    boxstyle="round,pad=0.02,rounding_size=0.12",
                                    linewidth=0, facecolor=header_bg, zorder=4)
        ax.add_patch(header_box)
        ax.fill([x, x + w, x + w, x], [y - header_height, y - header_height, y - header_height + 0.1, y - header_height + 0.1],
                color=header_bg, zorder=4)

        ax.text(x + w/2, y - header_height/2, title, fontsize=10.5, fontweight='bold',
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
                ax.text(badge_x, curr_y + row_height/2, "PK,FK", fontsize=7.5, fontweight='bold', color='#7C3AED', va='center', zorder=5)
            elif "PK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK", fontsize=7.5, fontweight='bold', color=pk_color, va='center', zorder=5)
            elif "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "FK", fontsize=7.5, fontweight='bold', color=fk_color, va='center', zorder=5)

            name_x = x + 1.1
            font_wt = 'bold' if "PK" in key_type else 'normal'
            ax.text(name_x, curr_y + row_height/2, col_name, fontsize=8.5, fontweight=font_wt, color=text_color, va='center', zorder=5)

            type_x = x + w - 0.2
            ax.text(type_x, curr_y + row_height/2, data_type, fontsize=7.5, fontstyle='italic', color=data_type_color, ha='right', va='center', zorder=5)

        return {'x': x, 'y': y, 'w': w, 'h': total_height, 'bottom': y - total_height}

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

        ax.text(x1, y1, label_start, fontsize=9, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # 1. TABLES
    # Top Row: PHIEUXUAT, CHI_TIET_PHIEU_XUAT, VATTU, CHI_TIET_PHIEU_NHAP, PHIEUNHAP
    t_px = draw_table(1.5, 15.5, 3.8, "PHIEUXUAT", [
        ("PK", "SoPX", "VARCHAR(20)"),
        ("", "NgayXuat", "DATE")
    ], header_bg=header_master)

    t_ctpx = draw_table(6.5, 15.5, 4.4, "CHI_TIET_PHIEU_XUAT", [
        ("PK,FK", "SoPX", "VARCHAR(20)"),
        ("PK,FK", "MaVTU", "VARCHAR(20)"),
        ("", "DGXuat", "DECIMAL(18,2)"),
        ("", "SLXuat", "INT")
    ], header_bg=header_bridge)

    t_vt = draw_table(12.2, 11.5, 3.8, "VATTU", [
        ("PK", "MaVTU", "VARCHAR(20)"),
        ("", "TenVTU", "VARCHAR(100)")
    ], header_bg=header_master)

    t_ctpn = draw_table(17.3, 15.5, 4.4, "CHI_TIET_PHIEU_NHAP", [
        ("PK,FK", "SoPN", "VARCHAR(20)"),
        ("PK,FK", "MaVTU", "VARCHAR(20)"),
        ("", "DGNhap", "DECIMAL(18,2)"),
        ("", "SLNhap", "INT")
    ], header_bg=header_bridge)

    t_pn = draw_table(23.0, 15.5, 3.8, "PHIEUNHAP", [
        ("PK", "SoPN", "VARCHAR(20)"),
        ("", "NgayNhap", "DATE")
    ], header_bg=header_master)

    # Bottom Row: DONDH, CHI_TIET_DON_DAT_HANG, NHACC, SO_DIEN_THOAI_NCC
    t_dh = draw_table(1.5, 8.5, 4.0, "DONDH", [
        ("PK", "SoDH", "VARCHAR(20)"),
        ("", "NgayDH", "DATE"),
        ("FK", "MaNCC", "VARCHAR(20)")
    ], header_bg=header_master)

    t_ctdh = draw_table(6.8, 8.5, 4.4, "CHI_TIET_DON_DAT_HANG", [
        ("PK,FK", "SoDH", "VARCHAR(20)"),
        ("PK,FK", "MaVTU", "VARCHAR(20)")
    ], header_bg=header_bridge)

    t_ncc = draw_table(18.0, 8.5, 4.2, "NHACC", [
        ("PK", "MaNCC", "VARCHAR(20)"),
        ("", "TenNCC", "VARCHAR(100)"),
        ("", "DiaChi", "VARCHAR(200)")
    ], header_bg=header_master)

    # Multivalued Table
    t_sdt = draw_table(23.2, 8.5, 4.2, "NHACC_SDT", [
        ("PK,FK", "MaNCC", "VARCHAR(20)"),
        ("PK", "SDT", "VARCHAR(15)")
    ], header_bg=header_multi)

    # 2. CONNECTORS
    # PHIEUXUAT (1) -> (N) CHI_TIET_PHIEU_XUAT
    draw_connector((t_px['x'] + t_px['w'], 14.5), (t_ctpx['x'], 14.5), label_start="1", label_end="N", style="straight")

    # VATTU (1) -> (N) CHI_TIET_PHIEU_XUAT
    draw_connector((t_vt['x'], 11.0), (t_ctpx['x'] + t_ctpx['w']/2, t_ctpx['bottom']), label_start="1", label_end="N", style="orthogonal")

    # PHIEUNHAP (1) -> (N) CHI_TIET_PHIEU_NHAP
    draw_connector((t_pn['x'], 14.5), (t_ctpn['x'] + t_ctpn['w'], 14.5), label_start="1", label_end="N", style="straight")

    # VATTU (1) -> (N) CHI_TIET_PHIEU_NHAP
    draw_connector((t_vt['x'] + t_vt['w'], 11.0), (t_ctpn['x'] + t_ctpn['w']/2, t_ctpn['bottom']), label_start="1", label_end="N", style="orthogonal")

    # DONDH (1) -> (N) CHI_TIET_DON_DAT_HANG
    draw_connector((t_dh['x'] + t_dh['w'], 7.8), (t_ctdh['x'], 7.8), label_start="1", label_end="N", style="straight")

    # VATTU (1) -> (N) CHI_TIET_DON_DAT_HANG
    draw_connector((t_vt['x'], 10.0), (t_ctdh['x'] + t_ctdh['w']/2, t_ctdh['y']), label_start="1", label_end="N", style="orthogonal")

    # NHACC (1) -> (N) DONDH
    draw_connector((t_ncc['x'], 7.5), (t_dh['x'] + t_dh['w']/2, t_dh['bottom']), label_start="1", label_end="N", style="orthogonal")

    # NHACC (1) -> (N) NHACC_SDT (Tách từ thuộc tính đa trị)
    draw_connector((t_ncc['x'] + t_ncc['w'], 7.5), (t_sdt['x'], 7.5), label_start="1", label_end="N", style="straight")

    # Legend
    leg = FancyBboxPatch((1.5, 0.8), 25.5, 2.0, boxstyle="round,pad=0.04,rounding_size=0.1",
                         linewidth=1, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(leg)
    ax.text(2.0, 2.4, "Chú giải mô hình dữ liệu quan hệ chuyển đổi:", fontsize=10, fontweight='bold', color='#1E293B')
    
    ax.text(2.0, 1.8, "1. Thực thể mạnh:", fontsize=9, fontweight='bold', color=header_master)
    ax.text(5.5, 1.8, "Chuyển thành các bảng độc lập (PHIEUXUAT, VATTU, PHIEUNHAP, DONDH, NHACC).", fontsize=8.5, color='#334155')

    ax.text(2.0, 1.3, "2. Mối quan hệ n - m:", fontsize=9, fontweight='bold', color=header_bridge)
    ax.text(5.5, 1.3, "Tạo các bảng trung gian (CHI_TIET_PHIEU_XUAT, CHI_TIET_PHIEU_NHAP, CHI_TIET_DON_DAT_HANG).", fontsize=8.5, color='#334155')

    ax.text(2.0, 0.8, "3. Thuộc tính đa trị:", fontsize=9, fontweight='bold', color=header_multi)
    ax.text(5.5, 0.8, "Tách thuộc tính SDT thành bảng riêng NHACC_SDT(MaNCC, SDT) với khóa kết hợp (MaNCC, SDT).", fontsize=8.5, color='#334155')

    plt.tight_layout()
    plt.savefig(output_path, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Rendered Relational Schema: {output_path}")

# 3. COMBINE IMAGES
def combine_diagrams(img1_path, img2_path, out_path):
    im1 = Image.open(img1_path)
    im2 = Image.open(img2_path)

    w = max(im1.width, im2.width)
    im1_res = im1.resize((w, int(im1.height * w / im1.width)), Image.Resampling.LANCZOS)
    im2_res = im2.resize((w, int(im2.height * w / im2.width)), Image.Resampling.LANCZOS)

    total_h = im1_res.height + im2_res.height + 40
    combo = Image.new('RGB', (w, total_h), color=(255, 255, 255))
    combo.paste(im1_res, (0, 0))
    combo.paste(im2_res, (0, im1_res.height + 40))

    combo.save(out_path, quality=95)
    print(f"Combined Diagram saved at: {out_path}")

if __name__ == "__main__":
    p_in = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-to-relational/erd_input_model.png"
    p_rel = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-to-relational/erd_relational_schema.png"
    p_combo = "c:/Users/dathao/Downloads/AI/git-final-practice/erd-to-relational/erd_conversion_overview.png"

    draw_input_erd(p_in)
    draw_relational_schema(p_rel)
    combine_diagrams(p_in, p_rel, p_combo)

    # Mirror to standalone folder
    p_in2 = "c:/Users/dathao/Downloads/AI/erd-to-relational/erd_input_model.png"
    p_rel2 = "c:/Users/dathao/Downloads/AI/erd-to-relational/erd_relational_schema.png"
    p_combo2 = "c:/Users/dathao/Downloads/AI/erd-to-relational/erd_conversion_overview.png"
    draw_input_erd(p_in2)
    draw_relational_schema(p_rel2)
    combine_diagrams(p_in2, p_rel2, p_combo2)
